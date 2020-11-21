Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B32BBFCF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgKUOQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbgKUOQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeE4/rk1/OfbaMSMAIeE8ipLTBFgO9CU38gcibjW7Y0=;
        b=W66qt2Pc4QZnAUlXIAlEn9C0DkhfgOqkq9vkEDyTlxbT2yDeck+f889PWFTPXe0j9fTOge
        lYIg0CfG0pXTp/lBfZC6aTlL6TUP1Gpmsz0MNlf6klzNLZrnLfHiZ9snwmYwDO0vmldTud
        I5UyxDb9p0hnqB8EEhlSI0LCGzgfoJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-Zn_niTc9NVKbsbADixy2Mg-1; Sat, 21 Nov 2020 09:16:41 -0500
X-MC-Unique: Zn_niTc9NVKbsbADixy2Mg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC781005D67;
        Sat, 21 Nov 2020 14:16:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A016085D;
        Sat, 21 Nov 2020 14:16:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/29] iov_iter: Split csum_and_copy_to_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:37 +0000
Message-ID: <160596819702.154728.12031895151454434193.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split csum_and_copy_to_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   68 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8820a9e72815..2f8019e3b09a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -698,14 +698,15 @@ static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
 	return csum_block_add(sum, next, off);
 }
 
-static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
-				__wsum *csum, struct iov_iter *i)
+static size_t pipe_csum_and_copy_to_iter(const void *addr, size_t bytes,
+				void *csump, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
 	unsigned int p_mask = pipe->ring_size - 1;
 	unsigned int i_head;
 	size_t n, r;
 	size_t off = 0;
+	__wsum *csum = csump;
 	__wsum sum = *csum;
 
 	if (!sanity(i))
@@ -1914,7 +1915,7 @@ static bool no_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *cs
 	return false;
 }
 
-static size_t xxx_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
+static size_t iovec_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 			     struct iov_iter *i)
 {
 	const char *from = addr;
@@ -1922,15 +1923,8 @@ static size_t xxx_csum_and_copy_to_iter(const void *addr, size_t bytes, void *cs
 	__wsum sum, next;
 	size_t off = 0;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return csum_and_copy_to_pipe_iter(addr, bytes, csum, i);
-
 	sum = *csum;
-	if (unlikely(iov_iter_is_discard(i))) {
-		WARN_ON(1);	/* for now */
-		return 0;
-	}
-	iterate_and_advance(i, bytes, v, ({
+	iterate_and_advance_iovec(i, bytes, v, ({
 		next = csum_and_copy_to_user((from += v.iov_len) - v.iov_len,
 					     v.iov_base,
 					     v.iov_len);
@@ -1939,24 +1933,58 @@ static size_t xxx_csum_and_copy_to_iter(const void *addr, size_t bytes, void *cs
 			off += v.iov_len;
 		}
 		next ? 0 : v.iov_len;
-	}), ({
+	}));
+	*csum = sum;
+	return bytes;
+}
+
+static size_t bvec_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
+			     struct iov_iter *i)
+{
+	const char *from = addr;
+	__wsum *csum = csump;
+	__wsum sum;
+	size_t off = 0;
+
+	sum = *csum;
+	iterate_and_advance_bvec(i, bytes, v, ({
 		char *p = kmap_atomic(v.bv_page);
 		sum = csum_and_memcpy(p + v.bv_offset,
 				      (from += v.bv_len) - v.bv_len,
 				      v.bv_len, sum, off);
 		kunmap_atomic(p);
 		off += v.bv_len;
-	}),({
+	}));
+	*csum = sum;
+	return bytes;
+}
+
+static size_t kvec_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
+			     struct iov_iter *i)
+{
+	const char *from = addr;
+	__wsum *csum = csump;
+	__wsum sum;
+	size_t off = 0;
+
+	sum = *csum;
+	iterate_and_advance_kvec(i, bytes, v, ({
 		sum = csum_and_memcpy(v.iov_base,
 				     (from += v.iov_len) - v.iov_len,
 				     v.iov_len, sum, off);
 		off += v.iov_len;
-	})
-	)
+	}));
 	*csum = sum;
 	return bytes;
 }
 
+static size_t discard_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
+			     struct iov_iter *i)
+{
+	WARN_ON(1);	/* for now */
+	return 0;
+}
+
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
@@ -2256,7 +2284,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= iovec_copy_mc_to_iter,
 #endif
-	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_to_iter		= iovec_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= iovec_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= iovec_csum_and_copy_from_iter_full,
 
@@ -2290,7 +2318,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= kvec_copy_mc_to_iter,
 #endif
-	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_to_iter		= kvec_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= kvec_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= kvec_csum_and_copy_from_iter_full,
 
@@ -2324,7 +2352,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= bvec_copy_mc_to_iter,
 #endif
-	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_to_iter		= bvec_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= bvec_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= bvec_csum_and_copy_from_iter_full,
 
@@ -2358,7 +2386,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= pipe_copy_mc_to_iter,
 #endif
-	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_to_iter		= pipe_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= no_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= no_csum_and_copy_from_iter_full,
 
@@ -2392,7 +2420,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= discard_copy_to_iter,
 #endif
-	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_to_iter		= discard_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= no_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= no_csum_and_copy_from_iter_full,
 



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC812BBFDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgKUORQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728435AbgKUORQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qj6g0VELT0qjcnm2/ASGN+ZeoPWRa3oiC5gcLS/+yjQ=;
        b=A+DIxU1AhBEAYC7MjRjFL80eff8wOjrqbXAfCTfW/yCkblpgC7ulf2Dr4TiHhQjvh0uTb8
        mRpmDZknaEtgrQsZpbRJ36HuoPclqUpP0ZROaEyySteOGeTYtmNCUFwNu3GCpAxjZrP9i1
        98/A7w6HJFEBp54BmgoaRH+7Ul9Dl7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-7wUiTP2RMgKzm_8_wma7kw-1; Sat, 21 Nov 2020 09:17:12 -0500
X-MC-Unique: 7wUiTP2RMgKzm_8_wma7kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93A2B80EF8B;
        Sat, 21 Nov 2020 14:17:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E83885C22B;
        Sat, 21 Nov 2020 14:17:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/29] iov_iter: Remove iterate_all_kinds() and
 iterate_and_advance()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:17:08 +0000
Message-ID: <160596822810.154728.8582333072148760464.stgit@warthog.procyon.org.uk>
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

Remove iterate_all_kinds() and iterate_and_advance() as they're no longer
used, having been split.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   61 --------------------------------------------------------
 1 file changed, 61 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index db798966823e..ba6b60c45103 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -86,26 +86,6 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n);
 	}						\
 }
 
-#define iterate_all_kinds(i, n, v, I, B, K) {			\
-	if (likely(n)) {					\
-		size_t skip = i->iov_offset;			\
-		if (unlikely(iov_iter_type(i) & ITER_BVEC)) {		\
-			struct bio_vec v;			\
-			struct bvec_iter __bi;			\
-			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (unlikely(iov_iter_type(i) & ITER_KVEC)) {	\
-			const struct kvec *kvec;		\
-			struct kvec v;				\
-			iterate_kvec(i, n, v, kvec, skip, (K))	\
-		} else if (unlikely(iov_iter_type(i) & ITER_DISCARD)) {	\
-		} else {					\
-			const struct iovec *iov;		\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
-		}						\
-	}							\
-}
-
 #define iterate_over_iovec(i, n, v, CMD) {			\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
@@ -133,47 +113,6 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n);
 	}							\
 }
 
-#define iterate_and_advance(i, n, v, I, B, K) {			\
-	if (unlikely(i->count < n))				\
-		n = i->count;					\
-	if (i->count) {						\
-		size_t skip = i->iov_offset;			\
-		if (unlikely(iov_iter_type(i) & ITER_BVEC)) {		\
-			const struct bio_vec *bvec = i->bvec;	\
-			struct bio_vec v;			\
-			struct bvec_iter __bi;			\
-			iterate_bvec(i, n, v, __bi, skip, (B))	\
-			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
-			i->nr_segs -= i->bvec - bvec;		\
-			skip = __bi.bi_bvec_done;		\
-		} else if (unlikely(iov_iter_type(i) & ITER_KVEC)) {	\
-			const struct kvec *kvec;		\
-			struct kvec v;				\
-			iterate_kvec(i, n, v, kvec, skip, (K))	\
-			if (skip == kvec->iov_len) {		\
-				kvec++;				\
-				skip = 0;			\
-			}					\
-			i->nr_segs -= kvec - i->kvec;		\
-			i->kvec = kvec;				\
-		} else if (unlikely(iov_iter_type(i) & ITER_DISCARD)) {	\
-			skip += n;				\
-		} else {					\
-			const struct iovec *iov;		\
-			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
-			if (skip == iov->iov_len) {		\
-				iov++;				\
-				skip = 0;			\
-			}					\
-			i->nr_segs -= iov - i->iov;		\
-			i->iov = iov;				\
-		}						\
-		i->count -= n;					\
-		i->iov_offset = skip;				\
-	}							\
-}
-
 #define iterate_and_advance_iovec(i, n, v, CMD) {		\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\



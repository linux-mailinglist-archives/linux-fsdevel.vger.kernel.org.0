Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B146F2BBFB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgKUOPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728215AbgKUOP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9kgWJW9dIIPW9GuwP3JfJltGkxfQ81N7Gf5cW28glQ=;
        b=gUcOGfz5qNUV587QhAQ8B7N+ISUJ2JUIRxJWKt3AUQIIoCNJIVZQ6xsQOZQYrU8oZCfRcL
        ywLfM0A5dYNsHAvd7iuAU+ptYAkBpXV3/nffQQqQUYOFleC5vCkkv8gXa2JS686HFYnmbF
        lbAasVqDns6mRz5AupP4ewtogZdC+nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Eo_K1U2FO26W8OddVM7xzQ-1; Sat, 21 Nov 2020 09:15:23 -0500
X-MC-Unique: Eo_K1U2FO26W8OddVM7xzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 168ED1005D6B;
        Sat, 21 Nov 2020 14:15:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E5165D6BA;
        Sat, 21 Nov 2020 14:15:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/29] iov_iter: Split copy_from_user_atomic()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:19 +0000
Message-ID: <160596811958.154728.14803339635754597304.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split copy_from_user_atomic() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9a167f53ecff..a626d41fef72 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1195,7 +1195,7 @@ static size_t discard_zero(size_t bytes, struct iov_iter *i)
 	return bytes;
 }
 
-static size_t xxx_copy_from_user_atomic(struct page *page,
+static size_t iovec_copy_from_user_atomic(struct page *page,
 		struct iov_iter *i, unsigned long offset, size_t bytes)
 {
 	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
@@ -1203,21 +1203,48 @@ static size_t xxx_copy_from_user_atomic(struct page *page,
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
+	iterate_over_iovec(i, bytes, v,
+		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
+	kunmap_atomic(kaddr);
+	return bytes;
+}
+
+static size_t bvec_copy_from_user_atomic(struct page *page,
+		struct iov_iter *i, unsigned long offset, size_t bytes)
+{
+	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
+	if (unlikely(!page_copy_sane(page, offset, bytes))) {
 		kunmap_atomic(kaddr);
-		WARN_ON(1);
 		return 0;
 	}
-	iterate_all_kinds(i, bytes, v,
-		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+	iterate_over_bvec(i, bytes, v,
 		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
-	)
+				 v.bv_offset, v.bv_len));
 	kunmap_atomic(kaddr);
 	return bytes;
 }
 
+static size_t kvec_copy_from_user_atomic(struct page *page,
+		struct iov_iter *i, unsigned long offset, size_t bytes)
+{
+	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
+	if (unlikely(!page_copy_sane(page, offset, bytes))) {
+		kunmap_atomic(kaddr);
+		return 0;
+	}
+	iterate_over_kvec(i, bytes, v,
+		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
+	kunmap_atomic(kaddr);
+	return bytes;
+}
+
+static size_t no_copy_from_user_atomic(struct page *page,
+		struct iov_iter *i, unsigned long offset, size_t bytes)
+{
+	WARN_ON(1);
+	return 0;
+}
+
 static inline void pipe_truncate(struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
@@ -2046,7 +2073,7 @@ static int xxx_for_each_range(struct iov_iter *i, size_t bytes,
 
 static const struct iov_iter_ops iovec_iter_ops = {
 	.type				= ITER_IOVEC,
-	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.copy_from_user_atomic		= iovec_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= iovec_fault_in_readable,
@@ -2080,7 +2107,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 
 static const struct iov_iter_ops kvec_iter_ops = {
 	.type				= ITER_KVEC,
-	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.copy_from_user_atomic		= kvec_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
@@ -2114,7 +2141,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 
 static const struct iov_iter_ops bvec_iter_ops = {
 	.type				= ITER_BVEC,
-	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.copy_from_user_atomic		= bvec_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
@@ -2148,7 +2175,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 
 static const struct iov_iter_ops pipe_iter_ops = {
 	.type				= ITER_PIPE,
-	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.copy_from_user_atomic		= no_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
@@ -2182,7 +2209,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 
 static const struct iov_iter_ops discard_iter_ops = {
 	.type				= ITER_DISCARD,
-	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.copy_from_user_atomic		= no_copy_from_user_atomic,
 	.advance			= xxx_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,



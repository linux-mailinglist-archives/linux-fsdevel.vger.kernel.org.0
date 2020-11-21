Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F252BBF93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKUOO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728077AbgKUOO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=io9b5GXM3K4SaRCqdO0RNvHKl1y+Lut3sf8uCdt9yCQ=;
        b=XFSKZimYvEsY7uaBXAdbb+ckT32s/Rdh/PA6pwdvNLBNgY3hU6xewYNzYhuEKy46aYlVPQ
        9PhRh39+qEX0MxFk74CtpWBVSguTlq61qPDahhkQNVPTPqLFUzfB6vl+jY5vTXKWIEb9O3
        KqhKby8KJNmN4kxSItVNHJDEMV45OlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-n32Qrx4qM7KKa3j2SHR7Jg-1; Sat, 21 Nov 2020 09:14:21 -0500
X-MC-Unique: n32Qrx4qM7KKa3j2SHR7Jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17701107AD44;
        Sat, 21 Nov 2020 14:14:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 329005C22B;
        Sat, 21 Nov 2020 14:14:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/29] iov_iter: Split copy_from_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:17 +0000
Message-ID: <160596805741.154728.12190794089892831917.stgit@warthog.procyon.org.uk>
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

Split copy_from_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7c1d92f7d020..5b18dfe0dcc7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -863,22 +863,36 @@ static size_t kvec_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_it
 }
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static size_t xxx_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+static size_t iovec_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	if (iter_is_iovec(i))
-		might_fault();
-	iterate_and_advance(i, bytes, v,
-		copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+	might_fault();
+	iterate_and_advance_iovec(i, bytes, v,
+		copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
+
+	return bytes;
+}
+
+static size_t bvec_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	iterate_and_advance_bvec(i, bytes, v,
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
-	)
+				 v.bv_offset, v.bv_len));
+	return bytes;
+}
+
+static size_t kvec_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	iterate_and_advance_kvec(i, bytes, v,
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
+	return bytes;
+}
 
+static size_t no_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	WARN_ON(1);
 	return bytes;
 }
 
@@ -1037,7 +1051,7 @@ static size_t xxx_copy_page_from_iter(struct page *page, size_t offset, size_t b
 	}
 	if (iov_iter_type(i) & (ITER_BVEC|ITER_KVEC)) {
 		void *kaddr = kmap_atomic(page);
-		size_t wanted = xxx_copy_from_iter(kaddr + offset, bytes, i);
+		size_t wanted = copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
 	} else
@@ -1943,7 +1957,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_page_to_iter		= iovec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= iovec_copy_to_iter,
-	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter			= iovec_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
@@ -1977,7 +1991,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= kvec_copy_to_iter,
-	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter			= kvec_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
@@ -2011,7 +2025,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= bvec_copy_to_iter,
-	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter			= bvec_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
@@ -2045,7 +2059,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_page_to_iter		= pipe_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= pipe_copy_to_iter,
-	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
@@ -2079,7 +2093,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_page_to_iter		= discard_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= discard_copy_to_iter,
-	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,



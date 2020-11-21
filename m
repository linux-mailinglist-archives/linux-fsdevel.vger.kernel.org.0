Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A82BBFBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgKUOQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728286AbgKUOQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4NEsUyJ94oX0w8CnfwZML3FMbcbOmVC869wx5bM3lA=;
        b=MvB9o7kAMpzKHSKwG2fzW+67E7R5uBcuaVezrHok96lk4MYH+TKyFTH81P2AuhrOf9R1V4
        xFIMZyNLG+3BiRLfHXKS7mqOzea8ORPLOTciGQwI6lA/AJLMmCbT2bRTR8KBTLeU379Fny
        Uih1OqapZHHDXX2LpRtPWFv/NAyZG3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-WRSH_fD4PlCHu0TtuMO4hQ-1; Sat, 21 Nov 2020 09:15:54 -0500
X-MC-Unique: WRSH_fD4PlCHu0TtuMO4hQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 029F61842142;
        Sat, 21 Nov 2020 14:15:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BBB66085D;
        Sat, 21 Nov 2020 14:15:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/29] iov_iter: Split iov_iter_alignment()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:50 +0000
Message-ID: <160596815051.154728.15434909811290333829.stgit@warthog.procyon.org.uk>
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

Split iov_iter_alignment() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   59 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 90291188ace5..d2a66e951995 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1497,26 +1497,51 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
-static unsigned long xxx_alignment(const struct iov_iter *i)
+static unsigned long iovec_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i))) {
-		unsigned int p_mask = i->pipe->ring_size - 1;
+	iterate_over_iovec(i, size, v,
+		(res |= (unsigned long)v.iov_base | v.iov_len, 0));
+	return res;
+}
 
-		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
-			return size | i->iov_offset;
-		return size;
-	}
-	iterate_all_kinds(i, size, v,
-		(res |= (unsigned long)v.iov_base | v.iov_len, 0),
-		res |= v.bv_offset | v.bv_len,
-		res |= (unsigned long)v.iov_base | v.iov_len
-	)
+static unsigned long bvec_alignment(const struct iov_iter *i)
+{
+	unsigned long res = 0;
+	size_t size = i->count;
+
+	iterate_over_bvec(i, size, v,
+		res |= v.bv_offset | v.bv_len);
 	return res;
 }
 
+static unsigned long kvec_alignment(const struct iov_iter *i)
+{
+	unsigned long res = 0;
+	size_t size = i->count;
+
+	iterate_over_kvec(i, size, v,
+		res |= (unsigned long)v.iov_base | v.iov_len);
+	return res;
+}
+
+static unsigned long pipe_alignment(const struct iov_iter *i)
+{
+	size_t size = i->count;
+	unsigned int p_mask = i->pipe->ring_size - 1;
+
+	if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
+		return size | i->iov_offset;
+	return size;
+}
+
+static unsigned long no_alignment(const struct iov_iter *i)
+{
+	return 0;
+}
+
 static unsigned long xxx_gap_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
@@ -2134,7 +2159,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= iovec_zero,
-	.alignment			= xxx_alignment,
+	.alignment			= iovec_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
@@ -2168,7 +2193,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= kvec_zero,
-	.alignment			= xxx_alignment,
+	.alignment			= kvec_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
@@ -2202,7 +2227,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= bvec_zero,
-	.alignment			= xxx_alignment,
+	.alignment			= bvec_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
@@ -2236,7 +2261,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= pipe_zero,
-	.alignment			= xxx_alignment,
+	.alignment			= pipe_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
@@ -2270,7 +2295,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
 	.zero				= discard_zero,
-	.alignment			= xxx_alignment,
+	.alignment			= no_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,



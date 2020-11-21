Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED92BBFC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgKUOQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728295AbgKUOQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9qDylx4ewpBGOJoY7+LpQLGp85UBysg0NqjPw7tJrk=;
        b=FDnj/pIdnd4aneh+mZg7IPbDBuvgN6Y98tOIgA9cihaanSrlsuers/9dkq7EH2Dp3FLl12
        G6jrBFQH8AapYzSFjMRZKKepVlQe5p7S58VxXO+aQ7u77piexbOAmEFe52q/kMYLjfs+CK
        lawq9D6WdFQ1IXBD6/prsXxfzsK3Ko4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-HeJl7aVjNTez9AGzqE1P7w-1; Sat, 21 Nov 2020 09:16:02 -0500
X-MC-Unique: HeJl7aVjNTez9AGzqE1P7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 929DB1DDE7;
        Sat, 21 Nov 2020 14:16:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F15F55D6BA;
        Sat, 21 Nov 2020 14:15:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/29] iov_iter: Split iov_iter_gap_alignment()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:58 +0000
Message-ID: <160596815823.154728.8595962159705739709.stgit@warthog.procyon.org.uk>
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

Split iov_iter_gap_alignment() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   50 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d2a66e951995..5744ddec854f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1542,27 +1542,45 @@ static unsigned long no_alignment(const struct iov_iter *i)
 	return 0;
 }
 
-static unsigned long xxx_gap_alignment(const struct iov_iter *i)
+static unsigned long iovec_gap_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return ~0U;
-	}
-
-	iterate_all_kinds(i, size, v,
+	iterate_over_iovec(i, size, v,
 		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0), 0),
+			(size != v.iov_len ? size : 0), 0));
+	return res;
+}
+
+static unsigned long bvec_gap_alignment(const struct iov_iter *i)
+{
+	unsigned long res = 0;
+	size_t size = i->count;
+
+	iterate_over_bvec(i, size, v,
 		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
-			(size != v.bv_len ? size : 0)),
+			(size != v.bv_len ? size : 0)));
+	return res;
+}
+
+static unsigned long kvec_gap_alignment(const struct iov_iter *i)
+{
+	unsigned long res = 0;
+	size_t size = i->count;
+
+	iterate_over_kvec(i, size, v,
 		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0))
-		);
+			(size != v.iov_len ? size : 0)));
 	return res;
 }
 
+static unsigned long no_gap_alignment(const struct iov_iter *i)
+{
+	WARN_ON(1);
+	return ~0U;
+}
+
 static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
@@ -2160,7 +2178,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 
 	.zero				= iovec_zero,
 	.alignment			= iovec_alignment,
-	.gap_alignment			= xxx_gap_alignment,
+	.gap_alignment			= iovec_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
@@ -2194,7 +2212,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 
 	.zero				= kvec_zero,
 	.alignment			= kvec_alignment,
-	.gap_alignment			= xxx_gap_alignment,
+	.gap_alignment			= kvec_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
@@ -2228,7 +2246,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 
 	.zero				= bvec_zero,
 	.alignment			= bvec_alignment,
-	.gap_alignment			= xxx_gap_alignment,
+	.gap_alignment			= bvec_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
@@ -2262,7 +2280,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 
 	.zero				= pipe_zero,
 	.alignment			= pipe_alignment,
-	.gap_alignment			= xxx_gap_alignment,
+	.gap_alignment			= no_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,
@@ -2296,7 +2314,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 
 	.zero				= discard_zero,
 	.alignment			= no_alignment,
-	.gap_alignment			= xxx_gap_alignment,
+	.gap_alignment			= no_gap_alignment,
 	.get_pages			= xxx_get_pages,
 	.get_pages_alloc		= xxx_get_pages_alloc,
 	.npages				= xxx_npages,



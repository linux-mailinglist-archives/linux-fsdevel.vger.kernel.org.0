Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC62BBFD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgKUORA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgKUOQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnsHwUz2owKZw0pxEz2d8pMfFj7z+dxze69mcs+0QuY=;
        b=OqJDEQD0x85brkq8/gauMZQdfHXVmsCiLiQ+MSmJ+QxDSSzvFlctylGwe780uo3LVtpFvL
        n1pJxV1Pen85aBFugoq+FaICBzNGUm7HnRIsW0DEY7Mt3c4PlFP46xZklD9SKTF0kRKbkA
        L9IiQUn+MZeMg2eaAuguDcpCatsynX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-oO_5MCQAMwSJuSmormMs6g-1; Sat, 21 Nov 2020 09:16:56 -0500
X-MC-Unique: oO_5MCQAMwSJuSmormMs6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A1B11842155;
        Sat, 21 Nov 2020 14:16:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96FA85C22B;
        Sat, 21 Nov 2020 14:16:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/29] iov_iter: Split dup_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:16:52 +0000
Message-ID: <160596821281.154728.8509303947333815047.stgit@warthog.procyon.org.uk>
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

Split dup_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d8ef6c81c55f..ca0e94596eda 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2078,26 +2078,35 @@ static int discard_npages(const struct iov_iter *i, int maxpages)
 	return 0;
 }
 
-static const void *xxx_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
+static const void *iovec_kvec_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
-	if (unlikely(iov_iter_is_pipe(new))) {
-		WARN_ON(1);
-		return NULL;
-	}
-	if (unlikely(iov_iter_is_discard(new)))
-		return NULL;
-	if (iov_iter_is_bvec(new))
-		return new->bvec = kmemdup(new->bvec,
-				    new->nr_segs * sizeof(struct bio_vec),
-				    flags);
-	else
-		/* iovec and kvec have identical layout */
-		return new->iov = kmemdup(new->iov,
-				   new->nr_segs * sizeof(struct iovec),
+	/* iovec and kvec have identical layout */
+	return new->iov = kmemdup(new->iov,
+				  new->nr_segs * sizeof(struct iovec),
+				  flags);
+}
+
+static const void *bvec_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
+{
+	*new = *old;
+	return new->bvec = kmemdup(new->bvec,
+				   new->nr_segs * sizeof(struct bio_vec),
 				   flags);
 }
 
+static const void *discard_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
+{
+	*new = *old;
+	return NULL;
+}
+
+static const void *no_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
+{
+	WARN_ON(1);
+	return NULL;
+}
+
 static int copy_compat_iovec_from_user(struct iovec *iov,
 		const struct iovec __user *uvec, unsigned long nr_segs)
 {
@@ -2324,7 +2333,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.get_pages			= iovec_get_pages,
 	.get_pages_alloc		= iovec_get_pages_alloc,
 	.npages				= iovec_npages,
-	.dup_iter			= xxx_dup_iter,
+	.dup_iter			= iovec_kvec_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
 
@@ -2358,7 +2367,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.get_pages			= no_get_pages,
 	.get_pages_alloc		= no_get_pages_alloc,
 	.npages				= kvec_npages,
-	.dup_iter			= xxx_dup_iter,
+	.dup_iter			= iovec_kvec_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
 
@@ -2392,7 +2401,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.get_pages			= bvec_get_pages,
 	.get_pages_alloc		= bvec_get_pages_alloc,
 	.npages				= bvec_npages,
-	.dup_iter			= xxx_dup_iter,
+	.dup_iter			= bvec_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
 
@@ -2426,7 +2435,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.get_pages			= pipe_get_pages,
 	.get_pages_alloc		= pipe_get_pages_alloc,
 	.npages				= pipe_npages,
-	.dup_iter			= xxx_dup_iter,
+	.dup_iter			= no_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };
 
@@ -2460,6 +2469,6 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.get_pages			= no_get_pages,
 	.get_pages_alloc		= no_get_pages_alloc,
 	.npages				= discard_npages,
-	.dup_iter			= xxx_dup_iter,
+	.dup_iter			= discard_dup_iter,
 	.for_each_range			= xxx_for_each_range,
 };



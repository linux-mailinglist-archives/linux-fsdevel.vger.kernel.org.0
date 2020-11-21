Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A432BBFB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgKUOPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728225AbgKUOPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lIjo+vSpe3gII8dHaOlAjbgozxM0tOye0nfuL6GBd1k=;
        b=gja71lf9NWMvMDzt0LIJbwstOx+mvINGNuHQJuocWZV3gHGEBlimeyZr/1iQOz/H1JqJU3
        hHgwqqGdZgDZ99XwzcM7aKQjBLLgcnTJ7mpNxy/KkQwWEf0Kusqzrno3LtTJVYdYWPomll
        KuQ9dPgCkConMs9ARwG2JzBvA6dpOx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-MI51AxE4MIayROV3LgzCHw-1; Sat, 21 Nov 2020 09:15:31 -0500
X-MC-Unique: MI51AxE4MIayROV3LgzCHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3C531DDE7;
        Sat, 21 Nov 2020 14:15:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BE7A60C15;
        Sat, 21 Nov 2020 14:15:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/29] iov_iter: Split iov_iter_advance()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:27 +0000
Message-ID: <160596812731.154728.10053807137767432607.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split iov_iter_advance() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a626d41fef72..9859b4b8a116 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1299,17 +1299,24 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 	pipe_truncate(i);
 }
 
-static void xxx_advance(struct iov_iter *i, size_t size)
+static void iovec_advance(struct iov_iter *i, size_t size)
 {
-	if (unlikely(iov_iter_is_pipe(i))) {
-		pipe_advance(i, size);
-		return;
-	}
-	if (unlikely(iov_iter_is_discard(i))) {
-		i->count -= size;
-		return;
-	}
-	iterate_and_advance(i, size, v, 0, 0, 0)
+	iterate_and_advance_iovec(i, size, v, 0)
+}
+
+static void bvec_iov_advance(struct iov_iter *i, size_t size)
+{
+	iterate_and_advance_bvec(i, size, v, 0)
+}
+
+static void kvec_advance(struct iov_iter *i, size_t size)
+{
+	iterate_and_advance_kvec(i, size, v, 0)
+}
+
+static void discard_advance(struct iov_iter *i, size_t size)
+{
+	i->count -= size;
 }
 
 static void xxx_revert(struct iov_iter *i, size_t unroll)
@@ -2074,7 +2081,7 @@ static int xxx_for_each_range(struct iov_iter *i, size_t bytes,
 static const struct iov_iter_ops iovec_iter_ops = {
 	.type				= ITER_IOVEC,
 	.copy_from_user_atomic		= iovec_copy_from_user_atomic,
-	.advance			= xxx_advance,
+	.advance			= iovec_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= iovec_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
@@ -2108,7 +2115,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 static const struct iov_iter_ops kvec_iter_ops = {
 	.type				= ITER_KVEC,
 	.copy_from_user_atomic		= kvec_copy_from_user_atomic,
-	.advance			= xxx_advance,
+	.advance			= kvec_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
@@ -2142,7 +2149,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 static const struct iov_iter_ops bvec_iter_ops = {
 	.type				= ITER_BVEC,
 	.copy_from_user_atomic		= bvec_copy_from_user_atomic,
-	.advance			= xxx_advance,
+	.advance			= bvec_iov_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
@@ -2176,7 +2183,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 static const struct iov_iter_ops pipe_iter_ops = {
 	.type				= ITER_PIPE,
 	.copy_from_user_atomic		= no_copy_from_user_atomic,
-	.advance			= xxx_advance,
+	.advance			= pipe_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
@@ -2210,7 +2217,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 static const struct iov_iter_ops discard_iter_ops = {
 	.type				= ITER_DISCARD,
 	.copy_from_user_atomic		= no_copy_from_user_atomic,
-	.advance			= xxx_advance,
+	.advance			= discard_advance,
 	.revert				= xxx_revert,
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,



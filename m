Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61A2BBF8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgKUOOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgKUOOK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMVXr0SmpHGBj3khS+Fv45yL6polUCT+1h37uSQqPAQ=;
        b=fQ0jq0SfQe9Vx0RKnrAxosnaC8zTLbl6Geqdn+kzgP/zeqAGRUGCNzb54gLqQKDbmtU4Dz
        1NQjTU/bTRwZmZ39hJygPdyYoA2VqqtZGDcAygFEArIbv9bost84zfFyc+KpIMnK0DhHiH
        aFkmvzA0vSMunKKXS17G/vpiueIiv28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-9caVioyUN0WqeRNE9gUNAg-1; Sat, 21 Nov 2020 09:14:05 -0500
X-MC-Unique: 9caVioyUN0WqeRNE9gUNAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4712E80EDAA;
        Sat, 21 Nov 2020 14:14:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 731CD60C15;
        Sat, 21 Nov 2020 14:14:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/29] iov_iter: Split copy_to_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:01 +0000
Message-ID: <160596804162.154728.9403561513393584180.stgit@warthog.procyon.org.uk>
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

Split copy_to_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a221e7771201..0865e0b6eee9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -634,7 +634,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 	return size - left;
 }
 
-static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
+static size_t pipe_copy_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
@@ -703,20 +703,35 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 	return bytes;
 }
 
-static size_t xxx_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+static size_t iovec_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
-	if (unlikely(iov_iter_is_pipe(i)))
-		return copy_pipe_to_iter(addr, bytes, i);
-	if (iter_is_iovec(i))
-		might_fault();
-	iterate_and_advance(i, bytes, v,
-		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
+	might_fault();
+	iterate_and_advance_iovec(i, bytes, v,
+		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len));
+	return bytes;
+}
+
+static size_t bvec_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	iterate_and_advance_bvec(i, bytes, v,
 		memcpy_to_page(v.bv_page, v.bv_offset,
-			       (from += v.bv_len) - v.bv_len, v.bv_len),
-		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
-	)
+			       (from += v.bv_len) - v.bv_len, v.bv_len));
+	return bytes;
+}
 
+static size_t kvec_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	iterate_and_advance_kvec(i, bytes, v,
+		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len));
+	return bytes;
+}
+
+static size_t discard_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	iterate_and_advance_discard(i, bytes);
 	return bytes;
 }
 
@@ -1915,7 +1930,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= iovec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
-	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_to_iter			= iovec_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
@@ -1949,7 +1964,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
-	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_to_iter			= kvec_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
@@ -1983,7 +1998,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
-	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_to_iter			= bvec_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
@@ -2017,7 +2032,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= pipe_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
-	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_to_iter			= pipe_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
@@ -2051,7 +2066,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= discard_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
-	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_to_iter			= discard_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
 	.copy_from_iter_full		= xxx_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,



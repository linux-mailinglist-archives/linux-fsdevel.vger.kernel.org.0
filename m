Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073DC2BBFAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgKUOPQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728178AbgKUOPO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImAvip0pcYDz2Ziq1ISGpj9wOLsuHLQraCd9SE2xGcg=;
        b=QZV70xkOqXL2eEizlQip/PF8zU431M2TE7maDZHLGkO7JLYaxVlISmfWgkEEi2bZoWruNn
        rBr34oknDMhaarQS4T3WV3OT+/AZDvvW21X8tFPWvrsZQf79mUUU1ktVrBaCP/386Fell8
        9NgAHcBq8zlgiKZGHC3+yvMbbz/BMv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-1ygIhq0NPK2LnOwvAFWPPw-1; Sat, 21 Nov 2020 09:15:08 -0500
X-MC-Unique: 1ygIhq0NPK2LnOwvAFWPPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD69B814266;
        Sat, 21 Nov 2020 14:15:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 985E65C234;
        Sat, 21 Nov 2020 14:15:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/29] iov_iter: Split copy_page_from_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:03 +0000
Message-ID: <160596810377.154728.16198787469062466076.stgit@warthog.procyon.org.uk>
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

Split copy_page_from_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 544e532e3e9f..54029aeab3ec 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -344,7 +344,7 @@ static size_t iovec_copy_page_to_iter(struct page *page, size_t offset, size_t b
 	return wanted - bytes;
 }
 
-static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t bytes,
+static size_t iovec_copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	size_t skip, copy, left, wanted;
@@ -352,6 +352,8 @@ static size_t copy_page_from_iter_iovec(struct page *page, size_t offset, size_t
 	char __user *buf;
 	void *kaddr, *to;
 
+	if (unlikely(!page_copy_sane(page, offset, bytes)))
+		return 0;
 	if (unlikely(bytes > i->count))
 		bytes = i->count;
 
@@ -1120,22 +1122,23 @@ static size_t discard_copy_page_to_iter(struct page *page, size_t offset, size_t
 	return bytes;
 }
 
-static size_t xxx_copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
+static size_t bkvec_copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-	if (unlikely(!page_copy_sane(page, offset, bytes)))
-		return 0;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	if (iov_iter_type(i) & (ITER_BVEC|ITER_KVEC)) {
+	size_t wanted = 0;
+	if (likely(page_copy_sane(page, offset, bytes))) {
 		void *kaddr = kmap_atomic(page);
-		size_t wanted = copy_from_iter(kaddr + offset, bytes, i);
+		wanted = copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
-		return wanted;
-	} else
-		return copy_page_from_iter_iovec(page, offset, bytes, i);
+	}
+	return wanted;
+}
+
+static size_t no_copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
+				     struct iov_iter *i)
+{
+	WARN_ON(1);
+	return 0;
 }
 
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
@@ -2035,7 +2038,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.fault_in_readable		= iovec_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= iovec_copy_page_to_iter,
-	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_page_from_iter		= iovec_copy_page_from_iter,
 	.copy_to_iter			= iovec_copy_to_iter,
 	.copy_from_iter			= iovec_copy_from_iter,
 	.copy_from_iter_full		= iovec_copy_from_iter_full,
@@ -2069,7 +2072,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
-	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_page_from_iter		= bkvec_copy_page_from_iter,
 	.copy_to_iter			= kvec_copy_to_iter,
 	.copy_from_iter			= kvec_copy_from_iter,
 	.copy_from_iter_full		= kvec_copy_from_iter_full,
@@ -2103,7 +2106,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
-	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_page_from_iter		= bkvec_copy_page_from_iter,
 	.copy_to_iter			= bvec_copy_to_iter,
 	.copy_from_iter			= bvec_copy_from_iter,
 	.copy_from_iter_full		= bvec_copy_from_iter_full,
@@ -2137,7 +2140,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= pipe_copy_page_to_iter,
-	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_page_from_iter		= no_copy_page_from_iter,
 	.copy_to_iter			= pipe_copy_to_iter,
 	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= no_copy_from_iter_full,
@@ -2171,7 +2174,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.fault_in_readable		= no_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
 	.copy_page_to_iter		= discard_copy_page_to_iter,
-	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_page_from_iter		= no_copy_page_from_iter,
 	.copy_to_iter			= discard_copy_to_iter,
 	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= no_copy_from_iter_full,



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818562BBF82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgKUONs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:13:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727920AbgKUONq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JcWyfdmDr6kJ/GdHDBbHFKPN7p1aKQ7b6+idcK3zWxo=;
        b=SrXwtr6uXmOTaD5PKVbYGHsyTW1cFfp4qWcGRGS+s7wuBjL532xsFa2yrAtwEU9QY0CkCO
        sWyzYXl2J2/YDz7s2e0LTLBqzwABKGn0HZ7SX8jN/qogB2hxoxxP5o0cklMRcrDKagt+Pi
        rdch+QmTNY+GqRv+TDjs9ZvqgMENwu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-vJNJYYrXOdWQ0EgNvmQI8g-1; Sat, 21 Nov 2020 09:13:42 -0500
X-MC-Unique: vJNJYYrXOdWQ0EgNvmQI8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18DF1107AD44;
        Sat, 21 Nov 2020 14:13:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 483236064B;
        Sat, 21 Nov 2020 14:13:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/29] iov_iter: Split copy_page_to_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:13:38 +0000
Message-ID: <160596801844.154728.6494357560297311234.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split copy_page_to_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e403d524c797..fee8e99fbb9c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -19,6 +19,8 @@ static const struct iov_iter_ops bvec_iter_ops;
 static const struct iov_iter_ops pipe_iter_ops;
 static const struct iov_iter_ops discard_iter_ops;
 
+static inline bool page_copy_sane(struct page *page, size_t offset, size_t n);
+
 #define PIPE_PARANOIA /* for now */
 
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
@@ -167,7 +169,7 @@ static int copyin(void *to, const void __user *from, size_t n)
 	return n;
 }
 
-static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
+static size_t iovec_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	size_t skip, copy, left, wanted;
@@ -175,6 +177,8 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 	char __user *buf;
 	void *kaddr, *from;
 
+	if (unlikely(!page_copy_sane(page, offset, bytes)))
+		return 0;
 	if (unlikely(bytes > i->count))
 		bytes = i->count;
 
@@ -378,7 +382,7 @@ static bool sanity(const struct iov_iter *i)
 #define sanity(i) true
 #endif
 
-static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t bytes,
+static size_t pipe_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
@@ -388,6 +392,8 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 	unsigned int i_head = i->head;
 	size_t off;
 
+	if (unlikely(!page_copy_sane(page, offset, bytes)))
+		return 0;
 	if (unlikely(bytes > i->count))
 		bytes = i->count;
 
@@ -910,22 +916,22 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 	return false;
 }
 
-static size_t xxx_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+static size_t bkvec_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-	if (unlikely(!page_copy_sane(page, offset, bytes)))
-		return 0;
-	if (iov_iter_type(i) & (ITER_BVEC|ITER_KVEC)) {
+	size_t wanted = 0;
+	if (likely(page_copy_sane(page, offset, bytes))) {
 		void *kaddr = kmap_atomic(page);
-		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
+		wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
-		return wanted;
-	} else if (unlikely(iov_iter_is_discard(i)))
-		return bytes;
-	else if (likely(!iov_iter_is_pipe(i)))
-		return copy_page_to_iter_iovec(page, offset, bytes, i);
-	else
-		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	}
+	return wanted;
+}
+
+static size_t discard_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+					struct iov_iter *i)
+{
+	return bytes;
 }
 
 static size_t xxx_copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
@@ -1842,7 +1848,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.revert				= xxx_revert,
 	.fault_in_readable		= xxx_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
-	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_to_iter		= iovec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= xxx_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
@@ -1876,7 +1882,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.revert				= xxx_revert,
 	.fault_in_readable		= xxx_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
-	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= xxx_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
@@ -1910,7 +1916,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.revert				= xxx_revert,
 	.fault_in_readable		= xxx_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
-	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= xxx_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
@@ -1944,7 +1950,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.revert				= xxx_revert,
 	.fault_in_readable		= xxx_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
-	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_to_iter		= pipe_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= xxx_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,
@@ -1978,7 +1984,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.revert				= xxx_revert,
 	.fault_in_readable		= xxx_fault_in_readable,
 	.single_seg_count		= xxx_single_seg_count,
-	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_to_iter		= discard_copy_page_to_iter,
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= xxx_copy_to_iter,
 	.copy_from_iter			= xxx_copy_from_iter,



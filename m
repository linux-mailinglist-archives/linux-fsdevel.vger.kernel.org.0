Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28B2BBFD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKUORK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbgKUORI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d87qXzclWdjG5Yvx06kiTnj6d7IqmRDOIVlZdO+mdY0=;
        b=PofveTjnytimYUIVC87JLHMEiM9t+4qozd8ojf2/C73MIBhxfA41dA/NZZ6CNguJG7RO4C
        hYxe6TKtryvd4SbUDH2SF6Fjb4vj2uIm+t6TyB+xK+EyCvttLhFU6IdcJJO0gQcuZ1xmQB
        NFM84MieTefy4ULewGyYKpTgZHgNmLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-1lZL9I3jOhi78lr1D53rOw-1; Sat, 21 Nov 2020 09:17:04 -0500
X-MC-Unique: 1lZL9I3jOhi78lr1D53rOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D66688042C6;
        Sat, 21 Nov 2020 14:17:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AD65C22B;
        Sat, 21 Nov 2020 14:17:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/29] iov_iter: Split iov_iter_for_each_range()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:17:00 +0000
Message-ID: <160596822038.154728.6350968091336040046.stgit@warthog.procyon.org.uk>
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

Split iov_iter_for_each_range() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ca0e94596eda..db798966823e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2282,7 +2282,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
 }
 EXPORT_SYMBOL(import_single_range);
 
-static int xxx_for_each_range(struct iov_iter *i, size_t bytes,
+static int bvec_for_each_range(struct iov_iter *i, size_t bytes,
 			    int (*f)(struct kvec *vec, void *context),
 			    void *context)
 {
@@ -2291,18 +2291,39 @@ static int xxx_for_each_range(struct iov_iter *i, size_t bytes,
 	if (!bytes)
 		return 0;
 
-	iterate_all_kinds(i, bytes, v, -EINVAL, ({
+	iterate_over_bvec(i, bytes, v, ({
 		w.iov_base = kmap(v.bv_page) + v.bv_offset;
 		w.iov_len = v.bv_len;
 		err = f(&w, context);
 		kunmap(v.bv_page);
-		err;}), ({
+		err;
+	}));
+	return err;
+}
+
+static int kvec_for_each_range(struct iov_iter *i, size_t bytes,
+			    int (*f)(struct kvec *vec, void *context),
+			    void *context)
+{
+	struct kvec w;
+	int err = -EINVAL;
+	if (!bytes)
+		return 0;
+
+	iterate_over_kvec(i, bytes, v, ({
 		w = v;
-		err = f(&w, context);})
-	)
+		err = f(&w, context);
+	}));
 	return err;
 }
 
+static int no_for_each_range(struct iov_iter *i, size_t bytes,
+			    int (*f)(struct kvec *vec, void *context),
+			    void *context)
+{
+	return !bytes ? 0 : -EINVAL;
+}
+
 static const struct iov_iter_ops iovec_iter_ops = {
 	.type				= ITER_IOVEC,
 	.copy_from_user_atomic		= iovec_copy_from_user_atomic,
@@ -2334,7 +2355,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.get_pages_alloc		= iovec_get_pages_alloc,
 	.npages				= iovec_npages,
 	.dup_iter			= iovec_kvec_dup_iter,
-	.for_each_range			= xxx_for_each_range,
+	.for_each_range			= no_for_each_range,
 };
 
 static const struct iov_iter_ops kvec_iter_ops = {
@@ -2368,7 +2389,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.get_pages_alloc		= no_get_pages_alloc,
 	.npages				= kvec_npages,
 	.dup_iter			= iovec_kvec_dup_iter,
-	.for_each_range			= xxx_for_each_range,
+	.for_each_range			= kvec_for_each_range,
 };
 
 static const struct iov_iter_ops bvec_iter_ops = {
@@ -2402,7 +2423,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.get_pages_alloc		= bvec_get_pages_alloc,
 	.npages				= bvec_npages,
 	.dup_iter			= bvec_dup_iter,
-	.for_each_range			= xxx_for_each_range,
+	.for_each_range			= bvec_for_each_range,
 };
 
 static const struct iov_iter_ops pipe_iter_ops = {
@@ -2436,7 +2457,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.get_pages_alloc		= pipe_get_pages_alloc,
 	.npages				= pipe_npages,
 	.dup_iter			= no_dup_iter,
-	.for_each_range			= xxx_for_each_range,
+	.for_each_range			= no_for_each_range,
 };
 
 static const struct iov_iter_ops discard_iter_ops = {
@@ -2470,5 +2491,5 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.get_pages_alloc		= no_get_pages_alloc,
 	.npages				= discard_npages,
 	.dup_iter			= discard_dup_iter,
-	.for_each_range			= xxx_for_each_range,
+	.for_each_range			= no_for_each_range,
 };



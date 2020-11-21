Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B222BBF9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgKUOOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728112AbgKUOOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYwhg3i3DgX8/KOErE9/+meufmLn4/JOQzdQe5HA0zA=;
        b=TazDcVbO5evOtOl3WAqdSm+O7RA9ordXSHiVpPQ1fl+AQdymhKgHbXtWzkUUR75+zNeHTQ
        eLWwn1lUuMl6kCjC0gh6t8KmFL1EzBuou55nL8PijbTAnpsFueXsMDSKka4G3MEhjxOPjq
        wXq4LO4xO6YHY+cdwLHTR+ksplOWil8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-NJtFoOwfOlS7D78FCgVuVw-1; Sat, 21 Nov 2020 09:14:37 -0500
X-MC-Unique: NJtFoOwfOlS7D78FCgVuVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8494C1005D65;
        Sat, 21 Nov 2020 14:14:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1CAA6085D;
        Sat, 21 Nov 2020 14:14:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/29] iov_iter: Split copy_from_iter_full()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:32 +0000
Message-ID: <160596807288.154728.10950334371240472423.stgit@warthog.procyon.org.uk>
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

Split copy_from_iter_full() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   59 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 934193627540..3dba665a1ee9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -923,32 +923,55 @@ static size_t no_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 	return bytes;
 }
 
-static bool xxx_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+static bool iovec_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return false;
-	}
+
 	if (unlikely(i->count < bytes))
 		return false;
 
-	if (iter_is_iovec(i))
-		might_fault();
-	iterate_all_kinds(i, bytes, v, ({
+	might_fault();
+	iterate_over_iovec(i, bytes, v, ({
 		if (copyin((to += v.iov_len) - v.iov_len,
-				      v.iov_base, v.iov_len))
+			   v.iov_base, v.iov_len))
 			return false;
-		0;}),
+		0;}));
+	iov_iter_advance(i, bytes);
+	return true;
+}
+
+static bool bvec_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+
+	if (unlikely(i->count < bytes))
+		return false;
+	iterate_over_bvec(i, bytes, v,
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
-	)
+				 v.bv_offset, v.bv_len));
+	iov_iter_advance(i, bytes);
+	return true;
+}
+
+static bool kvec_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
 
+	if (unlikely(i->count < bytes))
+		return false;
+
+	iterate_over_kvec(i, bytes, v,
+	       memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
 	iov_iter_advance(i, bytes);
 	return true;
 }
 
+static bool no_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+{
+	WARN_ON(1);
+	return false;
+}
+
 static size_t xxx_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
@@ -1985,7 +2008,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= iovec_copy_to_iter,
 	.copy_from_iter			= iovec_copy_from_iter,
-	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_full		= iovec_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
@@ -2019,7 +2042,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= kvec_copy_to_iter,
 	.copy_from_iter			= kvec_copy_from_iter,
-	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_full		= kvec_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
@@ -2053,7 +2076,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= bvec_copy_to_iter,
 	.copy_from_iter			= bvec_copy_from_iter,
-	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_full		= bvec_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
@@ -2087,7 +2110,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= pipe_copy_to_iter,
 	.copy_from_iter			= no_copy_from_iter,
-	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_full		= no_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
@@ -2121,7 +2144,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_page_from_iter		= xxx_copy_page_from_iter,
 	.copy_to_iter			= discard_copy_to_iter,
 	.copy_from_iter			= no_copy_from_iter,
-	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_full		= no_copy_from_iter_full,
 	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B3D2BBF9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKUOO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728145AbgKUOO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ni5MPjwKtqOf/JECYK0nOWDI9zN4ZAqVX24jMSlVJjE=;
        b=gHWyXz+Tq07ksNJR4b3WtxH5QboTW7quBb6jw686/QVfq4yy+UHEP1yR6mfXeu4DJGskKT
        8pn0H1hxgfwutsu7mpCRz3tuGiLHwwOk0d+pv4fmsqjRXz4J3b4YxN+bY2/1o/Hu8r184R
        KJy0JFXYqAul4mnpwuFoR3gdyuxEyGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-z7_-QuhqN5ODuAEHuaWKyg-1; Sat, 21 Nov 2020 09:14:52 -0500
X-MC-Unique: z7_-QuhqN5ODuAEHuaWKyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE5521DDE7;
        Sat, 21 Nov 2020 14:14:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C85C5D6BA;
        Sat, 21 Nov 2020 14:14:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/29] iov_iter: Split copy_from_iter_flushcache()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:48 +0000
Message-ID: <160596808849.154728.14090146839666312433.stgit@warthog.procyon.org.uk>
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

Split copy_from_iter_flushcache() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c57c2171f730..6b4739d7dd9a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1000,7 +1000,7 @@ static size_t kvec_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_i
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
- * _copy_from_iter_flushcache - write destination through cpu cache
+ * copy_from_iter_flushcache - write destination through cpu cache
  * @addr: destination kernel address
  * @bytes: total transfer length
  * @iter: source iterator
@@ -1013,22 +1013,30 @@ static size_t kvec_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_i
  * bypass the cache for the ITER_IOVEC case, and on some archs may use
  * instructions that strand dirty-data in the cache.
  */
-static size_t xxx_copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
+static size_t iovec_copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	iterate_and_advance(i, bytes, v,
+	iterate_and_advance_iovec(i, bytes, v,
 		__copy_from_user_flushcache((to += v.iov_len) - v.iov_len,
-					 v.iov_base, v.iov_len),
+					    v.iov_base, v.iov_len));
+	return bytes;
+}
+
+static size_t bvec_copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	iterate_and_advance_bvec(i, bytes, v,
 		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy_flushcache((to += v.iov_len) - v.iov_len, v.iov_base,
-			v.iov_len)
-	)
+				 v.bv_offset, v.bv_len));
+	return bytes;
+}
 
+static size_t kvec_copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	iterate_and_advance_kvec(i, bytes, v,
+		memcpy_flushcache((to += v.iov_len) - v.iov_len, v.iov_base,
+			v.iov_len));
 	return bytes;
 }
 #endif
@@ -2020,7 +2028,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_from_iter_nocache		= iovec_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+	.copy_from_iter_flushcache	= iovec_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= iovec_copy_mc_to_iter,
@@ -2054,7 +2062,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_from_iter_nocache		= kvec_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+	.copy_from_iter_flushcache	= kvec_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= kvec_copy_mc_to_iter,
@@ -2088,7 +2096,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_from_iter_nocache		= bvec_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+	.copy_from_iter_flushcache	= bvec_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= bvec_copy_mc_to_iter,
@@ -2122,7 +2130,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_from_iter_nocache		= no_copy_from_iter,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+	.copy_from_iter_flushcache	= no_copy_from_iter,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= pipe_copy_mc_to_iter,
@@ -2156,7 +2164,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_from_iter_nocache		= no_copy_from_iter,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+	.copy_from_iter_flushcache	= no_copy_from_iter,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 	.copy_mc_to_iter		= discard_copy_to_iter,



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94022BBF9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgKUOOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbgKUOOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRdtaSmCdug5+jFBzzaX1HskS8uwScH3nKxj3/t7xpo=;
        b=R7Ziw8r6x8YROxYVvpse4xBadCbZ1a9k8MBm8hL3DZ6DbCpbpB03RREocDbJHSDCAEYtGO
        GxawUo51XBL/BhcGexQ1v82g1ve9VTxSwijEUmt99eHecW7VhlS/VTHUHrnSbX68487kLn
        E10yqJoYGvm9p79tI41hdr8M6w/klcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-jgjAXMVQNoecXTGmFFrtug-1; Sat, 21 Nov 2020 09:14:44 -0500
X-MC-Unique: jgjAXMVQNoecXTGmFFrtug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41F721DDE7;
        Sat, 21 Nov 2020 14:14:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD4C5C22B;
        Sat, 21 Nov 2020 14:14:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/29] iov_iter: Split copy_from_iter_nocache()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:40 +0000
Message-ID: <160596808077.154728.7004427791292645021.stgit@warthog.procyon.org.uk>
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

Split copy_from_iter_nocache() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3dba665a1ee9..c57c2171f730 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -972,21 +972,29 @@ static bool no_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 	return false;
 }
 
-static size_t xxx_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
+static size_t iovec_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(iov_iter_is_pipe(i))) {
-		WARN_ON(1);
-		return 0;
-	}
-	iterate_and_advance(i, bytes, v,
+	iterate_and_advance_iovec(i, bytes, v,
 		__copy_from_user_inatomic_nocache((to += v.iov_len) - v.iov_len,
-					 v.iov_base, v.iov_len),
+						  v.iov_base, v.iov_len));
+	return bytes;
+}
+
+static size_t bvec_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	iterate_and_advance_bvec(i, bytes, v,
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
-				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
-	)
+				 v.bv_offset, v.bv_len));
+	return bytes;
+}
 
+static size_t kvec_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	char *to = addr;
+	iterate_and_advance_kvec(i, bytes, v,
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len));
 	return bytes;
 }
 
@@ -2009,7 +2017,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_to_iter			= iovec_copy_to_iter,
 	.copy_from_iter			= iovec_copy_from_iter,
 	.copy_from_iter_full		= iovec_copy_from_iter_full,
-	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_nocache		= iovec_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
@@ -2043,7 +2051,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_to_iter			= kvec_copy_to_iter,
 	.copy_from_iter			= kvec_copy_from_iter,
 	.copy_from_iter_full		= kvec_copy_from_iter_full,
-	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_nocache		= kvec_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
@@ -2077,7 +2085,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_to_iter			= bvec_copy_to_iter,
 	.copy_from_iter			= bvec_copy_from_iter,
 	.copy_from_iter_full		= bvec_copy_from_iter_full,
-	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_nocache		= bvec_copy_from_iter_nocache,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
@@ -2111,7 +2119,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_to_iter			= pipe_copy_to_iter,
 	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= no_copy_from_iter_full,
-	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_nocache		= no_copy_from_iter,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
@@ -2145,7 +2153,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_to_iter			= discard_copy_to_iter,
 	.copy_from_iter			= no_copy_from_iter,
 	.copy_from_iter_full		= no_copy_from_iter_full,
-	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_nocache		= no_copy_from_iter,
 	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,



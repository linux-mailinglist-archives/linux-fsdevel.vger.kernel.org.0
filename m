Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85392BBF90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKUOOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728040AbgKUOOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cts/UysbCeke0SRrY+6cxZefIvVJUV/6NiBfhTcZI1c=;
        b=BlVA+lnGqGffc6nIFQ/igEg8utlPIK9OhyA5WDt4jwRua3eRP3WcXbKu+7gH715pLuHBik
        inr2AKj2JuDfy/6SPh7jYL6bBq1RpVyNMQfTMbUxKXUvk/v6GDM0GYsagZkgRwjYm5R3XH
        r2e2bput9vEi/6z5jr+loPh2sO/QOCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-05YIL5MQOp25jyuwwWcgug-1; Sat, 21 Nov 2020 09:14:13 -0500
X-MC-Unique: 05YIL5MQOp25jyuwwWcgug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD94804766;
        Sat, 21 Nov 2020 14:14:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59C9D5C253;
        Sat, 21 Nov 2020 14:14:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/29] iov_iter: Split copy_mc_to_iter()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:14:09 +0000
Message-ID: <160596804951.154728.12388891412575059303.stgit@warthog.procyon.org.uk>
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

Split copy_mc_to_iter() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   54 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0865e0b6eee9..7c1d92f7d020 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -758,7 +758,7 @@ static unsigned long copy_mc_to_page(struct page *page, size_t offset,
 	return ret;
 }
 
-static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
+static size_t pipe_copy_mc_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
@@ -815,18 +815,23 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
  *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
  *   a short copy.
  */
-static size_t xxx_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+static size_t iovec_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
-	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return copy_mc_pipe_to_iter(addr, bytes, i);
-	if (iter_is_iovec(i))
-		might_fault();
-	iterate_and_advance(i, bytes, v,
+	might_fault();
+	iterate_and_advance_iovec(i, bytes, v,
 		copyout_mc(v.iov_base, (from += v.iov_len) - v.iov_len,
-			   v.iov_len),
+			   v.iov_len));
+	return bytes;
+}
+
+static size_t bvec_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
+
+	iterate_and_advance_bvec(i, bytes, v,
 		({
 		rem = copy_mc_to_page(v.bv_page, v.bv_offset,
 				      (from += v.bv_len) - v.bv_len, v.bv_len);
@@ -835,18 +840,25 @@ static size_t xxx_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_ite
 			bytes = curr_addr - s_addr - rem;
 			return bytes;
 		}
-		}),
-		({
-		rem = copy_mc_to_kernel(v.iov_base, (from += v.iov_len)
-					- v.iov_len, v.iov_len);
+		}))
+	return bytes;
+}
+
+static size_t kvec_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
+
+	iterate_and_advance_kvec(i, bytes, v, ({
+		rem = copy_mc_to_kernel(v.iov_base,
+					(from += v.iov_len) - v.iov_len,
+					v.iov_len);
 		if (rem) {
 			curr_addr = (unsigned long) from;
 			bytes = curr_addr - s_addr - rem;
 			return bytes;
 		}
-		})
-	)
-
+		}));
 	return bytes;
 }
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
@@ -1939,7 +1951,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+	.copy_mc_to_iter		= iovec_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
@@ -1973,7 +1985,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+	.copy_mc_to_iter		= kvec_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
@@ -2007,7 +2019,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+	.copy_mc_to_iter		= bvec_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
@@ -2041,7 +2053,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+	.copy_mc_to_iter		= pipe_copy_mc_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
@@ -2075,7 +2087,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
 #endif
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+	.copy_mc_to_iter		= discard_copy_to_iter,
 #endif
 	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,



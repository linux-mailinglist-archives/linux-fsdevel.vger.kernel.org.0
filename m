Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21E2BBFAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgKUOPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbgKUOPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24lXXSwLkr6iyJf1PKmI6Pby4jsOo+WBOkmoFqT5dpA=;
        b=Fr5Gd+U8vWrL7aE5oh4HAGx9eRXzjqQrnsCaXdYRsBryviH9Mb8k7YJ48gdcbWUxkRptUF
        1asF9ov9/a3XxwtPgBY7GGeLLqI/XLB0VUTedFKDLbLhprhrtsxs5b9KH45KtqR3Seiord
        i1EB+aZlMvtZUm15GQa4IpvQV4xoe+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-sZqBLL8mPSWhZLjZCn95iQ-1; Sat, 21 Nov 2020 09:15:15 -0500
X-MC-Unique: sZqBLL8mPSWhZLjZCn95iQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C4B31005D65;
        Sat, 21 Nov 2020 14:15:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6F915D6BA;
        Sat, 21 Nov 2020 14:15:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/29] iov_iter: Split iov_iter_zero()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:12 +0000
Message-ID: <160596811200.154728.9144901939425608415.stgit@warthog.procyon.org.uk>
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

Split iov_iter_zero() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 54029aeab3ec..9a167f53ecff 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1168,16 +1168,30 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 	return bytes;
 }
 
-static size_t xxx_zero(size_t bytes, struct iov_iter *i)
+static size_t iovec_zero(size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i)))
-		return pipe_zero(bytes, i);
-	iterate_and_advance(i, bytes, v,
-		clear_user(v.iov_base, v.iov_len),
-		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
-		memset(v.iov_base, 0, v.iov_len)
-	)
+	iterate_and_advance_iovec(i, bytes, v,
+		clear_user(v.iov_base, v.iov_len));
+	return bytes;
+}
 
+static size_t bvec_zero(size_t bytes, struct iov_iter *i)
+{
+	iterate_and_advance_bvec(i, bytes, v,
+		memzero_page(v.bv_page, v.bv_offset, v.bv_len));
+	return bytes;
+}
+
+static size_t kvec_zero(size_t bytes, struct iov_iter *i)
+{
+	iterate_and_advance_kvec(i, bytes, v,
+		memset(v.iov_base, 0, v.iov_len));
+	return bytes;
+}
+
+static size_t discard_zero(size_t bytes, struct iov_iter *i)
+{
+	iterate_and_advance_discard(i, bytes);
 	return bytes;
 }
 
@@ -2054,7 +2068,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
-	.zero				= xxx_zero,
+	.zero				= iovec_zero,
 	.alignment			= xxx_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
@@ -2088,7 +2102,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
-	.zero				= xxx_zero,
+	.zero				= kvec_zero,
 	.alignment			= xxx_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
@@ -2122,7 +2136,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
-	.zero				= xxx_zero,
+	.zero				= bvec_zero,
 	.alignment			= xxx_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
@@ -2156,7 +2170,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
-	.zero				= xxx_zero,
+	.zero				= pipe_zero,
 	.alignment			= xxx_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,
@@ -2190,7 +2204,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
 	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
 
-	.zero				= xxx_zero,
+	.zero				= discard_zero,
 	.alignment			= xxx_alignment,
 	.gap_alignment			= xxx_gap_alignment,
 	.get_pages			= xxx_get_pages,



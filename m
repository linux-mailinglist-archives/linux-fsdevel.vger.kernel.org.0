Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8A2BBFBA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKUOPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728258AbgKUOPv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XP3mnUJc4mxTb6vHs3+R4NsGbX5N4I46o5CgY2C0v48=;
        b=VM/OBmsRXfpXfA0JdrlOCSqd3RRT25BIWRiG9Yl6LY7YSl4NfEgOgAjMUtcZWrYKjPLFWH
        uxyNoiYUj4l6G6wyhQFIguf7pXtR4ye2pOc98f+1vlIGbkISjkv4pcu4QsBeVPGbt67Usn
        5uj18nl2F/8426cmDlTHH1FgoNfoKQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-W_XtH6zlM8uyYu3poeiBQw-1; Sat, 21 Nov 2020 09:15:46 -0500
X-MC-Unique: W_XtH6zlM8uyYu3poeiBQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 469471DDE8;
        Sat, 21 Nov 2020 14:15:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70A4C5D6CF;
        Sat, 21 Nov 2020 14:15:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/29] iov_iter: Split iov_iter_single_seg_count()
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:15:42 +0000
Message-ID: <160596814260.154728.8650477861968611110.stgit@warthog.procyon.org.uk>
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

Split iov_iter_single_seg_count() by type.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 lib/iov_iter.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b8e3da20547e..90291188ace5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1415,18 +1415,23 @@ static void discard_revert(struct iov_iter *i, size_t unroll)
 /*
  * Return the count of just the current iov_iter segment.
  */
-static size_t xxx_single_seg_count(const struct iov_iter *i)
+static size_t iovec_kvec_single_seg_count(const struct iov_iter *i)
 {
-	if (unlikely(iov_iter_is_pipe(i)))
-		return i->count;	// it is a silly place, anyway
 	if (i->nr_segs == 1)
 		return i->count;
-	if (unlikely(iov_iter_is_discard(i)))
+	return min(i->count, i->iov->iov_len - i->iov_offset);
+}
+
+static size_t bvec_single_seg_count(const struct iov_iter *i)
+{
+	if (i->nr_segs == 1)
 		return i->count;
-	else if (iov_iter_is_bvec(i))
-		return min(i->count, i->bvec->bv_len - i->iov_offset);
-	else
-		return min(i->count, i->iov->iov_len - i->iov_offset);
+	return min(i->count, i->bvec->bv_len - i->iov_offset);
+}
+
+static size_t simple_single_seg_count(const struct iov_iter *i)
+{
+	return i->count;
 }
 
 void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
@@ -2110,7 +2115,7 @@ static const struct iov_iter_ops iovec_iter_ops = {
 	.advance			= iovec_advance,
 	.revert				= iovec_kvec_revert,
 	.fault_in_readable		= iovec_fault_in_readable,
-	.single_seg_count		= xxx_single_seg_count,
+	.single_seg_count		= iovec_kvec_single_seg_count,
 	.copy_page_to_iter		= iovec_copy_page_to_iter,
 	.copy_page_from_iter		= iovec_copy_page_from_iter,
 	.copy_to_iter			= iovec_copy_to_iter,
@@ -2144,7 +2149,7 @@ static const struct iov_iter_ops kvec_iter_ops = {
 	.advance			= kvec_advance,
 	.revert				= iovec_kvec_revert,
 	.fault_in_readable		= no_fault_in_readable,
-	.single_seg_count		= xxx_single_seg_count,
+	.single_seg_count		= iovec_kvec_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= bkvec_copy_page_from_iter,
 	.copy_to_iter			= kvec_copy_to_iter,
@@ -2178,7 +2183,7 @@ static const struct iov_iter_ops bvec_iter_ops = {
 	.advance			= bvec_iov_advance,
 	.revert				= bvec_revert,
 	.fault_in_readable		= no_fault_in_readable,
-	.single_seg_count		= xxx_single_seg_count,
+	.single_seg_count		= bvec_single_seg_count,
 	.copy_page_to_iter		= bkvec_copy_page_to_iter,
 	.copy_page_from_iter		= bkvec_copy_page_from_iter,
 	.copy_to_iter			= bvec_copy_to_iter,
@@ -2212,7 +2217,7 @@ static const struct iov_iter_ops pipe_iter_ops = {
 	.advance			= pipe_advance,
 	.revert				= pipe_revert,
 	.fault_in_readable		= no_fault_in_readable,
-	.single_seg_count		= xxx_single_seg_count,
+	.single_seg_count		= simple_single_seg_count,
 	.copy_page_to_iter		= pipe_copy_page_to_iter,
 	.copy_page_from_iter		= no_copy_page_from_iter,
 	.copy_to_iter			= pipe_copy_to_iter,
@@ -2246,7 +2251,7 @@ static const struct iov_iter_ops discard_iter_ops = {
 	.advance			= discard_advance,
 	.revert				= discard_revert,
 	.fault_in_readable		= no_fault_in_readable,
-	.single_seg_count		= xxx_single_seg_count,
+	.single_seg_count		= simple_single_seg_count,
 	.copy_page_to_iter		= discard_copy_page_to_iter,
 	.copy_page_from_iter		= no_copy_page_from_iter,
 	.copy_to_iter			= discard_copy_to_iter,



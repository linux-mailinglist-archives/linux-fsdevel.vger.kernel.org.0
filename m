Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F2939D0AE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFFTND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhFFTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6334C061795;
        Sun,  6 Jun 2021 12:10:55 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056bM-FZ; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 24/37] iov_iter: unify iterate_iovec and iterate_kvec
Date:   Sun,  6 Jun 2021 19:10:38 +0000
Message-Id: <20210606191051.1216821-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The differences between iterate_iovec and iterate_kvec are minor:
	* kvec callback is treated as if it returned 0
	* initialization of __p is with i->iov and i->kvec resp.
which is trivially dealt with.

No code generation changes - compiler is quite capable of turning
	left = ((void)(STEP), 0);
	__v.iov_len -= left;
(with no accesses to left downstream) and
	(void)(STEP);
into the same code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 578f40788943..19c103e9ef7d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -16,10 +16,10 @@
 
 #define PIPE_PARANOIA /* for now */
 
+/* covers iovec and kvec alike */
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {		\
 	size_t left;						\
 	size_t wanted = n;					\
-	__p = i->iov;						\
 	do {							\
 		__v.iov_len = min(n, __p->iov_len - skip);	\
 		if (likely(__v.iov_len)) {			\
@@ -37,25 +37,6 @@
 	n = wanted - n;						\
 }
 
-#define iterate_kvec(i, n, __v, __p, skip, STEP) {		\
-	size_t wanted = n;					\
-	__p = i->kvec;						\
-	do {							\
-		__v.iov_len = min(n, __p->iov_len - skip);	\
-		if (likely(__v.iov_len)) {			\
-			__v.iov_base = __p->iov_base + skip;	\
-			(void)(STEP);				\
-			skip += __v.iov_len;			\
-			n -= __v.iov_len;			\
-			if (skip < __p->iov_len)		\
-				break;				\
-		}						\
-		__p++;						\
-		skip = 0;					\
-	} while (n);						\
-	n = wanted - n;						\
-}
-
 #define iterate_bvec(i, n, __v, __bi, skip, STEP) {	\
 	struct bvec_iter __start;			\
 	__start.bi_size = n;				\
@@ -109,7 +90,7 @@
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
 		if (likely(iter_is_iovec(i))) {			\
-			const struct iovec *iov;		\
+			const struct iovec *iov = i->iov;	\
 			struct iovec v;				\
 			iterate_iovec(i, n, v, iov, skip, (I))	\
 			i->nr_segs -= iov - i->iov;		\
@@ -123,9 +104,10 @@
 			i->nr_segs -= i->bvec - bvec;		\
 			skip = __bi.bi_bvec_done;		\
 		} else if (iov_iter_is_kvec(i)) {		\
-			const struct kvec *kvec;		\
+			const struct kvec *kvec = i->kvec;	\
 			struct kvec v;				\
-			iterate_kvec(i, n, v, kvec, skip, (K))	\
+			iterate_iovec(i, n, v, kvec, skip,	\
+						((void)(K),0))	\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
-- 
2.11.0


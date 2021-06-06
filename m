Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A125D39D0B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFFTNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFFTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86337C0613A2;
        Sun,  6 Jun 2021 12:10:56 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056bG-Cj; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 23/37] iov_iter: massage iterate_iovec and iterate_kvec to logics similar to iterate_bvec
Date:   Sun,  6 Jun 2021 19:10:37 +0000
Message-Id: <20210606191051.1216821-23-viro@zeniv.linux.org.uk>
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

Premature optimization is the root of all evil...  Trying
to unroll the first pass through the loop makes it harder
to follow and not just for readers - compiler ends up
generating worse code than it would on a "non-optimized"
loop.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 91 +++++++++++++++++++++++-----------------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ebb907c6393c..578f40788943 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -16,55 +16,44 @@
 
 #define PIPE_PARANOIA /* for now */
 
-#define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
-	size_t left;					\
-	size_t wanted = n;				\
-	__p = i->iov;					\
-	__v.iov_len = min(n, __p->iov_len - skip);	\
-	if (likely(__v.iov_len)) {			\
-		__v.iov_base = __p->iov_base + skip;	\
-		left = (STEP);				\
-		__v.iov_len -= left;			\
-		skip += __v.iov_len;			\
-		n -= __v.iov_len;			\
-	} else {					\
-		left = 0;				\
-	}						\
-	while (unlikely(!left && n)) {			\
-		__p++;					\
-		__v.iov_len = min(n, __p->iov_len);	\
-		if (unlikely(!__v.iov_len))		\
-			continue;			\
-		__v.iov_base = __p->iov_base;		\
-		left = (STEP);				\
-		__v.iov_len -= left;			\
-		skip = __v.iov_len;			\
-		n -= __v.iov_len;			\
-	}						\
-	n = wanted - n;					\
+#define iterate_iovec(i, n, __v, __p, skip, STEP) {		\
+	size_t left;						\
+	size_t wanted = n;					\
+	__p = i->iov;						\
+	do {							\
+		__v.iov_len = min(n, __p->iov_len - skip);	\
+		if (likely(__v.iov_len)) {			\
+			__v.iov_base = __p->iov_base + skip;	\
+			left = (STEP);				\
+			__v.iov_len -= left;			\
+			skip += __v.iov_len;			\
+			n -= __v.iov_len;			\
+			if (skip < __p->iov_len)		\
+				break;				\
+		}						\
+		__p++;						\
+		skip = 0;					\
+	} while (n);						\
+	n = wanted - n;						\
 }
 
-#define iterate_kvec(i, n, __v, __p, skip, STEP) {	\
-	size_t wanted = n;				\
-	__p = i->kvec;					\
-	__v.iov_len = min(n, __p->iov_len - skip);	\
-	if (likely(__v.iov_len)) {			\
-		__v.iov_base = __p->iov_base + skip;	\
-		(void)(STEP);				\
-		skip += __v.iov_len;			\
-		n -= __v.iov_len;			\
-	}						\
-	while (unlikely(n)) {				\
-		__p++;					\
-		__v.iov_len = min(n, __p->iov_len);	\
-		if (unlikely(!__v.iov_len))		\
-			continue;			\
-		__v.iov_base = __p->iov_base;		\
-		(void)(STEP);				\
-		skip = __v.iov_len;			\
-		n -= __v.iov_len;			\
-	}						\
-	n = wanted;					\
+#define iterate_kvec(i, n, __v, __p, skip, STEP) {		\
+	size_t wanted = n;					\
+	__p = i->kvec;						\
+	do {							\
+		__v.iov_len = min(n, __p->iov_len - skip);	\
+		if (likely(__v.iov_len)) {			\
+			__v.iov_base = __p->iov_base + skip;	\
+			(void)(STEP);				\
+			skip += __v.iov_len;			\
+			n -= __v.iov_len;			\
+			if (skip < __p->iov_len)		\
+				break;				\
+		}						\
+		__p++;						\
+		skip = 0;					\
+	} while (n);						\
+	n = wanted - n;						\
 }
 
 #define iterate_bvec(i, n, __v, __bi, skip, STEP) {	\
@@ -123,10 +112,6 @@
 			const struct iovec *iov;		\
 			struct iovec v;				\
 			iterate_iovec(i, n, v, iov, skip, (I))	\
-			if (skip == iov->iov_len) {		\
-				iov++;				\
-				skip = 0;			\
-			}					\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
 		} else if (iov_iter_is_bvec(i)) {		\
@@ -141,10 +126,6 @@
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
-			if (skip == kvec->iov_len) {		\
-				kvec++;				\
-				skip = 0;			\
-			}					\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
-- 
2.11.0


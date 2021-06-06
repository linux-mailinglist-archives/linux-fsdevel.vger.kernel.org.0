Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF739D0B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFFTNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFFTMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D893C0617A8;
        Sun,  6 Jun 2021 12:10:56 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAh-0056c7-7u; Sun, 06 Jun 2021 19:10:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 30/37] pull handling of ->iov_offset into iterate_{iovec,bvec,xarray}
Date:   Sun,  6 Jun 2021 19:10:44 +0000
Message-Id: <20210606191051.1216821-30-viro@zeniv.linux.org.uk>
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

fewer arguments (by one, but still...) for iterate_...() macros

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8a7a8e5f4155..c1580e574d76 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -17,8 +17,9 @@
 #define PIPE_PARANOIA /* for now */
 
 /* covers iovec and kvec alike */
-#define iterate_iovec(i, n, base, len, off, __p, skip, STEP) {	\
+#define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
 	size_t off = 0;						\
+	size_t skip = i->iov_offset;				\
 	do {							\
 		len = min(n, __p->iov_len - skip);		\
 		if (likely(len)) {				\
@@ -33,18 +34,20 @@
 		__p++;						\
 		skip = 0;					\
 	} while (n);						\
+	i->iov_offset = skip;					\
 	n = off;						\
 }
 
-#define iterate_bvec(i, n, base, len, off, p, skip, STEP) {	\
+#define iterate_bvec(i, n, base, len, off, p, STEP) {		\
 	size_t off = 0;						\
+	unsigned skip = i->iov_offset;				\
 	while (n) {						\
 		unsigned offset = p->bv_offset + skip;		\
 		unsigned left;					\
 		void *kaddr = kmap_local_page(p->bv_page +	\
 					offset / PAGE_SIZE);	\
 		base = kaddr + offset % PAGE_SIZE;		\
-		len = min(min(n, p->bv_len - skip),		\
+		len = min(min(n, (size_t)(p->bv_len - skip)),	\
 		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
 		left = (STEP);					\
 		kunmap_local(kaddr);				\
@@ -59,15 +62,16 @@
 		if (left)					\
 			break;					\
 	}							\
+	i->iov_offset = skip;					\
 	n = off;						\
 }
 
-#define iterate_xarray(i, n, base, len, __off, skip, STEP) {	\
+#define iterate_xarray(i, n, base, len, __off, STEP) {		\
 	__label__ __out;					\
 	size_t __off = 0;					\
 	struct page *head = NULL;				\
 	size_t offset;						\
-	loff_t start = i->xarray_start + skip;			\
+	loff_t start = i->xarray_start + i->iov_offset;		\
 	pgoff_t index = start >> PAGE_SHIFT;			\
 	int j;							\
 								\
@@ -100,7 +104,7 @@
 	}							\
 __out:								\
 	rcu_read_unlock();					\
-	skip += __off;						\
+	i->iov_offset += __off;						\
 	n = __off;						\
 }
 
@@ -108,13 +112,12 @@ __out:								\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (likely(n)) {					\
-		size_t skip = i->iov_offset;			\
 		if (likely(iter_is_iovec(i))) {			\
 			const struct iovec *iov = i->iov;	\
 			void __user *base;			\
 			size_t len;				\
 			iterate_iovec(i, n, base, len, off,	\
-						iov, skip, (I))	\
+						iov, (I))	\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
 		} else if (iov_iter_is_bvec(i)) {		\
@@ -122,7 +125,7 @@ __out:								\
 			void *base;				\
 			size_t len;				\
 			iterate_bvec(i, n, base, len, off,	\
-					bvec, skip, (K))	\
+						bvec, (K))	\
 			i->nr_segs -= bvec - i->bvec;		\
 			i->bvec = bvec;				\
 		} else if (iov_iter_is_kvec(i)) {		\
@@ -130,17 +133,16 @@ __out:								\
 			void *base;				\
 			size_t len;				\
 			iterate_iovec(i, n, base, len, off,	\
-					kvec, skip, (K))	\
+						kvec, (K))	\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
 		} else if (iov_iter_is_xarray(i)) {		\
 			void *base;				\
 			size_t len;				\
 			iterate_xarray(i, n, base, len, off,	\
-						skip, (K))	\
+							(K))	\
 		}						\
 		i->count -= n;					\
-		i->iov_offset = skip;				\
 	}							\
 }
 #define iterate_and_advance(i, n, base, len, off, I, K) \
-- 
2.11.0


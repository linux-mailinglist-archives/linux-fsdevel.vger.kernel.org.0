Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF639D0C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFFTNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFFTMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:52 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE63C061795;
        Sun,  6 Jun 2021 12:11:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056bW-JC; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 25/37] iterate_bvec(): expand bvec.h macro forest, massage a bit
Date:   Sun,  6 Jun 2021 19:10:39 +0000
Message-Id: <20210606191051.1216821-25-viro@zeniv.linux.org.uk>
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

... incidentally, using pointer instead of index in an array
(the only change here) trims half-kilobyte of .text...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 19c103e9ef7d..af9525c21c77 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -37,14 +37,23 @@
 	n = wanted - n;						\
 }
 
-#define iterate_bvec(i, n, __v, __bi, skip, STEP) {	\
-	struct bvec_iter __start;			\
-	__start.bi_size = n;				\
-	__start.bi_bvec_done = skip;			\
-	__start.bi_idx = 0;				\
-	for_each_bvec(__v, i->bvec, __bi, __start) {	\
-		(void)(STEP);				\
-	}						\
+#define iterate_bvec(i, n, __v, p, skip, STEP) {		\
+	size_t wanted = n;					\
+	while (n) {						\
+		unsigned offset = p->bv_offset + skip;		\
+		__v.bv_offset = offset % PAGE_SIZE;		\
+		__v.bv_page = p->bv_page + offset / PAGE_SIZE;	\
+		__v.bv_len = min(min(n, p->bv_len - skip),	\
+		     (size_t)(PAGE_SIZE - offset % PAGE_SIZE));	\
+		(void)(STEP);					\
+		skip += __v.bv_len;				\
+		if (skip == p->bv_len) {			\
+			skip = 0;				\
+			p++;					\
+		}						\
+		n -= __v.bv_len;				\
+	}							\
+	n = wanted - n;						\
 }
 
 #define iterate_xarray(i, n, __v, skip, STEP) {		\
@@ -98,11 +107,9 @@
 		} else if (iov_iter_is_bvec(i)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
-			struct bvec_iter __bi;			\
-			iterate_bvec(i, n, v, __bi, skip, (B))	\
-			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
-			i->nr_segs -= i->bvec - bvec;		\
-			skip = __bi.bi_bvec_done;		\
+			iterate_bvec(i, n, v, bvec, skip, (B))	\
+			i->nr_segs -= bvec - i->bvec;		\
+			i->bvec = bvec;				\
 		} else if (iov_iter_is_kvec(i)) {		\
 			const struct kvec *kvec = i->kvec;	\
 			struct kvec v;				\
-- 
2.11.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9E39D0A0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFFTMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E44C0617A8;
        Sun,  6 Jun 2021 12:10:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAe-0056ZZ-41; Sun, 06 Jun 2021 19:10:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 12/37] iov_iter: separate direction from flavour
Date:   Sun,  6 Jun 2021 19:10:26 +0000
Message-Id: <20210606191051.1216821-12-viro@zeniv.linux.org.uk>
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

Instead of having them mixed in iter->type, use separate ->iter_type
and ->data_source (u8 and bool resp.)  And don't bother with (pseudo-)
bitmap for the former - microoptimizations from being able to check
if the flavour is one of two values are not worth the confusion for
optimizer.  It can't prove that we never get e.g. ITER_IOVEC | ITER_PIPE,
so we end up with extra headache.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/uio.h | 24 ++++++--------
 lib/iov_iter.c      | 92 +++++++++++++++++++++++++++++++++--------------------
 2 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index c697c23138b5..56b6ff235281 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -19,21 +19,17 @@ struct kvec {
 
 enum iter_type {
 	/* iter types */
-	ITER_IOVEC = 4,
-	ITER_KVEC = 8,
-	ITER_BVEC = 16,
-	ITER_PIPE = 32,
-	ITER_DISCARD = 64,
-	ITER_XARRAY = 128,
+	ITER_IOVEC,
+	ITER_KVEC,
+	ITER_BVEC,
+	ITER_PIPE,
+	ITER_XARRAY,
+	ITER_DISCARD,
 };
 
 struct iov_iter {
-	/*
-	 * Bit 0 is the read/write bit, set if we're writing.
-	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
-	 * the caller isn't expecting to drop a page reference when done.
-	 */
-	unsigned int type;
+	u8 iter_type;
+	bool data_source;
 	size_t iov_offset;
 	size_t count;
 	union {
@@ -55,7 +51,7 @@ struct iov_iter {
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
-	return i->type & ~(READ | WRITE);
+	return i->iter_type;
 }
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
@@ -90,7 +86,7 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
-	return i->type & (READ | WRITE);
+	return i->data_source ? WRITE : READ;
 }
 
 /*
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e6c5834da32d..5a02c94a51ab 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -489,19 +489,26 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	direction &= READ | WRITE;
 
 	/* It will get better.  Eventually... */
-	if (uaccess_kernel()) {
-		i->type = ITER_KVEC | direction;
-		i->kvec = (struct kvec *)iov;
-	} else {
-		i->type = ITER_IOVEC | direction;
-		i->iov = iov;
-	}
-	i->nr_segs = nr_segs;
-	i->iov_offset = 0;
-	i->count = count;
+	if (uaccess_kernel())
+		*i = (struct iov_iter) {
+			.iter_type = ITER_KVEC,
+			.data_source = direction,
+			.kvec = (struct kvec *)iov,
+			.nr_segs = nr_segs,
+			.iov_offset = 0,
+			.count = count
+		};
+	else
+		*i = (struct iov_iter) {
+			.iter_type = ITER_IOVEC,
+			.data_source = direction,
+			.iov = iov,
+			.nr_segs = nr_segs,
+			.iov_offset = 0,
+			.count = count
+		};
 }
 EXPORT_SYMBOL(iov_iter_init);
 
@@ -1218,11 +1225,14 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	i->type = ITER_KVEC | (direction & (READ | WRITE));
-	i->kvec = kvec;
-	i->nr_segs = nr_segs;
-	i->iov_offset = 0;
-	i->count = count;
+	*i = (struct iov_iter){
+		.iter_type = ITER_KVEC,
+		.data_source = direction,
+		.kvec = kvec,
+		.nr_segs = nr_segs,
+		.iov_offset = 0,
+		.count = count
+	};
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
@@ -1231,11 +1241,14 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	i->type = ITER_BVEC | (direction & (READ | WRITE));
-	i->bvec = bvec;
-	i->nr_segs = nr_segs;
-	i->iov_offset = 0;
-	i->count = count;
+	*i = (struct iov_iter){
+		.iter_type = ITER_BVEC,
+		.data_source = direction,
+		.bvec = bvec,
+		.nr_segs = nr_segs,
+		.iov_offset = 0,
+		.count = count
+	};
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
@@ -1245,12 +1258,15 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 {
 	BUG_ON(direction != READ);
 	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
-	i->type = ITER_PIPE | READ;
-	i->pipe = pipe;
-	i->head = pipe->head;
-	i->iov_offset = 0;
-	i->count = count;
-	i->start_head = i->head;
+	*i = (struct iov_iter){
+		.iter_type = ITER_PIPE,
+		.data_source = false,
+		.pipe = pipe,
+		.head = pipe->head,
+		.start_head = pipe->head,
+		.iov_offset = 0,
+		.count = count
+	};
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 
@@ -1271,11 +1287,14 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 		     struct xarray *xarray, loff_t start, size_t count)
 {
 	BUG_ON(direction & ~1);
-	i->type = ITER_XARRAY | (direction & (READ | WRITE));
-	i->xarray = xarray;
-	i->xarray_start = start;
-	i->count = count;
-	i->iov_offset = 0;
+	*i = (struct iov_iter) {
+		.iter_type = ITER_XARRAY,
+		.data_source = direction,
+		.xarray = xarray,
+		.xarray_start = start,
+		.count = count,
+		.iov_offset = 0
+	};
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
@@ -1291,9 +1310,12 @@ EXPORT_SYMBOL(iov_iter_xarray);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 {
 	BUG_ON(direction != READ);
-	i->type = ITER_DISCARD | READ;
-	i->count = count;
-	i->iov_offset = 0;
+	*i = (struct iov_iter){
+		.iter_type = ITER_DISCARD,
+		.data_source = false,
+		.count = count,
+		.iov_offset = 0
+	};
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
-- 
2.11.0


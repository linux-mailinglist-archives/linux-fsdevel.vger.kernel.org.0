Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3F2BBF7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKUONo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbgKUONo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lfv4FQ56Ng1mDXK+3kEJa6lpcMG3pXvv44BndwILziA=;
        b=YVk6GZqkUyyNrk8MdXauR/gPt79YAVMA/j1cNEjRVCVdzARCAf2wjSfmV2i9uPrn0OvMtF
        zahhXmkF8lkD9mlVZgwbBSN7I66jGpGyP3GeqvI2bRru9Yoy3wFeQxUaglnT2gfQ0nWj7w
        Jx2YYO08w0B9/dNh107j8b9bxgZpocE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-l7J7gu7oNPG5NISzJ38DoA-1; Sat, 21 Nov 2020 09:13:35 -0500
X-MC-Unique: l7J7gu7oNPG5NISzJ38DoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 355D9804759;
        Sat, 21 Nov 2020 14:13:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA2210016DB;
        Sat, 21 Nov 2020 14:13:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/29] iov_iter: Switch to using a table of operations
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:13:30 +0000
Message-ID: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch to using a table of operations.  In a future patch the individual
methods will be split up by type.  For the moment, however, the ops tables
just jump directly to the old functions - which are now static.  Inline
wrappers are provided to jump through the hooks.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/io_uring.c       |    2 
 include/linux/uio.h |  241 ++++++++++++++++++++++++++++++++++--------
 lib/iov_iter.c      |  293 +++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 422 insertions(+), 114 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4ead291b2976..baa78f58ae5c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3192,7 +3192,7 @@ static void io_req_map_rw(struct io_kiocb *req, const struct iovec *iovec,
 	rw->free_iovec = iovec;
 	rw->bytes_done = 0;
 	/* can only be fixed buffers, no need to do anything */
-	if (iter->type == ITER_BVEC)
+	if (iov_iter_is_bvec(iter))
 		return;
 	if (!iovec) {
 		unsigned iov_off = 0;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..45ee087f8c43 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -32,9 +32,10 @@ struct iov_iter {
 	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
 	 * the caller isn't expecting to drop a page reference when done.
 	 */
-	unsigned int type;
+	unsigned int flags;
 	size_t iov_offset;
 	size_t count;
+	const struct iov_iter_ops *ops;
 	union {
 		const struct iovec *iov;
 		const struct kvec *kvec;
@@ -50,9 +51,63 @@ struct iov_iter {
 	};
 };
 
+void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
+			unsigned long nr_segs, size_t count);
+void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
+			unsigned long nr_segs, size_t count);
+void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
+			unsigned long nr_segs, size_t count);
+void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
+			size_t count);
+void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+
+struct iov_iter_ops {
+	enum iter_type type;
+	size_t (*copy_from_user_atomic)(struct page *page, struct iov_iter *i,
+					unsigned long offset, size_t bytes);
+	void (*advance)(struct iov_iter *i, size_t bytes);
+	void (*revert)(struct iov_iter *i, size_t bytes);
+	int (*fault_in_readable)(struct iov_iter *i, size_t bytes);
+	size_t (*single_seg_count)(const struct iov_iter *i);
+	size_t (*copy_page_to_iter)(struct page *page, size_t offset, size_t bytes,
+				    struct iov_iter *i);
+	size_t (*copy_page_from_iter)(struct page *page, size_t offset, size_t bytes,
+				      struct iov_iter *i);
+	size_t (*copy_to_iter)(const void *addr, size_t bytes, struct iov_iter *i);
+	size_t (*copy_from_iter)(void *addr, size_t bytes, struct iov_iter *i);
+	bool (*copy_from_iter_full)(void *addr, size_t bytes, struct iov_iter *i);
+	size_t (*copy_from_iter_nocache)(void *addr, size_t bytes, struct iov_iter *i);
+	bool (*copy_from_iter_full_nocache)(void *addr, size_t bytes, struct iov_iter *i);
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	size_t (*copy_from_iter_flushcache)(void *addr, size_t bytes, struct iov_iter *i);
+#endif
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	size_t (*copy_mc_to_iter)(const void *addr, size_t bytes, struct iov_iter *i);
+#endif
+	size_t (*csum_and_copy_to_iter)(const void *addr, size_t bytes, void *csump,
+					struct iov_iter *i);
+	size_t (*csum_and_copy_from_iter)(void *addr, size_t bytes, __wsum *csum,
+					  struct iov_iter *i);
+	bool (*csum_and_copy_from_iter_full)(void *addr, size_t bytes, __wsum *csum,
+					     struct iov_iter *i);
+
+	size_t (*zero)(size_t bytes, struct iov_iter *i);
+	unsigned long (*alignment)(const struct iov_iter *i);
+	unsigned long (*gap_alignment)(const struct iov_iter *i);
+	ssize_t (*get_pages)(struct iov_iter *i, struct page **pages,
+			     size_t maxsize, unsigned maxpages, size_t *start);
+	ssize_t (*get_pages_alloc)(struct iov_iter *i, struct page ***pages,
+				   size_t maxsize, size_t *start);
+	int (*npages)(const struct iov_iter *i, int maxpages);
+	const void *(*dup_iter)(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
+	int (*for_each_range)(struct iov_iter *i, size_t bytes,
+			      int (*f)(struct kvec *vec, void *context),
+			      void *context);
+};
+
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
-	return i->type & ~(READ | WRITE);
+	return i->ops->type;
 }
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
@@ -82,7 +137,7 @@ static inline bool iov_iter_is_discard(const struct iov_iter *i)
 
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
-	return i->type & (READ | WRITE);
+	return i->flags & (READ | WRITE);
 }
 
 /*
@@ -111,22 +166,71 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 	};
 }
 
-size_t iov_iter_copy_from_user_atomic(struct page *page,
-		struct iov_iter *i, unsigned long offset, size_t bytes);
-void iov_iter_advance(struct iov_iter *i, size_t bytes);
-void iov_iter_revert(struct iov_iter *i, size_t bytes);
-int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
-size_t iov_iter_single_seg_count(const struct iov_iter *i);
+static inline
+size_t iov_iter_copy_from_user_atomic(struct page *page, struct iov_iter *i,
+				      unsigned long offset, size_t bytes)
+{
+	return i->ops->copy_from_user_atomic(page, i, offset, bytes);
+}
+static inline
+void iov_iter_advance(struct iov_iter *i, size_t bytes)
+{
+	return i->ops->advance(i, bytes);
+}
+static inline
+void iov_iter_revert(struct iov_iter *i, size_t bytes)
+{
+	return i->ops->revert(i, bytes);
+}
+static inline
+int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
+{
+	return i->ops->fault_in_readable(i, bytes);
+}
+static inline
+size_t iov_iter_single_seg_count(const struct iov_iter *i)
+{
+	return i->ops->single_seg_count(i);
+}
+
+static inline
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i);
+				       struct iov_iter *i)
+{
+	return i->ops->copy_page_to_iter(page, offset, bytes, i);
+}
+static inline
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i);
+					 struct iov_iter *i)
+{
+	return i->ops->copy_page_from_iter(page, offset, bytes, i);
+}
 
-size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
-size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
-bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i);
-size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
-bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i);
+static __always_inline __must_check
+size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	return i->ops->copy_to_iter(addr, bytes, i);
+}
+static __always_inline __must_check
+size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	return i->ops->copy_from_iter(addr, bytes, i);
+}
+static __always_inline __must_check
+bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+{
+	return i->ops->copy_from_iter_full(addr, bytes, i);
+}
+static __always_inline __must_check
+size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	return i->ops->copy_from_iter_nocache(addr, bytes, i);
+}
+static __always_inline __must_check
+bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
+{
+	return i->ops->copy_from_iter_full_nocache(addr, bytes, i);
+}
 
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
@@ -173,23 +277,21 @@ bool copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_from_iter_full_nocache(addr, bytes, i);
 }
 
-#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /*
  * Note, users like pmem that depend on the stricter semantics of
  * copy_from_iter_flushcache() than copy_from_iter_nocache() must check for
  * IS_ENABLED(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) before assuming that the
  * destination is flushed from the cache on return.
  */
-size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i);
-#else
-#define _copy_from_iter_flushcache _copy_from_iter_nocache
-#endif
-
-#ifdef CONFIG_ARCH_HAS_COPY_MC
-size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
+static __always_inline __must_check
+size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
+{
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	return i->ops->copy_from_iter_flushcache(addr, bytes, i);
 #else
-#define _copy_mc_to_iter _copy_to_iter
+	return i->ops->copy_from_iter_nocache(addr, bytes, i);
 #endif
+}
 
 static __always_inline __must_check
 size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
@@ -200,6 +302,16 @@ size_t copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_from_iter_flushcache(addr, bytes, i);
 }
 
+static __always_inline __must_check
+size_t _copy_mc_to_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	return i->ops->copy_mc_to_iter(addr, bytes, i);
+#else
+	return i->ops->copy_to_iter(addr, bytes, i);
+#endif
+}
+
 static __always_inline __must_check
 size_t copy_mc_to_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -209,25 +321,47 @@ size_t copy_mc_to_iter(void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_mc_to_iter(addr, bytes, i);
 }
 
-size_t iov_iter_zero(size_t bytes, struct iov_iter *);
-unsigned long iov_iter_alignment(const struct iov_iter *i);
-unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
-void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
-			unsigned long nr_segs, size_t count);
-void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
-			unsigned long nr_segs, size_t count);
-void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
-			unsigned long nr_segs, size_t count);
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
-			size_t count);
-void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
+static inline
+size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
+{
+	return i->ops->zero(bytes, i);
+}
+static inline
+unsigned long iov_iter_alignment(const struct iov_iter *i)
+{
+	return i->ops->alignment(i);
+}
+static inline
+unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
+{
+	return i->ops->gap_alignment(i);
+}
+
+static inline
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
-			size_t maxsize, unsigned maxpages, size_t *start);
+			size_t maxsize, unsigned maxpages, size_t *start)
+{
+	return i->ops->get_pages(i, pages, maxsize, maxpages, start);
+}
+
+static inline
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
-			size_t maxsize, size_t *start);
-int iov_iter_npages(const struct iov_iter *i, int maxpages);
+			size_t maxsize, size_t *start)
+{
+	return i->ops->get_pages_alloc(i, pages, maxsize, start);
+}
+
+static inline
+int iov_iter_npages(const struct iov_iter *i, int maxpages)
+{
+	return i->ops->npages(i, maxpages);
+}
 
-const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
+static inline
+const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
+{
+	return old->ops->dup_iter(new, old, flags);
+}
 
 static inline size_t iov_iter_count(const struct iov_iter *i)
 {
@@ -260,9 +394,22 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 {
 	i->count = count;
 }
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i);
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
-bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+
+static inline
+size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i)
+{
+	return i->ops->csum_and_copy_to_iter(addr, bytes, csump, i);
+}
+static inline
+size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
+{
+	return i->ops->csum_and_copy_from_iter(addr, bytes, csum, i);
+}
+static inline
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
+{
+	return i->ops->csum_and_copy_from_iter_full(addr, bytes, csum, i);
+}
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i);
 
@@ -278,8 +425,12 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 int import_single_range(int type, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
 
+static inline
 int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 			    int (*f)(struct kvec *vec, void *context),
-			    void *context);
+			    void *context)
+{
+	return i->ops->for_each_range(i, bytes, f, context);
+}
 
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..e403d524c797 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -13,6 +13,12 @@
 #include <linux/scatterlist.h>
 #include <linux/instrumented.h>
 
+static const struct iov_iter_ops iovec_iter_ops;
+static const struct iov_iter_ops kvec_iter_ops;
+static const struct iov_iter_ops bvec_iter_ops;
+static const struct iov_iter_ops pipe_iter_ops;
+static const struct iov_iter_ops discard_iter_ops;
+
 #define PIPE_PARANOIA /* for now */
 
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
@@ -81,15 +87,15 @@
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (unlikely(iov_iter_type(i) & ITER_BVEC)) {		\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
 			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (unlikely(iov_iter_type(i) & ITER_KVEC)) {	\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
-		} else if (unlikely(i->type & ITER_DISCARD)) {	\
+		} else if (unlikely(iov_iter_type(i) & ITER_DISCARD)) {	\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -103,7 +109,7 @@
 		n = i->count;					\
 	if (i->count) {						\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->type & ITER_BVEC)) {		\
+		if (unlikely(iov_iter_type(i) & ITER_BVEC)) {		\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
@@ -111,7 +117,7 @@
 			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
 			i->nr_segs -= i->bvec - bvec;		\
 			skip = __bi.bi_bvec_done;		\
-		} else if (unlikely(i->type & ITER_KVEC)) {	\
+		} else if (unlikely(iov_iter_type(i) & ITER_KVEC)) {	\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
@@ -121,7 +127,7 @@
 			}					\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
-		} else if (unlikely(i->type & ITER_DISCARD)) {	\
+		} else if (unlikely(iov_iter_type(i) & ITER_DISCARD)) {	\
 			skip += n;				\
 		} else {					\
 			const struct iovec *iov;		\
@@ -427,14 +433,14 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
  * Return 0 on success, or non-zero if the memory could not be accessed (i.e.
  * because it is an invalid address).
  */
-int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
+static int xxx_fault_in_readable(struct iov_iter *i, size_t bytes)
 {
 	size_t skip = i->iov_offset;
 	const struct iovec *iov;
 	int err;
 	struct iovec v;
 
-	if (!(i->type & (ITER_BVEC|ITER_KVEC))) {
+	if (!(iov_iter_type(i) & (ITER_BVEC|ITER_KVEC))) {
 		iterate_iovec(i, bytes, v, iov, skip, ({
 			err = fault_in_pages_readable(v.iov_base, v.iov_len);
 			if (unlikely(err))
@@ -443,7 +449,6 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
@@ -454,10 +459,12 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 
 	/* It will get better.  Eventually... */
 	if (uaccess_kernel()) {
-		i->type = ITER_KVEC | direction;
+		i->ops = &kvec_iter_ops;
+		i->flags = direction;
 		i->kvec = (struct kvec *)iov;
 	} else {
-		i->type = ITER_IOVEC | direction;
+		i->ops = &iovec_iter_ops;
+		i->flags = direction;
 		i->iov = iov;
 	}
 	i->nr_segs = nr_segs;
@@ -625,7 +632,7 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 	return bytes;
 }
 
-size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+static size_t xxx_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
 	if (unlikely(iov_iter_is_pipe(i)))
@@ -641,7 +648,6 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 
 	return bytes;
 }
-EXPORT_SYMBOL(_copy_to_iter);
 
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 static int copyout_mc(void __user *to, const void *from, size_t n)
@@ -723,7 +729,7 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
  *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
  *   a short copy.
  */
-size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+static size_t xxx_copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
 	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
@@ -757,10 +763,9 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 
 	return bytes;
 }
-EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+static size_t xxx_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
@@ -778,9 +783,8 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 
 	return bytes;
 }
-EXPORT_SYMBOL(_copy_from_iter);
 
-bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
+static bool xxx_copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
@@ -805,9 +809,8 @@ bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 	iov_iter_advance(i, bytes);
 	return true;
 }
-EXPORT_SYMBOL(_copy_from_iter_full);
 
-size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
+static size_t xxx_copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
@@ -824,7 +827,6 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 
 	return bytes;
 }
-EXPORT_SYMBOL(_copy_from_iter_nocache);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
@@ -841,7 +843,7 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
  * bypass the cache for the ITER_IOVEC case, and on some archs may use
  * instructions that strand dirty-data in the cache.
  */
-size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
+static size_t xxx_copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
@@ -859,10 +861,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 
 	return bytes;
 }
-EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 #endif
 
-bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
+static bool xxx_copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
 	if (unlikely(iov_iter_is_pipe(i))) {
@@ -884,7 +885,6 @@ bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 	iov_iter_advance(i, bytes);
 	return true;
 }
-EXPORT_SYMBOL(_copy_from_iter_full_nocache);
 
 static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 {
@@ -910,12 +910,12 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 	return false;
 }
 
-size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+static size_t xxx_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (iov_iter_type(i) & (ITER_BVEC|ITER_KVEC)) {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
@@ -927,9 +927,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 	else
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
 }
-EXPORT_SYMBOL(copy_page_to_iter);
 
-size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
+static size_t xxx_copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
@@ -938,15 +937,14 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 		WARN_ON(1);
 		return 0;
 	}
-	if (i->type & (ITER_BVEC|ITER_KVEC)) {
+	if (iov_iter_type(i) & (ITER_BVEC|ITER_KVEC)) {
 		void *kaddr = kmap_atomic(page);
-		size_t wanted = _copy_from_iter(kaddr + offset, bytes, i);
+		size_t wanted = xxx_copy_from_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
 	} else
 		return copy_page_from_iter_iovec(page, offset, bytes, i);
 }
-EXPORT_SYMBOL(copy_page_from_iter);
 
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
@@ -975,7 +973,7 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 	return bytes;
 }
 
-size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
+static size_t xxx_zero(size_t bytes, struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_zero(bytes, i);
@@ -987,9 +985,8 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 
 	return bytes;
 }
-EXPORT_SYMBOL(iov_iter_zero);
 
-size_t iov_iter_copy_from_user_atomic(struct page *page,
+static size_t xxx_copy_from_user_atomic(struct page *page,
 		struct iov_iter *i, unsigned long offset, size_t bytes)
 {
 	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
@@ -1011,7 +1008,6 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 	kunmap_atomic(kaddr);
 	return bytes;
 }
-EXPORT_SYMBOL(iov_iter_copy_from_user_atomic);
 
 static inline void pipe_truncate(struct iov_iter *i)
 {
@@ -1067,7 +1063,7 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 	pipe_truncate(i);
 }
 
-void iov_iter_advance(struct iov_iter *i, size_t size)
+static void xxx_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(iov_iter_is_pipe(i))) {
 		pipe_advance(i, size);
@@ -1079,9 +1075,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 	}
 	iterate_and_advance(i, size, v, 0, 0, 0)
 }
-EXPORT_SYMBOL(iov_iter_advance);
 
-void iov_iter_revert(struct iov_iter *i, size_t unroll)
+static void xxx_revert(struct iov_iter *i, size_t unroll)
 {
 	if (!unroll)
 		return;
@@ -1147,12 +1142,11 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		}
 	}
 }
-EXPORT_SYMBOL(iov_iter_revert);
 
 /*
  * Return the count of just the current iov_iter segment.
  */
-size_t iov_iter_single_seg_count(const struct iov_iter *i)
+static size_t xxx_single_seg_count(const struct iov_iter *i)
 {
 	if (unlikely(iov_iter_is_pipe(i)))
 		return i->count;	// it is a silly place, anyway
@@ -1165,14 +1159,14 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 	else
 		return min(i->count, i->iov->iov_len - i->iov_offset);
 }
-EXPORT_SYMBOL(iov_iter_single_seg_count);
 
 void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
-			const struct kvec *kvec, unsigned long nr_segs,
-			size_t count)
+		   const struct kvec *kvec, unsigned long nr_segs,
+		   size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	i->type = ITER_KVEC | (direction & (READ | WRITE));
+	i->ops = &kvec_iter_ops;
+	i->flags = direction & (READ | WRITE);
 	i->kvec = kvec;
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
@@ -1185,7 +1179,8 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 			size_t count)
 {
 	WARN_ON(direction & ~(READ | WRITE));
-	i->type = ITER_BVEC | (direction & (READ | WRITE));
+	i->ops = &bvec_iter_ops;
+	i->flags = direction & (READ | WRITE);
 	i->bvec = bvec;
 	i->nr_segs = nr_segs;
 	i->iov_offset = 0;
@@ -1199,7 +1194,8 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 {
 	BUG_ON(direction != READ);
 	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
-	i->type = ITER_PIPE | READ;
+	i->ops = &pipe_iter_ops;
+	i->flags = READ;
 	i->pipe = pipe;
 	i->head = pipe->head;
 	i->iov_offset = 0;
@@ -1220,13 +1216,14 @@ EXPORT_SYMBOL(iov_iter_pipe);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 {
 	BUG_ON(direction != READ);
-	i->type = ITER_DISCARD | READ;
+	i->ops = &discard_iter_ops;
+	i->flags = READ;
 	i->count = count;
 	i->iov_offset = 0;
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
-unsigned long iov_iter_alignment(const struct iov_iter *i)
+static unsigned long xxx_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
 	size_t size = i->count;
@@ -1245,9 +1242,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	)
 	return res;
 }
-EXPORT_SYMBOL(iov_iter_alignment);
 
-unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
+static unsigned long xxx_gap_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
 	size_t size = i->count;
@@ -1267,7 +1263,6 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 		);
 	return res;
 }
-EXPORT_SYMBOL(iov_iter_gap_alignment);
 
 static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
@@ -1313,7 +1308,7 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, start);
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+static ssize_t xxx_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
 {
@@ -1352,7 +1347,6 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	)
 	return 0;
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
 
 static struct page **get_pages_array(size_t n)
 {
@@ -1392,7 +1386,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	return n;
 }
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+static ssize_t xxx_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
 {
@@ -1439,9 +1433,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	)
 	return 0;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
+static size_t xxx_csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
 	char *to = addr;
@@ -1478,9 +1471,8 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	*csum = sum;
 	return bytes;
 }
-EXPORT_SYMBOL(csum_and_copy_from_iter);
 
-bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
+static bool xxx_csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {
 	char *to = addr;
@@ -1520,9 +1512,8 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	iov_iter_advance(i, bytes);
 	return true;
 }
-EXPORT_SYMBOL(csum_and_copy_from_iter_full);
 
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
+static size_t xxx_csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 			     struct iov_iter *i)
 {
 	const char *from = addr;
@@ -1564,7 +1555,6 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 	*csum = sum;
 	return bytes;
 }
-EXPORT_SYMBOL(csum_and_copy_to_iter);
 
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
@@ -1585,7 +1575,7 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 }
 EXPORT_SYMBOL(hash_and_copy_to_iter);
 
-int iov_iter_npages(const struct iov_iter *i, int maxpages)
+static int xxx_npages(const struct iov_iter *i, int maxpages)
 {
 	size_t size = i->count;
 	int npages = 0;
@@ -1628,9 +1618,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	)
 	return npages;
 }
-EXPORT_SYMBOL(iov_iter_npages);
 
-const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
+static const void *xxx_dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
 	if (unlikely(iov_iter_is_pipe(new))) {
@@ -1649,7 +1638,6 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
 }
-EXPORT_SYMBOL(dup_iter);
 
 static int copy_compat_iovec_from_user(struct iovec *iov,
 		const struct iovec __user *uvec, unsigned long nr_segs)
@@ -1826,7 +1814,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
 }
 EXPORT_SYMBOL(import_single_range);
 
-int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
+static int xxx_for_each_range(struct iov_iter *i, size_t bytes,
 			    int (*f)(struct kvec *vec, void *context),
 			    void *context)
 {
@@ -1846,4 +1834,173 @@ int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 	)
 	return err;
 }
-EXPORT_SYMBOL(iov_iter_for_each_range);
+
+static const struct iov_iter_ops iovec_iter_ops = {
+	.type				= ITER_IOVEC,
+	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.advance			= xxx_advance,
+	.revert				= xxx_revert,
+	.fault_in_readable		= xxx_fault_in_readable,
+	.single_seg_count		= xxx_single_seg_count,
+	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+#endif
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+#endif
+	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+
+	.zero				= xxx_zero,
+	.alignment			= xxx_alignment,
+	.gap_alignment			= xxx_gap_alignment,
+	.get_pages			= xxx_get_pages,
+	.get_pages_alloc		= xxx_get_pages_alloc,
+	.npages				= xxx_npages,
+	.dup_iter			= xxx_dup_iter,
+	.for_each_range			= xxx_for_each_range,
+};
+
+static const struct iov_iter_ops kvec_iter_ops = {
+	.type				= ITER_KVEC,
+	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.advance			= xxx_advance,
+	.revert				= xxx_revert,
+	.fault_in_readable		= xxx_fault_in_readable,
+	.single_seg_count		= xxx_single_seg_count,
+	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+#endif
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+#endif
+	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+
+	.zero				= xxx_zero,
+	.alignment			= xxx_alignment,
+	.gap_alignment			= xxx_gap_alignment,
+	.get_pages			= xxx_get_pages,
+	.get_pages_alloc		= xxx_get_pages_alloc,
+	.npages				= xxx_npages,
+	.dup_iter			= xxx_dup_iter,
+	.for_each_range			= xxx_for_each_range,
+};
+
+static const struct iov_iter_ops bvec_iter_ops = {
+	.type				= ITER_BVEC,
+	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.advance			= xxx_advance,
+	.revert				= xxx_revert,
+	.fault_in_readable		= xxx_fault_in_readable,
+	.single_seg_count		= xxx_single_seg_count,
+	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+#endif
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+#endif
+	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+
+	.zero				= xxx_zero,
+	.alignment			= xxx_alignment,
+	.gap_alignment			= xxx_gap_alignment,
+	.get_pages			= xxx_get_pages,
+	.get_pages_alloc		= xxx_get_pages_alloc,
+	.npages				= xxx_npages,
+	.dup_iter			= xxx_dup_iter,
+	.for_each_range			= xxx_for_each_range,
+};
+
+static const struct iov_iter_ops pipe_iter_ops = {
+	.type				= ITER_PIPE,
+	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.advance			= xxx_advance,
+	.revert				= xxx_revert,
+	.fault_in_readable		= xxx_fault_in_readable,
+	.single_seg_count		= xxx_single_seg_count,
+	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+#endif
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+#endif
+	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+
+	.zero				= xxx_zero,
+	.alignment			= xxx_alignment,
+	.gap_alignment			= xxx_gap_alignment,
+	.get_pages			= xxx_get_pages,
+	.get_pages_alloc		= xxx_get_pages_alloc,
+	.npages				= xxx_npages,
+	.dup_iter			= xxx_dup_iter,
+	.for_each_range			= xxx_for_each_range,
+};
+
+static const struct iov_iter_ops discard_iter_ops = {
+	.type				= ITER_DISCARD,
+	.copy_from_user_atomic		= xxx_copy_from_user_atomic,
+	.advance			= xxx_advance,
+	.revert				= xxx_revert,
+	.fault_in_readable		= xxx_fault_in_readable,
+	.single_seg_count		= xxx_single_seg_count,
+	.copy_page_to_iter		= xxx_copy_page_to_iter,
+	.copy_page_from_iter		= xxx_copy_page_from_iter,
+	.copy_to_iter			= xxx_copy_to_iter,
+	.copy_from_iter			= xxx_copy_from_iter,
+	.copy_from_iter_full		= xxx_copy_from_iter_full,
+	.copy_from_iter_nocache		= xxx_copy_from_iter_nocache,
+	.copy_from_iter_full_nocache	= xxx_copy_from_iter_full_nocache,
+#ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
+	.copy_from_iter_flushcache	= xxx_copy_from_iter_flushcache,
+#endif
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+	.copy_mc_to_iter		= xxx_copy_mc_to_iter,
+#endif
+	.csum_and_copy_to_iter		= xxx_csum_and_copy_to_iter,
+	.csum_and_copy_from_iter	= xxx_csum_and_copy_from_iter,
+	.csum_and_copy_from_iter_full	= xxx_csum_and_copy_from_iter_full,
+
+	.zero				= xxx_zero,
+	.alignment			= xxx_alignment,
+	.gap_alignment			= xxx_gap_alignment,
+	.get_pages			= xxx_get_pages,
+	.get_pages_alloc		= xxx_get_pages_alloc,
+	.npages				= xxx_npages,
+	.dup_iter			= xxx_dup_iter,
+	.for_each_range			= xxx_for_each_range,
+};



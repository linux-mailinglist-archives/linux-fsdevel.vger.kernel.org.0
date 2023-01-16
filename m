Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CEA66D2AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjAPXKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjAPXJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724F23845
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9V/eGmZYnC6MiNi85mIVw3mHkZILPya3zFOC5f4iszc=;
        b=KsoBeqwFLbOUE61bKdLK8JwLNJFZUP7VgGGYBD+1WvjM02Y4otT1TcYZmE9OFtGd0uWSct
        PrP198VDAvZ2L3gZaXUPeLnY6Alm9cW33IiroSKJhg7pI68m+Pv/v6RVFdvbxG6rb4W6Zq
        rx1Lbv6/9qcw4odtm5ajCkxaL/ECUkE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-v6XTz86ZOaSWSCziUJ045Q-1; Mon, 16 Jan 2023 18:08:47 -0500
X-MC-Unique: v6XTz86ZOaSWSCziUJ045Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42B12806046;
        Mon, 16 Jan 2023 23:08:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82A6B40C6EC4;
        Mon, 16 Jan 2023 23:08:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 06/34] iov_iter: Use the direction in the iterator
 functions
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:08:44 +0000
Message-ID: <167391052497.2311931.9463379582932734164.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the direction in the iterator functions rather than READ/WRITE.

Add a check into __iov_iter_get_pages_alloc() that the supplied
FOLL_SOURCE/DEST_BUF gup_flag matches the ITER_SOURCE/DEST flag on the
iterator.

Changes
=======
ver #6)
 - Add a check on FOLL_SOURCE/DEST_BUF into __iov_iter_get_pages_alloc()

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>

Link: https://lore.kernel.org/r/167305162465.1521586.18077838937455153675.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344727112.2425628.995771894170560721.stgit@warthog.procyon.org.uk/ # v5
---

 include/linux/uio.h |   22 +--
 lib/iov_iter.c      |  409 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 396 insertions(+), 35 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 8d0dabfcb2fe..18b64068cc6d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -256,16 +256,16 @@ bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
 			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
-void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
+void iov_iter_init(struct iov_iter *i, enum iter_dir direction, const struct iovec *iov,
 			unsigned long nr_segs, size_t count);
-void iov_iter_kvec(struct iov_iter *i, unsigned int direction, const struct kvec *kvec,
+void iov_iter_kvec(struct iov_iter *i, enum iter_dir direction, const struct kvec *kvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_vec *bvec,
+void iov_iter_bvec(struct iov_iter *i, enum iter_dir direction, const struct bio_vec *bvec,
 			unsigned long nr_segs, size_t count);
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
+void iov_iter_pipe(struct iov_iter *i, enum iter_dir direction, struct pipe_inode_info *pipe,
 			size_t count);
-void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
-void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
+void iov_iter_discard(struct iov_iter *i, enum iter_dir direction, size_t count);
+void iov_iter_xarray(struct iov_iter *i, enum iter_dir direction, struct xarray *xarray,
 		     loff_t start, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 		size_t maxsize, unsigned maxpages, size_t *start,
@@ -351,19 +351,19 @@ size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 struct iovec *iovec_from_user(const struct iovec __user *uvector,
 		unsigned long nr_segs, unsigned long fast_segs,
 		struct iovec *fast_iov, bool compat);
-ssize_t import_iovec(int type, const struct iovec __user *uvec,
+ssize_t import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i);
-ssize_t __import_iovec(int type, const struct iovec __user *uvec,
+ssize_t __import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat);
-int import_single_range(int type, void __user *buf, size_t len,
+int import_single_range(enum iter_dir direction, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
 
-static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
+static inline void iov_iter_ubuf(struct iov_iter *i, enum iter_dir direction,
 			void __user *buf, size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
 		.user_backed = true,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ca89ffa9d6e1..6436438bf46b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -421,11 +421,11 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 }
 EXPORT_SYMBOL(fault_in_iov_iter_writeable);
 
-void iov_iter_init(struct iov_iter *i, unsigned int direction,
+void iov_iter_init(struct iov_iter *i, enum iter_dir direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_IOVEC,
 		.nofault = false,
@@ -994,11 +994,11 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
 
-void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
+void iov_iter_kvec(struct iov_iter *i, enum iter_dir direction,
 			const struct kvec *kvec, unsigned long nr_segs,
 			size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter){
 		.iter_type = ITER_KVEC,
 		.data_source = direction,
@@ -1010,11 +1010,11 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_kvec);
 
-void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
+void iov_iter_bvec(struct iov_iter *i, enum iter_dir direction,
 			const struct bio_vec *bvec, unsigned long nr_segs,
 			size_t count)
 {
-	WARN_ON(direction & ~(READ | WRITE));
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter){
 		.iter_type = ITER_BVEC,
 		.data_source = direction,
@@ -1026,15 +1026,15 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_bvec);
 
-void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
+void iov_iter_pipe(struct iov_iter *i, enum iter_dir direction,
 			struct pipe_inode_info *pipe,
 			size_t count)
 {
-	BUG_ON(direction != READ);
+	BUG_ON(direction != ITER_DEST);
 	WARN_ON(pipe_full(pipe->head, pipe->tail, pipe->ring_size));
 	*i = (struct iov_iter){
 		.iter_type = ITER_PIPE,
-		.data_source = false,
+		.data_source = ITER_DEST,
 		.pipe = pipe,
 		.head = pipe->head,
 		.start_head = pipe->head,
@@ -1057,10 +1057,10 @@ EXPORT_SYMBOL(iov_iter_pipe);
  * from evaporation, either by taking a ref on them or locking them by the
  * caller.
  */
-void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
+void iov_iter_xarray(struct iov_iter *i, enum iter_dir direction,
 		     struct xarray *xarray, loff_t start, size_t count)
 {
-	BUG_ON(direction & ~1);
+	WARN_ON(!iov_iter_dir_valid(direction));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_XARRAY,
 		.data_source = direction,
@@ -1079,14 +1079,14 @@ EXPORT_SYMBOL(iov_iter_xarray);
  * @count: The size of the I/O buffer in bytes.
  *
  * Set up an I/O iterator that just discards everything that's written to it.
- * It's only available as a READ iterator.
+ * It's only available as a destination iterator.
  */
-void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
+void iov_iter_discard(struct iov_iter *i, enum iter_dir direction, size_t count)
 {
-	BUG_ON(direction != READ);
+	BUG_ON(direction != ITER_DEST);
 	*i = (struct iov_iter){
 		.iter_type = ITER_DISCARD,
-		.data_source = false,
+		.data_source = ITER_DEST,
 		.count = count,
 		.iov_offset = 0
 	};
@@ -1444,10 +1444,10 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize = MAX_RW_COUNT;
 
 	if (WARN_ON_ONCE((gup_flags & FOLL_BUF_MASK) == FOLL_SOURCE_BUF &&
-			 i->data_source == ITER_DEST))
+			 iov_iter_is_dest(i)))
 		return -EIO;
 	if (WARN_ON_ONCE((gup_flags & FOLL_BUF_MASK) == FOLL_DEST_BUF &&
-			 i->data_source == ITER_SOURCE))
+			 iov_iter_is_source(i)))
 		return -EIO;
 
 	if (likely(user_backed_iter(i))) {
@@ -1775,7 +1775,7 @@ struct iovec *iovec_from_user(const struct iovec __user *uvec,
 	return iov;
 }
 
-ssize_t __import_iovec(int type, const struct iovec __user *uvec,
+ssize_t __import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs, struct iovec **iovp,
 		 struct iov_iter *i, bool compat)
 {
@@ -1814,7 +1814,7 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		total_len += len;
 	}
 
-	iov_iter_init(i, type, iov, nr_segs, total_len);
+	iov_iter_init(i, direction, iov, nr_segs, total_len);
 	if (iov == *iovp)
 		*iovp = NULL;
 	else
@@ -1827,7 +1827,7 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
  *     into the kernel, check that it is valid, and initialize a new
  *     &struct iov_iter iterator to access it.
  *
- * @type: One of %READ or %WRITE.
+ * @direction: One of %ITER_SOURCE or %ITER_DEST.
  * @uvec: Pointer to the userspace array.
  * @nr_segs: Number of elements in userspace array.
  * @fast_segs: Number of elements in @iov.
@@ -1844,16 +1844,16 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
  *
  * Return: Negative error code on error, bytes imported on success
  */
-ssize_t import_iovec(int type, const struct iovec __user *uvec,
+ssize_t import_iovec(enum iter_dir direction, const struct iovec __user *uvec,
 		 unsigned nr_segs, unsigned fast_segs,
 		 struct iovec **iovp, struct iov_iter *i)
 {
-	return __import_iovec(type, uvec, nr_segs, fast_segs, iovp, i,
+	return __import_iovec(direction, uvec, nr_segs, fast_segs, iovp, i,
 			      in_compat_syscall());
 }
 EXPORT_SYMBOL(import_iovec);
 
-int import_single_range(int rw, void __user *buf, size_t len,
+int import_single_range(enum iter_dir direction, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i)
 {
 	if (len > MAX_RW_COUNT)
@@ -1863,7 +1863,7 @@ int import_single_range(int rw, void __user *buf, size_t len,
 
 	iov->iov_base = buf;
 	iov->iov_len = len;
-	iov_iter_init(i, rw, iov, 1, len);
+	iov_iter_init(i, direction, iov, 1, len);
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);
@@ -1905,3 +1905,364 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+
+/*
+ * Extract a list of contiguous pages from an ITER_PIPE iterator.  This does
+ * not get references of its own on the pages, nor does it get a pin on them.
+ * If there's a partial page, it adds that first and will then allocate and add
+ * pages into the pipe to make up the buffer space to the amount required.
+ *
+ * The caller must hold the pipe locked and only transferring into a pipe is
+ * supported.
+ */
+static ssize_t iov_iter_extract_pipe_pages(struct iov_iter *i,
+					   struct page ***pages, size_t maxsize,
+					   unsigned int maxpages,
+					   unsigned int gup_flags,
+					   size_t *offset0)
+{
+	unsigned int nr, offset, chunk, j;
+	struct page **p;
+	size_t left;
+
+	if (!sanity(i))
+		return -EFAULT;
+
+	offset = pipe_npages(i, &nr);
+	if (!nr)
+		return -EFAULT;
+	*offset0 = offset;
+
+	maxpages = min_t(size_t, nr, maxpages);
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	p = *pages;
+
+	left = maxsize;
+	for (j = 0; j < maxpages; j++) {
+		struct page *page = append_pipe(i, left, &offset);
+		if (!page)
+			break;
+		chunk = min_t(size_t, left, PAGE_SIZE - offset);
+		left -= chunk;
+		*p++ = page;
+	}
+	if (!j)
+		return -EFAULT;
+	return maxsize - left;
+}
+
+/*
+ * Extract a list of contiguous pages from an ITER_XARRAY iterator.  This does not
+ * get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
+					     struct page ***pages, size_t maxsize,
+					     unsigned int maxpages,
+					     unsigned int gup_flags,
+					     size_t *offset0)
+{
+	struct page *page, **p;
+	unsigned int nr = 0, offset;
+	loff_t pos = i->xarray_start + i->iov_offset;
+	pgoff_t index = pos >> PAGE_SHIFT;
+	XA_STATE(xas, i->xarray, index);
+
+	offset = pos & ~PAGE_MASK;
+	*offset0 = offset;
+
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	p = *pages;
+
+	rcu_read_lock();
+	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
+		if (xas_retry(&xas, page))
+			continue;
+
+		/* Has the page moved or been split? */
+		if (unlikely(page != xas_reload(&xas))) {
+			xas_reset(&xas);
+			continue;
+		}
+
+		p[nr++] = find_subpage(page, xas.xa_index);
+		if (nr == maxpages)
+			break;
+	}
+	rcu_read_unlock();
+
+	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	i->iov_offset += maxsize;
+	i->count -= maxsize;
+	return maxsize;
+}
+
+/*
+ * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
+ * not get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
+					   struct page ***pages, size_t maxsize,
+					   unsigned int maxpages,
+					   unsigned int gup_flags,
+					   size_t *offset0)
+{
+	struct page **p, *page;
+	size_t skip = i->iov_offset, offset;
+	int k;
+
+	maxsize = min(maxsize, i->bvec->bv_len - skip);
+	skip += i->bvec->bv_offset;
+	page = i->bvec->bv_page + skip / PAGE_SIZE;
+	offset = skip % PAGE_SIZE;
+	*offset0 = offset;
+
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	p = *pages;
+	for (k = 0; k < maxpages; k++)
+		p[k] = page + k;
+
+	maxsize = min_t(size_t, maxsize, maxpages * PAGE_SIZE - offset);
+	i->count -= maxsize;
+	i->iov_offset += maxsize;
+	if (i->iov_offset == i->bvec->bv_len) {
+		i->iov_offset = 0;
+		i->bvec++;
+		i->nr_segs--;
+	}
+	return maxsize;
+}
+
+/*
+ * Get the first segment from an ITER_UBUF or ITER_IOVEC iterator.  The
+ * iterator must not be empty.
+ */
+static unsigned long iov_iter_extract_first_user_segment(const struct iov_iter *i,
+							 size_t *size)
+{
+	size_t skip;
+	long k;
+
+	if (iter_is_ubuf(i))
+		return (unsigned long)i->ubuf + i->iov_offset;
+
+	for (k = 0, skip = i->iov_offset; k < i->nr_segs; k++, skip = 0) {
+		size_t len = i->iov[k].iov_len - skip;
+
+		if (unlikely(!len))
+			continue;
+		if (*size > len)
+			*size = len;
+		return (unsigned long)i->iov[k].iov_base + skip;
+	}
+	BUG(); // if it had been empty, we wouldn't get called
+}
+
+/*
+ * Extract a list of contiguous pages from a user iterator and get references
+ * on them.  This should only be used iff the iterator is user-backed
+ * (IOBUF/UBUF) and data is being transferred out of the buffer described by
+ * the iterator (ie. this is the source).
+ *
+ * The pages are returned with incremented refcounts that the caller must undo
+ * once the transfer is complete, but no additional pins are obtained.
+ *
+ * This is only safe to be used where background IO/DMA is not going to be
+ * modifying the buffer, and so won't cause a problem with CoW on fork.
+ */
+static ssize_t iov_iter_extract_user_pages_and_get(struct iov_iter *i,
+						   struct page ***pages,
+						   size_t maxsize,
+						   unsigned int maxpages,
+						   unsigned int gup_flags,
+						   size_t *offset0)
+{
+	unsigned long addr;
+	size_t offset;
+	int res;
+
+	if (WARN_ON_ONCE(!iov_iter_is_source(i)))
+		return -EFAULT;
+
+	gup_flags |= FOLL_GET;
+	if (i->nofault)
+		gup_flags |= FOLL_NOFAULT;
+
+	addr = iov_iter_extract_first_user_segment(i, &maxsize);
+	*offset0 = offset = addr % PAGE_SIZE;
+	addr &= PAGE_MASK;
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	res = get_user_pages_fast(addr, maxpages, gup_flags, *pages);
+	if (unlikely(res <= 0))
+		return res;
+	maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - offset);
+	iov_iter_advance(i, maxsize);
+	return maxsize;
+}
+
+/*
+ * Extract a list of contiguous pages from a user iterator and get a pin on
+ * each of them.  This should only be used iff the iterator is user-backed
+ * (IOBUF/UBUF) and data is being transferred into the buffer described by the
+ * iterator (ie. this is the destination).
+ *
+ * It does not get refs on the pages, but the pages must be unpinned by the
+ * caller once the transfer is complete.
+ *
+ * This is safe to be used where background IO/DMA *is* going to be modifying
+ * the buffer; using a pin rather than a ref makes sure that CoW happens
+ * correctly in the parent during fork.
+ */
+static ssize_t iov_iter_extract_user_pages_and_pin(struct iov_iter *i,
+						   struct page ***pages,
+						   size_t maxsize,
+						   unsigned int maxpages,
+						   unsigned int gup_flags,
+						   size_t *offset0)
+{
+	unsigned long addr;
+	size_t offset;
+	int res;
+
+	if (WARN_ON_ONCE(!iov_iter_is_dest(i)))
+		return -EFAULT;
+
+	gup_flags |= FOLL_PIN | FOLL_WRITE;
+	if (i->nofault)
+		gup_flags |= FOLL_NOFAULT;
+
+	addr = first_iovec_segment(i, &maxsize);
+	*offset0 = offset = addr % PAGE_SIZE;
+	addr &= PAGE_MASK;
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	res = pin_user_pages_fast(addr, maxpages, gup_flags, *pages);
+	if (unlikely(res <= 0))
+		return res;
+	maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - offset);
+	iov_iter_advance(i, maxsize);
+	return maxsize;
+}
+
+static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
+					   struct page ***pages, size_t maxsize,
+					   unsigned int maxpages,
+					   unsigned int gup_flags,
+					   size_t *offset0)
+{
+	if (iov_iter_extract_mode(i, gup_flags) == FOLL_GET)
+		return iov_iter_extract_user_pages_and_get(i, pages, maxsize,
+							   maxpages, gup_flags,
+							   offset0);
+	else
+		return iov_iter_extract_user_pages_and_pin(i, pages, maxsize,
+							   maxpages, gup_flags,
+							   offset0);
+}
+
+/**
+ * iov_iter_extract_pages - Extract a list of contiguous pages from an iterator
+ * @i: The iterator to extract from
+ * @pages: Where to return the list of pages
+ * @maxsize: The maximum amount of iterator to extract
+ * @maxpages: The maximum size of the list of pages
+ * @gup_flags: Direction indicator and additional flags
+ * @offset0: Where to return the starting offset into (*@pages)[0]
+ *
+ * Extract a list of contiguous pages from the current point of the iterator,
+ * advancing the iterator.  The maximum number of pages and the maximum amount
+ * of page contents can be set.
+ *
+ * If *@pages is NULL, a page list will be allocated to the required size and
+ * *@pages will be set to its base.  If *@pages is not NULL, it will be assumed
+ * that the caller allocated a page list at least @maxpages in size and this
+ * will be filled in.
+ *
+ * @gup_flags can be set to either FOLL_SOURCE_BUF or FOLL_DEST_BUF, indicating
+ * how the buffer is to be used, and can have FOLL_PCI_P2PDMA OR'd with that.
+ *
+ * The iov_iter_extract_mode() function can be used to query how cleanup should
+ * be performed.
+ *
+ * Extra refs or pins on the pages may be obtained as follows:
+ *
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF) and data is to be
+ *      transferred /OUT OF/ the buffer (@gup_flags |= FOLL_SOURCE_BUF), refs
+ *      will be taken on the pages, but pins will not be added.  This can be
+ *      used for DMA from a page; it cannot be used for DMA to a page, as it
+ *      may cause page-COW problems in fork.  iov_iter_extract_mode() will
+ *      return FOLL_GET.
+ *
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF) and data is to be
+ *      transferred /INTO/ the described buffer (@gup_flags |= FOLL_DEST_BUF),
+ *      pins will be added to the pages, but refs will not be taken.  This must
+ *      be used for DMA to a page.  iov_iter_extract_mode() will return
+ *      FOLL_PIN.
+ *
+ *  (*) If the iterator is ITER_PIPE, this must describe a destination for the
+ *      data.  Additional pages may be allocated and added to the pipe (which
+ *      will hold the refs), but neither refs nor pins will be obtained for the
+ *      caller.  The caller must hold the pipe lock.  iov_iter_extract_mode()
+ *      will return 0.
+ *
+ *  (*) If the iterator is ITER_BVEC or ITER_XARRAY, the pages are merely
+ *      listed; no extra refs or pins are obtained.  iov_iter_extract_mode()
+ *      will return 0.
+ *
+ * Note also:
+ *
+ *  (*) Use with ITER_KVEC is not supported as that may refer to memory that
+ *      doesn't have associated page structs.
+ *
+ *  (*) Use with ITER_DISCARD is not supported as that has no content.
+ *
+ * On success, the function sets *@pages to the new pagelist, if allocated, and
+ * sets *offset0 to the offset into the first page..
+ *
+ * It may also return -ENOMEM and -EFAULT.
+ */
+ssize_t iov_iter_extract_pages(struct iov_iter *i,
+			       struct page ***pages,
+			       size_t maxsize,
+			       unsigned int maxpages,
+			       unsigned int gup_flags,
+			       size_t *offset0)
+{
+	if (WARN_ON_ONCE((gup_flags & FOLL_BUF_MASK) == FOLL_SOURCE_BUF &&
+			 iov_iter_is_dest(i)))
+		return -EIO;
+	if (WARN_ON_ONCE((gup_flags & FOLL_BUF_MASK) == FOLL_DEST_BUF &&
+			 iov_iter_is_source(i)))
+		return -EIO;
+
+	maxsize = min_t(size_t, min_t(size_t, maxsize, i->count), MAX_RW_COUNT);
+	if (!maxsize)
+		return 0;
+
+	if (likely(user_backed_iter(i)))
+		return iov_iter_extract_user_pages(i, pages, maxsize,
+						   maxpages, gup_flags,
+						   offset0);
+	if (iov_iter_is_bvec(i))
+		return iov_iter_extract_bvec_pages(i, pages, maxsize,
+						   maxpages, gup_flags,
+						   offset0);
+	if (iov_iter_is_pipe(i))
+		return iov_iter_extract_pipe_pages(i, pages, maxsize,
+						   maxpages, gup_flags,
+						   offset0);
+	if (iov_iter_is_xarray(i))
+		return iov_iter_extract_xarray_pages(i, pages, maxsize,
+						     maxpages, gup_flags,
+						     offset0);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(iov_iter_extract_pages);



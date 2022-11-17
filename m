Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E862DEBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 15:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiKQO4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbiKQOz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354035DBAC
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Nov 2022 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668696904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXjKZg5WljgzOeSAUW09t9JKhnsX6Sn+uoUMMkWxvVw=;
        b=SYeYLzQAdmsYZPJbnEqmJPNf0Y6szEZ1UrpVqAgEsMCOnocJDkcio1w+r3UMlbVSnJiZPW
        iOK1dxcV0SvPoJLZAyWtoY5V9FjJLk+S8YoaGmFi85vxrWfLGwCFzB7SQ+C/IQxw+Hl6Aq
        kz4VxQcmaLcqeHpgaQAFAUIAbesMvlk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-TBgu8tP6N3Ob-LPQgFlYPw-1; Thu, 17 Nov 2022 09:54:59 -0500
X-MC-Unique: TBgu8tP6N3Ob-LPQgFlYPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9891038012F3;
        Thu, 17 Nov 2022 14:54:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4449B1415119;
        Thu, 17 Nov 2022 14:54:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/4] iov_iter: Add a function to extract a page list from
 an iterator
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Nov 2022 14:54:54 +0000
Message-ID: <166869689451.3723671.18242195992447653092.stgit@warthog.procyon.org.uk>
In-Reply-To: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
References: <166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function, iov_iter_extract_pages(), to extract a list of pages from
an iterator.  The pages may be returned with a reference added or a pin
added or neither, depending on the type of iterator and the direction of
transfer.

An additional function, iov_iter_extract_mode() is also provided so that the
mode of retention that will be employed for an iterator can be queried - and
therefore how the caller should dispose of the pages later.

There are three cases:

 (1) Transfer *into* an ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have pins obtained on them (but not references)
     so that fork() doesn't CoW the pages incorrectly whilst the I/O is in
     progress.

     iov_iter_extract_mode() will return FOLL_PIN for this case.  The caller
     should use something like unpin_user_page() to dispose of the page.

 (2) Transfer is *out of* an ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have references obtained on them, but not pins.

     iov_iter_extract_mode() will return FOLL_GET.  The caller should use
     something like put_page() for page disposal.

 (3) Any other sort of iterator.

     No refs or pins are obtained on the page, the assumption is made that
     the caller will manage page retention.

     iov_iter_extract_mode() will return 0.  The pages don't need additional
     disposal.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/166722777971.2555743.12953624861046741424.stgit@warthog.procyon.org.uk/
---

 include/linux/uio.h |   29 ++++
 lib/iov_iter.c      |  333 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 362 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e3134b14ffd..329e36d41f0a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -351,4 +351,33 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	};
 }
 
+ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
+			       size_t maxsize, unsigned int maxpages,
+			       size_t *offset0);
+
+/**
+ * iov_iter_extract_mode - Indicate how pages from the iterator will be retained
+ * @iter: The iterator
+ *
+ * Examine the indicator and indicate with FOLL_PIN, FOLL_GET or 0 as to how,
+ * if at all, pages extracted from the iterator will be retained by the
+ * extraction function.
+ *
+ * FOLL_GET indicates that the pages will have a reference taken on them that
+ * the caller must put.  This can be done for DMA/async DIO write from a page.
+ *
+ * FOLL_PIN indicates that the pages will have a pin placed in them that the
+ * caller must unpin.  This is must be done for DMA/async DIO read to a page to
+ * avoid CoW problems in fork.
+ *
+ * 0 indicates that no measures are taken and that it's up to the caller to
+ * retain the pages.
+ */
+static inline unsigned int iov_iter_extract_mode(struct iov_iter *iter)
+{
+	if (user_backed_iter(iter))
+		return iter->data_source ? FOLL_GET : FOLL_PIN;
+	return 0;
+}
+
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c3ca28ca68a6..17f63f4d499b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1892,3 +1892,336 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
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
+						   size_t *offset0)
+{
+	unsigned long addr;
+	unsigned int gup_flags = FOLL_GET;
+	size_t offset;
+	int res;
+
+	if (WARN_ON_ONCE(iov_iter_rw(i) != WRITE))
+		return -EFAULT;
+
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
+						   size_t *offset0)
+{
+	unsigned long addr;
+	unsigned int gup_flags = FOLL_PIN | FOLL_WRITE;
+	size_t offset;
+	int res;
+
+	if (WARN_ON_ONCE(iov_iter_rw(i) != READ))
+		return -EFAULT;
+
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
+					   size_t *offset0)
+{
+	switch (iov_iter_extract_mode(i)) {
+	case FOLL_GET:
+		return iov_iter_extract_user_pages_and_get(i, pages, maxsize,
+							   maxpages, offset0);
+	case FOLL_PIN:
+		return iov_iter_extract_user_pages_and_pin(i, pages, maxsize,
+							   maxpages, offset0);
+	default:
+		BUG();
+	}
+}
+
+/**
+ * iov_iter_extract_pages - Extract a list of contiguous pages from an iterator
+ * @i: The iterator to extract from
+ * @pages: Where to return the list of pages
+ * @maxsize: The maximum amount of iterator to extract
+ * @maxpages: The maximum size of the list of pages
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
+ * Extra refs or pins on the pages may be obtained as follows:
+ *
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF) and data is to be
+ *      transferred /OUT OF/ the described buffer, refs will be taken on the
+ *      pages, but pins will not be added.  This can be used for DMA from a
+ *      page; it cannot be used for DMA to a page, as it may cause page-COW
+ *      problems in fork.
+ *
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF) and data is to be
+ *      transferred /INTO/ the described buffer, pins will be added to the
+ *      pages, but refs will not be taken.  This must be used for DMA to a
+ *      page.
+ *
+ *  (*) If the iterator is ITER_PIPE, this must describe a destination for the
+ *      data.  Additional pages may be allocated and added to the pipe (which
+ *      will hold the refs), but neither refs nor pins will be obtained for the
+ *      caller.  The caller must hold the pipe lock.
+ *
+ *  (*) If the iterator is ITER_BVEC or ITER_XARRAY, the pages are merely
+ *      listed; no extra refs or pins are obtained.
+ *
+ * Note also:
+ *
+ *  (*) Use with ITER_KVEC is not supported as that may refer to memory that
+ *      doesn't have associated page structs.
+ *
+ *  (*) Use with ITER_DISCARD is not supported as that has no content.
+ *
+ * On success, the function sets *@pages to the new pagelist, if allocated, and
+ * sets *offset0 to the offset into the first page and returns the amount of
+ * buffer space added represented by the page list.
+ *
+ * It may also return -ENOMEM and -EFAULT.
+ */
+ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
+			       size_t maxsize, unsigned int maxpages,
+			       size_t *offset0)
+{
+	maxsize = min_t(size_t, min_t(size_t, maxsize, i->count), MAX_RW_COUNT);
+	if (!maxsize)
+		return 0;
+
+	if (likely(user_backed_iter(i)))
+		return iov_iter_extract_user_pages(i, pages, maxsize,
+						   maxpages, offset0);
+	if (iov_iter_is_bvec(i))
+		return iov_iter_extract_bvec_pages(i, pages, maxsize,
+						   maxpages, offset0);
+	if (iov_iter_is_pipe(i))
+		return iov_iter_extract_pipe_pages(i, pages, maxsize,
+						   maxpages, offset0);
+	if (iov_iter_is_xarray(i))
+		return iov_iter_extract_xarray_pages(i, pages, maxsize,
+						     maxpages, offset0);
+	return -EFAULT;
+}
+EXPORT_SYMBOL(iov_iter_extract_pages);



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1B675C42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjATR5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 12:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjATR5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E43FF38
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOc0D7umTnyUP1ok6rrw95EYcgD0TtRB9xXUvJKEMgA=;
        b=g8xBOOLBk5l3x26jFCr5uxmczg1cS2HzD88i65JR+ooSgnDK4AIWqZnf+UohB2azLddBIR
        +NFd6gUV9FMxPXF2sVHVuBGk71qHh9/9tcLQrPolz+yi+WaeJ1LgdMJRISWocR0RT04APT
        V9eM98Kk4EAQzyRxTYyqI6CuSC+UJfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-FJgQK12-PNayxGNY9zL-hQ-1; Fri, 20 Jan 2023 12:56:07 -0500
X-MC-Unique: FJgQK12-PNayxGNY9zL-hQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD6ED802BEE;
        Fri, 20 Jan 2023 17:56:06 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 102662166B2A;
        Fri, 20 Jan 2023 17:56:04 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: [PATCH v7 2/8] iov_iter: Add a function to extract a page list from an iterator
Date:   Fri, 20 Jan 2023 17:55:50 +0000
Message-Id: <20230120175556.3556978-3-dhowells@redhat.com>
In-Reply-To: <20230120175556.3556978-1-dhowells@redhat.com>
References: <20230120175556.3556978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
transfer.  The caller must pass FOLL_READ_FROM_MEM or FOLL_WRITE_TO_MEM
as part of gup_flags to indicate how the iterator contents are to be used.

Add a second function, iov_iter_extract_mode(), to determine how the
cleanup should be done.

There are three cases:

 (1) Transfer *into* an ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have pins obtained on them (but not references)
     so that fork() doesn't CoW the pages incorrectly whilst the I/O is in
     progress.

     iov_iter_extract_mode() will return FOLL_PIN for this case.  The
     caller should use something like unpin_user_page() to dispose of the
     page.

 (2) Transfer is *out of* an ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have references obtained on them, but not pins.

     iov_iter_extract_mode() will return FOLL_GET.  The caller should use
     something like put_page() for page disposal.

 (3) Any other sort of iterator.

     No refs or pins are obtained on the page, the assumption is made that
     the caller will manage page retention.  ITER_ALLOW_P2PDMA is not
     permitted.

     iov_iter_extract_mode() will return 0.  The pages don't need
     additional disposal.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/166920903885.1461876.692029808682876184.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/167305163883.1521586.10777155475378874823.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/167391053207.2311931.16398133457201442907.stgit@warthog.procyon.org.uk/ # v6
---

Notes:
    ver #7)
     - Switch to passing in iter-specific flags rather than FOLL_* flags.
     - Drop the direction flags for now.
     - Use ITER_ALLOW_P2PDMA to request FOLL_PCI_P2PDMA.
     - Disallow use of ITER_ALLOW_P2PDMA with non-user-backed iter.
     - Add support for extraction from KVEC-type iters.
     - Use iov_iter_advance() rather than open-coding it.
     - Make BVEC- and KVEC-type skip over initial empty vectors.
    
    ver #6)
     - Add back the function to indicate the cleanup mode.
     - Drop the cleanup_mode return arg to iov_iter_extract_pages().
     - Pass FOLL_SOURCE/DEST_BUF in gup_flags.  Check this against the iter
       data_source.
    
    ver #4)
     - Use ITER_SOURCE/DEST instead of WRITE/READ.
     - Allow additional FOLL_* flags, such as FOLL_PCI_P2PDMA to be passed in.
    
    ver #3)
     - Switch to using EXPORT_SYMBOL_GPL to prevent indirect 3rd-party access
       to get/pin_user_pages_fast()[1].

 include/linux/uio.h |  28 +++
 lib/iov_iter.c      | 424 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 452 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 46d5080314c6..a4233049ab7a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -363,4 +363,32 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 /* Flags for iov_iter_get/extract_pages*() */
 #define ITER_ALLOW_P2PDMA	0x01	/* Allow P2PDMA on the extracted pages */
 
+ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
+			       size_t maxsize, unsigned int maxpages,
+			       unsigned int extract_flags, size_t *offset0);
+
+/**
+ * iov_iter_extract_mode - Indicate how pages from the iterator will be retained
+ * @iter: The iterator
+ * @extract_flags: How the iterator is to be used
+ *
+ * Examine the iterator and @extract_flags and indicate by returning FOLL_PIN,
+ * FOLL_GET or 0 as to how, if at all, pages extracted from the iterator will
+ * be retained by the extraction function.
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
+#define iov_iter_extract_mode(iter, extract_flags) \
+	(user_backed_iter(iter) ?				\
+	 (iter->data_source == ITER_SOURCE) ?			\
+	 FOLL_GET : FOLL_PIN : 0)
+
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb04abe7d746..843abe566efb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1916,3 +1916,427 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
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
+					   unsigned int extract_flags,
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
+					     unsigned int extract_flags,
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
+	iov_iter_advance(i, maxsize);
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
+					   unsigned int extract_flags,
+					   size_t *offset0)
+{
+	struct page **p, *page;
+	size_t skip = i->iov_offset, offset;
+	int k;
+
+	for (;;) {
+		if (i->nr_segs == 0)
+			return 0;
+		maxsize = min(maxsize, i->bvec->bv_len - skip);
+		if (maxsize)
+			break;
+		i->iov_offset = 0;
+		i->nr_segs--;
+		i->kvec++;
+		skip = 0;
+	}
+
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
+	iov_iter_advance(i, maxsize);
+	return maxsize;
+}
+
+/*
+ * Extract a list of virtually contiguous pages from an ITER_KVEC iterator.
+ * This does not get references on the pages, nor does it get a pin on them.
+ */
+static ssize_t iov_iter_extract_kvec_pages(struct iov_iter *i,
+					   struct page ***pages, size_t maxsize,
+					   unsigned int maxpages,
+					   unsigned int extract_flags,
+					   size_t *offset0)
+{
+	struct page **p, *page;
+	const void *kaddr;
+	size_t skip = i->iov_offset, offset, len;
+	int k;
+
+	for (;;) {
+		if (i->nr_segs == 0)
+			return 0;
+		maxsize = min(maxsize, i->kvec->iov_len - skip);
+		if (maxsize)
+			break;
+		i->iov_offset = 0;
+		i->nr_segs--;
+		i->kvec++;
+		skip = 0;
+	}
+
+	offset = skip % PAGE_SIZE;
+	*offset0 = offset;
+	kaddr = i->kvec->iov_base;
+
+	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	if (!maxpages)
+		return -ENOMEM;
+	p = *pages;
+
+	kaddr -= offset;
+	len = offset + maxsize;
+	for (k = 0; k < maxpages; k++) {
+		size_t seg = min_t(size_t, len, PAGE_SIZE);
+
+		if (is_vmalloc_or_module_addr(kaddr))
+			page = vmalloc_to_page(kaddr);
+		else
+			page = virt_to_page(kaddr);
+
+		p[k] = page;
+		len -= seg;
+		kaddr += PAGE_SIZE;
+	}
+
+	maxsize = min_t(size_t, maxsize, maxpages * PAGE_SIZE - offset);
+	iov_iter_advance(i, maxsize);
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
+						   unsigned int extract_flags,
+						   size_t *offset0)
+{
+	unsigned long addr;
+	unsigned int gup_flags = FOLL_GET;
+	size_t offset;
+	int res;
+
+	if (WARN_ON_ONCE(i->data_source != ITER_SOURCE))
+		return -EFAULT;
+
+	if (extract_flags & ITER_ALLOW_P2PDMA)
+		gup_flags |= FOLL_PCI_P2PDMA;
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
+						   unsigned int extract_flags,
+						   size_t *offset0)
+{
+	unsigned long addr;
+	unsigned int gup_flags = FOLL_PIN | FOLL_WRITE;
+	size_t offset;
+	int res;
+
+	if (WARN_ON_ONCE(i->data_source != ITER_DEST))
+		return -EFAULT;
+
+	if (extract_flags & ITER_ALLOW_P2PDMA)
+		gup_flags |= FOLL_PCI_P2PDMA;
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
+					   unsigned int extract_flags,
+					   size_t *offset0)
+{
+	if (iov_iter_extract_mode(i, extract_flags) == FOLL_GET)
+		return iov_iter_extract_user_pages_and_get(i, pages, maxsize,
+							   maxpages, extract_flags,
+							   offset0);
+	else
+		return iov_iter_extract_user_pages_and_pin(i, pages, maxsize,
+							   maxpages, extract_flags,
+							   offset0);
+}
+
+/**
+ * iov_iter_extract_pages - Extract a list of contiguous pages from an iterator
+ * @i: The iterator to extract from
+ * @pages: Where to return the list of pages
+ * @maxsize: The maximum amount of iterator to extract
+ * @maxpages: The maximum size of the list of pages
+ * @extract_flags: Flags to qualify request
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
+ * @extract_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
+ * allowed on the pages extracted.
+ *
+ * The iov_iter_extract_mode() function can be used to query how cleanup should
+ * be performed.
+ *
+ * Extra refs or pins on the pages may be obtained as follows:
+ *
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF) and data is to be
+ *      transferred /OUT OF/ the buffer (@i->data_source == ITER_SOURCE), refs
+ *      will be taken on the pages, but pins will not be added.  This can be
+ *      used for DMA from a page; it cannot be used for DMA to a page, as it
+ *      may cause page-COW problems in fork.  iov_iter_extract_mode() will
+ *      return FOLL_GET.
+ *
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF) and data is to be
+ *      transferred /INTO/ the described buffer (@i->data_source |= ITER_DEST),
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
+ *  (*) If the iterator is ITER_KVEC, ITER_BVEC or ITER_XARRAY, the pages are
+ *      merely listed; no extra refs or pins are obtained.
+ *      iov_iter_extract_mode() will return 0.
+ *
+ * Note also:
+ *
+ *  (*) Peer-to-peer DMA (ITER_ALLOW_P2PDMA) is only permitted with user-backed
+ *      iterators.
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
+			       unsigned int extract_flags,
+			       size_t *offset0)
+{
+	maxsize = min_t(size_t, min_t(size_t, maxsize, i->count), MAX_RW_COUNT);
+	if (!maxsize)
+		return 0;
+
+	if (likely(user_backed_iter(i)))
+		return iov_iter_extract_user_pages(i, pages, maxsize,
+						   maxpages, extract_flags,
+						   offset0);
+	if (WARN_ON_ONCE(extract_flags & ITER_ALLOW_P2PDMA))
+		return -EIO;
+	if (iov_iter_is_kvec(i))
+		return iov_iter_extract_kvec_pages(i, pages, maxsize,
+						   maxpages, extract_flags,
+						   offset0);
+	if (iov_iter_is_bvec(i))
+		return iov_iter_extract_bvec_pages(i, pages, maxsize,
+						   maxpages, extract_flags,
+						   offset0);
+	if (iov_iter_is_pipe(i))
+		return iov_iter_extract_pipe_pages(i, pages, maxsize,
+						   maxpages, extract_flags,
+						   offset0);
+	if (iov_iter_is_xarray(i))
+		return iov_iter_extract_xarray_pages(i, pages, maxsize,
+						     maxpages, extract_flags,
+						     offset0);
+	return -EFAULT;
+}
+EXPORT_SYMBOL_GPL(iov_iter_extract_pages);


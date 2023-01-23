Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB48C67832E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjAWRcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjAWRby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D22C65E
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674495021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BQhW3wHk53SQ0g+pPIstFzSMICN3HLKrueb/Jgd0sA=;
        b=jP1dm7ApYkt4ESH99Gf+DI16xzcS9rfye7SgPHtWNWwZh/Gh1DYeSxHKMTmjQqy5E+kSVq
        HpxPi8R9VVqf7uk0trwoSdm/2UEapQbIyxRPKf4yezIxSSJdl/gLJNaQRnUME0u+3MAxhN
        R//Jf00BxPORfVbRLbQbKO8ubRmD28I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-MGtzFN3AN8yceGHs8VyG8Q-1; Mon, 23 Jan 2023 12:30:18 -0500
X-MC-Unique: MGtzFN3AN8yceGHs8VyG8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CA7A18E6C41;
        Mon, 23 Jan 2023 17:30:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1CA61121330;
        Mon, 23 Jan 2023 17:30:15 +0000 (UTC)
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
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Subject: [PATCH v8 02/10] iov_iter: Add a function to extract a page list from an iterator
Date:   Mon, 23 Jan 2023 17:29:59 +0000
Message-Id: <20230123173007.325544-3-dhowells@redhat.com>
In-Reply-To: <20230123173007.325544-1-dhowells@redhat.com>
References: <20230123173007.325544-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function, iov_iter_extract_pages(), to extract a list of pages from
an iterator.  The pages may be returned with a pin added or nothing,
depending on the type of iterator.

Add a second function, iov_iter_extract_mode(), to determine how the
cleanup should be done.

There are two cases:

 (1) ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have pins (FOLL_PIN) obtained on them so that a
     concurrent fork() will forcibly copy the page so that DMA is done
     to/from the parent's buffer and is unavailable to/unaffected by the
     child process.

     iov_iter_extract_mode() will return FOLL_PIN for this case.  The
     caller should use something like folio_put_unpin() to dispose of the
     page.

 (2) Any other sort of iterator.

     No refs or pins are obtained on the page, the assumption is made that
     the caller will manage page retention.

     iov_iter_extract_mode() will return 0.  The pages don't need
     additional disposal.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #8)
     - It seems that all DIO is supposed to be done under FOLL_PIN now, and not
       FOLL_GET, so switch to only using pin_user_pages() for user-backed
       iters.
     - Wrap an argument in brackets in the iov_iter_extract_mode() macro.
     - Drop the extract_flags argument to iov_iter_extract_mode() for now
       [hch].
    
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

 include/linux/uio.h |  22 +++
 lib/iov_iter.c      | 320 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 342 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 46d5080314c6..a8165335f8da 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -363,4 +363,26 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 /* Flags for iov_iter_get/extract_pages*() */
 #define ITER_ALLOW_P2PDMA	0x01	/* Allow P2PDMA on the extracted pages */
 
+ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
+			       size_t maxsize, unsigned int maxpages,
+			       unsigned int extract_flags, size_t *offset0);
+
+/**
+ * iov_iter_extract_mode - Indicate how pages from the iterator will be retained
+ * @iter: The iterator
+ *
+ * Examine the iterator and indicate by returning FOLL_PIN or 0 as to how, if
+ * at all, pages extracted from the iterator will be retained by the extraction
+ * function.
+ *
+ * FOLL_PIN indicates that the pages will have a pin placed in them that the
+ * caller must unpin.  This is must be done for DMA/async DIO to force fork()
+ * to forcibly copy a page for the child (the parent must retain the original
+ * page).
+ *
+ * 0 indicates that no measures are taken and that it's up to the caller to
+ * retain the pages.
+ */
+#define iov_iter_extract_mode(iter) (user_backed_iter(iter) ? FOLL_PIN : 0)
+
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fb04abe7d746..57f3e9404160 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1916,3 +1916,323 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
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
+ * Extract a list of contiguous pages from a user iterator and get a pin on
+ * each of them.  This should only be used if the iterator is user-backed
+ * (IOBUF/UBUF).
+ *
+ * It does not get refs on the pages, but the pages must be unpinned by the
+ * caller once the transfer is complete.
+ *
+ * This is safe to be used where background IO/DMA *is* going to be modifying
+ * the buffer; using a pin rather than a ref makes forces fork() to give the
+ * child a copy of the page.
+ */
+static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
+					   struct page ***pages,
+					   size_t maxsize,
+					   unsigned int maxpages,
+					   unsigned int extract_flags,
+					   size_t *offset0)
+{
+	unsigned long addr;
+	unsigned int gup_flags = FOLL_PIN;
+	size_t offset;
+	int res;
+
+	if (i->data_source == ITER_DEST)
+		gup_flags |= FOLL_WRITE;
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
+ *  (*) If the iterator is user-backed (ITER_IOVEC/ITER_UBUF), pins will be
+ *      added to the pages, but refs will not be taken.
+ *      iov_iter_extract_mode() will return FOLL_PIN.
+ *
+ *  (*) If the iterator is ITER_PIPE, this must describe a destination for the
+ *      data.  Additional pages may be allocated and added to the pipe (which
+ *      will hold the refs), but pins will not be obtained for the caller.  The
+ *      caller must hold the pipe lock.  iov_iter_extract_mode() will return 0.
+ *
+ *  (*) If the iterator is ITER_KVEC, ITER_BVEC or ITER_XARRAY, the pages are
+ *      merely listed; no extra refs or pins are obtained.
+ *      iov_iter_extract_mode() will return 0.
+ *
+ * Note also:
+ *
+ *  (*) Use with ITER_DISCARD is not supported as that has no content.
+ *
+ * On success, the function sets *@pages to the new pagelist, if allocated, and
+ * sets *offset0 to the offset into the first page.
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAB5B42FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIIXSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 19:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIXSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E3D0745
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662765495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r1+0RvgsFqTgu72dnYxCvCO2DtJfMc66wNhG10S227Y=;
        b=Gz7TLxlUX9KEVRi0S9FmQWINHL6xsmoTSRlD2NYldP3yg9ULXAlCjczqg1GKojuKSv2xiw
        72G6eWeqfCp1wgXq1hddngu7QZw3jiRyM1ZU+gFeBotuEV6jN+bccpG/gDN3OsfLefzmEG
        9a4LKR3ViglI6GtyAWfjniC+Y50vF8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-Z_OqPFTpOUCssaKC5oMWjA-1; Fri, 09 Sep 2022 19:18:12 -0400
X-MC-Unique: Z_OqPFTpOUCssaKC5oMWjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70E27185A7B2;
        Fri,  9 Sep 2022 23:18:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87754492C3B;
        Fri,  9 Sep 2022 23:18:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, jlayton@redhat.com
cc:     dhowells@redhat.com, smfrench@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] iov_iter: Add extraction functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3750752.1662765490.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 10 Sep 2022 00:18:10 +0100
Message-ID: <3750754.1662765490@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Jeff,

Here's a replacement for the extract_iter_to_iter() patch I had previously=
.
It's a WIP, some bits aren't fully implemented, though some bits I have te=
sted
and got to work, but if you could take a look and see if you're okay with =
the
interface.

I think I've addressed most of Al's comments.  The page-pinning is conditi=
onal
on certain types of iterator, and a number of the iterator types just extr=
act
to the same thing.  It should now handle kvec-class iterators that refer t=
o
vmalloc'd data.

I've also added extraction to scatterlist (which I'll need for doing vario=
us
crypto things) and extraction to ib_sge which could be used in cifs/smb RD=
MA,
bypassing the conversion-to-scatterlist step.

As mentioned, there are bits that aren't fully implemented, let alone test=
ed.

David
---
iov_iter: Add extraction functions

Add extraction functions to extract the page content from an I/O iterator
to one of three destinations:

 (1) extract_iter_to_iter()

     Builds a new iterator from the source iterator such that the new
     iterator remains valid if the source iterator gets deallocated, such
     as can happen in asynchronous I/O when -EIOCBQUEUED is returned.

     For UBUF/IOVEC-class iterators the output iteratior will be BVEC-clas=
s
     and data/buffer pages are pinned to prevent them being moved, swapped
     out or discarded for the duration.

     For XARRAY-class iterators, the new iterator is copied and then
     trimmed; no page pinning is done.  For BVEC- and KVEC-class iterators=
,
     the bio_vec/kvec table is copied and trimmed; again no page pinning.

     KVEC-class iterators with vmalloc'd areas should work.

     DISCARD- and PIPE-class iterators are not currently supported and
     incur an error.

     The extraction function fills out a "cleanup" record that can then be
     passed to iov_iter_clean_up() once the I/O is complete.  This will
     undo any pinning and free any allocated bufferage.

     Tested with DIO read: IOVEC, UBUF.
     Tested just dumping iterator: BVEC, KVEC.
     Untested: XARRAY.

 (2) extract_iter_to_sg()

     Similar to above, but builds a scatterlist and attaches it to an
     sg_table instead of a new iterator.  Returns an indication if the
     pages were pinned.

     The caller is responsible for freeing the scatterlist and unpinning
     any pages.

     Tested to dump sglist: IOVEC, UBUF, KVEC.
     Untested: BVEC, XARRAY.

 (3) extract_iter_to_rdma()

     Similar again, but fills in an ib_sge struct array, mapping the pages
     to DMA addresses appropriate to the specified driver.

     The caller provides the ib_sge array, so it's up to the caller to
     clean that up.  No page-pinning is done as ib_sge does not provide a
     place to note the source page(s), so only BVEC-, KVEC- and
     XARRAY-class iterators are supported for now.  One possible solution
     to that is to pass the iterator through extract_iter_to_iter() first.

     Completely untested and needs more modification to deal with errors
     from ib_dma_map_page().

Note that for the moment, none of these advance the source iterator.

An additional function, iov_iter_flush_dcache(), is provided to do dcache
flushing over the source buffer, using the information provided in the
extracted iterator and the cleanup record.  This works for BVEC-class
iterators, but is incompletely implemented for KVEC-class and probably
wrong for XARRAY-class.

Signed-off-by: David Howells <dhowells@redhat.com>
---

diff --git a/include/linux/uio2.h b/include/linux/uio2.h
new file mode 100644
index 000000000000..bc3e5ea96de7
--- /dev/null
+++ b/include/linux/uio2.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* iov_iter extractors
+ *
+ * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_UIO2_H
+#define _LINUX_UIO2_H
+
+#include <linux/uio.h>
+#include <linux/dma-direction.h>
+
+struct sg_table;
+struct ib_device;
+struct ib_sge;
+
+/*
+ * Cleanup information for an extracted iterator.
+ */
+struct iov_iter_cleanup {
+	union {
+		struct bio_vec	*bv;
+		struct kvec	*kv;
+	};
+	unsigned int	nr_segs;
+	bool		pages_pinned;
+	enum iter_type	type:8;
+};
+
+ssize_t extract_iter_to_iter(struct iov_iter *iter, size_t len,
+			     struct iov_iter *to,
+			     struct iov_iter_cleanup *cleanup);
+ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t len,
+			   struct sg_table *sgtable, bool *pinned);
+ssize_t extract_iter_to_rdma(struct iov_iter *iter, size_t len,
+			     struct ib_device *device, u32 local_dma_lkey,
+			     enum dma_data_direction direction,
+			     struct ib_sge *sge, unsigned int max_sge,
+			     unsigned int *nr_sge);
+void iov_iter_flush_dcache(struct iov_iter *iter,
+			   struct iov_iter_cleanup *cleanup);
+void iov_iter_clean_up(struct iov_iter_cleanup *cleanup);
+
+#endif /* _LINUX_UIO2_H */
diff --git a/lib/Makefile b/lib/Makefile
index 5927d7fa0806..7d46c1a68322 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,7 +44,7 @@ obj-y	+=3D lockref.o
 =

 obj-y +=3D bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
-	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
+	 list_sort.o uuid.o iov_iter.o iov_iter_extract.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o usercopy.o errseq.o bucket_locks.o \
diff --git a/lib/iov_iter_extract.c b/lib/iov_iter_extract.c
new file mode 100644
index 000000000000..eec7287ce779
--- /dev/null
+++ b/lib/iov_iter_extract.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Extract page list from an iterator and attach it to a scatter list, an=
 RDMA
+ * SGE array or another iterator.
+ *
+ * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/bvec.h>
+#include <linux/uio.h>
+#include <linux/uio2.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/scatterlist.h>
+#include <rdma/ib_verbs.h>
+
+enum iter_extract_dest {
+	EXTRACT_TO_BVEC,
+	EXTRACT_TO_SGLIST,
+	EXTRACT_TO_RDMA,
+};
+
+struct extract_to_rdma {
+	struct ib_sge		*sge;
+	unsigned int		*nr_sge;
+	struct ib_device	*device;
+	u32			local_dma_lkey;
+	enum dma_data_direction	direction;
+};
+
+/*
+ * When we're extracting lists of pages, we can avoid having to do a seco=
nd
+ * allocation by putting the list of extracted pages overlapping the end =
of the
+ * array.  As long as the array elements are larger than page pointers, a=
nd as
+ * long as we work 0->last, the two shouldn't interfere.
+ */
+static struct page **locate_pages_array(void *array, unsigned int array_m=
ax,
+					enum iter_extract_dest dest)
+{
+	void *p;
+	size_t arr_size, pg_size;
+
+	switch (dest) {
+	case EXTRACT_TO_BVEC: {
+		struct iov_iter *to =3D array;
+
+		arr_size =3D array_size(array_max, sizeof(struct bio_vec));
+		p =3D (void *)to->bvec;
+		break;
+	}
+	case EXTRACT_TO_SGLIST: {
+		struct sg_table *sgtable =3D array;
+
+		arr_size =3D array_size(array_max, sizeof(struct scatterlist));
+		p =3D sgtable->sgl;
+		break;
+	}
+	case EXTRACT_TO_RDMA: {
+		struct extract_to_rdma *rdma =3D array;
+
+		arr_size =3D array_size(array_max, sizeof(struct ib_sge));
+		p =3D rdma->sge;
+		break;
+	}
+	}
+
+	pg_size =3D array_size(array_max, sizeof(struct page *));
+	return (void *)p + arr_size - pg_size;
+}
+
+/*
+ * Attach a segment of a contiguous span of pages to a single buffer segm=
ent.
+ */
+static int extract_contig_pages(void *array, struct page *lowest_page,
+				unsigned long off, size_t len,
+				enum iter_extract_dest dest)
+{
+	switch (dest) {
+	case EXTRACT_TO_BVEC: {
+		struct iov_iter *to =3D array;
+		struct bio_vec *bv =3D (struct bio_vec *)&to->bvec[to->nr_segs++];
+
+		bv->bv_page =3D lowest_page;
+		bv->bv_len =3D len;
+		bv->bv_offset =3D off;
+		to->count +=3D len;
+		return to->nr_segs;
+	}
+	case EXTRACT_TO_SGLIST: {
+		struct sg_table *sgtable =3D array;
+		struct scatterlist *sg =3D &sgtable->sgl[sgtable->nents++];
+
+		sg_set_page(sg, lowest_page, len, off);
+		return sgtable->nents;
+	}
+	case EXTRACT_TO_RDMA: {
+		struct extract_to_rdma *rdma =3D array;
+		struct ib_sge *sge =3D &rdma->sge[*rdma->nr_sge];
+
+		sge->addr =3D ib_dma_map_page(rdma->device, lowest_page,
+					    off, len, rdma->direction);
+		if (ib_dma_mapping_error(rdma->device, sge->addr)) {
+			sge->addr =3D 0;
+			return -EIO;
+		}
+		sge->length =3D len;
+		sge->lkey   =3D rdma->local_dma_lkey;
+		*rdma->nr_sge +=3D 1;
+		return *rdma->nr_sge;
+	}
+	}
+
+	BUG();
+}
+
+static unsigned int extract_page_list(void *array,
+				      struct page **pages, unsigned int nr_pages,
+				      unsigned long off, size_t len,
+				      enum iter_extract_dest dest)
+{
+	struct page *page;
+	unsigned int ret =3D 0;
+	size_t seg;
+	int i;
+
+	for (i =3D 0; i < nr_pages; i++) {
+		seg =3D min_t(size_t, PAGE_SIZE - off, len);
+		page =3D *pages;
+		*pages++ =3D NULL;
+		ret =3D extract_contig_pages(array, page, off, seg, dest);
+		len -=3D seg;
+		off =3D 0;
+	}
+
+	return ret;
+}
+
+static void terminate_array(void *array, enum iter_extract_dest dest)
+{
+	if (dest =3D=3D EXTRACT_TO_SGLIST) {
+		struct sg_table *sgtable =3D array;
+		struct scatterlist *sg =3D sgtable->sgl + sgtable->nents - 1;
+
+		sgtable->orig_nents =3D sgtable->nents;
+		if (sgtable->nents)
+			sg_mark_end(sg);
+	}
+}
+
+/*
+ * Extract and pin the pages from UBUF- or IOVEC-class iterators and add =
them
+ * to the destination buffer.
+ */
+static ssize_t iov_iter_extract_user(struct iov_iter *iter,
+				     void *array, unsigned int array_max,
+				     ssize_t maxsize,
+				     enum iter_extract_dest dest)
+{
+	const struct iovec *iov;
+	struct iovec ubuf;
+	struct page **pages;
+	unsigned long uaddr, start =3D iter->iov_offset;
+	unsigned int i =3D 0, ix =3D 0, gup_flags =3D 0, nr_segs, n;
+	ssize_t ret =3D 0;
+	size_t len, off;
+	int res;
+
+	pages =3D locate_pages_array(array, array_max, dest);
+
+	if (iov_iter_rw(iter) !=3D WRITE)
+		gup_flags |=3D FOLL_WRITE;
+	if (iter->nofault)
+		gup_flags |=3D FOLL_NOFAULT;
+
+	if (iter_is_ubuf(iter)) {
+		ubuf.iov_base =3D iter->ubuf;
+		ubuf.iov_len =3D iov_iter_count(iter);
+		iov =3D &ubuf;
+		nr_segs =3D 1;
+	} else {
+		iov =3D iter->iov;
+		nr_segs =3D iter->nr_segs;
+	}
+
+	do {
+		len =3D iov[i].iov_len;
+		if (start >=3D len) {
+			start -=3D len;
+			i++;
+			if (i >=3D nr_segs)
+				break;
+			continue;
+		}
+
+		uaddr =3D (unsigned long)iov[i].iov_base + start;
+		len =3D min_t(size_t, maxsize, len - start);
+		off =3D uaddr & ~PAGE_MASK;
+		uaddr &=3D PAGE_MASK;
+
+		n =3D DIV_ROUND_UP(len + off, PAGE_SIZE);
+		n =3D min(n, array_max - ix);
+
+		res =3D get_user_pages_fast(uaddr, n, gup_flags, pages + ix);
+		if (unlikely(res <=3D 0)) {
+			if (res < 0)
+				return res;
+			break;
+		}
+
+		len =3D min_t(size_t, len, res * PAGE_SIZE - off);
+		maxsize -=3D len;
+		start +=3D len;
+		ret +=3D len;
+		ix =3D extract_page_list(array, pages + ix, res, off, len, dest);
+	} while (maxsize > 0 && ix < array_max);
+
+	terminate_array(array, dest);
+	return ret;
+}
+
+/*
+ * Extract the pages from a BVEC-class iterator and add them to the desti=
nation
+ * buffer.  The pages are not pinned.
+ */
+static ssize_t iov_iter_extract_bvec(struct iov_iter *iter,
+				     void *array, unsigned int array_max,
+				     ssize_t maxsize,
+				     enum iter_extract_dest dest)
+{
+	const struct bio_vec *bv =3D iter->bvec;
+	unsigned long start =3D iter->iov_offset;
+	unsigned int i, ix;
+	ssize_t ret =3D 0;
+
+	for (i =3D 0; i < iter->nr_segs; i++) {
+		size_t off, len;
+
+		len =3D bv[i].bv_len;
+		if (start >=3D len) {
+			start -=3D len;
+			continue;
+		}
+
+		len =3D min_t(size_t, maxsize, len - start);
+		off =3D bv[i].bv_offset + start;
+
+		maxsize -=3D len;
+		ret +=3D len;
+		ix =3D extract_contig_pages(array, bv[i].bv_page, off, len,
+					  dest);
+		if (maxsize <=3D 0 || ix >=3D array_max)
+			break;
+		start =3D 0;
+	}
+
+	terminate_array(array, dest);
+	return ret;
+}
+
+/*
+ * Extract the pages from a KVEC-class iterator and add them to the desti=
nation
+ * buffer.  This can deal with vmalloc'd buffers as well as kmalloc'd or =
static
+ * buffers.  The pages are not pinned.
+ */
+static ssize_t iov_iter_extract_kvec(struct iov_iter *iter,
+				     void *array, unsigned int array_max,
+				     ssize_t maxsize,
+				     enum iter_extract_dest dest)
+{
+	const struct kvec *kv =3D iter->kvec;
+	unsigned long start =3D iter->iov_offset;
+	unsigned int i, ix;
+	ssize_t ret =3D 0;
+
+	for (i =3D 0; i < iter->nr_segs; i++) {
+		struct page *page;
+		unsigned long kaddr;
+		size_t off, len, seg;
+
+		len =3D kv[i].iov_len;
+		if (start >=3D len) {
+			start -=3D len;
+			continue;
+		}
+
+		kaddr =3D (unsigned long)kv[i].iov_base + start;
+		off =3D kaddr & ~PAGE_MASK;
+		len =3D min_t(size_t, maxsize, len - start);
+		kaddr &=3D PAGE_MASK;
+
+		maxsize -=3D len;
+		ret +=3D len;
+		do {
+			seg =3D min_t(size_t, len, PAGE_SIZE - off);
+			if (is_vmalloc_or_module_addr((void *)kaddr))
+				page =3D vmalloc_to_page((void *)kaddr);
+			else
+				page =3D virt_to_page(kaddr);
+			ix =3D extract_contig_pages(array, page, off, seg, dest);
+			len -=3D seg;
+			kaddr +=3D PAGE_SIZE;
+			off =3D 0;
+		} while (len > 0 && ix <=3D array_max);
+		if (maxsize <=3D 0 || ix >=3D array_max)
+			break;
+		start =3D 0;
+	}
+
+	terminate_array(array, dest);
+	return ret;
+}
+
+/*
+ * Extract the pages from an XARRAY-class iterator and add them to the
+ * destination buffer.  The pages are not pinned.
+ */
+static ssize_t iov_iter_extract_xarray(struct iov_iter *iter,
+				       void *array, unsigned int array_max,
+				       ssize_t maxsize,
+				       enum iter_extract_dest dest)
+{
+	struct xarray *xa =3D iter->xarray;
+	struct folio *folio;
+	unsigned int ix;
+	loff_t start =3D iter->xarray_start + iter->iov_offset;
+	pgoff_t index =3D start / PAGE_SIZE;
+	ssize_t ret;
+	size_t offset, len;
+	XA_STATE(xas, xa, index);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		offset =3D offset_in_folio(folio, start);
+		len =3D min_t(size_t, maxsize, folio_size(folio) - offset);
+
+		ix =3D extract_contig_pages(array, folio_page(folio, 0),
+					  offset, len, dest);
+		maxsize -=3D len;
+		ret +=3D len;
+		if (ix >=3D array_max) {
+			WARN_ON_ONCE(ix > array_max);
+			break;
+		}
+
+		if (maxsize <=3D 0)
+			break;
+	}
+
+	rcu_read_unlock();
+	terminate_array(array, dest);
+	return ret;
+}
+
+static ssize_t iov_iter_extract_pages(struct iov_iter *iter,
+				      void *array, unsigned int array_max,
+				      size_t maxsize,
+				      enum iter_extract_dest dest)
+{
+	if (likely(user_backed_iter(iter)))
+		return iov_iter_extract_user(iter, array, array_max, maxsize,
+					     dest);
+	if (iov_iter_is_bvec(iter))
+		return iov_iter_extract_bvec(iter, array, array_max, maxsize,
+					     dest);
+	if (iov_iter_is_kvec(iter))
+		return iov_iter_extract_kvec(iter, array, array_max, maxsize,
+					     dest);
+	if (iov_iter_is_xarray(iter))
+		return iov_iter_extract_xarray(iter, array, array_max, maxsize,
+					       dest);
+	if (iov_iter_is_pipe(iter)) {
+		pr_warn("extract pipe unsupported\n");
+		return -EIO;
+	}
+
+	pr_warn("extract other-type unsupported\n");
+	return -EFAULT;
+}
+
+/**
+ * extract_iter_to_iter - Extract the pages from an iterator into another=
 iterator
+ * @iter: The iterator to extract from
+ * @len: The amount of iterator to copy
+ * @to: The iterator to fill in
+ * @cleanup: Information on how to clean up the resulting iterator
+ *
+ * Extract the page fragments from the given amount of the source iterato=
r and
+ * build up an iterator that refers to all of those bits.  This allows th=
e
+ * source iterator to disposed of.
+ *
+ * UBUF- and IOVEC-class iterators are extracted to BVEC-class iterators =
and
+ * the extracted pages are pinned; BVEC-, KVEC- and XARRAY-class are extr=
acted
+ * as the same type and truncated with no pinning; PIPE- and DISCARD-clas=
s are
+ * not supported.
+ */
+ssize_t extract_iter_to_iter(struct iov_iter *iter, size_t len,
+			     struct iov_iter *to,
+			     struct iov_iter_cleanup *cleanup)
+{
+	struct bio_vec *bv;
+	unsigned int bv_max;
+	ssize_t ret;
+	size_t bv_size;
+
+	memset(cleanup, 0, sizeof(*cleanup));
+
+	cleanup->type =3D iov_iter_type(iter);
+	switch (iov_iter_type(iter)) {
+	case ITER_KVEC:
+		cleanup->kv =3D (void *)dup_iter(to, iter, GFP_KERNEL);
+		if (!cleanup->kv)
+			return -ENOMEM;
+		cleanup->nr_segs =3D to->nr_segs;
+		iov_iter_truncate(to, len);
+		return iov_iter_count(to);
+	case ITER_XARRAY:
+		*to =3D *iter;
+		iov_iter_truncate(to, len);
+		return iov_iter_count(to);
+
+	case ITER_UBUF:
+	case ITER_IOVEC:
+		cleanup->pages_pinned =3D true;
+		fallthrough;
+	case ITER_BVEC:
+		bv_max =3D iov_iter_npages(iter, INT_MAX);
+		bv_size =3D array_size(bv_max, sizeof(*bv));
+		bv =3D kvmalloc(bv_size, GFP_KERNEL);
+		if (!bv)
+			return -ENOMEM;
+
+		iov_iter_bvec(to, iov_iter_rw(iter), bv, 0, 0);
+		ret =3D iov_iter_extract_pages(iter, to, bv_max, len,
+					     EXTRACT_TO_BVEC);
+		if (ret < 0) {
+			iov_iter_clean_up(cleanup);
+			return ret;
+		}
+
+		cleanup->type =3D ITER_BVEC;
+		cleanup->bv =3D bv;
+		cleanup->nr_segs =3D to->nr_segs;
+		return ret;
+
+	case ITER_DISCARD:
+	case ITER_PIPE:
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL(extract_iter_to_iter);
+
+/**
+ * extract_iter_to_sg - Extract the pages from an iterator into an sglist
+ * @iter: The iterator to extract from
+ * @len: The amount of iterator to copy
+ * @sgtable: The scatterlist table to fill in
+ * @pages_pinned: On return set to true if pages were pinned
+ *
+ * Extract the page fragments from the given amount of the source iterato=
r and
+ * build up scatterlist that refers to all of those bits.
+ *
+ * The pages referred to by UBUF- and IOVEC-class iterators are extracted=
 and
+ * pinned; BVEC-, KVEC- and XARRAY-class are extracted and aren't pinned;=
 PIPE-
+ * and DISCARD-class are not supported
+ */
+ssize_t extract_iter_to_sg(struct iov_iter *iter, size_t len,
+			   struct sg_table *sgtable, bool *pages_pinned)
+{
+	struct scatterlist *sg =3D NULL;
+	unsigned int sg_max;
+	ssize_t ret;
+	size_t sg_size;
+
+	switch (iov_iter_type(iter)) {
+	case ITER_DISCARD:
+	case ITER_PIPE:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	case ITER_UBUF:
+	case ITER_IOVEC:
+		*pages_pinned =3D true;
+		break;
+	case ITER_BVEC:
+	case ITER_KVEC:
+	case ITER_XARRAY:
+		*pages_pinned =3D false;
+		break;
+	}
+
+	sg_max =3D iov_iter_npages(iter, INT_MAX);
+	sg_size =3D array_size(sg_max, sizeof(*sg));
+	sg =3D kvmalloc(sg_size, GFP_KERNEL);
+	if (!sg)
+		return -ENOMEM;
+	memset(sg, 0, sg_size);
+
+	sgtable->sgl =3D sg;
+	sgtable->nents =3D 0;
+	sgtable->orig_nents =3D 0;
+	ret =3D iov_iter_extract_pages(iter, sgtable, sg_max, len,
+				     EXTRACT_TO_SGLIST);
+	if (ret < 0)
+		kvfree(sg);
+	return ret;
+}
+EXPORT_SYMBOL(extract_iter_to_sg);
+
+/**
+ * extract_iter_to_rdma - Extract the pages from an iterator into an rdma=
 SGE list
+ * @iter: The iterator to extract from
+ * @len: The amount of iterator to copy
+ * @device: The RDMA device
+ * @local_dma_lkey: DMA keying
+ * @direction: The DMA direction
+ * @sge: The SGE array to fill
+ * @max_sge: The maximum size of SGE[].
+ * @nr_sge: On return set to the number of SGEs used
+ *
+ * Extract the page fragments from the given amount of the source iterato=
r and
+ * build up an RDMA SGE list that refers to all of those bits.
+ *
+ * Only BVEC-, KVEC- and XARRAY-class iterators are supported and the ext=
racted
+ * pages aren't pinned; UBUF-, IOVEC-, PIPE- and DISCARD-class are not
+ * supported.
+ */
+ssize_t extract_iter_to_rdma(struct iov_iter *iter, size_t len,
+			     struct ib_device *device, u32 local_dma_lkey,
+			     enum dma_data_direction direction,
+			     struct ib_sge *sge, unsigned int max_sge,
+			     unsigned int *nr_sge)
+{
+	struct extract_to_rdma rdma =3D {
+		.device		=3D device,
+		.local_dma_lkey	=3D local_dma_lkey,
+		.direction	=3D direction,
+		.sge		=3D sge,
+		.nr_sge		=3D nr_sge,
+	};
+
+	switch (iov_iter_type(iter)) {
+	case ITER_DISCARD:
+	case ITER_PIPE:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	case ITER_UBUF:
+	case ITER_IOVEC:
+		WARN_ON_ONCE(1); /* Can't pin pages; extract to a bvec first. */
+		break;
+	case ITER_BVEC:
+	case ITER_KVEC:
+	case ITER_XARRAY:
+		break;
+	}
+
+	BUG(); // TODO: Implement handling of errors from ib_dma_map_page().
+	return iov_iter_extract_pages(iter, &rdma, max_sge, len,
+				      EXTRACT_TO_RDMA);
+}
+EXPORT_SYMBOL(extract_iter_to_rdma);
+
+/**
+ * iov_iter_flush_dcache - Flush the dcache extracted into an iterator
+ * @iter: The destination iterator
+ * @cleanup: The cleanup record produced by extract_iter_to_iter()
+ *
+ * Use the information stored in an extraction cleanup record to flush th=
e
+ * cache.
+ */
+void iov_iter_flush_dcache(struct iov_iter *iter,
+			   struct iov_iter_cleanup *cleanup)
+{
+	int i;
+
+	switch (cleanup->type) {
+	case ITER_BVEC:
+		for (i =3D 0; i < cleanup->nr_segs; i++)
+			flush_dcache_page(cleanup->bv[i].bv_page);
+		break;
+	case ITER_KVEC:
+		BUG(); // TODO: Make this work.  Using bv is wrong.
+		//for (i =3D 0; i < cleanup->nr_segs; i++)
+		//	flush_dcache_page(cleanup->bv[i].bv_page);
+		break;
+	case ITER_XARRAY: {
+		struct page *page;
+		loff_t pos =3D iter->xarray_start + iter->iov_offset;
+		pgoff_t index =3D pos >> PAGE_SHIFT;
+		unsigned int offset =3D pos & ~PAGE_MASK;
+		int nr_pages =3D DIV_ROUND_UP(offset + iov_iter_count(iter), PAGE_SIZE)=
;
+
+		XA_STATE(xas, iter->xarray, index);
+
+		rcu_read_lock();
+		for (page =3D xas_load(&xas); page; page =3D xas_next(&xas)) {
+			if (xas_retry(&xas, page))
+				continue;
+			if (unlikely(page !=3D xas_reload(&xas))) {
+				xas_reset(&xas);
+				continue;
+			}
+
+			flush_dcache_page(find_subpage(page, xas.xa_index));
+			if (nr_pages <=3D 0)
+				break;
+		}
+		rcu_read_unlock();
+		break;
+	}
+	default:
+		BUG();
+	}
+}
+EXPORT_SYMBOL(iov_iter_flush_dcache);
+
+/**
+ * iov_iter_clean_up - Clean up segment list and unpin pages
+ * @cleanup: The cleanup information from extract_iter_to_iter()
+ */
+void iov_iter_clean_up(struct iov_iter_cleanup *cleanup)
+{
+	unsigned int i;
+
+	if (!cleanup->bv)
+		return;
+	switch (cleanup->type) {
+	case ITER_BVEC:
+		if (cleanup->pages_pinned) {
+			for (i =3D 0; i < cleanup->nr_segs; i++)
+				if (cleanup->bv[i].bv_page)
+					put_page(cleanup->bv[i].bv_page);
+		}
+		kvfree(cleanup->bv);
+		cleanup->bv =3D NULL;
+		break;
+	case ITER_KVEC:
+		kvfree(cleanup->kv);
+		cleanup->kv =3D NULL;
+		break;
+	default:
+		break;
+	}
+}


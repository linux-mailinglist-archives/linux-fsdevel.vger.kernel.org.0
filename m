Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B8611677
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJ1P5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJ1P5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43EB1FAE47
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEoP2AXBzQMN+gVCl/w8iN0okzoEHYRI5TFJoH1KK78=;
        b=RjIG5cont72lQAhehqRNFy+vqXKi+wAGXdSH2a4nvWyMTK5aw3XAC3ThHoNZAuYXAEom4o
        kISnSonX+vXvYkJOPV4sBuv2dgQpk3Y7Io+3VXd5Ec42onymRCWNH9goEnzo3E6r1QyWaw
        wTlljDrIyqs+ttE2oGHodUwyzRLxKFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-P_SdW9Z_NFaHNZlTnK2TMw-1; Fri, 28 Oct 2022 11:56:02 -0400
X-MC-Unique: P_SdW9Z_NFaHNZlTnK2TMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC6398027EC;
        Fri, 28 Oct 2022 15:56:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70F9514152E1;
        Fri, 28 Oct 2022 15:56:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 2/9] netfs: Add a function to extract an iterator into a
 scatterlist
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Oct 2022 16:55:59 +0100
Message-ID: <166697255985.61150.16489950598033809487.stgit@warthog.procyon.org.uk>
In-Reply-To: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
References: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function for filling in a scatterlist from the list of pages
contained in an iterator.

If the iterator is UBUF- or IOBUF-type, the pages have a ref taken on them.

If the iterator is BVEC-, KVEC- or XARRAY-type, no ref is taken on the
pages and it is left to the caller to manage their lifetime.  It cannot be
assumed that a ref can be validly taken, particularly in the case of a KVEC
iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/iterator.c   |  251 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |    3 +
 2 files changed, 254 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 6875c6c94466..fa9f42404870 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
+#include <linux/scatterlist.h>
 #include <linux/netfs.h>
 #include "internal.h"
 
@@ -94,3 +95,253 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 	return npages;
 }
 EXPORT_SYMBOL(netfs_extract_user_iter);
+
+/*
+ * Extract and pin up to sg_max pages from UBUF- or IOVEC-class iterators and
+ * add them to the scatterlist.
+ */
+static ssize_t netfs_extract_user_to_sg(struct iov_iter *iter,
+					ssize_t maxsize,
+					struct sg_table *sgtable,
+					unsigned int sg_max)
+{
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	struct page **pages;
+	unsigned int npages;
+	ssize_t ret = 0, res;
+	size_t len, off;
+
+	/* We decant the page list into the tail of the scatterlist */
+	pages = (void *)sgtable->sgl + array_size(sg_max, sizeof(struct scatterlist));
+	pages -= sg_max;
+
+	do {
+		res = iov_iter_get_pages2(iter, pages, maxsize, sg_max, &off);
+		if (res < 0)
+			goto failed;
+
+		len = res;
+		maxsize -= len;
+		ret += len;
+		npages = DIV_ROUND_UP(off + len, PAGE_SIZE);
+		sg_max -= npages;
+
+		for (; npages < 0; npages--) {
+			struct page *page = *pages;
+			size_t seg = min_t(size_t, PAGE_SIZE - off, len);
+
+			*pages++ = NULL;
+			sg_set_page(sg, page, len, off);
+			sgtable->nents++;
+			sg++;
+			len -= seg;
+			off = 0;
+		}
+	} while (maxsize > 0 && sg_max > 0);
+
+	return ret;
+
+failed:
+	while (sgtable->nents > sgtable->orig_nents)
+		put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
+	return res;
+}
+
+/*
+ * Extract up to sg_max pages from a BVEC-type iterator and add them to the
+ * scatterlist.  The pages are not pinned.
+ */
+static ssize_t netfs_extract_bvec_to_sg(struct iov_iter *iter,
+					ssize_t maxsize,
+					struct sg_table *sgtable,
+					unsigned int sg_max)
+{
+	const struct bio_vec *bv = iter->bvec;
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	unsigned long start = iter->iov_offset;
+	unsigned int i;
+	ssize_t ret = 0;
+
+	for (i = 0; i < iter->nr_segs; i++) {
+		size_t off, len;
+
+		len = bv[i].bv_len;
+		if (start >= len) {
+			start -= len;
+			continue;
+		}
+
+		len = min_t(size_t, maxsize, len - start);
+		off = bv[i].bv_offset + start;
+
+		sg_set_page(sg, bv[i].bv_page, len, off);
+		sgtable->nents++;
+		sg++;
+		sg_max--;
+
+		ret += len;
+		maxsize -= len;
+		if (maxsize <= 0 || sg_max == 0)
+			break;
+		start = 0;
+	}
+
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
+/*
+ * Extract up to sg_max pages from a KVEC-type iterator and add them to the
+ * scatterlist.  This can deal with vmalloc'd buffers as well as kmalloc'd or
+ * static buffers.  The pages are not pinned.
+ */
+static ssize_t netfs_extract_kvec_to_sg(struct iov_iter *iter,
+					ssize_t maxsize,
+					struct sg_table *sgtable,
+					unsigned int sg_max)
+{
+	const struct kvec *kv = iter->kvec;
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	unsigned long start = iter->iov_offset;
+	unsigned int i;
+	ssize_t ret = 0;
+
+	for (i = 0; i < iter->nr_segs; i++) {
+		struct page *page;
+		unsigned long kaddr;
+		size_t off, len, seg;
+
+		len = kv[i].iov_len;
+		if (start >= len) {
+			start -= len;
+			continue;
+		}
+
+		kaddr = (unsigned long)kv[i].iov_base + start;
+		off = kaddr & ~PAGE_MASK;
+		len = min_t(size_t, maxsize, len - start);
+		kaddr &= PAGE_MASK;
+
+		maxsize -= len;
+		ret += len;
+		do {
+			seg = min_t(size_t, len, PAGE_SIZE - off);
+			if (is_vmalloc_or_module_addr((void *)kaddr))
+				page = vmalloc_to_page((void *)kaddr);
+			else
+				page = virt_to_page(kaddr);
+
+			sg_set_page(sg, page, len, off);
+			sgtable->nents++;
+			sg++;
+			sg_max--;
+
+			len -= seg;
+			kaddr += PAGE_SIZE;
+			off = 0;
+		} while (len > 0 && sg_max > 0);
+
+		if (maxsize <= 0 || sg_max == 0)
+			break;
+		start = 0;
+	}
+
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
+/*
+ * Extract up to sg_max folios from an XARRAY-type iterator and add them to
+ * the scatterlist.  The pages are not pinned.
+ */
+static ssize_t netfs_extract_xarray_to_sg(struct iov_iter *iter,
+					  ssize_t maxsize,
+					  struct sg_table *sgtable,
+					  unsigned int sg_max)
+{
+	struct scatterlist *sg = sgtable->sgl + sgtable->nents;
+	struct xarray *xa = iter->xarray;
+	struct folio *folio;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	ssize_t ret = 0;
+	size_t offset, len;
+	XA_STATE(xas, xa, index);
+
+	rcu_read_lock();
+
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		offset = offset_in_folio(folio, start);
+		len = min_t(size_t, maxsize, folio_size(folio) - offset);
+
+		sg_set_page(sg, folio_page(folio, 0), len, offset);
+		sgtable->nents++;
+		sg++;
+		sg_max--;
+
+		maxsize -= len;
+		ret += len;
+		if (maxsize <= 0 || sg_max == 0)
+			break;
+	}
+
+	rcu_read_unlock();
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
+/**
+ * netfs_extract_iter_to_sg - Extract pages from an iterator and add ot an sglist
+ * @iter: The iterator to extract from
+ * @maxsize: The amount of iterator to copy
+ * @sgtable: The scatterlist table to fill in
+ * @sg_max: Maximum number of elements in @sgtable that may be filled
+ *
+ * Extract the page fragments from the given amount of the source iterator and
+ * add them to a scatterlist that refers to all of those bits, to a maximum
+ * addition of @sg_max elements.
+ *
+ * The pages referred to by UBUF- and IOVEC-type iterators are extracted and
+ * pinned; BVEC-, KVEC- and XARRAY-type are extracted but aren't pinned; PIPE-
+ * and DISCARD-type are not supported.
+ *
+ * No end mark is placed on the scatterlist; that's left to the caller.
+ *
+ * If successul, @sgtable->nents is updated to include the number of elements
+ * added and the number of bytes added is returned.  @sgtable->orig_nents is
+ * left unaltered.
+ */
+ssize_t netfs_extract_iter_to_sg(struct iov_iter *iter, size_t maxsize,
+				 struct sg_table *sgtable, unsigned int sg_max)
+{
+	if (maxsize == 0)
+		return 0;
+
+	switch (iov_iter_type(iter)) {
+	case ITER_UBUF:
+	case ITER_IOVEC:
+		return netfs_extract_user_to_sg(iter, maxsize, sgtable, sg_max);
+	case ITER_BVEC:
+		return netfs_extract_bvec_to_sg(iter, maxsize, sgtable, sg_max);
+	case ITER_KVEC:
+		return netfs_extract_kvec_to_sg(iter, maxsize, sgtable, sg_max);
+	case ITER_XARRAY:
+		return netfs_extract_xarray_to_sg(iter, maxsize, sgtable, sg_max);
+	default:
+		pr_err("netfs_extract_iter_to_sg(%u) unsupported\n",
+		       iov_iter_type(iter));
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL(netfs_extract_iter_to_sg);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5f6ad0246946..21771dd594a1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -290,6 +290,9 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 void netfs_stats_show(struct seq_file *);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new);
+struct sg_table;
+ssize_t netfs_extract_iter_to_sg(struct iov_iter *iter, size_t len,
+				 struct sg_table *sgtable, unsigned int sg_max);
 
 /**
  * netfs_inode - Get the netfs inode context from the inode



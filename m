Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC161167D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJ1P5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJ1P5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002C1F043A
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoVW8a8wNo+uPOOsfZeJ7xICN5gX5Q8U3X9+4rP9EmE=;
        b=IDp4PVrr37lm1cN0Rgh9kikHcJCpYhD+HU0hd4beKwwXaMKXSMWOOHV5vyaDInEJsrIGYB
        m5xQiZ7aXebaT6vHOHHAUGAE0QI1S5nGu7UG2rWNeCter8zDwPJ1NCN2azOFjuZqxA4+P8
        C1eqNfGr3XGciO7n3ltLOUKaRtrgtlk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-7HIRKa1DO3yB9igaDjgKbw-1; Fri, 28 Oct 2022 11:56:09 -0400
X-MC-Unique: 7HIRKa1DO3yB9igaDjgKbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 150ED86EB21;
        Fri, 28 Oct 2022 15:56:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FB3E1415102;
        Fri, 28 Oct 2022 15:56:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 3/9] cifs: Add a function to build an RDMA SGE list from
 an iterator
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
Date:   Fri, 28 Oct 2022 16:56:07 +0100
Message-ID: <166697256704.61150.17388516338310645808.stgit@warthog.procyon.org.uk>
In-Reply-To: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
References: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function to add elements onto an RDMA SGE list representing page
fragments extracted from a BVEC-, KVEC- or XARRAY-type iterator and DMA
mapped until the maximum number of elements is reached.

Nothing is done to make sure the pages remain present - that must be done
by the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cifs/smbdirect.c |  224 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 90789aaa6567..18fb440a02c3 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -44,6 +44,17 @@ static int smbd_post_send_page(struct smbd_connection *info,
 static void destroy_mr_list(struct smbd_connection *info);
 static int allocate_mr_list(struct smbd_connection *info);
 
+struct smb_extract_to_rdma {
+	struct ib_sge		*sge;
+	unsigned int		nr_sge;
+	unsigned int		max_sge;
+	struct ib_device	*device;
+	u32			local_dma_lkey;
+	enum dma_data_direction	direction;
+};
+static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
+					struct smb_extract_to_rdma *rdma);
+
 /* SMBD version number */
 #define SMBD_V1	0x0100
 
@@ -2489,3 +2500,216 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 
 	return rc;
 }
+
+static bool smb_set_sge(struct smb_extract_to_rdma *rdma,
+			struct page *lowest_page, size_t off, size_t len)
+{
+	struct ib_sge *sge = &rdma->sge[rdma->nr_sge];
+	u64 addr;
+
+	addr = ib_dma_map_page(rdma->device, lowest_page,
+			       off, len, rdma->direction);
+	if (ib_dma_mapping_error(rdma->device, addr))
+		return false;
+
+	sge->addr   = addr;
+	sge->length = len;
+	sge->lkey   = rdma->local_dma_lkey;
+	rdma->nr_sge++;
+	return true;
+}
+
+/*
+ * Extract page fragments from a BVEC-class iterator and add them to an RDMA
+ * element list.  The pages are not pinned.
+ */
+static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
+					struct smb_extract_to_rdma *rdma,
+					ssize_t maxsize)
+{
+	const struct bio_vec *bv = iter->bvec;
+	unsigned long start = iter->iov_offset;
+	unsigned int i, sge_max = rdma->max_sge;
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
+		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
+			return -EIO;
+		sge_max--;
+
+		ret += len;
+		maxsize -= len;
+		if (maxsize <= 0 || sge_max == 0)
+			break;
+		start = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * Extract fragments from a KVEC-class iterator and add them to an RDMA list.
+ * This can deal with vmalloc'd buffers as well as kmalloc'd or static buffers.
+ * The pages are not pinned.
+ */
+static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
+					struct smb_extract_to_rdma *rdma,
+					ssize_t maxsize)
+{
+	const struct kvec *kv = iter->kvec;
+	unsigned long start = iter->iov_offset;
+	unsigned int i, sge_max = rdma->max_sge;
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
+
+			if (is_vmalloc_or_module_addr((void *)kaddr))
+				page = vmalloc_to_page((void *)kaddr);
+			else
+				page = virt_to_page(kaddr);
+
+			if (!smb_set_sge(rdma, page, off, len))
+				return -EIO;
+			sge_max--;
+
+			len -= seg;
+			kaddr += PAGE_SIZE;
+			off = 0;
+		} while (len > 0 && sge_max > 0);
+
+		if (maxsize <= 0 || sge_max == 0)
+			break;
+		start = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * Extract folio fragments from an XARRAY-class iterator and add them to an
+ * RDMA list.  The folios are not pinned.
+ */
+static ssize_t smb_extract_xarray_to_rdma(struct iov_iter *iter,
+					  struct smb_extract_to_rdma *rdma,
+					  ssize_t maxsize)
+{
+	struct xarray *xa = iter->xarray;
+	struct folio *folio;
+	unsigned int sge_max = rdma->max_sge;
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	ssize_t ret;
+	size_t off, len;
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
+		off = offset_in_folio(folio, start);
+		len = min_t(size_t, maxsize, folio_size(folio) - off);
+
+		if (!smb_set_sge(rdma, folio_page(folio, 0), off, len)) {
+			rcu_read_lock();
+			return -EIO;
+		}
+		sge_max--;
+
+		maxsize -= len;
+		ret += len;
+		if (maxsize <= 0 || sge_max == 0)
+			break;
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
+ * Extract page fragments from up to the given amount of the source iterator
+ * and build up an RDMA list that refers to all of those bits.  The RDMA list
+ * is appended to, up to the maximum number of elements set in the parameter
+ * block.
+ *
+ * The extracted page fragments are not pinned or ref'd in any way; if an
+ * IOVEC/UBUF-type iterator is to be used, it should be converted to a
+ * BVEC-type iterator and the pages pinned, ref'd or otherwise held in some
+ * way.
+ */
+static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
+					struct smb_extract_to_rdma *rdma)
+{
+	ssize_t ret;
+	int before = rdma->nr_sge;
+
+	if (iov_iter_is_discard(iter) ||
+	    iov_iter_is_pipe(iter) ||
+	    user_backed_iter(iter)) {
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+
+	switch (iov_iter_type(iter)) {
+	case ITER_BVEC:
+		ret = smb_extract_bvec_to_rdma(iter, rdma, len);
+		break;
+	case ITER_KVEC:
+		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
+		break;
+	case ITER_XARRAY:
+		ret = smb_extract_xarray_to_rdma(iter, rdma, len);
+		break;
+	default:
+		BUG();
+	}
+
+	if (ret > 0) {
+		iov_iter_advance(iter, ret);
+	} else if (ret < 0) {
+		while (rdma->nr_sge > before) {
+			struct ib_sge *sge = &rdma->sge[rdma->nr_sge--];
+
+			ib_dma_unmap_single(rdma->device, sge->addr, sge->length,
+					    rdma->direction);
+			sge->addr = 0;
+		}
+	}
+
+	return ret;
+}



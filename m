Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA268A3F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjBCVBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjBCVBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F022A08
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675457987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWb7O41f1WriEcZrcMKHfGt97wrF3RMDR3uAu+lgAnU=;
        b=R/lgVPpKcl24DP+NzX9lq/INSaJtn4Q0PFY950BH+2HZ33WSpMdE8h73/r0lhaW5pE3nb/
        9Ia05LYg8LcMTiWtiSWqXK/99Z4gFr+TtNk4SBImTzzq9qfzP6IDH50rdf0ArLnW+SVTd9
        P0teu7c+Vg/WBvS5fOAKKYSrkc37DxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-KYbMgd1CNYimq5JGbPE1aQ-1; Fri, 03 Feb 2023 15:59:44 -0500
X-MC-Unique: KYbMgd1CNYimq5JGbPE1aQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF79685A588;
        Fri,  3 Feb 2023 20:59:43 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11EDD492B15;
        Fri,  3 Feb 2023 20:59:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 04/11] cifs: Add a function to build an RDMA SGE list from an iterator
Date:   Fri,  3 Feb 2023 20:59:22 +0000
Message-Id: <20230203205929.2126634-5-dhowells@redhat.com>
In-Reply-To: <20230203205929.2126634-1-dhowells@redhat.com>
References: <20230203205929.2126634-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-rdma@vger.kernel.org

Link: https://lore.kernel.org/r/166697256704.61150.17388516338310645808.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732028840.3186319.8512284239779728860.stgit@warthog.procyon.org.uk/ # rfc
---
 fs/cifs/smbdirect.c | 220 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 8c816b25ce7c..44eff1cf4ed0 100644
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
 
@@ -2490,3 +2501,212 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 
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
+		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
+			return -EIO;
+
+		ret += len;
+		maxsize -= len;
+		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
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
+		do {
+			seg = min_t(size_t, len, PAGE_SIZE - off);
+
+			if (is_vmalloc_or_module_addr((void *)kaddr))
+				page = vmalloc_to_page((void *)kaddr);
+			else
+				page = virt_to_page(kaddr);
+
+			if (!smb_set_sge(rdma, page, off, seg))
+				return -EIO;
+
+			ret += seg;
+			len -= seg;
+			kaddr += PAGE_SIZE;
+			off = 0;
+		} while (len > 0 && rdma->nr_sge < rdma->max_sge);
+
+		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
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
+	loff_t start = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = start / PAGE_SIZE;
+	ssize_t ret = 0;
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
+
+		maxsize -= len;
+		ret += len;
+		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
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


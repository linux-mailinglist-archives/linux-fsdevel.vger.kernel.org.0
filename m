Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B166B66D2EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjAPXQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjAPXQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E9166FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvoePorPb+s/SNMB7xx6LbwM0BqIOrroTztDrtCxjAY=;
        b=dGysmAeAlEazIvTAYFtg6YYowokAYjlGzrfd/eWfpSGsBTwVO0zbW1nkrVaLzLaxODEf+o
        PRmsfMQ517Kcb0XfMhmHyBzoX/yS+I4XC2t2J+Lfok12weNf3CbbP1xBiKXecX8VEWRr/T
        IOMyZedHudPDpm3nX7eW+9XWzy6EdgI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-lT3YyhGPO9uz0g4OFhAvXg-1; Mon, 16 Jan 2023 18:10:57 -0500
X-MC-Unique: lT3YyhGPO9uz0g4OFhAvXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F272E85CCE0;
        Mon, 16 Jan 2023 23:10:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF9E40C6EC4;
        Mon, 16 Jan 2023 23:10:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 24/34] cifs: Add a function to build an RDMA SGE list from
 an iterator
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:54 +0000
Message-ID: <167391065455.2311931.6594946160942957670.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 fs/cifs/smbdirect.c |  224 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 3e693ffd0662..78a76752fafd 100644
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
 
@@ -2480,3 +2491,216 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 
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



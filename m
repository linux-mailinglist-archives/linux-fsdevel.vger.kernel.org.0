Return-Path: <linux-fsdevel+bounces-79384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDd7MuU9qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:12:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 398C9201181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924C731B8F03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27F3B7B61;
	Wed,  4 Mar 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBG69TPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5042224B05
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633078; cv=none; b=gceqH0Qhmdcaa4w3YHpv//VUJhNhEJyKUPNcvzCiC8YojHwqfydZ52sPeuUFeb6kBsdl/uBierwkwGgHcFM1sJFfYq0KjM4/fmTZ7bcPwhLJdxWAH4E7yReOF3UFaFFpnhXrDcA608sUIKxTKVGap96phNJOn5ZBwCuF5Y9HjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633078; c=relaxed/simple;
	bh=IP/juZtoL3vcS4yj+idXFsVpTc19MnDYbAUh31HpUdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ph1fNnx2y14eCtYKnfYN4PjQAFLmV92yJQlWkK6z2pQJ5t7qgMJfnq1Bjc2p8r7MYcD4tbNluvUnPjamEVnfceLaNji60vQaoFZRmeIu0W4rQXGCU6ApMdT5OIKqcUP7rBVbyNi89gAXY+RK49wJ0GEMibejkpxhPyAPW64PU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBG69TPQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37JYngOeA4ilbnvJNnNil1+CpObDot6D//VD7RHfZ8Q=;
	b=GBG69TPQlW+oE6Mhpt0U82S+wAtN6nio8vu+81viUB/H7AXRGGvH2xId92mIX9Q6or7801
	rmtVJxlZwG/NNkDOcGbR27kguQ3B8kNW21yadKeWx8IqGRTxQEnBJlk0IsdZqKhJ/ISK8o
	rXtCleed3RRAMKKZzSV4KtjAdL4Z2C0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-f9c12XnfNWiDXtK8o_9oOQ-1; Wed,
 04 Mar 2026 09:04:30 -0500
X-MC-Unique: f9c12XnfNWiDXtK8o_9oOQ-1
X-Mimecast-MFC-AGG-ID: f9c12XnfNWiDXtK8o_9oOQ_1772633068
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3596F1800245;
	Wed,  4 Mar 2026 14:04:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B2C4195608E;
	Wed,  4 Mar 2026 14:04:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>
Subject: [RFC PATCH 07/17] netfs: Add a function to extract from an iter into a bvecq
Date: Wed,  4 Mar 2026 14:03:14 +0000
Message-ID: <20260304140328.112636-8-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 398C9201181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79384-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,infradead.org:email,samba.org:email]
X-Rspamd-Action: no action

Add a function to extract a slice of data from an iterator of any type into
a bvec queue chain.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/iterator.c   | 122 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |   3 ++
 2 files changed, 125 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..faf4f0a3b33d 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -13,6 +13,128 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+/**
+ * netfs_extract_iter - Extract the pages from an iterator into a bvecq
+ * @orig: The original iterator
+ * @orig_len: The amount of iterator to copy
+ * @max_segs: Maximum number of contiguous segments
+ * @fpos: Starting file position to label the bvecq with
+ * @_bvecq_head: Where to cache the bvec queue
+ * @extraction_flags: Flags to qualify the request
+ *
+ * Extract the page fragments from the given amount of the source iterator and
+ * build bvec queue that refers to all of those bits.  This allows the original
+ * iterator to disposed of.
+ *
+ * @extraction_flags can have ITER_ALLOW_P2PDMA set to request peer-to-peer DMA be
+ * allowed on the pages extracted.
+ *
+ * On success, the amount of data in the bvec is returned, the original
+ * iterator will have been advanced by the amount extracted.
+ *
+ * The bvecq segments are marked with indications on how to get clean up the
+ * extracted fragments.
+ */
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags)
+{
+	struct bvecq *bq_tail = NULL;
+	ssize_t ret = 0;
+	size_t segs_per_bq;
+	size_t extracted = 0;
+
+	_enter("{%u,%zx},%zx", orig->iter_type, orig->count, orig_len);
+
+	if (max_segs == 0)
+		max_segs = ULONG_MAX;
+
+	/* We want the biggest pow-of-2 size that has at most 255 segs and that
+	 * won't exceed a 4K page.
+	 */
+	segs_per_bq = (4096 - sizeof(*bq_tail)) / sizeof(bq_tail->__bv[0]);
+	if (segs_per_bq > 255)
+		segs_per_bq = (2048 - sizeof(*bq_tail)) / sizeof(bq_tail->__bv[0]);
+
+	do {
+		struct bvecq *bq;
+		size_t nr_slots = iov_iter_npages(orig, umin(segs_per_bq, max_segs));
+
+		if (WARN_ON(nr_slots == 0 && extracted < orig_len) ||
+		    WARN_ON(nr_slots > max_segs))
+			break;
+		max_segs -= nr_slots;
+
+		bq = netfs_alloc_one_bvecq(nr_slots, GFP_NOFS);
+		if (!bq) {
+			ret = -ENOMEM;
+			break;
+		}
+		bq->free	= user_backed_iter(orig);
+		bq->unpin	= iov_iter_extract_will_pin(orig);
+		bq->prev	= bq_tail;
+		bq->fpos	= fpos + extracted;
+
+		if (bq_tail)
+			bq_tail->next = bq;
+		else
+			*_bvecq_head = bq;
+		bq_tail = bq;
+
+		if (extracted >= orig_len)
+			break;
+
+		/* Put the page list at the end of the bvec list storage.  bvec
+		 * elements are larger than page pointers, so as long as we
+		 * work 0->last, we should be fine.
+		 */
+		struct bio_vec *bv = bq->bv;
+		struct page **pages;
+		size_t bv_size = array_size(bq->max_segs, sizeof(*bv));
+		size_t pg_size = array_size(bq->max_segs, sizeof(*pages));
+
+		pages = (void *)bv + bv_size - pg_size;
+
+		do {
+			unsigned int cur_npages;
+			ssize_t got;
+			size_t offset;
+
+			got = iov_iter_extract_pages(orig, &pages, orig_len - extracted,
+						     bq->max_segs - bq->nr_segs,
+						     extraction_flags, &offset);
+			if (got < 0) {
+				pr_err("Couldn't get user pages (rc=%zd)\n", got);
+				ret = got;
+				break;
+			}
+
+			if (got > orig_len - extracted) {
+				pr_err("get_pages rc=%zd more than %zu\n",
+				       got, orig_len - extracted);
+				break;
+			}
+
+			extracted += got;
+			got += offset;
+			cur_npages = DIV_ROUND_UP(got, PAGE_SIZE);
+
+			for (unsigned int i = 0; i < cur_npages; i++) {
+				size_t len = umin(got, PAGE_SIZE);
+
+				bvec_set_page(&bq->bv[bq->nr_segs],
+					      *pages++, len - offset, offset);
+				bq->nr_segs++;
+				got -= len;
+				offset = 0;
+			}
+		} while (extracted < orig_len && !bvecq_is_full(bq));
+	} while (extracted < orig_len && max_segs > 0);
+
+	return extracted ?: ret;
+}
+EXPORT_SYMBOL_GPL(netfs_extract_iter);
+
 /**
  * netfs_extract_user_iter - Extract the pages from a user iterator into a bvec
  * @orig: The original iterator
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f9ad067a0a0c..b146aeaaf6c9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -448,6 +448,9 @@ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
+ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
+			   unsigned long long fpos, struct bvecq **_bvecq_head,
+			   iov_iter_extraction_t extraction_flags);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);



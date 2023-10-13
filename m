Return-Path: <linux-fsdevel+bounces-292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F347C89D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E324B212A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C745224D7;
	Fri, 13 Oct 2023 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggsrkVcV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C3224D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:05:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0461BB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ontDGl26Z2fbsTnGmpaZePgZN/TS57PItn3SJDCoVuk=;
	b=ggsrkVcVFL29VqRFgI5j7FuubWYWDSmZleavAkWU+A+WCmUKjl1lBmapPqVwmT2bAskKcv
	7XWrxZiDO70pr0ZGXjA6Y+bPbJvNvJs39uviwkRL3Y++UdguKaFHfPPoKbMbcUdt1Y44Yn
	Rpgqez345bCq+zA37t2o0RrLO4VGmsA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-rWbD_8zjPn63ZHOu7ytAzw-1; Fri, 13 Oct 2023 12:05:15 -0400
X-MC-Unique: rWbD_8zjPn63ZHOu7ytAzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 190583823337;
	Fri, 13 Oct 2023 16:05:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97A0425C0;
	Fri, 13 Oct 2023 16:05:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 14/53] netfs: Add func to calculate pagecount/size-limited span of an iterator
Date: Fri, 13 Oct 2023 17:03:43 +0100
Message-ID: <20231013160423.2218093-15-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a function to work out how much of an ITER_BVEC or ITER_XARRAY iterator
we can use in a pagecount-limited and size-limited span.  This will be
used, for example, to limit the number of segments in a subrequest to the
maximum number of elements that an RDMA transfer can handle.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/iterator.c   | 97 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |  2 +
 2 files changed, 99 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 2ff07ba655a0..b781bbbf1d8d 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -101,3 +101,100 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 	return npages;
 }
 EXPORT_SYMBOL_GPL(netfs_extract_user_iter);
+
+/*
+ * Select the span of a bvec iterator we're going to use.  Limit it by both maximum
+ * size and maximum number of segments.  Returns the size of the span in bytes.
+ */
+static size_t netfs_limit_bvec(const struct iov_iter *iter, size_t start_offset,
+			       size_t max_size, size_t max_segs)
+{
+	const struct bio_vec *bvecs = iter->bvec;
+	unsigned int nbv = iter->nr_segs, ix = 0, nsegs = 0;
+	size_t len, span = 0, n = iter->count;
+	size_t skip = iter->iov_offset + start_offset;
+
+	if (WARN_ON(!iov_iter_is_bvec(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+
+	while (n && ix < nbv && skip) {
+		len = bvecs[ix].bv_len;
+		if (skip < len)
+			break;
+		skip -= len;
+		n -= len;
+		ix++;
+	}
+
+	while (n && ix < nbv) {
+		len = min3(n, bvecs[ix].bv_len - skip, max_size);
+		span += len;
+		nsegs++;
+		ix++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+		skip = 0;
+		n -= len;
+	}
+
+	return min(span, max_size);
+}
+
+/*
+ * Select the span of an xarray iterator we're going to use.  Limit it by both
+ * maximum size and maximum number of segments.  It is assumed that segments
+ * can be larger than a page in size, provided they're physically contiguous.
+ * Returns the size of the span in bytes.
+ */
+static size_t netfs_limit_xarray(const struct iov_iter *iter, size_t start_offset,
+				 size_t max_size, size_t max_segs)
+{
+	struct folio *folio;
+	unsigned int nsegs = 0;
+	loff_t pos = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = pos / PAGE_SIZE;
+	size_t span = 0, n = iter->count;
+
+	XA_STATE(xas, iter->xarray, index);
+
+	if (WARN_ON(!iov_iter_is_xarray(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+	max_size = min(max_size, n - start_offset);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t offset, flen, len;
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		flen = folio_size(folio);
+		offset = offset_in_folio(folio, pos);
+		len = min(max_size, flen - offset);
+		span += len;
+		nsegs++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+	}
+
+	rcu_read_unlock();
+	return min(span, max_size);
+}
+
+size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
+			size_t max_size, size_t max_segs)
+{
+	if (iov_iter_is_bvec(iter))
+		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
+	if (iov_iter_is_xarray(iter))
+		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
+	BUG();
+}
+EXPORT_SYMBOL(netfs_limit_iter);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a7220e906287..2b5e04ea4db2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -328,6 +328,8 @@ void netfs_stats_show(struct seq_file *);
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);
+size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
+			size_t max_size, size_t max_segs);
 
 int netfs_start_io_read(struct inode *inode);
 void netfs_end_io_read(struct inode *inode);



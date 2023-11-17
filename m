Return-Path: <linux-fsdevel+bounces-3072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF27EFA33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46668280D9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B0482E3;
	Fri, 17 Nov 2023 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7jE98mq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5E2119
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28kgPZMsHEWnVwc0vT6VK3Ue5Bj5q+rjSv2U7JFM+9k=;
	b=f7jE98mqdx2vIPJSFUqoA0jqnCJqNrH7Yd1X4M8srIhHubhCpQP6uMci5Lhoc4CiVIoGyN
	QWz6ZW7KzZmXobjNAL5voOJ+GFOvZg6ACm1OQZxP5dSEXaCaM3yWW8KHNiac16nt4EVHry
	wCJc1G+ozcVwT5poAr5V/Koi0nSkYrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-95hHtn_bOoOzYt_pFWk_0w-1; Fri, 17 Nov 2023 16:17:27 -0500
X-MC-Unique: 95hHtn_bOoOzYt_pFWk_0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56578101A52D;
	Fri, 17 Nov 2023 21:17:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5C232026D4C;
	Fri, 17 Nov 2023 21:17:23 +0000 (UTC)
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
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/51] netfs: Make netfs_read_folio() handle streaming-write pages
Date: Fri, 17 Nov 2023 21:15:15 +0000
Message-ID: <20231117211544.1740466-24-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

netfs_read_folio() needs to handle partially-valid pages that are marked
dirty, but not uptodate in the event that someone tries to read a page was
used to cache data by a streaming write.

In such a case, make netfs_read_folio() set up a bvec iterator that points
to the parts of the folio that need filling and to a sink page for the data
that should be discarded and use that instead of i_pages as the iterator to
be written to.

This requires netfs_rreq_unlock_folios() to convert the page into a normal
dirty uptodate page, getting rid of the partial write record and bumping
the group pointer over to folio->private.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c     | 61 ++++++++++++++++++++++++++++++++++--
 include/trace/events/netfs.h |  2 ++
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 2f06344bba21..374707df6575 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -16,6 +16,7 @@
 void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
+	struct netfs_folio *finfo;
 	struct folio *folio;
 	pgoff_t start_page = rreq->start / PAGE_SIZE;
 	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
@@ -86,6 +87,15 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 
 		if (!pg_failed) {
 			flush_dcache_folio(folio);
+			finfo = netfs_folio_info(folio);
+			if (finfo) {
+				trace_netfs_folio(folio, netfs_folio_trace_filled_gaps);
+				if (finfo->netfs_group)
+					folio_change_private(folio, finfo->netfs_group);
+				else
+					folio_detach_private(folio);
+				kfree(finfo);
+			}
 			folio_mark_uptodate(folio);
 		}
 
@@ -245,6 +255,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct address_space *mapping = folio_file_mapping(folio);
 	struct netfs_io_request *rreq;
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
+	struct folio *sink = NULL;
 	int ret;
 
 	_enter("%lx", folio_index(folio));
@@ -265,12 +276,56 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	/* Set up the output buffer */
-	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
-			rreq->start, rreq->len);
+	if (folio_test_dirty(folio)) {
+		/* Handle someone trying to read from an unflushed streaming
+		 * write.  We fiddle the buffer so that a gap at the beginning
+		 * and/or a gap at the end get copied to, but the middle is
+		 * discarded.
+		 */
+		struct netfs_folio *finfo = netfs_folio_info(folio);
+		struct bio_vec *bvec;
+		unsigned int from = finfo->dirty_offset;
+		unsigned int to = from + finfo->dirty_len;
+		unsigned int off = 0, i = 0;
+		size_t flen = folio_size(folio);
+		size_t nr_bvec = flen / PAGE_SIZE + 2;
+		size_t part;
+
+		ret = -ENOMEM;
+		bvec = kmalloc_array(nr_bvec, sizeof(*bvec), GFP_KERNEL);
+		if (!bvec)
+			goto discard;
+
+		sink = folio_alloc(GFP_KERNEL, 0);
+		if (!sink)
+			goto discard;
+
+		trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
+
+		rreq->direct_bv = bvec;
+		rreq->direct_bv_count = nr_bvec;
+		if (from > 0) {
+			bvec_set_folio(&bvec[i++], folio, from, 0);
+			off = from;
+		}
+		while (off < to) {
+			part = min_t(size_t, to - off, PAGE_SIZE);
+			bvec_set_folio(&bvec[i++], sink, part, 0);
+			off += part;
+		}
+		if (to < flen)
+			bvec_set_folio(&bvec[i++], folio, flen - to, to);
+		iov_iter_bvec(&rreq->iter, ITER_DEST, bvec, i, rreq->len);
+	} else {
+		iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
+				rreq->start, rreq->len);
+	}
 
 	ret = netfs_begin_read(rreq, true);
+	if (sink)
+		folio_put(sink);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
-	return ret;
+	return ret < 0 ? ret : 0;
 
 discard:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 94793f842000..b7426f455086 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -115,9 +115,11 @@
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
+	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
+	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
 	EM(netfs_folio_trace_redirty,		"redirty")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\



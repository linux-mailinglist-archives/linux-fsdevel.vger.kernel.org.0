Return-Path: <linux-fsdevel+bounces-3085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508D7EFA72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85731C20AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137A7495E3;
	Fri, 17 Nov 2023 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW1Q7T7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB7385C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzDhN/w9cvvKua4gBrl6PWgKrwY4TekGMNM6JSQn30M=;
	b=YW1Q7T7P80mLt4JzFlv7yojXXrrAtdeSIYosUAJH0IWW8OpCDuRII3aJStFud+AUbrTboY
	l8P8wyUS6g1/qQlWsyNQchoqvf/feD6eYeGUXV9xzfm1NLv+/2LozcQepd+dTTZCrlnMBZ
	FjPMlXhpIsKpbwJ4DkWeIbduC1Zg4Sc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-OgAQOJ2NNXial4Md-qzOTg-1; Fri, 17 Nov 2023 16:18:14 -0500
X-MC-Unique: OgAQOJ2NNXial4Md-qzOTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 862E5185A787;
	Fri, 17 Nov 2023 21:18:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EAC44C15881;
	Fri, 17 Nov 2023 21:18:10 +0000 (UTC)
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
Subject: [PATCH v2 37/51] netfs: Provide a launder_folio implementation
Date: Fri, 17 Nov 2023 21:15:29 +0000
Message-ID: <20231117211544.1740466-38-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Provide a launder_folio implementation for netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c    | 71 ++++++++++++++++++++++++++++++++++++
 fs/netfs/main.c              |  1 +
 include/linux/netfs.h        |  2 +
 include/trace/events/netfs.h |  3 ++
 4 files changed, 77 insertions(+)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 93e16f7caf67..43e825b882ff 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1099,3 +1099,74 @@ int netfs_writepages(struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_writepages);
+
+/*
+ * Deal with the disposition of a laundered folio.
+ */
+static void netfs_cleanup_launder_folio(struct netfs_io_request *wreq)
+{
+	if (wreq->error) {
+		pr_notice("R=%08x Laundering error %d\n", wreq->debug_id, wreq->error);
+		mapping_set_error(wreq->mapping, wreq->error);
+	}
+}
+
+/**
+ * netfs_launder_folio - Clean up a dirty folio that's being invalidated
+ * @folio: The folio to clean
+ *
+ * This is called to write back a folio that's being invalidated when an inode
+ * is getting torn down.  Ideally, writepages would be used instead.
+ */
+int netfs_launder_folio(struct folio *folio)
+{
+	struct netfs_io_request *wreq;
+	struct address_space *mapping = folio->mapping;
+	struct netfs_folio *finfo;
+	struct bio_vec bvec;
+	unsigned long long i_size = i_size_read(mapping->host);
+	unsigned long long start = folio_pos(folio);
+	size_t offset = 0, len;
+	int ret = 0;
+
+	finfo = netfs_folio_info(folio);
+	if (finfo) {
+		offset = finfo->dirty_offset;
+		start += offset;
+		len = finfo->dirty_len;
+	} else {
+		len = folio_size(folio);
+	}
+	len = min_t(unsigned long long, len, i_size - start);
+
+	wreq = netfs_alloc_request(mapping, NULL, start, len, NETFS_LAUNDER_WRITE);
+	if (IS_ERR(wreq)) {
+		ret = PTR_ERR(wreq);
+		goto out;
+	}
+
+	if (!folio_clear_dirty_for_io(folio))
+		goto out_put;
+
+	trace_netfs_folio(folio, netfs_folio_trace_launder);
+
+	_debug("launder %llx-%llx", start, start + len - 1);
+
+	/* Speculatively write to the cache.  We have to fix this up later if
+	 * the store fails.
+	 */
+	wreq->cleanup = netfs_cleanup_launder_folio;
+
+	bvec_set_folio(&bvec, folio, len, offset);
+	iov_iter_bvec(&wreq->iter, ITER_SOURCE, &bvec, 1, len);
+	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+	ret = netfs_begin_write(wreq, true, netfs_write_trace_launder);
+
+out_put:
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+out:
+	folio_wait_fscache(folio);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_launder_folio);
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index b335e6a50f9c..577c8a9fc0f2 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_LAUNDER_WRITE]		= "LW",
 	[NETFS_RMW_READ]		= "RM",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_READ]		= "DR",
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c3d1eac1ce51..474b3a0f202a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -234,6 +234,7 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
 	NETFS_RMW_READ,			/* This is an unbuffered read for RMW */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
@@ -423,6 +424,7 @@ int netfs_writepages(struct address_space *mapping,
 		     struct writeback_control *wbc);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
+int netfs_launder_folio(struct folio *folio);
 
 /* VMA operations API. */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 825946f510ee..54b2d781d3a9 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -25,6 +25,7 @@
 
 #define netfs_write_traces					\
 	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
+	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
 	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
 	E_(netfs_write_trace_writeback,		"WRITEBACK")
 
@@ -33,6 +34,7 @@
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
+	EM(NETFS_LAUNDER_WRITE,			"LW")		\
 	EM(NETFS_RMW_READ,			"RM")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
@@ -129,6 +131,7 @@
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
+	EM(netfs_folio_trace_launder,		"launder")	\
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\



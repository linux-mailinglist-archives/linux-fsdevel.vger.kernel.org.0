Return-Path: <linux-fsdevel+bounces-7637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649D828BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41FB287181
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0943D0CE;
	Tue,  9 Jan 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSiGo+hc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B23C46E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704823297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4ihKq2RSkKhUM5kA055LwpHV4/BqtYxlxEJ8VssZ38=;
	b=LSiGo+hchgyrErCtbiNuvQE+HjMAZy76owmarPGvs+BVlP88d3ibypvAbEFcjhyasA57YY
	BulnjTVpt7ismPZi/z32jOzV3kJq0+fhsYqraaDI7Kw5rsul7d/feAmWZlzEWZTviMelFb
	rOd0ZM1jWWy0VhI3EV28ZO2THKSAi90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-BvkGftaQOpql1newkq7g1g-1; Tue, 09 Jan 2024 13:01:32 -0500
X-MC-Unique: BvkGftaQOpql1newkq7g1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 415E110334A3;
	Tue,  9 Jan 2024 18:01:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BE45C15A0C;
	Tue,  9 Jan 2024 18:01:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] netfs: Don't use certain internal folio_*() functions
Date: Tue,  9 Jan 2024 18:01:12 +0000
Message-ID: <20240109180117.1669008-2-dhowells@redhat.com>
In-Reply-To: <20240109180117.1669008-1-dhowells@redhat.com>
References: <20240109180117.1669008-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Filesystems should not be using folio->index not folio_index(folio) and
folio->mapping, not folio_mapping() or folio_file_mapping() in filesystem
code.

Change this automagically with:

perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/netfs/*.c
perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/netfs/*.c
perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/netfs/*.c

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-cifs@vger.kernel.org
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c  | 12 ++++++------
 fs/netfs/buffered_write.c | 10 +++++-----
 fs/netfs/io.c             |  2 +-
 fs/netfs/misc.c           |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a59e7b2edaac..3298c29b5548 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -101,7 +101,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 		}
 
 		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
-			if (folio_index(folio) == rreq->no_unlock_folio &&
+			if (folio->index == rreq->no_unlock_folio &&
 			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
 				_debug("no unlock");
 			else
@@ -246,13 +246,13 @@ EXPORT_SYMBOL(netfs_readahead);
  */
 int netfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct address_space *mapping = folio_file_mapping(folio);
+	struct address_space *mapping = folio->mapping;
 	struct netfs_io_request *rreq;
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	struct folio *sink = NULL;
 	int ret;
 
-	_enter("%lx", folio_index(folio));
+	_enter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
 				   folio_file_pos(folio), folio_size(folio),
@@ -460,7 +460,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 		ret = PTR_ERR(rreq);
 		goto error;
 	}
-	rreq->no_unlock_folio	= folio_index(folio);
+	rreq->no_unlock_folio	= folio->index;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 
 	ret = netfs_begin_cache_read(rreq, ctx);
@@ -518,7 +518,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len)
 {
 	struct netfs_io_request *rreq;
-	struct address_space *mapping = folio_file_mapping(folio);
+	struct address_space *mapping = folio->mapping;
 	struct netfs_inode *ctx = netfs_inode(mapping->host);
 	unsigned long long start = folio_pos(folio);
 	size_t flen = folio_size(folio);
@@ -535,7 +535,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 		goto error;
 	}
 
-	rreq->no_unlock_folio = folio_index(folio);
+	rreq->no_unlock_folio = folio->index;
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
 	ret = netfs_begin_cache_read(rreq, ctx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index de517ca70d91..3afb1a0f92d1 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -343,7 +343,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 		default:
 			WARN(true, "Unexpected modify type %u ix=%lx\n",
-			     howto, folio_index(folio));
+			     howto, folio->index);
 			ret = -EIO;
 			goto error_folio_unlock;
 		}
@@ -648,7 +648,7 @@ static void netfs_pages_written_back(struct netfs_io_request *wreq)
 	xas_for_each(&xas, folio, last) {
 		WARN(!folio_test_writeback(folio),
 		     "bad %zx @%llx page %lx %lx\n",
-		     wreq->len, wreq->start, folio_index(folio), last);
+		     wreq->len, wreq->start, folio->index, last);
 
 		if ((finfo = netfs_folio_info(folio))) {
 			/* Streaming writes cannot be redirtied whilst under
@@ -795,7 +795,7 @@ static void netfs_extend_writeback(struct address_space *mapping,
 				continue;
 			if (xa_is_value(folio))
 				break;
-			if (folio_index(folio) != index) {
+			if (folio->index != index) {
 				xas_reset(xas);
 				break;
 			}
@@ -901,7 +901,7 @@ static ssize_t netfs_write_back_from_locked_folio(struct address_space *mapping,
 	long count = wbc->nr_to_write;
 	int ret;
 
-	_enter(",%lx,%llx-%llx,%u", folio_index(folio), start, end, caching);
+	_enter(",%lx,%llx-%llx,%u", folio->index, start, end, caching);
 
 	wreq = netfs_alloc_request(mapping, NULL, start, folio_size(folio),
 				   NETFS_WRITEBACK);
@@ -1047,7 +1047,7 @@ static ssize_t netfs_writepages_begin(struct address_space *mapping,
 
 	start = folio_pos(folio); /* May regress with THPs */
 
-	_debug("wback %lx", folio_index(folio));
+	_debug("wback %lx", folio->index);
 
 	/* At this point we hold neither the i_pages lock nor the page lock:
 	 * the page may be truncated or invalidated (changing page->mapping to
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 4309edf33862..e8ff1e61ce79 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -124,7 +124,7 @@ static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 			/* We might have multiple writes from the same huge
 			 * folio, but we mustn't unlock a folio more than once.
 			 */
-			if (have_unlocked && folio_index(folio) <= unlocked)
+			if (have_unlocked && folio->index <= unlocked)
 				continue;
 			unlocked = folio_next_index(folio) - 1;
 			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0e3af37fc924..90051ced8e2a 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -180,7 +180,7 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	struct netfs_folio *finfo = NULL;
 	size_t flen = folio_size(folio);
 
-	_enter("{%lx},%zx,%zx", folio_index(folio), offset, length);
+	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 
 	folio_wait_fscache(folio);
 



Return-Path: <linux-fsdevel+bounces-15569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D898905E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95AA1B250CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4113B59B;
	Thu, 28 Mar 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8uag1VW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B35131E4B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643884; cv=none; b=c8yK3Ha5yOIanXoy+dMsIvaEniNvpjEQNk5BuhHpCzcSMV5CTGsD9/SJNBwD3wSlIa2nRMRfA7IZLfu/DqDNCRPzTX0vvnW7mzuFUu2wzaj5Ep7QHtR8V086PD5/6D0T7VKRbb5jWNl1Q/jiFpTe+Waz6EuXBU3hUhgpbPu3rUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643884; c=relaxed/simple;
	bh=rR/pxHa2zU/gZNPp6UbtKKEPdO6Ib38p44culPd5H74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMovsdn95B7/UHnNtJvmsf9htnJjP+ag1a+L5i/8SQGGrt+CazszOWWkGEl5TeEh/0H3fhg62JIkoJkmcBj3DpXLubBO5NgGUI5pvHUTyeOVHSbWV1H5WJFh+3hBmhQ0NU2YLriq589uRpBqwysx6Wb5cZo6qTHv/R1LeMR+Esc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a8uag1VW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7667ccFdpRzMigl57YVlQb0kfAbqZCsj5Cjk/duSxs=;
	b=a8uag1VWftEBpQoaUR407VP9CzusdDPAP071HSSrVamVYBxUm3J9KfZSiY5hOHfbJMF/O8
	/NAD/1T3RnNlFzUMnslfGDQfurOt44UyT6UdjFYMeFeXEQbRKRZ7Us1s/4Xs8oqUCiNK7q
	+K25BBxqWlBQcsa4tWPgoKV3aZ0N1l8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-TmRjE1B5MY27K3EnD_2QOA-1; Thu,
 28 Mar 2024 12:37:54 -0400
X-MC-Unique: TmRjE1B5MY27K3EnD_2QOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBE8C3C02464;
	Thu, 28 Mar 2024 16:37:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A33411C05E1C;
	Thu, 28 Mar 2024 16:37:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
	linux-kernel@vger.kernel.org,
	Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 16/26] netfs: Switch to using unsigned long long rather than loff_t
Date: Thu, 28 Mar 2024 16:34:08 +0000
Message-ID: <20240328163424.2781320-17-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Switch to using unsigned long long rather than loff_t in netfslib to avoid
problems with the sign flipping in the maths when we're dealing with the
byte at position 0x7fffffffffffffff.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Xiubo Li <xiubli@redhat.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c           |  2 +-
 fs/ceph/addr.c               |  2 +-
 fs/netfs/buffered_read.c     |  4 +++-
 fs/netfs/buffered_write.c    |  2 +-
 fs/netfs/io.c                |  6 +++---
 fs/netfs/main.c              |  2 +-
 fs/netfs/output.c            |  4 ++--
 include/linux/netfs.h        | 16 +++++++++-------
 include/trace/events/netfs.h |  6 +++---
 9 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 1d685357e67f..5ba5c7814fe4 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -493,7 +493,7 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
  * boundary as appropriate.
  */
 static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						    loff_t i_size)
+						    unsigned long long i_size)
 {
 	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
 					  subreq->start, &subreq->len, i_size,
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2d0f13537c85..3bd58eaea231 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -193,7 +193,7 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 	 * block, but do not exceed the file size, unless the original
 	 * request already exceeds it.
 	 */
-	new_end = min(round_up(end, lo->stripe_unit), rreq->i_size);
+	new_end = umin(round_up(end, lo->stripe_unit), rreq->i_size);
 	if (new_end > end && new_end <= rreq->start + max_len)
 		rreq->len = new_end - rreq->start;
 
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 1622cce535a3..47603f08680e 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -130,7 +130,9 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 }
 
 static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
-					 loff_t *_start, size_t *_len, loff_t i_size)
+					 unsigned long long *_start,
+					 unsigned long long *_len,
+					 unsigned long long i_size)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 624d8859c2fa..8e4a3fb287e3 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -663,7 +663,7 @@ static void netfs_pages_written_back(struct netfs_io_request *wreq)
 	last = (wreq->start + wreq->len - 1) / PAGE_SIZE;
 	xas_for_each(&xas, folio, last) {
 		WARN(!folio_test_writeback(folio),
-		     "bad %zx @%llx page %lx %lx\n",
+		     "bad %llx @%llx page %lx %lx\n",
 		     wreq->len, wreq->start, folio->index, last);
 
 		if ((finfo = netfs_folio_info(folio))) {
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 8de581ac0cfb..6cfecfcd02e1 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -476,7 +476,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 
 set:
 	if (subreq->len > rreq->len)
-		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %zx\n",
+		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %llx\n",
 			rreq->debug_id, subreq->debug_index,
 			subreq->len, rreq->len);
 
@@ -513,7 +513,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 	subreq->start		= rreq->start + rreq->submitted;
 	subreq->len		= io_iter->count;
 
-	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
+	_debug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted);
 	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
 	/* Call out to the cache to find out what it can do with the remaining
@@ -588,7 +588,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	atomic_set(&rreq->nr_outstanding, 1);
 	io_iter = rreq->io_iter;
 	do {
-		_debug("submit %llx + %zx >= %llx",
+		_debug("submit %llx + %llx >= %llx",
 		       rreq->start, rreq->submitted, rreq->i_size);
 		if (rreq->origin == NETFS_DIO_READ &&
 		    rreq->start + rreq->submitted >= rreq->i_size)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 4805b9377364..5f0f438e5d21 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -62,7 +62,7 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 
 	rreq = list_entry(v, struct netfs_io_request, proc_link);
 	seq_printf(m,
-		   "%08x %s %3d %2lx %4d %3d @%04llx %zx/%zx",
+		   "%08x %s %3d %2lx %4d %3d @%04llx %llx/%llx",
 		   rreq->debug_id,
 		   netfs_origins[rreq->origin],
 		   refcount_read(&rreq->ref),
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index e586396d6b72..85374322f10f 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -439,7 +439,7 @@ static void netfs_submit_writethrough(struct netfs_io_request *wreq, bool final)
  */
 int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end)
 {
-	_enter("ic=%zu sb=%zu ws=%u cp=%zu tp=%u",
+	_enter("ic=%zu sb=%llu ws=%u cp=%zu tp=%u",
 	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_end);
 
 	wreq->iter.count += copied;
@@ -457,7 +457,7 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb)
 {
 	int ret = -EIOCBQUEUED;
 
-	_enter("ic=%zu sb=%zu ws=%u",
+	_enter("ic=%zu sb=%llu ws=%u",
 	       wreq->iter.count, wreq->submitted, wreq->wsize);
 
 	if (wreq->submitted < wreq->io_iter.count)
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 0b6c2c2d3c23..88269681d4fc 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -149,7 +149,7 @@ struct netfs_io_subrequest {
 	struct work_struct	work;
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct iov_iter		io_iter;	/* Iterator for this subrequest */
-	loff_t			start;		/* Where to start the I/O */
+	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
 	refcount_t		ref;
@@ -205,15 +205,15 @@ struct netfs_io_request {
 	atomic_t		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
-	size_t			submitted;	/* Amount submitted for I/O so far */
-	size_t			len;		/* Length of the request */
 	size_t			upper_len;	/* Length can be extended to here */
+	unsigned long long	submitted;	/* Amount submitted for I/O so far */
+	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
-	loff_t			i_size;		/* Size of the file */
-	loff_t			start;		/* Start position */
+	unsigned long long	i_size;		/* Size of the file */
+	unsigned long long	start;		/* Start position */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	refcount_t		ref;
 	unsigned long		flags;
@@ -294,13 +294,15 @@ struct netfs_cache_ops {
 
 	/* Expand readahead request */
 	void (*expand_readahead)(struct netfs_cache_resources *cres,
-				 loff_t *_start, size_t *_len, loff_t i_size);
+				 unsigned long long *_start,
+				 unsigned long long *_len,
+				 unsigned long long i_size);
 
 	/* Prepare a read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
 	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-					     loff_t i_size);
+					     unsigned long long i_size);
 
 	/* Prepare a write operation, working out what part of the write we can
 	 * actually do.
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 30769103638f..7126d2ea459c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -280,7 +280,7 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->start	= sreq->start;
 			   ),
 
-	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx/%zx e=%d",
+	    TP_printk("R=%08x[%x] %s %s f=%02x s=%llx %zx/%zx e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->what, netfs_sreq_traces),
@@ -320,7 +320,7 @@ TRACE_EVENT(netfs_failure,
 		    __entry->start	= sreq ? sreq->start : 0;
 			   ),
 
-	    TP_printk("R=%08x[%d] %s f=%02x s=%llx %zx/%zx %s e=%d",
+	    TP_printk("R=%08x[%x] %s f=%02x s=%llx %zx/%zx %s e=%d",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __entry->flags,
@@ -436,7 +436,7 @@ TRACE_EVENT(netfs_write,
 		    __field(unsigned int,		cookie		)
 		    __field(enum netfs_write_trace,	what		)
 		    __field(unsigned long long,		start		)
-		    __field(size_t,			len		)
+		    __field(unsigned long long,		len		)
 			     ),
 
 	    TP_fast_assign(



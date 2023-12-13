Return-Path: <linux-fsdevel+bounces-5946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB6811750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E81C208DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06507FBDC;
	Wed, 13 Dec 2023 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIB06LjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A917D47
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTfmcNPb0gO1dPN+fv6cw9EjGqJBYpwlxH/Goq7Tcsg=;
	b=dIB06LjOxwkGA17HUFwcbBAKedg1LrBIdcfv7lALZUuWCcligExSsR8/KXH/wMvJP8OFqI
	yjE9rXcKTdG13gar1tiYbocO3syQedef/1c5D/abO5z/AN44ZanZnI0HDR4Ub9wOWgn9Zk
	740gdSRIkczh+13YqTkJZITPTlBnVxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-0voZJWsMPjGkJFjCSOYEhQ-1; Wed, 13 Dec 2023 10:25:38 -0500
X-MC-Unique: 0voZJWsMPjGkJFjCSOYEhQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FBC9101A52A;
	Wed, 13 Dec 2023 15:25:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33F1C492BC6;
	Wed, 13 Dec 2023 15:25:34 +0000 (UTC)
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
	Eric Van Hensbergen <ericvh@kernel.org>,
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
Subject: [PATCH v4 24/39] netfs: Dispatch write requests to process a writeback slice
Date: Wed, 13 Dec 2023 15:23:34 +0000
Message-ID: <20231213152350.431591-25-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Dispatch one or more write reqeusts to process a writeback slice, where a
slice is tailored more to logical block divisions within the file (such as
crypto blocks, an object layout or cache granules) than the protocol RPC
maximum capacity.

The dispatch doesn't happen until throttling allows, at which point the
entire writeback slice is processed and queued.  A slice may be written to
multiple destinations (one or more servers and the local cache) and the
writes to each destination might be split up along different lines.

The writeback slice holds the required folios pinned.  An iov_iter is
provided in netfs_write_request that describes the buffer to be used.  This
may be part of the pagecache, may have auxiliary padding pages attached or
may be a bounce buffer resulting from crypto or compression.  Consequently,
the filesystem must not twiddle the folio markings directly.

The following API is available to the filesystem:

 (1) The ->create_write_requests() method is called to ask the filesystem
     to create the requests it needs.  This is passed the writeback slice
     to be processed.

 (2) The filesystem should then call netfs_create_write_request() to create
     the requests it needs.

 (3) Once a request is initialised, netfs_queue_write_request() can be
     called to dispatch it asynchronously, if not completed immediately.

 (4) netfs_write_request_completed() should be called to note the
     completion of a request.

 (5) netfs_get_write_request() and netfs_put_write_request() are provided
     to refcount a request.  These take constants from the netfs_wreq_trace
     enum for logging into ftrace.

 (6) The ->free_write_request is method is called to ask the filesystem to
     clean up a request.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/Makefile            |   3 +-
 fs/netfs/internal.h          |   6 +
 fs/netfs/output.c            | 363 +++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |  13 ++
 include/trace/events/netfs.h |  50 ++++-
 5 files changed, 432 insertions(+), 3 deletions(-)
 create mode 100644 fs/netfs/output.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index cf3fc847b8ac..c69c6775b8ac 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -7,7 +7,8 @@ netfs-y := \
 	locking.o \
 	main.o \
 	misc.o \
-	objects.o
+	objects.o \
+	output.o
 
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 1b83c534593a..a71fc21fc4ad 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -88,6 +88,12 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
 	trace_netfs_rreq_ref(rreq->debug_id, refcount_read(&rreq->ref), what);
 }
 
+/*
+ * output.c
+ */
+int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
+		      enum netfs_write_trace what);
+
 /*
  * stats.c
  */
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
new file mode 100644
index 000000000000..2ad0fd8c32be
--- /dev/null
+++ b/fs/netfs/output.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem high-level write support.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/writeback.h>
+#include <linux/pagevec.h>
+#include "internal.h"
+
+/**
+ * netfs_create_write_request - Create a write operation.
+ * @wreq: The write request this is storing from.
+ * @dest: The destination type
+ * @start: Start of the region this write will modify
+ * @len: Length of the modification
+ * @worker: The worker function to handle the write(s)
+ *
+ * Allocate a write operation, set it up and add it to the list on a write
+ * request.
+ */
+struct netfs_io_subrequest *netfs_create_write_request(struct netfs_io_request *wreq,
+						       enum netfs_io_source dest,
+						       loff_t start, size_t len,
+						       work_func_t worker)
+{
+	struct netfs_io_subrequest *subreq;
+
+	subreq = netfs_alloc_subrequest(wreq);
+	if (subreq) {
+		INIT_WORK(&subreq->work, worker);
+		subreq->source	= dest;
+		subreq->start	= start;
+		subreq->len	= len;
+		subreq->debug_index = wreq->subreq_counter++;
+
+		switch (subreq->source) {
+		case NETFS_UPLOAD_TO_SERVER:
+			netfs_stat(&netfs_n_wh_upload);
+			break;
+		case NETFS_WRITE_TO_CACHE:
+			netfs_stat(&netfs_n_wh_write);
+			break;
+		default:
+			BUG();
+		}
+
+		subreq->io_iter = wreq->io_iter;
+		iov_iter_advance(&subreq->io_iter, subreq->start - wreq->start);
+		iov_iter_truncate(&subreq->io_iter, subreq->len);
+
+		trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
+				     refcount_read(&subreq->ref),
+				     netfs_sreq_trace_new);
+		atomic_inc(&wreq->nr_outstanding);
+		list_add_tail(&subreq->rreq_link, &wreq->subrequests);
+		trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+	}
+
+	return subreq;
+}
+EXPORT_SYMBOL(netfs_create_write_request);
+
+/*
+ * Process a completed write request once all the component operations have
+ * been completed.
+ */
+static void netfs_write_terminated(struct netfs_io_request *wreq, bool was_async)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_inode *ctx = netfs_inode(wreq->inode);
+
+	_enter("R=%x[]", wreq->debug_id);
+
+	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
+
+	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
+		if (!subreq->error)
+			continue;
+		switch (subreq->source) {
+		case NETFS_UPLOAD_TO_SERVER:
+			/* Depending on the type of failure, this may prevent
+			 * writeback completion unless we're in disconnected
+			 * mode.
+			 */
+			if (!wreq->error)
+				wreq->error = subreq->error;
+			break;
+
+		case NETFS_WRITE_TO_CACHE:
+			/* Failure doesn't prevent writeback completion unless
+			 * we're in disconnected mode.
+			 */
+			if (subreq->error != -ENOBUFS)
+				ctx->ops->invalidate_cache(wreq);
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			if (!wreq->error)
+				wreq->error = -EIO;
+			return;
+		}
+	}
+
+	wreq->cleanup(wreq);
+
+	_debug("finished");
+	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
+	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
+	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
+
+	netfs_clear_subrequests(wreq, was_async);
+	netfs_put_request(wreq, was_async, netfs_rreq_trace_put_complete);
+}
+
+/*
+ * Deal with the completion of writing the data to the cache.
+ */
+void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
+				       bool was_async)
+{
+	struct netfs_io_subrequest *subreq = _op;
+	struct netfs_io_request *wreq = subreq->rreq;
+	unsigned int u;
+
+	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_error);
+
+	switch (subreq->source) {
+	case NETFS_UPLOAD_TO_SERVER:
+		netfs_stat(&netfs_n_wh_upload_done);
+		break;
+	case NETFS_WRITE_TO_CACHE:
+		netfs_stat(&netfs_n_wh_write_done);
+		break;
+	case NETFS_INVALID_WRITE:
+		break;
+	default:
+		BUG();
+	}
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		subreq->error = transferred_or_error;
+		trace_netfs_failure(wreq, subreq, transferred_or_error,
+				    netfs_fail_write);
+		goto failed;
+	}
+
+	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
+		 "Subreq excess write: R%x[%x] %zd > %zu - %zu",
+		 wreq->debug_id, subreq->debug_index,
+		 transferred_or_error, subreq->len, subreq->transferred))
+		transferred_or_error = subreq->len - subreq->transferred;
+
+	subreq->error = 0;
+	subreq->transferred += transferred_or_error;
+
+	if (iov_iter_count(&subreq->io_iter) != subreq->len - subreq->transferred)
+		pr_warn("R=%08x[%u] ITER POST-MISMATCH %zx != %zx-%zx %x\n",
+			wreq->debug_id, subreq->debug_index,
+			iov_iter_count(&subreq->io_iter), subreq->len,
+			subreq->transferred, subreq->io_iter.iter_type);
+
+	if (subreq->transferred < subreq->len)
+		goto incomplete;
+
+	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+out:
+	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
+
+	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
+	u = atomic_dec_return(&wreq->nr_outstanding);
+	if (u == 0)
+		netfs_write_terminated(wreq, was_async);
+	else if (u == 1)
+		wake_up_var(&wreq->nr_outstanding);
+
+	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+	return;
+
+incomplete:
+	if (transferred_or_error == 0) {
+		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
+			subreq->error = -ENODATA;
+			goto failed;
+		}
+	} else {
+		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	}
+
+	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
+	set_bit(NETFS_RREQ_INCOMPLETE_IO, &wreq->flags);
+	goto out;
+
+failed:
+	switch (subreq->source) {
+	case NETFS_WRITE_TO_CACHE:
+		netfs_stat(&netfs_n_wh_write_failed);
+		set_bit(NETFS_RREQ_INCOMPLETE_IO, &wreq->flags);
+		break;
+	case NETFS_UPLOAD_TO_SERVER:
+		netfs_stat(&netfs_n_wh_upload_failed);
+		set_bit(NETFS_RREQ_FAILED, &wreq->flags);
+		wreq->error = subreq->error;
+		break;
+	default:
+		break;
+	}
+	goto out;
+}
+EXPORT_SYMBOL(netfs_write_subrequest_terminated);
+
+static void netfs_write_to_cache_op(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &wreq->cache_resources;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+
+	cres->ops->write(cres, subreq->start, &subreq->io_iter,
+			 netfs_write_subrequest_terminated, subreq);
+}
+
+static void netfs_write_to_cache_op_worker(struct work_struct *work)
+{
+	struct netfs_io_subrequest *subreq =
+		container_of(work, struct netfs_io_subrequest, work);
+
+	netfs_write_to_cache_op(subreq);
+}
+
+/**
+ * netfs_queue_write_request - Queue a write request for attention
+ * @subreq: The write request to be queued
+ *
+ * Queue the specified write request for processing by a worker thread.  We
+ * pass the caller's ref on the request to the worker thread.
+ */
+void netfs_queue_write_request(struct netfs_io_subrequest *subreq)
+{
+	if (!queue_work(system_unbound_wq, &subreq->work))
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_wip);
+}
+EXPORT_SYMBOL(netfs_queue_write_request);
+
+/*
+ * Set up a op for writing to the cache.
+ */
+static void netfs_set_up_write_to_cache(struct netfs_io_request *wreq)
+{
+	struct netfs_cache_resources *cres;
+	struct netfs_io_subrequest *subreq;
+	struct netfs_inode *ctx = netfs_inode(wreq->inode);
+	struct fscache_cookie *cookie = netfs_i_cookie(ctx);
+	loff_t start = wreq->start;
+	size_t len = wreq->len;
+	int ret;
+
+	if (!fscache_cookie_enabled(cookie)) {
+		clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags);
+		return;
+	}
+
+	_debug("write to cache");
+	subreq = netfs_create_write_request(wreq, NETFS_WRITE_TO_CACHE, start, len,
+					    netfs_write_to_cache_op_worker);
+	if (!subreq)
+		return;
+
+	cres = &wreq->cache_resources;
+	ret = fscache_begin_read_operation(cres, cookie);
+	if (ret < 0) {
+		netfs_write_subrequest_terminated(subreq, ret, false);
+		return;
+	}
+
+	ret = cres->ops->prepare_write(cres, &start, &len, i_size_read(wreq->inode),
+				       true);
+	if (ret < 0) {
+		netfs_write_subrequest_terminated(subreq, ret, false);
+		return;
+	}
+
+	netfs_queue_write_request(subreq);
+}
+
+/*
+ * Begin the process of writing out a chunk of data.
+ *
+ * We are given a write request that holds a series of dirty regions and
+ * (partially) covers a sequence of folios, all of which are present.  The
+ * pages must have been marked as writeback as appropriate.
+ *
+ * We need to perform the following steps:
+ *
+ * (1) If encrypting, create an output buffer and encrypt each block of the
+ *     data into it, otherwise the output buffer will point to the original
+ *     folios.
+ *
+ * (2) If the data is to be cached, set up a write op for the entire output
+ *     buffer to the cache, if the cache wants to accept it.
+ *
+ * (3) If the data is to be uploaded (ie. not merely cached):
+ *
+ *     (a) If the data is to be compressed, create a compression buffer and
+ *         compress the data into it.
+ *
+ *     (b) For each destination we want to upload to, set up write ops to write
+ *         to that destination.  We may need multiple writes if the data is not
+ *         contiguous or the span exceeds wsize for a server.
+ */
+int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
+		      enum netfs_write_trace what)
+{
+	struct netfs_inode *ctx = netfs_inode(wreq->inode);
+
+	_enter("R=%x %llx-%llx f=%lx",
+	       wreq->debug_id, wreq->start, wreq->start + wreq->len - 1,
+	       wreq->flags);
+
+	trace_netfs_write(wreq, what);
+	if (wreq->len == 0 || wreq->iter.count == 0) {
+		pr_err("Zero-sized write [R=%x]\n", wreq->debug_id);
+		return -EIO;
+	}
+
+	wreq->io_iter = wreq->iter;
+
+	/* ->outstanding > 0 carries a ref */
+	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
+	atomic_set(&wreq->nr_outstanding, 1);
+
+	/* Start the encryption/compression going.  We can do that in the
+	 * background whilst we generate a list of write ops that we want to
+	 * perform.
+	 */
+	// TODO: Encrypt or compress the region as appropriate
+
+	/* We need to write all of the region to the cache */
+	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
+		netfs_set_up_write_to_cache(wreq);
+
+	/* However, we don't necessarily write all of the region to the server.
+	 * Caching of reads is being managed this way also.
+	 */
+	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+		ctx->ops->create_write_requests(wreq, wreq->start, wreq->len);
+
+	if (atomic_dec_and_test(&wreq->nr_outstanding))
+		netfs_write_terminated(wreq, false);
+
+	if (!may_wait)
+		return -EIOCBQUEUED;
+
+	wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
+		    TASK_UNINTERRUPTIBLE);
+	return wreq->error;
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 2406e11b41bd..143374a77e84 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -251,6 +251,7 @@ struct netfs_io_request {
 	__counted_by(direct_bv_count);
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
+	unsigned int		wsize;		/* Maximum write size (0 for none) */
 	unsigned int		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
@@ -274,6 +275,7 @@ struct netfs_io_request {
 #define NETFS_RREQ_WRITE_TO_CACHE	7	/* Need to write to the cache */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 	const struct netfs_request_ops *netfs_ops;
+	void (*cleanup)(struct netfs_io_request *req);
 };
 
 /*
@@ -297,6 +299,11 @@ struct netfs_request_ops {
 
 	/* Modification handling */
 	void (*update_i_size)(struct inode *inode, loff_t i_size);
+
+	/* Write request handling */
+	void (*create_write_requests)(struct netfs_io_request *wreq,
+				      loff_t start, size_t len);
+	void (*invalidate_cache)(struct netfs_io_request *wreq);
 };
 
 /*
@@ -385,6 +392,12 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				iov_iter_extraction_t extraction_flags);
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs);
+struct netfs_io_subrequest *netfs_create_write_request(
+	struct netfs_io_request *wreq, enum netfs_io_source dest,
+	loff_t start, size_t len, work_func_t worker);
+void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
+				       bool was_async);
+void netfs_queue_write_request(struct netfs_io_subrequest *subreq);
 
 int netfs_start_io_read(struct inode *inode);
 void netfs_end_io_read(struct inode *inode);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 6daadf2aac8a..e03635172760 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -21,6 +21,11 @@
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
+#define netfs_write_traces					\
+	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
+	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
+	E_(netfs_write_trace_writeback,		"WRITEBACK")
+
 #define netfs_rreq_origins					\
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
@@ -32,11 +37,13 @@
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
+	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
 	EM(netfs_rreq_trace_unmark,		"UNMARK ")	\
 	EM(netfs_rreq_trace_wait_ip,		"WAIT-IP")	\
-	E_(netfs_rreq_trace_wake_ip,		"WAKE-IP")
+	EM(netfs_rreq_trace_wake_ip,		"WAKE-IP")	\
+	E_(netfs_rreq_trace_write_done,		"WR-DONE")
 
 #define netfs_sreq_sources					\
 	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
@@ -64,7 +71,8 @@
 	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
 	EM(netfs_fail_read,			"read")			\
 	EM(netfs_fail_short_read,		"short-read")		\
-	E_(netfs_fail_prepare_write,		"prep-write")
+	EM(netfs_fail_prepare_write,		"prep-write")		\
+	E_(netfs_fail_write,			"write")
 
 #define netfs_rreq_ref_traces					\
 	EM(netfs_rreq_trace_get_for_outstanding,"GET OUTSTND")	\
@@ -74,6 +82,8 @@
 	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
 	EM(netfs_rreq_trace_put_return,		"PUT RETURN ")	\
 	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
+	EM(netfs_rreq_trace_put_work,		"PUT WORK   ")	\
+	EM(netfs_rreq_trace_see_work,		"SEE WORK   ")	\
 	E_(netfs_rreq_trace_new,		"NEW        ")
 
 #define netfs_sreq_ref_traces					\
@@ -82,9 +92,12 @@
 	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
 	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\
+	EM(netfs_sreq_trace_put_discard,	"PUT DISCARD")	\
 	EM(netfs_sreq_trace_put_failed,		"PUT FAILED ")	\
 	EM(netfs_sreq_trace_put_merged,		"PUT MERGED ")	\
 	EM(netfs_sreq_trace_put_no_copy,	"PUT NO COPY")	\
+	EM(netfs_sreq_trace_put_wip,		"PUT WIP    ")	\
+	EM(netfs_sreq_trace_put_work,		"PUT WORK   ")	\
 	E_(netfs_sreq_trace_put_terminated,	"PUT TERM   ")
 
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
@@ -96,6 +109,7 @@
 #define E_(a, b) a
 
 enum netfs_read_trace { netfs_read_traces } __mode(byte);
+enum netfs_write_trace { netfs_write_traces } __mode(byte);
 enum netfs_rreq_trace { netfs_rreq_traces } __mode(byte);
 enum netfs_sreq_trace { netfs_sreq_traces } __mode(byte);
 enum netfs_failure { netfs_failures } __mode(byte);
@@ -113,6 +127,7 @@ enum netfs_sreq_ref_trace { netfs_sreq_ref_traces } __mode(byte);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
 netfs_read_traces;
+netfs_write_traces;
 netfs_rreq_origins;
 netfs_rreq_traces;
 netfs_sreq_sources;
@@ -320,6 +335,37 @@ TRACE_EVENT(netfs_sreq_ref,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(netfs_write,
+	    TP_PROTO(const struct netfs_io_request *wreq,
+		     enum netfs_write_trace what),
+
+	    TP_ARGS(wreq, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		wreq		)
+		    __field(unsigned int,		cookie		)
+		    __field(enum netfs_write_trace,	what		)
+		    __field(unsigned long long,		start		)
+		    __field(size_t,			len		)
+			     ),
+
+	    TP_fast_assign(
+		    struct netfs_inode *__ctx = netfs_inode(wreq->inode);
+		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
+		    __entry->wreq	= wreq->debug_id;
+		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->what	= what;
+		    __entry->start	= wreq->start;
+		    __entry->len	= wreq->len;
+			   ),
+
+	    TP_printk("R=%08x %s c=%08x by=%llx-%llx",
+		      __entry->wreq,
+		      __print_symbolic(__entry->what, netfs_write_traces),
+		      __entry->cookie,
+		      __entry->start, __entry->start + __entry->len - 1)
+	    );
+
 #undef EM
 #undef E_
 #endif /* _TRACE_NETFS_H */



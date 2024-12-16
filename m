Return-Path: <linux-fsdevel+bounces-37542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B69F3BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A1B188063E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD551F3D5F;
	Mon, 16 Dec 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dO68P3tQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364D1DA0E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381846; cv=none; b=MuCxUzua3kOh1bkTBBEafkCmK6IJkSbCqOAkvq59y7Q5BpLkvzXFdolZ2sBitrdjoeG4yT3SqTRNtBKzxmSZ5oNK5tqQdkW+4rH++oRInBJmDThmmBhALou+HimyNBHNEE0S9vsckPkCCSjPK0EVRJqNRVsBkwRA8sYHewcVYmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381846; c=relaxed/simple;
	bh=EjkO+woicJZRa+aSC4QTKuC53mJoYttwlqPtVwhy8Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoE1TSTFqkE7c+o11sY42D/PNi+DtcIK+8cdg6D856EkgIKCmDWSXo4TU/nlDlen9vx/ITp8imApS3GzguRoLdbuTqtTixY7uJsbrSS3ZDwcbg9/K5iz/hn0O4dTAocXxicda7+SNpacgEBHSeTWMtnzD58BbIV5NmndHttSMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dO68P3tQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8G5+zBwY2GQiJAqxEalsgN8Izm09pDHUervIsBL5Kc=;
	b=dO68P3tQdnMjYBN0ha6FQ+4y5efGWfPiBt0zicVFuwVmQJkZkmjLQVgPlxwLlYkugGsVcc
	V8d3d8bt/U0LBSS1OkHhIH1V1njhXlCP8xhfVdBKT90gY+oxTtFEGT5ZFGN2GXr1ZBjf/1
	tUB5+uylhs046QnEoYJPE893omBMSKY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-ADu6qDSRM6qEBrmLFFC2pg-1; Mon,
 16 Dec 2024 15:43:59 -0500
X-MC-Unique: ADu6qDSRM6qEBrmLFFC2pg-1
X-Mimecast-MFC-AGG-ID: ADu6qDSRM6qEBrmLFFC2pg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44D7519560A6;
	Mon, 16 Dec 2024 20:43:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 861A930044C1;
	Mon, 16 Dec 2024 20:43:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
Subject: [PATCH v5 19/32] netfs: Add support for caching single monolithic objects such as AFS dirs
Date: Mon, 16 Dec 2024 20:41:09 +0000
Message-ID: <20241216204124.3752367-20-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add support for caching the content of a file that contains a single
monolithic object that must be read/written with a single I/O operation,
such as an AFS directory.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/Makefile            |   1 +
 fs/netfs/buffered_read.c     |  11 +-
 fs/netfs/internal.h          |   2 +
 fs/netfs/main.c              |   2 +
 fs/netfs/objects.c           |   2 +
 fs/netfs/read_collect.c      |  45 +++++++-
 fs/netfs/read_single.c       | 202 ++++++++++++++++++++++++++++++++++
 fs/netfs/stats.c             |   4 +-
 fs/netfs/write_collect.c     |   6 +-
 fs/netfs/write_issue.c       | 203 ++++++++++++++++++++++++++++++++++-
 include/linux/netfs.h        |  10 ++
 include/trace/events/netfs.h |   4 +
 12 files changed, 478 insertions(+), 14 deletions(-)
 create mode 100644 fs/netfs/read_single.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index cbb30bdeacc4..b43188d64bd8 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -13,6 +13,7 @@ netfs-y := \
 	read_collect.o \
 	read_pgpriv2.o \
 	read_retry.o \
+	read_single.o \
 	rolling_buffer.o \
 	write_collect.o \
 	write_issue.o \
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 4ff4b587dc4b..c420e9dee0e4 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -137,14 +137,17 @@ static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rr
 						     loff_t i_size)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
+	enum netfs_io_source source;
 
 	if (!cres->ops)
 		return NETFS_DOWNLOAD_FROM_SERVER;
-	return cres->ops->prepare_read(subreq, i_size);
+	source = cres->ops->prepare_read(subreq, i_size);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+	return source;
+
 }
 
-static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
-					bool was_async)
+void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool was_async)
 {
 	struct netfs_io_subrequest *subreq = priv;
 
@@ -213,6 +216,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			unsigned long long zp = umin(ictx->zero_point, rreq->i_size);
 			size_t len = subreq->len;
 
+			if (unlikely(rreq->origin == NETFS_READ_SINGLE))
+				zp = rreq->i_size;
 			if (subreq->start >= zp) {
 				subreq->source = source = NETFS_FILL_WITH_ZEROES;
 				goto fill_with_zeroes;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ba32ca61063c..e236f752af88 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -23,6 +23,7 @@
 /*
  * buffered_read.c
  */
+void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool was_async);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
@@ -110,6 +111,7 @@ void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq);
 extern atomic_t netfs_n_rh_dio_read;
 extern atomic_t netfs_n_rh_readahead;
 extern atomic_t netfs_n_rh_read_folio;
+extern atomic_t netfs_n_rh_read_single;
 extern atomic_t netfs_n_rh_rreq;
 extern atomic_t netfs_n_rh_sreq;
 extern atomic_t netfs_n_rh_download;
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 6c7be1377ee0..8c1922c0cb42 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -37,9 +37,11 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READAHEAD]		= "RA",
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_GAPS]		= "RG",
+	[NETFS_READ_SINGLE]		= "R1",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_DIO_READ]		= "DR",
 	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_WRITEBACK_SINGLE]	= "W1",
 	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_WRITE]		= "DW",
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 8c98b70eb3a4..dde4a679d9e2 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -54,6 +54,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	if (origin == NETFS_READAHEAD ||
 	    origin == NETFS_READPAGE ||
 	    origin == NETFS_READ_GAPS ||
+	    origin == NETFS_READ_SINGLE ||
 	    origin == NETFS_READ_FOR_WRITE ||
 	    origin == NETFS_DIO_READ)
 		INIT_WORK(&rreq->work, NULL);
@@ -196,6 +197,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	case NETFS_READAHEAD:
 	case NETFS_READPAGE:
 	case NETFS_READ_GAPS:
+	case NETFS_READ_SINGLE:
 	case NETFS_READ_FOR_WRITE:
 	case NETFS_DIO_READ:
 		INIT_WORK(&subreq->work, netfs_read_subreq_termination_worker);
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 26e430baeb5a..2e9291ab1d62 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -361,6 +361,39 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		inode_dio_end(rreq->inode);
 }
 
+/*
+ * Do processing after reading a monolithic single object.
+ */
+static void netfs_rreq_assess_single(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+
+	subreq = list_first_entry_or_null(&stream->subrequests,
+					  struct netfs_io_subrequest, rreq_link);
+	if (subreq) {
+		if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+			rreq->error = subreq->error;
+		else
+			rreq->transferred = subreq->transferred;
+
+		if (!rreq->error && subreq->source == NETFS_DOWNLOAD_FROM_SERVER &&
+		    fscache_resources_valid(&rreq->cache_resources)) {
+			trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
+			netfs_single_mark_inode_dirty(rreq->inode);
+		}
+	}
+
+	if (rreq->iocb) {
+		rreq->iocb->ki_pos += rreq->transferred;
+		if (rreq->iocb->ki_complete)
+			rreq->iocb->ki_complete(
+				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+	}
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+}
+
 /*
  * Assess the state of a read request and decide what to do next.
  *
@@ -378,9 +411,17 @@ void netfs_rreq_terminated(struct netfs_io_request *rreq)
 		return;
 	}
 
-	if (rreq->origin == NETFS_DIO_READ ||
-	    rreq->origin == NETFS_READ_GAPS)
+	switch (rreq->origin) {
+	case NETFS_DIO_READ:
+	case NETFS_READ_GAPS:
 		netfs_rreq_assess_dio(rreq);
+		break;
+	case NETFS_READ_SINGLE:
+		netfs_rreq_assess_single(rreq);
+		break;
+	default:
+		break;
+	}
 	task_io_account_read(rreq->transferred);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
new file mode 100644
index 000000000000..2a66c5fde071
--- /dev/null
+++ b/fs/netfs/read_single.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Single, monolithic object support (e.g. AFS directory).
+ *
+ * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/sched/mm.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+/**
+ * netfs_single_mark_inode_dirty - Mark a single, monolithic object inode dirty
+ * @inode: The inode to mark
+ *
+ * Mark an inode that contains a single, monolithic object as dirty so that its
+ * writepages op will get called.  If set, the SINGLE_NO_UPLOAD flag indicates
+ * that the object will only be written to the cache and not uploaded (e.g. AFS
+ * directory contents).
+ */
+void netfs_single_mark_inode_dirty(struct inode *inode)
+{
+	struct netfs_inode *ictx = netfs_inode(inode);
+	bool cache_only = test_bit(NETFS_ICTX_SINGLE_NO_UPLOAD, &ictx->flags);
+	bool caching = fscache_cookie_enabled(netfs_i_cookie(netfs_inode(inode)));
+
+	if (cache_only && !caching)
+		return;
+
+	mark_inode_dirty(inode);
+
+	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+		bool need_use = false;
+
+		spin_lock(&inode->i_lock);
+		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+			inode->i_state |= I_PINNING_NETFS_WB;
+			need_use = true;
+		}
+		spin_unlock(&inode->i_lock);
+
+		if (need_use)
+			fscache_use_cookie(netfs_i_cookie(ictx), true);
+	}
+
+}
+EXPORT_SYMBOL(netfs_single_mark_inode_dirty);
+
+static int netfs_single_begin_cache_read(struct netfs_io_request *rreq, struct netfs_inode *ctx)
+{
+	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
+}
+
+static void netfs_single_cache_prepare_read(struct netfs_io_request *rreq,
+					    struct netfs_io_subrequest *subreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	if (!cres->ops) {
+		subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
+		return;
+	}
+	subreq->source = cres->ops->prepare_read(subreq, rreq->i_size);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
+
+}
+
+static void netfs_single_read_cache(struct netfs_io_request *rreq,
+				    struct netfs_io_subrequest *subreq)
+{
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+	netfs_stat(&netfs_n_rh_read);
+	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_FAIL,
+			netfs_cache_read_terminated, subreq);
+}
+
+/*
+ * Perform a read to a buffer from the cache or the server.  Only a single
+ * subreq is permitted as the object must be fetched in a single transaction.
+ */
+static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	int ret = 0;
+
+	atomic_set(&rreq->nr_outstanding, 1);
+
+	subreq = netfs_alloc_subrequest(rreq);
+	if (!subreq) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
+	subreq->start	= 0;
+	subreq->len	= rreq->len;
+	subreq->io_iter	= rreq->buffer.iter;
+
+	atomic_inc(&rreq->nr_outstanding);
+
+	spin_lock_bh(&rreq->lock);
+	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
+	spin_unlock_bh(&rreq->lock);
+
+	netfs_single_cache_prepare_read(rreq, subreq);
+	switch (subreq->source) {
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		netfs_stat(&netfs_n_rh_download);
+		if (rreq->netfs_ops->prepare_read) {
+			ret = rreq->netfs_ops->prepare_read(subreq);
+			if (ret < 0)
+				goto cancel;
+		}
+
+		rreq->netfs_ops->issue_read(subreq);
+		rreq->submitted += subreq->len;
+		break;
+	case NETFS_READ_FROM_CACHE:
+		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+		netfs_single_read_cache(rreq, subreq);
+		rreq->submitted += subreq->len;
+		ret = 0;
+		break;
+	default:
+		pr_warn("Unexpected single-read source %u\n", subreq->source);
+		WARN_ON_ONCE(true);
+		ret = -EIO;
+		break;
+	}
+
+out:
+	if (atomic_dec_and_test(&rreq->nr_outstanding))
+		netfs_rreq_terminated(rreq);
+	return ret;
+cancel:
+	atomic_dec(&rreq->nr_outstanding);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+	goto out;
+}
+
+/**
+ * netfs_read_single - Synchronously read a single blob of pages.
+ * @inode: The inode to read from.
+ * @file: The file we're using to read or NULL.
+ * @iter: The buffer we're reading into.
+ *
+ * Fulfil a read request for a single monolithic object by drawing data from
+ * the cache if possible, or the netfs if not.  The buffer may be larger than
+ * the file content; unused beyond the EOF will be zero-filled.  The content
+ * will be read with a single I/O request (though this may be retried).
+ *
+ * The calling netfs must initialise a netfs context contiguous to the vfs
+ * inode before calling this.
+ *
+ * This is usable whether or not caching is enabled.  If caching is enabled,
+ * the data will be stored as a single object into the cache.
+ */
+ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_iter *iter)
+{
+	struct netfs_io_request *rreq;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	ssize_t ret;
+
+	rreq = netfs_alloc_request(inode->i_mapping, file, 0, iov_iter_count(iter),
+				   NETFS_READ_SINGLE);
+	if (IS_ERR(rreq))
+		return PTR_ERR(rreq);
+
+	ret = netfs_single_begin_cache_read(rreq, ictx);
+	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
+		goto cleanup_free;
+
+	netfs_stat(&netfs_n_rh_read_single);
+	trace_netfs_read(rreq, 0, rreq->len, netfs_read_trace_read_single);
+
+	rreq->buffer.iter = *iter;
+	netfs_single_dispatch_read(rreq);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
+	wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
+		    TASK_UNINTERRUPTIBLE);
+
+	ret = rreq->error;
+	if (ret == 0)
+		ret = rreq->transferred;
+	netfs_put_request(rreq, true, netfs_rreq_trace_put_return);
+	return ret;
+
+cleanup_free:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_read_single);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 8e63516b40f6..f1af344266cc 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -12,6 +12,7 @@
 atomic_t netfs_n_rh_dio_read;
 atomic_t netfs_n_rh_readahead;
 atomic_t netfs_n_rh_read_folio;
+atomic_t netfs_n_rh_read_single;
 atomic_t netfs_n_rh_rreq;
 atomic_t netfs_n_rh_sreq;
 atomic_t netfs_n_rh_download;
@@ -46,10 +47,11 @@ atomic_t netfs_n_folioq;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Reads  : DR=%u RA=%u RF=%u WB=%u WBZ=%u\n",
+	seq_printf(m, "Reads  : DR=%u RA=%u RF=%u RS=%u WB=%u WBZ=%u\n",
 		   atomic_read(&netfs_n_rh_dio_read),
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_read_folio),
+		   atomic_read(&netfs_n_rh_read_single),
 		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_write_zskip));
 	seq_printf(m, "Writes : BW=%u WT=%u DW=%u WP=%u 2C=%u\n",
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index f026cbc0e2fe..d54526d2e751 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -17,7 +17,7 @@
 #define HIT_PENDING		0x01	/* A front op was still pending */
 #define NEED_REASSESS		0x02	/* Need to loop round and reassess */
 #define MADE_PROGRESS		0x04	/* Made progress cleaning up a stream or the folio set */
-#define BUFFERED		0x08	/* The pagecache needs cleaning up */
+#define NEED_UNLOCK		0x08	/* The pagecache needs unlocking */
 #define NEED_RETRY		0x10	/* A front op requests retrying */
 #define SAW_FAILURE		0x20	/* One stream or hit a permanent failure */
 
@@ -179,7 +179,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	if (wreq->origin == NETFS_WRITEBACK ||
 	    wreq->origin == NETFS_WRITETHROUGH ||
 	    wreq->origin == NETFS_PGPRIV2_COPY_TO_CACHE)
-		notes = BUFFERED;
+		notes = NEED_UNLOCK;
 	else
 		notes = 0;
 
@@ -276,7 +276,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	trace_netfs_collect_state(wreq, wreq->collected_to, notes);
 
 	/* Unlock any folios that we have now finished with. */
-	if (notes & BUFFERED) {
+	if (notes & NEED_UNLOCK) {
 		if (wreq->cleaned_to < wreq->collected_to)
 			netfs_writeback_unlock_folios(wreq, &notes);
 	} else {
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 286bc2aa3ca0..6f14a7c2f040 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -94,9 +94,10 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 {
 	struct netfs_io_request *wreq;
 	struct netfs_inode *ictx;
-	bool is_buffered = (origin == NETFS_WRITEBACK ||
-			    origin == NETFS_WRITETHROUGH ||
-			    origin == NETFS_PGPRIV2_COPY_TO_CACHE);
+	bool is_cacheable = (origin == NETFS_WRITEBACK ||
+			     origin == NETFS_WRITEBACK_SINGLE ||
+			     origin == NETFS_WRITETHROUGH ||
+			     origin == NETFS_PGPRIV2_COPY_TO_CACHE);
 
 	wreq = netfs_alloc_request(mapping, file, start, 0, origin);
 	if (IS_ERR(wreq))
@@ -105,7 +106,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	_enter("R=%x", wreq->debug_id);
 
 	ictx = netfs_inode(wreq->inode);
-	if (is_buffered && netfs_is_cache_enabled(ictx))
+	if (is_cacheable && netfs_is_cache_enabled(ictx))
 		fscache_begin_write_operation(&wreq->cache_resources, netfs_i_cookie(ictx));
 	if (rolling_buffer_init(&wreq->buffer, wreq->debug_id, ITER_SOURCE) < 0)
 		goto nomem;
@@ -452,7 +453,8 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		stream = &wreq->io_streams[s];
 		stream->submit_off = foff;
 		stream->submit_len = flen;
-		if ((stream->source == NETFS_WRITE_TO_CACHE && streamw) ||
+		if (!stream->avail ||
+		    (stream->source == NETFS_WRITE_TO_CACHE && streamw) ||
 		    (stream->source == NETFS_UPLOAD_TO_SERVER &&
 		     fgroup == NETFS_FOLIO_COPY_TO_CACHE)) {
 			stream->submit_off = UINT_MAX;
@@ -731,3 +733,194 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 	_leave(" = %d", error);
 	return error;
 }
+
+/*
+ * Write some of a pending folio data back to the server and/or the cache.
+ */
+static int netfs_write_folio_single(struct netfs_io_request *wreq,
+				    struct folio *folio)
+{
+	struct netfs_io_stream *upload = &wreq->io_streams[0];
+	struct netfs_io_stream *cache  = &wreq->io_streams[1];
+	struct netfs_io_stream *stream;
+	size_t iter_off = 0;
+	size_t fsize = folio_size(folio), flen;
+	loff_t fpos = folio_pos(folio);
+	bool to_eof = false;
+	bool no_debug = false;
+
+	_enter("");
+
+	flen = folio_size(folio);
+	if (flen > wreq->i_size - fpos) {
+		flen = wreq->i_size - fpos;
+		folio_zero_segment(folio, flen, fsize);
+		to_eof = true;
+	} else if (flen == wreq->i_size - fpos) {
+		to_eof = true;
+	}
+
+	_debug("folio %zx/%zx", flen, fsize);
+
+	if (!upload->avail && !cache->avail) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		return 0;
+	}
+
+	if (!upload->construct)
+		trace_netfs_folio(folio, netfs_folio_trace_store);
+	else
+		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
+
+	/* Attach the folio to the rolling buffer. */
+	folio_get(folio);
+	rolling_buffer_append(&wreq->buffer, folio, NETFS_ROLLBUF_PUT_MARK);
+
+	/* Move the submission point forward to allow for write-streaming data
+	 * not starting at the front of the page.  We don't do write-streaming
+	 * with the cache as the cache requires DIO alignment.
+	 *
+	 * Also skip uploading for data that's been read and just needs copying
+	 * to the cache.
+	 */
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		stream = &wreq->io_streams[s];
+		stream->submit_off = 0;
+		stream->submit_len = flen;
+		if (!stream->avail) {
+			stream->submit_off = UINT_MAX;
+			stream->submit_len = 0;
+		}
+	}
+
+	/* Attach the folio to one or more subrequests.  For a big folio, we
+	 * could end up with thousands of subrequests if the wsize is small -
+	 * but we might need to wait during the creation of subrequests for
+	 * network resources (eg. SMB credits).
+	 */
+	for (;;) {
+		ssize_t part;
+		size_t lowest_off = ULONG_MAX;
+		int choose_s = -1;
+
+		/* Always add to the lowest-submitted stream first. */
+		for (int s = 0; s < NR_IO_STREAMS; s++) {
+			stream = &wreq->io_streams[s];
+			if (stream->submit_len > 0 &&
+			    stream->submit_off < lowest_off) {
+				lowest_off = stream->submit_off;
+				choose_s = s;
+			}
+		}
+
+		if (choose_s < 0)
+			break;
+		stream = &wreq->io_streams[choose_s];
+
+		/* Advance the iterator(s). */
+		if (stream->submit_off > iter_off) {
+			rolling_buffer_advance(&wreq->buffer, stream->submit_off - iter_off);
+			iter_off = stream->submit_off;
+		}
+
+		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
+		stream->submit_extendable_to = fsize - stream->submit_off;
+		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
+					   stream->submit_len, to_eof);
+		stream->submit_off += part;
+		if (part > stream->submit_len)
+			stream->submit_len = 0;
+		else
+			stream->submit_len -= part;
+		if (part > 0)
+			no_debug = true;
+	}
+
+	wreq->buffer.iter.iov_offset = 0;
+	if (fsize > iter_off)
+		rolling_buffer_advance(&wreq->buffer, fsize - iter_off);
+	atomic64_set(&wreq->issued_to, fpos + fsize);
+
+	if (!no_debug)
+		kdebug("R=%x: No submit", wreq->debug_id);
+	_leave(" = 0");
+	return 0;
+}
+
+/**
+ * netfs_writeback_single - Write back a monolithic payload
+ * @mapping: The mapping to write from
+ * @wbc: Hints from the VM
+ * @iter: Data to write, must be ITER_FOLIOQ.
+ *
+ * Write a monolithic, non-pagecache object back to the server and/or
+ * the cache.
+ */
+int netfs_writeback_single(struct address_space *mapping,
+			   struct writeback_control *wbc,
+			   struct iov_iter *iter)
+{
+	struct netfs_io_request *wreq;
+	struct netfs_inode *ictx = netfs_inode(mapping->host);
+	struct folio_queue *fq;
+	size_t size = iov_iter_count(iter);
+	int ret;
+
+	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
+		return -EIO;
+
+	if (!mutex_trylock(&ictx->wb_lock)) {
+		if (wbc->sync_mode == WB_SYNC_NONE) {
+			netfs_stat(&netfs_n_wb_lock_skip);
+			return 0;
+		}
+		netfs_stat(&netfs_n_wb_lock_wait);
+		mutex_lock(&ictx->wb_lock);
+	}
+
+	wreq = netfs_create_write_req(mapping, NULL, 0, NETFS_WRITEBACK_SINGLE);
+	if (IS_ERR(wreq)) {
+		ret = PTR_ERR(wreq);
+		goto couldnt_start;
+	}
+
+	trace_netfs_write(wreq, netfs_write_trace_writeback);
+	netfs_stat(&netfs_n_wh_writepages);
+
+	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+		wreq->netfs_ops->begin_writeback(wreq);
+
+	for (fq = (struct folio_queue *)iter->folioq; fq; fq = fq->next) {
+		for (int slot = 0; slot < folioq_count(fq); slot++) {
+			struct folio *folio = folioq_folio(fq, slot);
+			size_t part = umin(folioq_folio_size(fq, slot), size);
+
+			_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
+
+			ret = netfs_write_folio_single(wreq, folio);
+			if (ret < 0)
+				goto stop;
+			size -= part;
+			if (size <= 0)
+				goto stop;
+		}
+	}
+
+stop:
+	for (int s = 0; s < NR_IO_STREAMS; s++)
+		netfs_issue_write(wreq, &wreq->io_streams[s]);
+	smp_wmb(); /* Write lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+
+	mutex_unlock(&ictx->wb_lock);
+
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+	_leave(" = %d", ret);
+	return ret;
+
+couldnt_start:
+	mutex_unlock(&ictx->wb_lock);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_writeback_single);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index dd737344cff3..27e62f7d2940 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -73,6 +73,7 @@ struct netfs_inode {
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 #define NETFS_ICTX_MODIFIED_ATTR 3		/* Indicate change in mtime/ctime */
+#define NETFS_ICTX_SINGLE_NO_UPLOAD 4		/* Monolithic payload, cache but no upload */
 };
 
 /*
@@ -210,9 +211,11 @@ enum netfs_io_origin {
 	NETFS_READAHEAD,		/* This read was triggered by readahead */
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_GAPS,		/* This read is a synchronous read to fill gaps */
+	NETFS_READ_SINGLE,		/* This read should be treated as a single object */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_WRITEBACK_SINGLE,		/* This monolithic write was triggered by writepages */
 	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_WRITE,		/* This is a direct I/O write */
@@ -408,6 +411,13 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 					   struct netfs_group *netfs_group);
 ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
+/* Single, monolithic object read/write API. */
+void netfs_single_mark_inode_dirty(struct inode *inode);
+ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_iter *iter);
+int netfs_writeback_single(struct address_space *mapping,
+			   struct writeback_control *wbc,
+			   struct iov_iter *iter);
+
 /* Address operations API */
 struct readahead_control;
 void netfs_readahead(struct readahead_control *);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index fc237ff23a33..6df2e7313371 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -21,6 +21,7 @@
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
 	EM(netfs_read_trace_read_gaps,		"READ-GAPS")	\
+	EM(netfs_read_trace_read_single,	"READ-SNGL")	\
 	EM(netfs_read_trace_prefetch_for_write,	"PREFETCHW")	\
 	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
@@ -35,9 +36,11 @@
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_GAPS,			"RG")		\
+	EM(NETFS_READ_SINGLE,			"R1")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
+	EM(NETFS_WRITEBACK_SINGLE,		"W1")		\
 	EM(NETFS_WRITETHROUGH,			"WT")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_WRITE,			"DW")		\
@@ -47,6 +50,7 @@
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_collect,		"COLLECT")	\
+	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\



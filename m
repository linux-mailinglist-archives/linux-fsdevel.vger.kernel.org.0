Return-Path: <linux-fsdevel+bounces-5938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B1811718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C741B210BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EAE364C1;
	Wed, 13 Dec 2023 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik7yb84M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF36170B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIwLzDiZpaZMbFiReSwdjbMUxVWmR1x4Wpn5Zq569s4=;
	b=Ik7yb84M05D1Yn8iT7eD7MYZiKcK4RlEN9ff2dx4fL/PSFJ5YG/mpWJt9e/4DN+v/qBCpo
	oVwtAzk/sqMxRfREBUbXN386e05nBi3T4nxmGNMDka7zqW+uYTXTI13xWOK7M+5T1qg8BD
	rf6YB+tyG+vtXGqHUkfTXY5OeDiZHH8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-J6bMlVj2NQiuKCy5TuSEbg-1; Wed,
 13 Dec 2023 10:25:59 -0500
X-MC-Unique: J6bMlVj2NQiuKCy5TuSEbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDD7F1C18CCA;
	Wed, 13 Dec 2023 15:25:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 65E3440C6EB9;
	Wed, 13 Dec 2023 15:25:54 +0000 (UTC)
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
Subject: [PATCH v4 28/39] netfs: Implement support for unbuffered/DIO read
Date: Wed, 13 Dec 2023 15:23:38 +0000
Message-ID: <20231213152350.431591-29-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Implement support for unbuffered and DIO reads in the netfs library,
utilising the existing read helper code to do block splitting and
individual queuing.  The code also handles extraction of the destination
buffer from the supplied iterator, allowing async unbuffered reads to take
place.

The read will be split up according to the rsize setting and, if supplied,
the ->clamp_length() method.  Note that the next subrequest will be issued
as soon as issue_op returns, without waiting for previous ones to finish.
The network filesystem needs to pause or handle queuing them if it doesn't
want to fire them all at the server simultaneously.

Once all the subrequests have finished, the state will be assessed and the
amount of data to be indicated as having being obtained will be
determined.  As the subrequests may finish in any order, if an intermediate
subrequest is short, any further subrequests may be copied into the buffer
and then abandoned.

In the future, this will also take care of doing an unbuffered read from
encrypted content, with the decryption being done by the library.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/Makefile            |   1 +
 fs/netfs/direct_read.c       | 252 +++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |   1 +
 fs/netfs/io.c                |  82 ++++++++++--
 fs/netfs/main.c              |   1 +
 fs/netfs/objects.c           |   5 +-
 fs/netfs/stats.c             |   4 +-
 include/linux/netfs.h        |   9 ++
 include/trace/events/netfs.h |   7 +-
 mm/filemap.c                 |   1 +
 10 files changed, 352 insertions(+), 11 deletions(-)
 create mode 100644 fs/netfs/direct_read.c

diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 85d8333a1ed4..e968ab1eca40 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -3,6 +3,7 @@
 netfs-y := \
 	buffered_read.o \
 	buffered_write.o \
+	direct_read.o \
 	io.o \
 	iterator.o \
 	locking.o \
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
new file mode 100644
index 000000000000..1d26468aafd9
--- /dev/null
+++ b/fs/netfs/direct_read.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Direct I/O support.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
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
+/*
+ * Copy all of the data from the folios in the source xarray into the
+ * destination iterator.  We cannot step through and kmap the dest iterator if
+ * it's an iovec, so we have to step through the xarray and drop the RCU lock
+ * each time.
+ */
+static int netfs_copy_xarray_to_iter(struct netfs_io_request *rreq,
+				     struct xarray *xa, struct iov_iter *dst,
+				     unsigned long long start, size_t avail)
+{
+	struct folio *folio;
+	void *base;
+	pgoff_t index = start / PAGE_SIZE;
+	size_t len, copied, count = min(avail, iov_iter_count(dst));
+
+	XA_STATE(xas, xa, index);
+
+	_enter("%zx", count);
+
+	if (!count) {
+		trace_netfs_failure(rreq, NULL, -EIO, netfs_fail_dio_read_zero);
+		return -EIO;
+	}
+
+	len = PAGE_SIZE - offset_in_page(start);
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t offset;
+
+		if (xas_retry(&xas, folio))
+			continue;
+
+		/* There shouldn't be a need to call xas_pause() as no one else
+		 * should be modifying the xarray we're iterating over.
+		 * Really, we only need the RCU readlock to keep lockdep happy
+		 * inside xas_for_each().
+		 */
+		rcu_read_unlock();
+
+		offset = offset_in_folio(folio, start);
+		kdebug("folio %lx +%zx [%llx]", folio->index, offset, start);
+
+		while (offset < folio_size(folio)) {
+			len = min(count, len);
+
+			base = kmap_local_folio(folio, offset);
+			copied = copy_to_iter(base, len, dst);
+			kunmap_local(base);
+			if (copied != len)
+				goto out;
+			count -= len;
+			if (count == 0)
+				goto out;
+
+			start += len;
+			offset += len;
+			len = PAGE_SIZE;
+		}
+
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
+out:
+	_leave(" = %zx", count);
+	return count ? -EFAULT : 0;
+}
+
+/*
+ * If we did a direct read to a bounce buffer (say we needed to decrypt it),
+ * copy the data obtained to the destination iterator.
+ */
+static int netfs_dio_copy_bounce_to_dest(struct netfs_io_request *rreq)
+{
+	struct iov_iter *dest_iter = &rreq->iter;
+	struct kiocb *iocb = rreq->iocb;
+	unsigned long long start = rreq->start;
+
+	_enter("%zx/%zx @%llx", rreq->transferred, rreq->len, start);
+
+	if (!test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags))
+		return 0;
+
+	if (start < iocb->ki_pos) {
+		if (rreq->transferred <= iocb->ki_pos - start) {
+			trace_netfs_failure(rreq, NULL, -EIO, netfs_fail_dio_read_short);
+			return -EIO;
+		}
+		rreq->len = rreq->transferred;
+		rreq->transferred -= iocb->ki_pos - start;
+	}
+
+	if (rreq->transferred > iov_iter_count(dest_iter))
+		rreq->transferred = iov_iter_count(dest_iter);
+
+	_debug("xfer %zx/%zx @%llx", rreq->transferred, rreq->len, iocb->ki_pos);
+	return netfs_copy_xarray_to_iter(rreq, &rreq->bounce, dest_iter,
+					 iocb->ki_pos, rreq->transferred);
+}
+
+/**
+ * netfs_unbuffered_read_iter_locked - Perform an unbuffered or direct I/O read
+ * @iocb: The I/O control descriptor describing the read
+ * @iter: The output buffer (also specifies read length)
+ *
+ * Perform an unbuffered I/O or direct I/O from the file in @iocb to the
+ * output buffer.  No use is made of the pagecache.
+ *
+ * The caller must hold any appropriate locks.
+ */
+static ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct netfs_io_request *rreq;
+	struct netfs_inode *ctx;
+	unsigned long long start, end;
+	unsigned int min_bsize;
+	pgoff_t first, last;
+	ssize_t ret;
+	size_t orig_count = iov_iter_count(iter);
+	bool async = !is_sync_kiocb(iocb);
+
+	_enter("");
+
+	if (!orig_count)
+		return 0; /* Don't update atime */
+
+	ret = kiocb_write_and_wait(iocb, orig_count);
+	if (ret < 0)
+		return ret;
+	file_accessed(iocb->ki_filp);
+
+	rreq = netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
+				   iocb->ki_pos, orig_count,
+				   NETFS_DIO_READ);
+	if (IS_ERR(rreq))
+		return PTR_ERR(rreq);
+
+	ctx = netfs_inode(rreq->inode);
+	netfs_stat(&netfs_n_rh_dio_read);
+	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_dio_read);
+
+	/* If this is an async op, we have to keep track of the destination
+	 * buffer for ourselves as the caller's iterator will be trashed when
+	 * we return.
+	 *
+	 * In such a case, extract an iterator to represent as much of the the
+	 * output buffer as we can manage.  Note that the extraction might not
+	 * be able to allocate a sufficiently large bvec array and may shorten
+	 * the request.
+	 */
+	if (user_backed_iter(iter)) {
+		ret = netfs_extract_user_iter(iter, rreq->len, &rreq->iter, 0);
+		if (ret < 0)
+			goto out;
+		rreq->direct_bv = (struct bio_vec *)rreq->iter.bvec;
+		rreq->direct_bv_count = ret;
+		rreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
+		rreq->len = iov_iter_count(&rreq->iter);
+	} else {
+		rreq->iter = *iter;
+		rreq->len = orig_count;
+		rreq->direct_bv_unpin = false;
+		iov_iter_advance(iter, orig_count);
+	}
+
+	/* If we're going to use a bounce buffer, we need to set it up.  We
+	 * will then need to pad the request out to the minimum block size.
+	 */
+	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags)) {
+		start = rreq->start;
+		end = min_t(unsigned long long,
+			    round_up(rreq->start + rreq->len, min_bsize),
+			    ctx->remote_i_size);
+
+		rreq->start = start;
+		rreq->len   = end - start;
+		first = start / PAGE_SIZE;
+		last  = (end - 1) / PAGE_SIZE;
+		_debug("bounce %llx-%llx %lx-%lx",
+		       rreq->start, end, first, last);
+
+		ret = netfs_add_folios_to_buffer(&rreq->bounce, rreq->mapping,
+						 first, last, GFP_KERNEL);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (async)
+		rreq->iocb = iocb;
+
+	ret = netfs_begin_read(rreq, is_sync_kiocb(iocb));
+	if (ret < 0)
+		goto out; /* May be -EIOCBQUEUED */
+	if (!async) {
+		ret = netfs_dio_copy_bounce_to_dest(rreq);
+		if (ret == 0) {
+			iocb->ki_pos += rreq->transferred;
+			ret = rreq->transferred;
+		}
+	}
+
+out:
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
+	if (ret > 0)
+		orig_count -= ret;
+	if (ret != -EIOCBQUEUED)
+		iov_iter_revert(iter, orig_count - iov_iter_count(iter));
+	return ret;
+}
+
+/**
+ * netfs_unbuffered_read_iter - Perform an unbuffered or direct I/O read
+ * @iocb: The I/O control descriptor describing the read
+ * @iter: The output buffer (also specifies read length)
+ *
+ * Perform an unbuffered I/O or direct I/O from the file in @iocb to the
+ * output buffer.  No use is made of the pagecache.
+ */
+ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (!iter->count)
+		return 0; /* Don't update atime */
+
+	ret = netfs_start_io_direct(inode);
+	if (ret == 0) {
+		ret = netfs_unbuffered_read_iter_locked(iocb, iter);
+		netfs_end_io_direct(inode);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(netfs_unbuffered_read_iter);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 62c349cc71f9..5bb1cdbdee0e 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -100,6 +100,7 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
  * stats.c
  */
 #ifdef CONFIG_NETFS_STATS
+extern atomic_t netfs_n_rh_dio_read;
 extern atomic_t netfs_n_rh_readahead;
 extern atomic_t netfs_n_rh_readpage;
 extern atomic_t netfs_n_rh_rreq;
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 776ca0aa6b62..e017dc735cdb 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -78,7 +78,9 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
 				   struct netfs_io_subrequest *subreq)
 {
 	netfs_stat(&netfs_n_rh_download);
-	if (iov_iter_count(&subreq->io_iter) != subreq->len - subreq->transferred)
+
+	if (rreq->origin != NETFS_DIO_READ &&
+	    iov_iter_count(&subreq->io_iter) != subreq->len - subreq->transferred)
 		pr_warn("R=%08x[%u] ITER PRE-MISMATCH %zx != %zx-%zx %lx\n",
 			rreq->debug_id, subreq->debug_index,
 			iov_iter_count(&subreq->io_iter), subreq->len,
@@ -341,6 +343,43 @@ static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
 	}
 }
 
+/*
+ * Determine how much we can admit to having read from a DIO read.
+ */
+static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	unsigned int i;
+	size_t transferred = 0;
+
+	for (i = 0; i < rreq->direct_bv_count; i++)
+		flush_dcache_page(rreq->direct_bv[i].bv_page);
+
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		if (subreq->error || subreq->transferred == 0)
+			break;
+		transferred += subreq->transferred;
+		if (subreq->transferred < subreq->len)
+			break;
+	}
+
+	for (i = 0; i < rreq->direct_bv_count; i++)
+		flush_dcache_page(rreq->direct_bv[i].bv_page);
+
+	rreq->transferred = transferred;
+	task_io_account_read(transferred);
+
+	if (rreq->iocb) {
+		rreq->iocb->ki_pos += transferred;
+		if (rreq->iocb->ki_complete)
+			rreq->iocb->ki_complete(
+				rreq->iocb, rreq->error ? rreq->error : transferred);
+	}
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+	inode_dio_end(rreq->inode);
+}
+
 /*
  * Assess the state of a read request and decide what to do next.
  *
@@ -361,7 +400,10 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
 		return;
 	}
 
-	netfs_rreq_unlock_folios(rreq);
+	if (rreq->origin != NETFS_DIO_READ)
+		netfs_rreq_unlock_folios(rreq);
+	else
+		netfs_rreq_assess_dio(rreq);
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
@@ -526,14 +568,16 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 			struct netfs_io_subrequest *subreq,
 			struct iov_iter *io_iter)
 {
-	enum netfs_io_source source;
+	enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
 	size_t lsize;
 
 	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
 
-	source = netfs_cache_prepare_read(subreq, rreq->i_size);
-	if (source == NETFS_INVALID_READ)
-		goto out;
+	if (rreq->origin != NETFS_DIO_READ) {
+		source = netfs_cache_prepare_read(subreq, rreq->i_size);
+		if (source == NETFS_INVALID_READ)
+			goto out;
+	}
 
 	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
 		/* Call out to the netfs to let it shrink the request to fit
@@ -544,6 +588,8 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 		 */
 		if (subreq->len > rreq->i_size - subreq->start)
 			subreq->len = rreq->i_size - subreq->start;
+		if (rreq->rsize && subreq->len > rreq->rsize)
+			subreq->len = rreq->rsize;
 
 		if (rreq->netfs_ops->clamp_length &&
 		    !rreq->netfs_ops->clamp_length(subreq)) {
@@ -662,6 +708,9 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 		return -EIO;
 	}
 
+	if (rreq->origin == NETFS_DIO_READ)
+		inode_dio_begin(rreq->inode);
+
 	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags))
 		iov_iter_xarray(&rreq->io_iter, ITER_DEST, &rreq->bounce,
 				rreq->start, rreq->len);
@@ -677,11 +726,25 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	atomic_set(&rreq->nr_outstanding, 1);
 	io_iter = rreq->io_iter;
 	do {
+		_debug("submit %llx + %zx >= %llx",
+		       rreq->start, rreq->submitted, rreq->i_size);
+		if (rreq->origin == NETFS_DIO_READ &&
+		    rreq->start + rreq->submitted >= rreq->i_size)
+			break;
 		if (!netfs_rreq_submit_slice(rreq, &io_iter, &debug_index))
 			break;
+		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
+		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
+			break;
 
 	} while (rreq->submitted < rreq->len);
 
+	if (!rreq->submitted) {
+		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
+		ret = 0;
+		goto out;
+	}
+
 	if (sync) {
 		/* Keep nr_outstanding incremented so that the ref always
 		 * belongs to us, and the service code isn't punted off to a
@@ -698,7 +761,8 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 			    TASK_UNINTERRUPTIBLE);
 
 		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len) {
+		if (ret == 0 && rreq->submitted < rreq->len &&
+		    rreq->origin != NETFS_DIO_READ) {
 			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
 			ret = -EIO;
 		}
@@ -706,7 +770,9 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
 		if (atomic_dec_and_test(&rreq->nr_outstanding))
 			netfs_rreq_assess(rreq, false);
-		ret = 0;
+		ret = -EIOCBQUEUED;
 	}
+
+out:
 	return ret;
 }
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 6584eafda944..d4430b51b03c 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READPAGE]	= "RP",
 	[NETFS_READ_FOR_WRITE]	= "RW",
 	[NETFS_WRITEBACK]	= "WB",
+	[NETFS_DIO_READ]	= "DR",
 };
 
 /*
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 3ce6313cc5f9..d46e957812a6 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -20,7 +20,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	struct inode *inode = file ? file_inode(file) : mapping->host;
 	struct netfs_inode *ctx = netfs_inode(inode);
 	struct netfs_io_request *rreq;
-	bool cached = netfs_is_cache_enabled(ctx);
+	bool is_dio = (origin == NETFS_DIO_READ);
+	bool cached = is_dio && netfs_is_cache_enabled(ctx);
 	int ret;
 
 	rreq = kzalloc(ctx->ops->io_request_size ?: sizeof(struct netfs_io_request),
@@ -43,6 +44,8 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (cached)
 		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+	if (file && file->f_flags & O_NONBLOCK)
+		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
 	if (rreq->netfs_ops->init_request) {
 		ret = rreq->netfs_ops->init_request(rreq, file);
 		if (ret < 0) {
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index c1f85cd595a4..15fd5c3f0f39 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -9,6 +9,7 @@
 #include <linux/seq_file.h>
 #include "internal.h"
 
+atomic_t netfs_n_rh_dio_read;
 atomic_t netfs_n_rh_readahead;
 atomic_t netfs_n_rh_readpage;
 atomic_t netfs_n_rh_rreq;
@@ -36,7 +37,8 @@ atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Netfs  : RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
+	seq_printf(m, "Netfs  : DR=%u RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
+		   atomic_read(&netfs_n_rh_dio_read),
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_readpage),
 		   atomic_read(&netfs_n_rh_write_begin),
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 63258998defb..da391f8c81c7 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -226,6 +226,7 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_DIO_READ,			/* This is a direct I/O read */
 	nr__netfs_io_origin
 } __mode(byte);
 
@@ -240,6 +241,7 @@ struct netfs_io_request {
 	};
 	struct inode		*inode;		/* The file being accessed */
 	struct address_space	*mapping;	/* The mapping being accessed */
+	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
 	struct list_head	subrequests;	/* Contributory I/O operations */
@@ -251,12 +253,14 @@ struct netfs_io_request {
 	__counted_by(direct_bv_count);
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
+	unsigned int		rsize;		/* Maximum read size (0 for none) */
 	unsigned int		wsize;		/* Maximum write size (0 for none) */
 	unsigned int		subreq_counter;	/* Next subreq->debug_index */
 	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
 	size_t			len;		/* Length of the request */
+	size_t			transferred;	/* Amount to be indicated as transferred */
 	short			error;		/* 0 or error that occurred */
 	enum netfs_io_origin	origin;		/* Origin of the request */
 	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
@@ -274,6 +278,8 @@ struct netfs_io_request {
 #define NETFS_RREQ_USE_BOUNCE_BUFFER	6	/* Use bounce buffer */
 #define NETFS_RREQ_WRITE_TO_CACHE	7	/* Need to write to the cache */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
+#define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
+#define NETFS_RREQ_BLOCKED		10	/* We blocked */
 	const struct netfs_request_ops *netfs_ops;
 	void (*cleanup)(struct netfs_io_request *req);
 };
@@ -370,6 +376,9 @@ struct netfs_cache_ops {
 			       loff_t *_data_start, size_t *_data_len);
 };
 
+/* High-level read API. */
+ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+
 /* High-level write API */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			    struct netfs_group *netfs_group);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 082a5e717b58..5a4edadf0e59 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -16,6 +16,7 @@
  * Define enums for tracing information.
  */
 #define netfs_read_traces					\
+	EM(netfs_read_trace_dio_read,		"DIO-READ ")	\
 	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
 	EM(netfs_read_trace_readpage,		"READPAGE ")	\
@@ -31,7 +32,8 @@
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
-	E_(NETFS_WRITEBACK,			"WB")
+	EM(NETFS_WRITEBACK,			"WB")		\
+	E_(NETFS_DIO_READ,			"DR")
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
@@ -70,6 +72,8 @@
 #define netfs_failures							\
 	EM(netfs_fail_check_write_begin,	"check-write-begin")	\
 	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
+	EM(netfs_fail_dio_read_short,		"dio-read-short")	\
+	EM(netfs_fail_dio_read_zero,		"dio-read-zero")	\
 	EM(netfs_fail_read,			"read")			\
 	EM(netfs_fail_short_read,		"short-read")		\
 	EM(netfs_fail_prepare_write,		"prep-write")		\
@@ -81,6 +85,7 @@
 	EM(netfs_rreq_trace_put_complete,	"PUT COMPLT ")	\
 	EM(netfs_rreq_trace_put_discard,	"PUT DISCARD")	\
 	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
+	EM(netfs_rreq_trace_put_no_submit,	"PUT NO-SUBM")	\
 	EM(netfs_rreq_trace_put_return,		"PUT RETURN ")	\
 	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
 	EM(netfs_rreq_trace_put_work,		"PUT WORK   ")	\
diff --git a/mm/filemap.c b/mm/filemap.c
index c0d7e1d7eea2..85a8eb23cfd2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2678,6 +2678,7 @@ int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
 
 	return filemap_write_and_wait_range(mapping, pos, end);
 }
+EXPORT_SYMBOL_GPL(kiocb_write_and_wait);
 
 int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
 {



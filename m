Return-Path: <linux-fsdevel+bounces-79378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCLqLfE7qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:04:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57210200EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C19213054AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF91374179;
	Wed,  4 Mar 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4L8ihjB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226F3A2555
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633043; cv=none; b=LUU5QpsMaD8sf7qLQbz/E3hG12Ixwjj5UMZih572NcZRyF4BpCqA0wJ9+7RvKqgGfFK5vyiGAqY0CHDY9TEE+WhcYiMFbCXDCrbFJ1zNMvxKYrYcp9YvsywrF/LhEBecqahIIBvZDLIrS3fwpaqf5dRBHpK0PQ8l8S+MNy7HvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633043; c=relaxed/simple;
	bh=zI3HWv6KcbFLTDF6/8ZbZ2gwfLn6Sw9GxZLiQf9CMlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUnHLxUsS89U8p4I3JvEgzXjIhPc2Syp3J4Z4B6CmyBdYzZGqs21npB0pFY/LsJnNylkg4jvk4ag3DjVIMB2L7LjlYahMrC+uJTEWjeWpZ6l6Fw79uGgHwfKohPPkJvO3Zm9VLZOkok0wb/yn5/ReCinXcmLs0hKeUeCbwmmO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4L8ihjB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYzpeyaxRRvfWXUR81PC971aeobf+q73Avt5gda2sjI=;
	b=I4L8ihjBoh+m+3aURc/aygn85yXH8oxGBnpyYY2+5u/H1P/Z9j9ZaCwpE0h13bH/Z9TsDa
	MnvrN6GFidjV0e2ZDzItIO3Vs9Xy4s24TeWnVuZ86ngUE4buVkooLzBwRsbhr9Yh+/pSaV
	5j5Exprlz9wqinsGVR1k7Zro3bf+1Uw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-arOpn1uFN3S9BSjGYhzQ5Q-1; Wed,
 04 Mar 2026 09:03:55 -0500
X-MC-Unique: arOpn1uFN3S9BSjGYhzQ5Q-1
X-Mimecast-MFC-AGG-ID: arOpn1uFN3S9BSjGYhzQ5Q_1772633033
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAFAC19300DE;
	Wed,  4 Mar 2026 14:03:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A7CF195419A;
	Wed,  4 Mar 2026 14:03:40 +0000 (UTC)
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
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>
Subject: [RFC PATCH 01/17] netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence
Date: Wed,  4 Mar 2026 14:03:08 +0000
Message-ID: <20260304140328.112636-2-dhowells@redhat.com>
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
X-Rspamd-Queue-Id: 57210200EE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79378-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Fix netfslib such that when it's making an unbuffered or DIO write, to make
sure that it sends each subrequest strictly sequentially, waiting till the
previous one is 'committed' before sending the next so that we don't have
pieces landing out of order and potentially leaving a hole if an error
occurs (ENOSPC for example).

This is done by copying in just those bits of issuing, collecting and
retrying subrequests that are necessary to do one subrequest at a time.
Retrying, in particular, is simpler because if the current subrequest needs
retrying, the source iterator can just be copied again and the subrequest
prepped and issued again without needing to be concerned about whether it
needs merging with the previous or next in the sequence.

Note that the issuing loop waits for a subrequest to complete right after
issuing it, but this wait could be moved elsewhere allowing preparatory
steps to be performed whilst the subrequest is in progress.  In particular,
once content encryption is available in netfslib, that could be done whilst
waiting, as could cleanup of buffers that have been completed.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c      | 228 ++++++++++++++++++++++++++++++++---
 fs/netfs/internal.h          |   4 +-
 fs/netfs/write_collect.c     |  21 ----
 fs/netfs/write_issue.c       |  41 +------
 include/trace/events/netfs.h |   4 +-
 5 files changed, 221 insertions(+), 77 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a9d1c3b2c084..dd1451bf7543 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,6 +9,202 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+/*
+ * Perform the cleanup rituals after an unbuffered write is complete.
+ */
+static void netfs_unbuffered_write_done(struct netfs_io_request *wreq)
+{
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+
+	_enter("R=%x", wreq->debug_id);
+
+	/* Okay, declare that all I/O is complete. */
+	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
+
+	if (!wreq->error)
+		netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferred);
+
+	if (wreq->origin == NETFS_DIO_WRITE &&
+	    wreq->mapping->nrpages) {
+		/* mmap may have got underfoot and we may now have folios
+		 * locally covering the region we just wrote.  Attempt to
+		 * discard the folios, but leave in place any modified locally.
+		 * ->write_iter() is prevented from interfering by the DIO
+		 * counter.
+		 */
+		pgoff_t first = wreq->start >> PAGE_SHIFT;
+		pgoff_t last = (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
+
+		invalidate_inode_pages2_range(wreq->mapping, first, last);
+	}
+
+	if (wreq->origin == NETFS_DIO_WRITE)
+		inode_dio_end(wreq->inode);
+
+	_debug("finished");
+	netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake_ip);
+	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
+
+	if (wreq->iocb) {
+		size_t written = umin(wreq->transferred, wreq->len);
+
+		wreq->iocb->ki_pos += written;
+		if (wreq->iocb->ki_complete) {
+			trace_netfs_rreq(wreq, netfs_rreq_trace_ki_complete);
+			wreq->iocb->ki_complete(wreq->iocb, wreq->error ?: written);
+		}
+		wreq->iocb = VFS_PTR_POISON;
+	}
+
+	netfs_clear_subrequests(wreq);
+}
+
+/*
+ * Collect the subrequest results of unbuffered write subrequests.
+ */
+static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
+					   struct netfs_io_stream *stream,
+					   struct netfs_io_subrequest *subreq)
+{
+	trace_netfs_collect_sreq(wreq, subreq);
+
+	spin_lock(&wreq->lock);
+	list_del_init(&subreq->rreq_link);
+	spin_unlock(&wreq->lock);
+
+	wreq->transferred += subreq->transferred;
+	iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+	stream->collected_to = subreq->start + subreq->transferred;
+	wreq->collected_to = stream->collected_to;
+	netfs_put_subrequest(subreq, netfs_sreq_trace_put_done);
+
+	trace_netfs_collect_stream(wreq, stream);
+	trace_netfs_collect_state(wreq, wreq->collected_to, 0);
+}
+
+/*
+ * Write data to the server without going through the pagecache and without
+ * writing it to the local cache.  We dispatch the subrequests serially and
+ * wait for each to complete before dispatching the next, lest we leave a gap
+ * in the data written due to a failure such as ENOSPC.  We could, however
+ * attempt to do preparation such as content encryption for the next subreq
+ * whilst the current is in progress.
+ */
+static int netfs_unbuffered_write(struct netfs_io_request *wreq)
+{
+	struct netfs_io_subrequest *subreq = NULL;
+	struct netfs_io_stream *stream = &wreq->io_streams[0];
+	int ret;
+
+	_enter("%llx", wreq->len);
+
+	if (wreq->origin == NETFS_DIO_WRITE)
+		inode_dio_begin(wreq->inode);
+
+	stream->collected_to = wreq->start;
+
+	for (;;) {
+		bool retry = false;
+
+		if (!subreq) {
+			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
+			subreq = stream->construct;
+			stream->construct = NULL;
+			stream->front = NULL;
+		}
+
+		/* Check if (re-)preparation failed. */
+		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
+			netfs_write_subrequest_terminated(subreq, subreq->error);
+			wreq->error = subreq->error;
+			break;
+		}
+
+		iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
+		if (!iov_iter_count(&subreq->io_iter))
+			break;
+
+		subreq->len = netfs_limit_iter(&subreq->io_iter, 0,
+					       stream->sreq_max_len,
+					       stream->sreq_max_segs);
+		iov_iter_truncate(&subreq->io_iter, subreq->len);
+		stream->submit_extendable_to = subreq->len;
+
+		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+		stream->issue_write(subreq);
+
+		/* Async, need to wait. */
+		netfs_wait_for_in_progress_stream(wreq, stream);
+
+		if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+			retry = true;
+		} else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
+			ret = subreq->error;
+			wreq->error = ret;
+			netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
+			subreq = NULL;
+			break;
+		}
+		ret = 0;
+
+		if (!retry) {
+			netfs_unbuffered_write_collect(wreq, stream, subreq);
+			subreq = NULL;
+			if (wreq->transferred >= wreq->len)
+				break;
+			if (!wreq->iocb && signal_pending(current)) {
+				ret = wreq->transferred ? -EINTR : -ERESTARTSYS;
+				trace_netfs_rreq(wreq, netfs_rreq_trace_intr);
+				break;
+			}
+			continue;
+		}
+
+		/* We need to retry the last subrequest, so first reset the
+		 * iterator, taking into account what, if anything, we managed
+		 * to transfer.
+		 */
+		subreq->error = -EAGAIN;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+		if (subreq->transferred > 0)
+			iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+		if (stream->source == NETFS_UPLOAD_TO_SERVER &&
+		    wreq->netfs_ops->retry_request)
+			wreq->netfs_ops->retry_request(wreq, stream);
+
+		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+		subreq->io_iter		= wreq->buffer.iter;
+		subreq->start		= wreq->start + wreq->transferred;
+		subreq->len		= wreq->len   - wreq->transferred;
+		subreq->transferred	= 0;
+		subreq->retry_count	+= 1;
+		stream->sreq_max_len	= UINT_MAX;
+		stream->sreq_max_segs	= INT_MAX;
+
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+		stream->prepare_write(subreq);
+
+		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+		netfs_stat(&netfs_n_wh_retry_write_subreq);
+	}
+
+	netfs_unbuffered_write_done(wreq);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+static void netfs_unbuffered_write_async(struct work_struct *work)
+{
+	struct netfs_io_request *wreq = container_of(work, struct netfs_io_request, work);
+
+	netfs_unbuffered_write(wreq);
+	netfs_put_request(wreq, netfs_rreq_trace_put_complete);
+}
+
 /*
  * Perform an unbuffered write where we may have to do an RMW operation on an
  * encrypted file.  This can also be used for direct I/O writes.
@@ -70,35 +266,35 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 			 */
 			wreq->buffer.iter = *iter;
 		}
+
+		wreq->len = iov_iter_count(&wreq->buffer.iter);
 	}
 
 	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
-	if (async)
-		__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 
 	/* Copy the data into the bounce buffer and encrypt it. */
 	// TODO
 
 	/* Dispatch the write. */
 	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-	if (async)
-		wreq->iocb = iocb;
-	wreq->len = iov_iter_count(&wreq->buffer.iter);
-	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
-	if (ret < 0) {
-		_debug("begin = %zd", ret);
-		goto out;
-	}
 
-	if (!async) {
-		ret = netfs_wait_for_write(wreq);
-		if (ret > 0)
-			iocb->ki_pos += ret;
-	} else {
+	if (async) {
+		INIT_WORK(&wreq->work, netfs_unbuffered_write_async);
+		wreq->iocb = iocb;
+		queue_work(system_dfl_wq, &wreq->work);
 		ret = -EIOCBQUEUED;
+	} else {
+		ret = netfs_unbuffered_write(wreq);
+		if (ret < 0) {
+			_debug("begin = %zd", ret);
+		} else {
+			iocb->ki_pos += wreq->transferred;
+			ret = wreq->transferred ?: wreq->error;
+		}
+
+		netfs_put_request(wreq, netfs_rreq_trace_put_complete);
 	}
 
-out:
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	return ret;
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 4319611f5354..d436e20d3418 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -198,6 +198,9 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						struct file *file,
 						loff_t start,
 						enum netfs_io_origin origin);
+void netfs_prepare_write(struct netfs_io_request *wreq,
+			 struct netfs_io_stream *stream,
+			 loff_t start);
 void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source);
@@ -212,7 +215,6 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio **writethrough_cache);
 ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *writethrough_cache);
-int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t len);
 
 /*
  * write_retry.c
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 61eab34ea67e..83eb3dc1adf8 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -399,27 +399,6 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 		ictx->ops->invalidate_cache(wreq);
 	}
 
-	if ((wreq->origin == NETFS_UNBUFFERED_WRITE ||
-	     wreq->origin == NETFS_DIO_WRITE) &&
-	    !wreq->error)
-		netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferred);
-
-	if (wreq->origin == NETFS_DIO_WRITE &&
-	    wreq->mapping->nrpages) {
-		/* mmap may have got underfoot and we may now have folios
-		 * locally covering the region we just wrote.  Attempt to
-		 * discard the folios, but leave in place any modified locally.
-		 * ->write_iter() is prevented from interfering by the DIO
-		 * counter.
-		 */
-		pgoff_t first = wreq->start >> PAGE_SHIFT;
-		pgoff_t last = (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
-		invalidate_inode_pages2_range(wreq->mapping, first, last);
-	}
-
-	if (wreq->origin == NETFS_DIO_WRITE)
-		inode_dio_end(wreq->inode);
-
 	_debug("finished");
 	netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake_ip);
 	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 34894da5a23e..437268f65640 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -154,9 +154,9 @@ EXPORT_SYMBOL(netfs_prepare_write_failed);
  * Prepare a write subrequest.  We need to allocate a new subrequest
  * if we don't have one.
  */
-static void netfs_prepare_write(struct netfs_io_request *wreq,
-				struct netfs_io_stream *stream,
-				loff_t start)
+void netfs_prepare_write(struct netfs_io_request *wreq,
+			 struct netfs_io_stream *stream,
+			 loff_t start)
 {
 	struct netfs_io_subrequest *subreq;
 	struct iov_iter *wreq_iter = &wreq->buffer.iter;
@@ -698,41 +698,6 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
 	return ret;
 }
 
-/*
- * Write data to the server without going through the pagecache and without
- * writing it to the local cache.
- */
-int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t len)
-{
-	struct netfs_io_stream *upload = &wreq->io_streams[0];
-	ssize_t part;
-	loff_t start = wreq->start;
-	int error = 0;
-
-	_enter("%zx", len);
-
-	if (wreq->origin == NETFS_DIO_WRITE)
-		inode_dio_begin(wreq->inode);
-
-	while (len) {
-		// TODO: Prepare content encryption
-
-		_debug("unbuffered %zx", len);
-		part = netfs_advance_write(wreq, upload, start, len, false);
-		start += part;
-		len -= part;
-		rolling_buffer_advance(&wreq->buffer, part);
-		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags))
-			netfs_wait_for_paused_write(wreq);
-		if (test_bit(NETFS_RREQ_FAILED, &wreq->flags))
-			break;
-	}
-
-	netfs_end_issue_write(wreq);
-	_leave(" = %d", error);
-	return error;
-}
-
 /*
  * Write some of a pending folio data back to the server and/or the cache.
  */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 64a382fbc31a..2d366be46a1c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -57,6 +57,7 @@
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_end_copy_to_cache,	"END-C2C")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
+	EM(netfs_rreq_trace_intr,		"INTR   ")	\
 	EM(netfs_rreq_trace_ki_complete,	"KI-CMPL")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
@@ -169,7 +170,8 @@
 	EM(netfs_sreq_trace_put_oom,		"PUT OOM    ")	\
 	EM(netfs_sreq_trace_put_wip,		"PUT WIP    ")	\
 	EM(netfs_sreq_trace_put_work,		"PUT WORK   ")	\
-	E_(netfs_sreq_trace_put_terminated,	"PUT TERM   ")
+	EM(netfs_sreq_trace_put_terminated,	"PUT TERM   ")	\
+	E_(netfs_sreq_trace_see_failed,		"SEE FAILED ")
 
 #define netfs_folio_traces					\
 	EM(netfs_folio_is_uptodate,		"mod-uptodate")	\



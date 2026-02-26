Return-Path: <linux-fsdevel+bounces-78481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKpBGo1LoGnvhwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:33:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F041A69CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2C6530071D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50C362125;
	Thu, 26 Feb 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjI6fGhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F0361DCB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112774; cv=none; b=hzYZH/yMC/C2Bi9Lqt5ttrnvU33YPSsEdX56M8V0NlUoxw5wmoMAcQB6HKipAzeiookph8Rkhyt8dyhaRSkzHOfpvNlnwHkM17Q2r1NCn2O5PhuqSppjdCQQkI849XK5jqzGlbigV9BCR5DPBSXoUEzL6ab5QBH6oLd2KqKY/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112774; c=relaxed/simple;
	bh=X5lyn+V9XuiSm3igKhJmE6Do5D0oMk+hXcsZ5DN2xk4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=tvFNKt0d4CR5sCo16vr2PNbRX7j88EOQ2Ruae2SGjM9KTSpxgQFGOPPtH3nIogTlmtX5OcLIYVbgGZaZxdrI7YJsTt4ks1pnouuM9eb+sRiOPv00XvCJlLgcUiNRhODm6aG9pk59k5si8/U7TQBsbMIx2GemVbyFy4jQMuljzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjI6fGhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772112765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oJZcnPIkOoIjHwRabLYuOt7Qpn66jHVrKz8/hblaaT8=;
	b=fjI6fGhGGPVwHhp/+Pz8vSdhCtEk0QO+hSTu4SaUcJopOAMuj6ImkFPj5lNJ3m2O9tQpXH
	urVHGUSva7oPuG6kb8Wr6CrmaX3ARkESwXUy5VAvkRkL1FsOqdssJcEBhWagiMw59DwUVn
	rll5TW+m8nYqW7KaoCfGyWvzlzqRVgU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-uRKau_f2MvmYT-pd6mBt0Q-1; Thu,
 26 Feb 2026 08:32:42 -0500
X-MC-Unique: uRKau_f2MvmYT-pd6mBt0Q-1
X-Mimecast-MFC-AGG-ID: uRKau_f2MvmYT-pd6mBt0Q_1772112760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4D6818003FC;
	Thu, 26 Feb 2026 13:32:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6400630001A5;
	Thu, 26 Feb 2026 13:32:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Steve French <sfrench@samba.org>, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <58525.1772112753.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Feb 2026 13:32:33 +0000
Message-ID: <58526.1772112753@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78481-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 05F041A69CD
X-Rspamd-Action: no action

    =

Fix netfslib such that when it's making an unbuffered or DIO write, to mak=
e
sure that it sends each subrequest strictly sequentially, waiting till the
previous one is 'committed' before sending the next so that we don't have
pieces landing out of order and potentially leaving a hole if an error
occurs (ENOSPC for example).

This is done by copying in just those bits of issuing, collecting and
retrying subrequests that are necessary to do one subrequest at a time.
Retrying, in particular, is simpler because if the current subrequest need=
s
retrying, the source iterator can just be copied again and the subrequest
prepped and issued again without needing to be concerned about whether it
needs merging with the previous or next in the sequence.

Note that the issuing loop waits for a subrequest to complete right after
issuing it, but this wait could be moved elsewhere allowing preparatory
steps to be performed whilst the subrequest is in progress.  In particular=
,
once content encryption is available in netfslib, that could be done whils=
t
waiting, as could cleanup of buffers that have been completed.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Tested-by: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c      |  228 +++++++++++++++++++++++++++++++++++++=
++----
 fs/netfs/internal.h          |    4 =

 fs/netfs/write_collect.c     |   21 ---
 fs/netfs/write_issue.c       |   41 -------
 include/trace/events/netfs.h |    4 =

 5 files changed, 221 insertions(+), 77 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a9d1c3b2c084..dd1451bf7543 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,6 +9,202 @@
 #include <linux/uio.h>
 #include "internal.h"
 =

+/*
+ * Perform the cleanup rituals after an unbuffered write is complete.
+ */
+static void netfs_unbuffered_write_done(struct netfs_io_request *wreq)
+{
+	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
+
+	_enter("R=3D%x", wreq->debug_id);
+
+	/* Okay, declare that all I/O is complete. */
+	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
+
+	if (!wreq->error)
+		netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferred)=
;
+
+	if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
+	    wreq->mapping->nrpages) {
+		/* mmap may have got underfoot and we may now have folios
+		 * locally covering the region we just wrote.  Attempt to
+		 * discard the folios, but leave in place any modified locally.
+		 * ->write_iter() is prevented from interfering by the DIO
+		 * counter.
+		 */
+		pgoff_t first =3D wreq->start >> PAGE_SHIFT;
+		pgoff_t last =3D (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
+
+		invalidate_inode_pages2_range(wreq->mapping, first, last);
+	}
+
+	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
+		inode_dio_end(wreq->inode);
+
+	_debug("finished");
+	netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake=
_ip);
+	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
+
+	if (wreq->iocb) {
+		size_t written =3D umin(wreq->transferred, wreq->len);
+
+		wreq->iocb->ki_pos +=3D written;
+		if (wreq->iocb->ki_complete) {
+			trace_netfs_rreq(wreq, netfs_rreq_trace_ki_complete);
+			wreq->iocb->ki_complete(wreq->iocb, wreq->error ?: written);
+		}
+		wreq->iocb =3D VFS_PTR_POISON;
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
+	wreq->transferred +=3D subreq->transferred;
+	iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+	stream->collected_to =3D subreq->start + subreq->transferred;
+	wreq->collected_to =3D stream->collected_to;
+	netfs_put_subrequest(subreq, netfs_sreq_trace_put_done);
+
+	trace_netfs_collect_stream(wreq, stream);
+	trace_netfs_collect_state(wreq, wreq->collected_to, 0);
+}
+
+/*
+ * Write data to the server without going through the pagecache and witho=
ut
+ * writing it to the local cache.  We dispatch the subrequests serially a=
nd
+ * wait for each to complete before dispatching the next, lest we leave a=
 gap
+ * in the data written due to a failure such as ENOSPC.  We could, howeve=
r
+ * attempt to do preparation such as content encryption for the next subr=
eq
+ * whilst the current is in progress.
+ */
+static int netfs_unbuffered_write(struct netfs_io_request *wreq)
+{
+	struct netfs_io_subrequest *subreq =3D NULL;
+	struct netfs_io_stream *stream =3D &wreq->io_streams[0];
+	int ret;
+
+	_enter("%llx", wreq->len);
+
+	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
+		inode_dio_begin(wreq->inode);
+
+	stream->collected_to =3D wreq->start;
+
+	for (;;) {
+		bool retry =3D false;
+
+		if (!subreq) {
+			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
+			subreq =3D stream->construct;
+			stream->construct =3D NULL;
+			stream->front =3D NULL;
+		}
+
+		/* Check if (re-)preparation failed. */
+		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
+			netfs_write_subrequest_terminated(subreq, subreq->error);
+			wreq->error =3D subreq->error;
+			break;
+		}
+
+		iov_iter_truncate(&subreq->io_iter, wreq->len - wreq->transferred);
+		if (!iov_iter_count(&subreq->io_iter))
+			break;
+
+		subreq->len =3D netfs_limit_iter(&subreq->io_iter, 0,
+					       stream->sreq_max_len,
+					       stream->sreq_max_segs);
+		iov_iter_truncate(&subreq->io_iter, subreq->len);
+		stream->submit_extendable_to =3D subreq->len;
+
+		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+		stream->issue_write(subreq);
+
+		/* Async, need to wait. */
+		netfs_wait_for_in_progress_stream(wreq, stream);
+
+		if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+			retry =3D true;
+		} else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
+			ret =3D subreq->error;
+			wreq->error =3D ret;
+			netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
+			subreq =3D NULL;
+			break;
+		}
+		ret =3D 0;
+
+		if (!retry) {
+			netfs_unbuffered_write_collect(wreq, stream, subreq);
+			subreq =3D NULL;
+			if (wreq->transferred >=3D wreq->len)
+				break;
+			if (!wreq->iocb && signal_pending(current)) {
+				ret =3D wreq->transferred ? -EINTR : -ERESTARTSYS;
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
+		subreq->error =3D -EAGAIN;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+		if (subreq->transferred > 0)
+			iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+
+		if (stream->source =3D=3D NETFS_UPLOAD_TO_SERVER &&
+		    wreq->netfs_ops->retry_request)
+			wreq->netfs_ops->retry_request(wreq, stream);
+
+		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+		subreq->io_iter		=3D wreq->buffer.iter;
+		subreq->start		=3D wreq->start + wreq->transferred;
+		subreq->len		=3D wreq->len   - wreq->transferred;
+		subreq->transferred	=3D 0;
+		subreq->retry_count	+=3D 1;
+		stream->sreq_max_len	=3D UINT_MAX;
+		stream->sreq_max_segs	=3D INT_MAX;
+
+		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+		stream->prepare_write(subreq);
+
+		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+		netfs_stat(&netfs_n_wh_retry_write_subreq);
+	}
+
+	netfs_unbuffered_write_done(wreq);
+	_leave(" =3D %d", ret);
+	return ret;
+}
+
+static void netfs_unbuffered_write_async(struct work_struct *work)
+{
+	struct netfs_io_request *wreq =3D container_of(work, struct netfs_io_req=
uest, work);
+
+	netfs_unbuffered_write(wreq);
+	netfs_put_request(wreq, netfs_rreq_trace_put_complete);
+}
+
 /*
  * Perform an unbuffered write where we may have to do an RMW operation o=
n an
  * encrypted file.  This can also be used for direct I/O writes.
@@ -70,35 +266,35 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kio=
cb *iocb, struct iov_iter *
 			 */
 			wreq->buffer.iter =3D *iter;
 		}
+
+		wreq->len =3D iov_iter_count(&wreq->buffer.iter);
 	}
 =

 	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
-	if (async)
-		__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 =

 	/* Copy the data into the bounce buffer and encrypt it. */
 	// TODO
 =

 	/* Dispatch the write. */
 	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-	if (async)
-		wreq->iocb =3D iocb;
-	wreq->len =3D iov_iter_count(&wreq->buffer.iter);
-	ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
-	if (ret < 0) {
-		_debug("begin =3D %zd", ret);
-		goto out;
-	}
 =

-	if (!async) {
-		ret =3D netfs_wait_for_write(wreq);
-		if (ret > 0)
-			iocb->ki_pos +=3D ret;
-	} else {
+	if (async) {
+		INIT_WORK(&wreq->work, netfs_unbuffered_write_async);
+		wreq->iocb =3D iocb;
+		queue_work(system_dfl_wq, &wreq->work);
 		ret =3D -EIOCBQUEUED;
+	} else {
+		ret =3D netfs_unbuffered_write(wreq);
+		if (ret < 0) {
+			_debug("begin =3D %zd", ret);
+		} else {
+			iocb->ki_pos +=3D wreq->transferred;
+			ret =3D wreq->transferred ?: wreq->error;
+		}
+
+		netfs_put_request(wreq, netfs_rreq_trace_put_complete);
 	}
 =

-out:
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	return ret;
 =

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 4319611f5354..d436e20d3418 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -198,6 +198,9 @@ struct netfs_io_request *netfs_create_write_req(struct=
 address_space *mapping,
 						struct file *file,
 						loff_t start,
 						enum netfs_io_origin origin);
+void netfs_prepare_write(struct netfs_io_request *wreq,
+			 struct netfs_io_stream *stream,
+			 loff_t start);
 void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source);
@@ -212,7 +215,6 @@ int netfs_advance_writethrough(struct netfs_io_request=
 *wreq, struct writeback_c
 			       struct folio **writethrough_cache);
 ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writ=
eback_control *wbc,
 			       struct folio *writethrough_cache);
-int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, =
size_t len);
 =

 /*
  * write_retry.c
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 61eab34ea67e..83eb3dc1adf8 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -399,27 +399,6 @@ bool netfs_write_collection(struct netfs_io_request *=
wreq)
 		ictx->ops->invalidate_cache(wreq);
 	}
 =

-	if ((wreq->origin =3D=3D NETFS_UNBUFFERED_WRITE ||
-	     wreq->origin =3D=3D NETFS_DIO_WRITE) &&
-	    !wreq->error)
-		netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferred)=
;
-
-	if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
-	    wreq->mapping->nrpages) {
-		/* mmap may have got underfoot and we may now have folios
-		 * locally covering the region we just wrote.  Attempt to
-		 * discard the folios, but leave in place any modified locally.
-		 * ->write_iter() is prevented from interfering by the DIO
-		 * counter.
-		 */
-		pgoff_t first =3D wreq->start >> PAGE_SHIFT;
-		pgoff_t last =3D (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
-		invalidate_inode_pages2_range(wreq->mapping, first, last);
-	}
-
-	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
-		inode_dio_end(wreq->inode);
-
 	_debug("finished");
 	netfs_wake_rreq_flag(wreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake=
_ip);
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
 	struct iov_iter *wreq_iter =3D &wreq->buffer.iter;
@@ -698,41 +698,6 @@ ssize_t netfs_end_writethrough(struct netfs_io_reques=
t *wreq, struct writeback_c
 	return ret;
 }
 =

-/*
- * Write data to the server without going through the pagecache and witho=
ut
- * writing it to the local cache.
- */
-int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, =
size_t len)
-{
-	struct netfs_io_stream *upload =3D &wreq->io_streams[0];
-	ssize_t part;
-	loff_t start =3D wreq->start;
-	int error =3D 0;
-
-	_enter("%zx", len);
-
-	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
-		inode_dio_begin(wreq->inode);
-
-	while (len) {
-		// TODO: Prepare content encryption
-
-		_debug("unbuffered %zx", len);
-		part =3D netfs_advance_write(wreq, upload, start, len, false);
-		start +=3D part;
-		len -=3D part;
-		rolling_buffer_advance(&wreq->buffer, part);
-		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags))
-			netfs_wait_for_paused_write(wreq);
-		if (test_bit(NETFS_RREQ_FAILED, &wreq->flags))
-			break;
-	}
-
-	netfs_end_issue_write(wreq);
-	_leave(" =3D %d", error);
-	return error;
-}
-
 /*
  * Write some of a pending folio data back to the server and/or the cache=
.
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
 =

 #define netfs_folio_traces					\
 	EM(netfs_folio_is_uptodate,		"mod-uptodate")	\



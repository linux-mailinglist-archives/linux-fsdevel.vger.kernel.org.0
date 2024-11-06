Return-Path: <linux-fsdevel+bounces-33756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D441F9BEA3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 13:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F03281DD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085F1F80A1;
	Wed,  6 Nov 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL7F3mWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB71F76B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896664; cv=none; b=SPMCdPg2ZqfjLBcipEegcbjMvlXINKEZI2baqK6cJd3lNb8B2gsgrssv3rHE3RYM74lxJnX8yLRQ27Hs2jYVRCZnqUjrlZOpjkH/2a949VvYVfoCXqRhHnaY9gjT1M6pcvQyM3216zgxjA1TeYgRtjXIDr1whM3e93psDmK0ACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896664; c=relaxed/simple;
	bh=Vv+jfpPcEP0ftAmIGzIlIjG1nUmyzSs6ZeUOcsiO1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoFLamaO5pwndoBAQBNCLAKniJjfmnn7rRb8lIa2awR+wrKsAfQqlrqpcvVPhPbDZDJmOd1ylHdcyRtT2Y0KBpQT0zWepJpYG+nv4eeSOFVL3/XbX935eZPcu0GpUWY/FEtanfmR8TWBVknHScuvGNwR712dIQysdetCzIMl1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL7F3mWc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQulb3S8MTlwASu6KLVgl06OEgPM8wXTsZf/G1673M4=;
	b=BL7F3mWcf3XbuQa32nU6gm/CgErSrVFi0LDJi/gCMY9cm+5WAEpsEfDL8KRsySj3I7eqtA
	wj8j+ZMd2NJLKsWEuh8kTRhJ2nafgSmhxvOYokvAwihxYMeIQDc1hJajnoXeV0LweKbTxX
	wMmY9uD+6/a04hyKmOhf5Rrr8C/xA/M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-pOm_FH0pPHeaEm0jK2PrQA-1; Wed,
 06 Nov 2024 07:37:38 -0500
X-MC-Unique: pOm_FH0pPHeaEm0jK2PrQA-1
X-Mimecast-MFC-AGG-ID: pOm_FH0pPHeaEm0jK2PrQA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D82CC19560BF;
	Wed,  6 Nov 2024 12:37:35 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2C5E30000DF;
	Wed,  6 Nov 2024 12:37:29 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 11/33] netfs: Drop the was_async arg from netfs_read_subreq_terminated()
Date: Wed,  6 Nov 2024 12:35:35 +0000
Message-ID: <20241106123559.724888-12-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Drop the was_async argument from netfs_read_subreq_terminated().  Almost
every caller is either in process context and passes false.  Some
filesystems delegate the call to a workqueue to avoid doing the work in
their network message queue parsing thread.

The only exception is netfs_cache_read_terminated() which handles
completion in the cache - which is usually a callback from the backing
filesystem in softirq context, though it can be from process context if an
error occurred.  In this case, delegate to a workqueue.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c         |  2 +-
 fs/afs/file.c            |  6 ++---
 fs/afs/fsclient.c        |  2 +-
 fs/afs/yfsclient.c       |  2 +-
 fs/ceph/addr.c           |  6 ++---
 fs/netfs/buffered_read.c |  6 ++---
 fs/netfs/direct_read.c   |  2 +-
 fs/netfs/internal.h      |  2 +-
 fs/netfs/objects.c       |  2 +-
 fs/netfs/read_collect.c  | 53 +++++++++-------------------------------
 fs/netfs/read_retry.c    |  2 +-
 fs/nfs/fscache.c         |  2 +-
 fs/nfs/fscache.h         |  2 +-
 fs/smb/client/file.c     |  2 +-
 include/linux/netfs.h    |  4 +--
 15 files changed, 33 insertions(+), 62 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 58a6bd284d88..e4144e1a10a9 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -84,7 +84,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 		subreq->transferred += total;
 
 	subreq->error = err;
-	netfs_read_subreq_terminated(subreq, false);
+	netfs_read_subreq_terminated(subreq);
 }
 
 /**
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 56248a078bca..f717168da4ab 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -247,7 +247,7 @@ static void afs_fetch_data_notify(struct afs_operation *op)
 		if (req->pos + req->actual_len >= req->file_size)
 			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 		subreq->error = error;
-		netfs_read_subreq_terminated(subreq, false);
+		netfs_read_subreq_terminated(subreq);
 		req->subreq = NULL;
 	} else if (req->done) {
 		req->done(req);
@@ -304,7 +304,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	if (IS_ERR(op)) {
 		if (req->subreq) {
 			req->subreq->error = PTR_ERR(op);
-			netfs_read_subreq_terminated(req->subreq, false);
+			netfs_read_subreq_terminated(req->subreq);
 		}
 		return PTR_ERR(op);
 	}
@@ -325,7 +325,7 @@ static void afs_read_worker(struct work_struct *work)
 	fsreq = afs_alloc_read(GFP_NOFS);
 	if (!fsreq) {
 		subreq->error = -ENOMEM;
-		return netfs_read_subreq_terminated(subreq, false);
+		return netfs_read_subreq_terminated(subreq);
 	}
 
 	fsreq->subreq	= subreq;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 098fa034a1cc..784f7daab112 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -352,7 +352,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		if (req->subreq) {
 			req->subreq->transferred += count_before - call->iov_len;
-			netfs_read_subreq_progress(req->subreq, false);
+			netfs_read_subreq_progress(req->subreq);
 		}
 		if (ret < 0)
 			return ret;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 024227aba4cd..368cf277d801 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -398,7 +398,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		if (req->subreq) {
 			req->subreq->transferred += count_before - call->iov_len;
-			netfs_read_subreq_progress(req->subreq, false);
+			netfs_read_subreq_progress(req->subreq);
 		}
 		if (ret < 0)
 			return ret;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 459249ba6319..d008e7334db7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -255,7 +255,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	}
 	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
-	netfs_read_subreq_terminated(subreq, false);
+	netfs_read_subreq_terminated(subreq);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
@@ -317,7 +317,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 out:
 	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
-	netfs_read_subreq_terminated(subreq, false);
+	netfs_read_subreq_terminated(subreq);
 	return true;
 }
 
@@ -431,7 +431,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	ceph_osdc_put_request(req);
 	if (err) {
 		subreq->error = err;
-		netfs_read_subreq_terminated(subreq, false);
+		netfs_read_subreq_terminated(subreq);
 	}
 	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 82c3b9957958..6fd4f3bef3b4 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -154,7 +154,7 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
 	} else {
 		subreq->error = transferred_or_error;
 	}
-	netfs_read_subreq_terminated(subreq, was_async);
+	schedule_work(&subreq->work);
 }
 
 /*
@@ -261,7 +261,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			slice = netfs_prepare_read_iterator(subreq);
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			subreq->error = 0;
-			netfs_read_subreq_terminated(subreq, false);
+			netfs_read_subreq_terminated(subreq);
 			goto done;
 		}
 
@@ -283,7 +283,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 	} while (size > 0);
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, false);
+		netfs_rreq_terminated(rreq);
 
 	/* Defer error return as we may need to wait for outstanding I/O. */
 	cmpxchg(&rreq->error, 0, ret);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a3f23adbae0f..54027fd14904 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -100,7 +100,7 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 	} while (size > 0);
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, false);
+		netfs_rreq_terminated(rreq);
 	return ret;
 }
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 73887525e939..ba32ca61063c 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -85,7 +85,7 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
  * read_collect.c
  */
 void netfs_read_termination_worker(struct work_struct *work);
-void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async);
+void netfs_rreq_terminated(struct netfs_io_request *rreq);
 
 /*
  * read_pgpriv2.c
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f10fd56efa17..8c98b70eb3a4 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -56,7 +56,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	    origin == NETFS_READ_GAPS ||
 	    origin == NETFS_READ_FOR_WRITE ||
 	    origin == NETFS_DIO_READ)
-		INIT_WORK(&rreq->work, netfs_read_termination_worker);
+		INIT_WORK(&rreq->work, NULL);
 	else
 		INIT_WORK(&rreq->work, netfs_write_collection_worker);
 
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 00358894fac4..146abb2e399a 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -85,7 +85,7 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
  * Unlock any folios that are now completely read.  Returns true if the
  * subrequest is removed from the list.
  */
-static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was_async)
+static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_subrequest *prev, *next;
 	struct netfs_io_request *rreq = subreq->rreq;
@@ -228,8 +228,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 		subreq->curr_folioq_slot = slot;
 		if (folioq && folioq_folio(folioq, slot))
 			subreq->curr_folio_order = folioq->orders[slot];
-		if (!was_async)
-			cond_resched();
+		cond_resched();
 		goto next_folio;
 	}
 
@@ -365,7 +364,7 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
  * Note that we're in normal kernel thread context at this point, possibly
  * running on a workqueue.
  */
-static void netfs_rreq_assess(struct netfs_io_request *rreq)
+void netfs_rreq_terminated(struct netfs_io_request *rreq)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 
@@ -392,56 +391,29 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq)
 		netfs_pgpriv2_write_to_the_cache(rreq);
 }
 
-void netfs_read_termination_worker(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-	netfs_see_request(rreq, netfs_rreq_trace_see_work);
-	netfs_rreq_assess(rreq);
-	netfs_put_request(rreq, false, netfs_rreq_trace_put_work_complete);
-}
-
-/*
- * Handle the completion of all outstanding I/O operations on a read request.
- * We inherit a ref from the caller.
- */
-void netfs_rreq_terminated(struct netfs_io_request *rreq, bool was_async)
-{
-	if (!was_async)
-		return netfs_rreq_assess(rreq);
-	if (!work_pending(&rreq->work)) {
-		netfs_get_request(rreq, netfs_rreq_trace_get_work);
-		if (!queue_work(system_unbound_wq, &rreq->work))
-			netfs_put_request(rreq, was_async, netfs_rreq_trace_put_work_nq);
-	}
-}
-
 /**
  * netfs_read_subreq_progress - Note progress of a read operation.
  * @subreq: The read request that has terminated.
- * @was_async: True if we're in an asynchronous context.
  *
  * This tells the read side of netfs lib that a contributory I/O operation has
  * made some progress and that it may be possible to unlock some folios.
  *
  * Before calling, the filesystem should update subreq->transferred to track
  * the amount of data copied into the output buffer.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
  */
-void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
-				bool was_async)
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
+	might_sleep();
+
 	trace_netfs_sreq(subreq, netfs_sreq_trace_progress);
 
 	if (subreq->transferred > subreq->consumed &&
 	    (rreq->origin == NETFS_READAHEAD ||
 	     rreq->origin == NETFS_READPAGE ||
 	     rreq->origin == NETFS_READ_FOR_WRITE)) {
-		netfs_consume_read_data(subreq, was_async);
+		netfs_consume_read_data(subreq);
 		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 	}
 }
@@ -450,7 +422,6 @@ EXPORT_SYMBOL(netfs_read_subreq_progress);
 /**
  * netfs_read_subreq_terminated - Note the termination of an I/O operation.
  * @subreq: The I/O request that has terminated.
- * @was_async: True if we're in an asynchronous context.
  *
  * This tells the read helper that a contributory I/O operation has terminated,
  * one way or another, and that it should integrate the results.
@@ -464,7 +435,7 @@ EXPORT_SYMBOL(netfs_read_subreq_progress);
  * Before calling, the filesystem should update subreq->transferred to track
  * the amount of data copied into the output buffer.
  */
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_async)
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 
@@ -498,7 +469,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_a
 		    (rreq->origin == NETFS_READAHEAD ||
 		     rreq->origin == NETFS_READPAGE ||
 		     rreq->origin == NETFS_READ_FOR_WRITE)) {
-			netfs_consume_read_data(subreq, was_async);
+			netfs_consume_read_data(subreq);
 			__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 		}
 		rreq->transferred += subreq->transferred;
@@ -540,9 +511,9 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_a
 	}
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, was_async);
+		netfs_rreq_terminated(rreq);
 
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
+	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
 }
 EXPORT_SYMBOL(netfs_read_subreq_terminated);
 
@@ -558,6 +529,6 @@ void netfs_read_subreq_termination_worker(struct work_struct *work)
 	struct netfs_io_subrequest *subreq =
 		container_of(work, struct netfs_io_subrequest, work);
 
-	netfs_read_subreq_terminated(subreq, false);
+	netfs_read_subreq_terminated(subreq);
 }
 EXPORT_SYMBOL(netfs_read_subreq_termination_worker);
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0fe7677b4022..d1986cec3db7 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -232,7 +232,7 @@ void netfs_retry_reads(struct netfs_io_request *rreq)
 	netfs_retry_read_subrequests(rreq);
 
 	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq, false);
+		netfs_rreq_terminated(rreq);
 }
 
 /*
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e585a7bcfe4d..2f3c4f773d73 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -309,7 +309,7 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 	netfs = nfs_netfs_alloc(sreq);
 	if (!netfs) {
 		sreq->error = -ENOMEM;
-		return netfs_read_subreq_terminated(sreq, false);
+		return netfs_read_subreq_terminated(sreq);
 	}
 
 	pgio.pg_netfs = netfs; /* used in completion */
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 1d86f7cc7195..9d86868f4998 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -75,7 +75,7 @@ static inline void nfs_netfs_put(struct nfs_netfs_io_data *netfs)
 	netfs->sreq->transferred = min_t(s64, netfs->sreq->len,
 					 atomic64_read(&netfs->transferred));
 	netfs->sreq->error = netfs->error;
-	netfs_read_subreq_terminated(netfs->sreq, false);
+	netfs_read_subreq_terminated(netfs->sreq);
 	kfree(netfs);
 }
 static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi)
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 10dd440f8178..27a1757a278e 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -228,7 +228,7 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 
 failed:
 	subreq->error = rc;
-	netfs_read_subreq_terminated(subreq, false);
+	netfs_read_subreq_terminated(subreq);
 }
 
 /*
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a3aa36c1869f..738c9c8763f0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -428,8 +428,8 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
-void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq, bool was_async);
-void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq, bool was_async);
+void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);
+void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq);
 void netfs_read_subreq_termination_worker(struct work_struct *work);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);



Return-Path: <linux-fsdevel+bounces-37550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2399F3BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1A47A6498
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8431DC74A;
	Mon, 16 Dec 2024 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZTSjqL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD951DC745
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381906; cv=none; b=qORaoNkg8o/K7Le9x7pfjYignKgKs0bIz7NCZ1Vcq882z94rA92dd7fLsexwy41xjyfPR59YP7y8ubj5KoeRn1cruTI6xfkeNiETyNfuu9Wvufy0cQroyXXl5qMHaOdURAr7Gbm20bfJr/KTEk+ENeWEsL2U31I3Xbcpl3p6Td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381906; c=relaxed/simple;
	bh=nkU1JNQ2nlXZoll+EG2KxQAIl69P9xJXh6J54lw1768=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtzLeq16HaZm/lEo0Ap5k8aEi6WtO59wWxDQfkS87z3vAT2cEfDDPCIQ2Vq6xE2ux5AYKRKuLGBs5MEjj9Kt7JjFc+R3Mw1X/f2xXGyo554RdAoR2+Xwzax4DGXIPWNIlOd0SM9g/uwiVG8RTvWnND8ddxELxB5VWaBrQD7Ky6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZTSjqL0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZCIyzKW4LOM5s8Lbbv9rDPrG4zH91mQwctNMhOJNjc=;
	b=eZTSjqL07eQVuecl9cnm7z6U+kKnt1TRP3NWkUhyH4tUSkYQ4FBiacz+pgswIUdGm0cONW
	ZuOw/7ErzVv/zoxEC22mcj4cp60JptejbvE5JsZqSI7aWafwhJ83YxT1CfqeuQ75DPWgJF
	VQj4Dv0vujBrt5BdAGjRJjFNNmzP9hI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-g3YWZVPvP7SmTnrzUneDvw-1; Mon,
 16 Dec 2024 15:44:56 -0500
X-MC-Unique: g3YWZVPvP7SmTnrzUneDvw-1
X-Mimecast-MFC-AGG-ID: g3YWZVPvP7SmTnrzUneDvw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 456361955F41;
	Mon, 16 Dec 2024 20:44:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 288891956053;
	Mon, 16 Dec 2024 20:44:46 +0000 (UTC)
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
Subject: [PATCH v5 27/32] netfs: Change the read result collector to only use one work item
Date: Mon, 16 Dec 2024 20:41:17 +0000
Message-ID: <20241216204124.3752367-28-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Change the way netfslib collects read results to do all the collection for
a particular read request using a single work item that walks along the
subrequest queue as subrequests make progress or complete, unlocking folios
progressively rather than doing the unlock in parallel as parallel requests
come in.

The code is remodelled to be more like the write-side code, though only
using a single stream.  This makes it more directly comparable and thus
easier to duplicate fixes between the two sides.

This has a number of advantages:

 (1) It's simpler.  There doesn't need to be a complex donation mechanism
     to handle mismatches between the size and alignment of subrequests and
     folios.  The collector unlocks folios as the subrequests covering each
     complete.

 (2) It should cause less scheduler overhead as there's a single work item
     in play unlocking pages in parallel when a read gets split up into a
     lot of subrequests instead of one per subrequest.

     Whilst the parallellism is nice in theory, in practice, the vast
     majority of loads are sequential reads of the whole file, so
     committing a bunch of threads to unlocking folios out of order doesn't
     help in those cases.

 (3) It should make it easier to implement content decryption.  A folio
     cannot be decrypted until all the requests that contribute to it have
     completed - and, again, most loads are sequential and so, most of the
     time, we want to begin decryption sequentially (though it's great if
     the decryption can happen in parallel).

There is a disadvantage in that we're losing the ability to decrypt and
unlock things on an as-things-arrive basis which may affect some
applications.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c             |   3 +-
 fs/afs/dir.c                 |   8 +-
 fs/ceph/addr.c               |   9 +-
 fs/netfs/buffered_read.c     | 160 ++++----
 fs/netfs/direct_read.c       |  60 +--
 fs/netfs/internal.h          |  21 +-
 fs/netfs/main.c              |   2 +-
 fs/netfs/objects.c           |  34 +-
 fs/netfs/read_collect.c      | 716 ++++++++++++++++++++---------------
 fs/netfs/read_pgpriv2.c      | 203 ++++------
 fs/netfs/read_retry.c        | 207 +++++-----
 fs/netfs/read_single.c       |  37 +-
 fs/netfs/write_collect.c     |   4 +-
 fs/netfs/write_issue.c       |   2 +-
 fs/netfs/write_retry.c       |  14 +-
 fs/smb/client/cifssmb.c      |   2 +
 fs/smb/client/smb2pdu.c      |   5 +-
 include/linux/netfs.h        |  16 +-
 include/trace/events/netfs.h |  79 +---
 19 files changed, 819 insertions(+), 763 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index b38be6ff90bc..32619d146cbc 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -81,8 +81,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	if (pos + total >= i_size_read(rreq->inode))
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
-
-	if (!err) {
+	if (!err && total) {
 		subreq->transferred += total;
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	}
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 3fa095429794..a386b4649f3e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -325,8 +325,10 @@ static ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	 * haven't read it yet.
 	 */
 	if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) &&
-	    test_bit(AFS_VNODE_DIR_READ, &dvnode->flags))
+	    test_bit(AFS_VNODE_DIR_READ, &dvnode->flags)) {
+		ret = i_size;
 		goto valid;
+	}
 
 	up_read(&dvnode->validate_lock);
 	if (down_write_killable(&dvnode->validate_lock) < 0)
@@ -346,11 +348,13 @@ static ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 
 		set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
 		set_bit(AFS_VNODE_DIR_READ, &dvnode->flags);
+	} else {
+		ret = i_size;
 	}
 
 	downgrade_write(&dvnode->validate_lock);
 valid:
-	return i_size;
+	return ret;
 
 error_unlock:
 	up_write(&dvnode->validate_lock);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4deb38fa470e..f5224a566b69 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -223,10 +223,13 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	      subreq->len, i_size_read(req->r_inode));
 
 	/* no object means success but no data */
-	if (err == -ENOENT)
+	if (err == -ENOENT) {
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 		err = 0;
-	else if (err == -EBLOCKLISTED)
+	} else if (err == -EBLOCKLISTED) {
 		fsc->blocklisted = true;
+	}
 
 	if (err >= 0) {
 		if (sparse && err > 0)
@@ -242,6 +245,8 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 			if (err > subreq->len)
 				err = subreq->len;
 		}
+		if (err > 0)
+			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	}
 
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index c420e9dee0e4..0245943d974d 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -121,12 +121,6 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq)
 
 	subreq->io_iter	= rreq->buffer.iter;
 
-	if (iov_iter_is_folioq(&subreq->io_iter)) {
-		subreq->curr_folioq = (struct folio_queue *)subreq->io_iter.folioq;
-		subreq->curr_folioq_slot = subreq->io_iter.folioq_slot;
-		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
-	}
-
 	iov_iter_truncate(&subreq->io_iter, subreq->len);
 	rolling_buffer_advance(&rreq->buffer, subreq->len);
 	return subreq->len;
@@ -147,19 +141,6 @@ static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rr
 
 }
 
-void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool was_async)
-{
-	struct netfs_io_subrequest *subreq = priv;
-
-	if (transferred_or_error > 0) {
-		subreq->transferred += transferred_or_error;
-		subreq->error = 0;
-	} else {
-		subreq->error = transferred_or_error;
-	}
-	schedule_work(&subreq->work);
-}
-
 /*
  * Issue a read against the cache.
  * - Eats the caller's ref on subreq.
@@ -174,6 +155,47 @@ static void netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
 			netfs_cache_read_terminated, subreq);
 }
 
+static void netfs_issue_read(struct netfs_io_request *rreq,
+			     struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+
+	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+
+	/* We add to the end of the list whilst the collector may be walking
+	 * the list.  The collector only goes nextwards and uses the lock to
+	 * remove entries off of the front.
+	 */
+	spin_lock(&rreq->lock);
+	list_add_tail(&subreq->rreq_link, &stream->subrequests);
+	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
+		stream->front = subreq;
+		if (!stream->active) {
+			stream->collected_to = stream->front->start;
+			/* Store list pointers before active flag */
+			smp_store_release(&stream->active, true);
+		}
+	}
+
+	spin_unlock(&rreq->lock);
+
+	switch (subreq->source) {
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		rreq->netfs_ops->issue_read(subreq);
+		break;
+	case NETFS_READ_FROM_CACHE:
+		netfs_read_cache_to_pagecache(rreq, subreq);
+		break;
+	default:
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		subreq->error = 0;
+		iov_iter_zero(subreq->len, &subreq->io_iter);
+		subreq->transferred = subreq->len;
+		netfs_read_subreq_terminated(subreq);
+		break;
+	}
+}
+
 /*
  * Perform a read to the pagecache from a series of sources of different types,
  * slicing up the region to be read according to available cache blocks and
@@ -186,8 +208,6 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 	ssize_t size = rreq->len;
 	int ret = 0;
 
-	atomic_inc(&rreq->nr_outstanding);
-
 	do {
 		struct netfs_io_subrequest *subreq;
 		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
@@ -202,14 +222,6 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		subreq->start	= start;
 		subreq->len	= size;
 
-		atomic_inc(&rreq->nr_outstanding);
-		spin_lock(&rreq->lock);
-		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-		subreq->prev_donated = rreq->prev_donated;
-		rreq->prev_donated = 0;
-		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock(&rreq->lock);
-
 		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
 		subreq->source = source;
 		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
@@ -237,17 +249,18 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_stat(&netfs_n_rh_download);
 			if (rreq->netfs_ops->prepare_read) {
 				ret = rreq->netfs_ops->prepare_read(subreq);
-				if (ret < 0)
-					goto prep_failed;
+				if (ret < 0) {
+					subreq->error = ret;
+					/* Not queued - release both refs. */
+					netfs_put_subrequest(subreq, false,
+							     netfs_sreq_trace_put_cancel);
+					netfs_put_subrequest(subreq, false,
+							     netfs_sreq_trace_put_cancel);
+					break;
+				}
 				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 			}
-
-			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0)
-				goto prep_iter_failed;
-
-			rreq->netfs_ops->issue_read(subreq);
-			goto done;
+			goto issue;
 		}
 
 	fill_with_zeroes:
@@ -255,67 +268,50 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			subreq->source = NETFS_FILL_WITH_ZEROES;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
-			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0)
-				goto prep_iter_failed;
-			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-			subreq->error = 0;
-			netfs_read_subreq_terminated(subreq);
-			goto done;
+			goto issue;
 		}
 
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0)
-				goto prep_iter_failed;
-			netfs_read_cache_to_pagecache(rreq, subreq);
-			goto done;
+			goto issue;
 		}
 
 		pr_err("Unexpected read source %u\n", source);
 		WARN_ON_ONCE(1);
 		break;
 
-	prep_iter_failed:
-		ret = slice;
-	prep_failed:
-		subreq->error = ret;
-		atomic_dec(&rreq->nr_outstanding);
-		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
-		break;
-
-	done:
+	issue:
+		slice = netfs_prepare_read_iterator(subreq);
+		if (slice < 0) {
+			ret = slice;
+			subreq->error = ret;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
+			/* Not queued - release both refs. */
+			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+			break;
+		}
 		size -= slice;
 		start += slice;
+		if (size <= 0) {
+			smp_wmb(); /* Write lists before ALL_QUEUED. */
+			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		}
+
+		netfs_issue_read(rreq, subreq);
 		cond_resched();
 	} while (size > 0);
 
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq);
+	if (unlikely(size > 0)) {
+		smp_wmb(); /* Write lists before ALL_QUEUED. */
+		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		netfs_wake_read_collector(rreq);
+	}
 
 	/* Defer error return as we may need to wait for outstanding I/O. */
 	cmpxchg(&rreq->error, 0, ret);
 }
 
-/*
- * Wait for the read operation to complete, successfully or otherwise.
- */
-static int netfs_wait_for_read(struct netfs_io_request *rreq)
-{
-	int ret;
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
-	wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS, TASK_UNINTERRUPTIBLE);
-	ret = rreq->error;
-	if (ret == 0 && rreq->submitted < rreq->len) {
-		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-		ret = -EIO;
-	}
-
-	return ret;
-}
-
 /**
  * netfs_readahead - Helper to manage a read request
  * @ractl: The description of the readahead request
@@ -344,6 +340,8 @@ void netfs_readahead(struct readahead_control *ractl)
 	if (IS_ERR(rreq))
 		return;
 
+	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags);
+
 	ret = netfs_begin_cache_read(rreq, ictx);
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 		goto cleanup_free;
@@ -460,7 +458,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 		folio_put(sink);
 
 	ret = netfs_wait_for_read(rreq);
-	if (ret == 0) {
+	if (ret >= 0) {
 		flush_dcache_folio(folio);
 		folio_mark_uptodate(folio);
 	}
@@ -748,7 +746,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	netfs_read_to_pagecache(rreq);
 	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
-	return ret;
+	return ret < 0 ? ret : 0;
 
 error_put:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 1a20cc3979c7..0bf3c2f5a710 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -47,12 +47,11 @@ static void netfs_prepare_dio_read_iterator(struct netfs_io_subrequest *subreq)
  */
 static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 {
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	unsigned long long start = rreq->start;
 	ssize_t size = rreq->len;
 	int ret = 0;
 
-	atomic_set(&rreq->nr_outstanding, 1);
-
 	do {
 		struct netfs_io_subrequest *subreq;
 		ssize_t slice;
@@ -67,11 +66,18 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		subreq->start	= start;
 		subreq->len	= size;
 
-		atomic_inc(&rreq->nr_outstanding);
+		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+
 		spin_lock(&rreq->lock);
-		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-		subreq->prev_donated = rreq->prev_donated;
-		rreq->prev_donated = 0;
+		list_add_tail(&subreq->rreq_link, &stream->subrequests);
+		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
+			stream->front = subreq;
+			if (!stream->active) {
+				stream->collected_to = stream->front->start;
+				/* Store list pointers before active flag */
+				smp_store_release(&stream->active, true);
+			}
+		}
 		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
 		spin_unlock(&rreq->lock);
 
@@ -79,7 +85,6 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		if (rreq->netfs_ops->prepare_read) {
 			ret = rreq->netfs_ops->prepare_read(subreq);
 			if (ret < 0) {
-				atomic_dec(&rreq->nr_outstanding);
 				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
 				break;
 			}
@@ -87,20 +92,32 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 
 		netfs_prepare_dio_read_iterator(subreq);
 		slice = subreq->len;
-		rreq->netfs_ops->issue_read(subreq);
-
 		size -= slice;
 		start += slice;
 		rreq->submitted += slice;
+		if (size <= 0) {
+			smp_wmb(); /* Write lists before ALL_QUEUED. */
+			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		}
+
+		rreq->netfs_ops->issue_read(subreq);
 
+		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+			netfs_wait_for_pause(rreq);
+		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
+			break;
 		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
 		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
 			break;
 		cond_resched();
 	} while (size > 0);
 
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq);
+	if (unlikely(size > 0)) {
+		smp_wmb(); /* Write lists before ALL_QUEUED. */
+		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		netfs_wake_read_collector(rreq);
+	}
+
 	return ret;
 }
 
@@ -133,21 +150,10 @@ static int netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 		goto out;
 	}
 
-	if (sync) {
-		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
-		wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
-			    TASK_UNINTERRUPTIBLE);
-
-		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len &&
-		    rreq->origin != NETFS_DIO_READ) {
-			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-			ret = -EIO;
-		}
-	} else {
+	if (sync)
+		ret = netfs_wait_for_read(rreq);
+	else
 		ret = -EIOCBQUEUED;
-	}
-
 out:
 	_leave(" = %d", ret);
 	return ret;
@@ -215,8 +221,10 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 
 	// TODO: Set up bounce buffer if needed
 
-	if (!sync)
+	if (!sync) {
 		rreq->iocb = iocb;
+		__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags);
+	}
 
 	ret = netfs_unbuffered_read(rreq, sync);
 	if (ret < 0)
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e236f752af88..eb76f98c894b 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -82,20 +82,27 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
 	trace_netfs_rreq_ref(rreq->debug_id, refcount_read(&rreq->ref), what);
 }
 
+static inline void netfs_see_subrequest(struct netfs_io_subrequest *subreq,
+					enum netfs_sreq_ref_trace what)
+{
+	trace_netfs_sreq_ref(subreq->rreq->debug_id, subreq->debug_index,
+			     refcount_read(&subreq->ref), what);
+}
+
 /*
  * read_collect.c
  */
-void netfs_read_termination_worker(struct work_struct *work);
-void netfs_rreq_terminated(struct netfs_io_request *rreq);
+void netfs_read_collection_worker(struct work_struct *work);
+void netfs_wake_read_collector(struct netfs_io_request *rreq);
+void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool was_async);
+ssize_t netfs_wait_for_read(struct netfs_io_request *rreq);
+void netfs_wait_for_pause(struct netfs_io_request *rreq);
 
 /*
  * read_pgpriv2.c
  */
-void netfs_pgpriv2_mark_copy_to_cache(struct netfs_io_subrequest *subreq,
-				      struct netfs_io_request *rreq,
-				      struct folio_queue *folioq,
-				      int slot);
-void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq);
+void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *folio);
+void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq);
 bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq);
 
 /*
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 16760695e667..4e3e62040831 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -71,7 +71,7 @@ static int netfs_requests_seq_show(struct seq_file *m, void *v)
 		   refcount_read(&rreq->ref),
 		   rreq->flags,
 		   rreq->error,
-		   atomic_read(&rreq->nr_outstanding),
+		   0,
 		   rreq->start, rreq->submitted, rreq->len);
 	seq_putc(m, '\n');
 	return 0;
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index dde4a679d9e2..dc6b41ef18b0 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -48,7 +48,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	spin_lock_init(&rreq->lock);
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
-	INIT_LIST_HEAD(&rreq->subrequests);
+	init_waitqueue_head(&rreq->waitq);
 	refcount_set(&rreq->ref, 1);
 
 	if (origin == NETFS_READAHEAD ||
@@ -56,10 +56,12 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	    origin == NETFS_READ_GAPS ||
 	    origin == NETFS_READ_SINGLE ||
 	    origin == NETFS_READ_FOR_WRITE ||
-	    origin == NETFS_DIO_READ)
-		INIT_WORK(&rreq->work, NULL);
-	else
+	    origin == NETFS_DIO_READ) {
+		INIT_WORK(&rreq->work, netfs_read_collection_worker);
+		rreq->io_streams[0].avail = true;
+	} else {
 		INIT_WORK(&rreq->work, netfs_write_collection_worker);
+	}
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
 	if (file && file->f_flags & O_NONBLOCK)
@@ -93,14 +95,6 @@ void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
 	struct netfs_io_stream *stream;
 	int s;
 
-	while (!list_empty(&rreq->subrequests)) {
-		subreq = list_first_entry(&rreq->subrequests,
-					  struct netfs_io_subrequest, rreq_link);
-		list_del(&subreq->rreq_link);
-		netfs_put_subrequest(subreq, was_async,
-				     netfs_sreq_trace_put_clear);
-	}
-
 	for (s = 0; s < ARRAY_SIZE(rreq->io_streams); s++) {
 		stream = &rreq->io_streams[s];
 		while (!list_empty(&stream->subrequests)) {
@@ -192,21 +186,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq
 	}
 
 	memset(subreq, 0, kmem_cache_size(cache));
-
-	switch (rreq->origin) {
-	case NETFS_READAHEAD:
-	case NETFS_READPAGE:
-	case NETFS_READ_GAPS:
-	case NETFS_READ_SINGLE:
-	case NETFS_READ_FOR_WRITE:
-	case NETFS_DIO_READ:
-		INIT_WORK(&subreq->work, netfs_read_subreq_termination_worker);
-		break;
-	default:
-		INIT_WORK(&subreq->work, NULL);
-		break;
-	}
-
+	INIT_WORK(&subreq->work, NULL);
 	INIT_LIST_HEAD(&subreq->rreq_link);
 	refcount_set(&subreq->ref, 2);
 	subreq->rreq = rreq;
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 2e9291ab1d62..f65affa5a9e4 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -14,6 +14,14 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
+/* Notes made in the collector */
+#define HIT_PENDING	0x01	/* A front op was still pending */
+#define MADE_PROGRESS	0x04	/* Made progress cleaning up a stream or the folio set */
+#define BUFFERED	0x08	/* The pagecache needs cleaning up */
+#define NEED_RETRY	0x10	/* A front op requests retrying */
+#define COPY_TO_CACHE	0x40	/* Need to copy subrequest to cache */
+#define ABANDON_SREQ	0x80	/* Need to abandon untransferred part of subrequest */
+
 /*
  * Clear the unread part of an I/O request.
  */
@@ -31,14 +39,18 @@ static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
  * cache the folio, we set the group to NETFS_FOLIO_COPY_TO_CACHE, mark it
  * dirty and let writeback handle it.
  */
-static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
-				    struct netfs_io_request *rreq,
+static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 				    struct folio_queue *folioq,
 				    int slot)
 {
 	struct netfs_folio *finfo;
 	struct folio *folio = folioq_folio(folioq, slot);
 
+	if (unlikely(folio_pos(folio) < rreq->abandon_to)) {
+		trace_netfs_folio(folio, netfs_folio_trace_abandon);
+		goto just_unlock;
+	}
+
 	flush_dcache_folio(folio);
 	folio_mark_uptodate(folio);
 
@@ -53,7 +65,7 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 			kfree(finfo);
 		}
 
-		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
+		if (test_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags)) {
 			if (!WARN_ON_ONCE(folio_get_private(folio) != NULL)) {
 				trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
 				folio_attach_private(folio, NETFS_FOLIO_COPY_TO_CACHE);
@@ -66,12 +78,11 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 		folioq_clear(folioq, slot);
 	} else {
 		// TODO: Use of PG_private_2 is deprecated.
-		if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
-			netfs_pgpriv2_mark_copy_to_cache(subreq, rreq, folioq, slot);
-		else
-			folioq_clear(folioq, slot);
+		if (test_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags))
+			netfs_pgpriv2_copy_to_cache(rreq, folio);
 	}
 
+just_unlock:
 	if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
 		if (folio->index == rreq->no_unlock_folio &&
 		    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags)) {
@@ -81,241 +92,249 @@ static void netfs_unlock_read_folio(struct netfs_io_subrequest *subreq,
 			folio_unlock(folio);
 		}
 	}
+
+	folioq_clear(folioq, slot);
 }
 
 /*
- * Unlock any folios that are now completely read.  Returns true if the
- * subrequest is removed from the list.
+ * Unlock any folios we've finished with.
  */
-static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
+static void netfs_read_unlock_folios(struct netfs_io_request *rreq,
+				     unsigned int *notes)
 {
-	struct netfs_io_subrequest *prev, *next;
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct folio_queue *folioq = subreq->curr_folioq;
-	size_t avail, prev_donated, next_donated, fsize, part, excess;
-	loff_t fpos, start;
-	loff_t fend;
-	int slot = subreq->curr_folioq_slot;
-
-	if (WARN(subreq->transferred > subreq->len,
-		 "Subreq overread: R%x[%x] %zu > %zu",
-		 rreq->debug_id, subreq->debug_index,
-		 subreq->transferred, subreq->len))
-		subreq->transferred = subreq->len;
-
-	trace_netfs_folioq(folioq, netfs_trace_folioq_read_progress);
-next_folio:
-	fsize = PAGE_SIZE << subreq->curr_folio_order;
-	fpos = round_down(subreq->start + subreq->consumed, fsize);
-	fend = fpos + fsize;
-
-	if (WARN_ON_ONCE(!folioq) ||
-	    WARN_ON_ONCE(!folioq_folio(folioq, slot)) ||
-	    WARN_ON_ONCE(folioq_folio(folioq, slot)->index != fpos / PAGE_SIZE)) {
-		pr_err("R=%08x[%x] s=%llx-%llx ctl=%zx/%zx/%zx sl=%u\n",
-		       rreq->debug_id, subreq->debug_index,
-		       subreq->start, subreq->start + subreq->transferred - 1,
-		       subreq->consumed, subreq->transferred, subreq->len,
-		       slot);
-		if (folioq) {
-			struct folio *folio = folioq_folio(folioq, slot);
-
-			pr_err("folioq: fq=%x orders=%02x%02x%02x%02x %px\n",
-			       folioq->debug_id,
-			       folioq->orders[0], folioq->orders[1],
-			       folioq->orders[2], folioq->orders[3],
-			       folioq);
-			if (folio)
-				pr_err("folio: %llx-%llx ix=%llx o=%u qo=%u\n",
-				       fpos, fend - 1, folio_pos(folio), folio_order(folio),
-				       folioq_folio_order(folioq, slot));
-		}
-	}
+	struct folio_queue *folioq = rreq->buffer.tail;
+	unsigned long long collected_to = rreq->collected_to;
+	unsigned int slot = rreq->buffer.first_tail_slot;
 
-donation_changed:
-	/* Try to consume the current folio if we've hit or passed the end of
-	 * it.  There's a possibility that this subreq doesn't start at the
-	 * beginning of the folio, in which case we need to donate to/from the
-	 * preceding subreq.
-	 *
-	 * We also need to include any potential donation back from the
-	 * following subreq.
-	 */
-	prev_donated = READ_ONCE(subreq->prev_donated);
-	next_donated =  READ_ONCE(subreq->next_donated);
-	if (prev_donated || next_donated) {
-		spin_lock(&rreq->lock);
-		prev_donated = subreq->prev_donated;
-		next_donated =  subreq->next_donated;
-		subreq->start -= prev_donated;
-		subreq->len += prev_donated;
-		subreq->transferred += prev_donated;
-		prev_donated = subreq->prev_donated = 0;
-		if (subreq->transferred == subreq->len) {
-			subreq->len += next_donated;
-			subreq->transferred += next_donated;
-			next_donated = subreq->next_donated = 0;
+	if (rreq->cleaned_to >= rreq->collected_to)
+		return;
+
+	// TODO: Begin decryption
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = rolling_buffer_delete_spent(&rreq->buffer);
+		if (!folioq) {
+			rreq->front_folio_order = 0;
+			return;
 		}
-		trace_netfs_sreq(subreq, netfs_sreq_trace_add_donations);
-		spin_unlock(&rreq->lock);
+		slot = 0;
 	}
 
-	avail = subreq->transferred;
-	if (avail == subreq->len)
-		avail += next_donated;
-	start = subreq->start;
-	if (subreq->consumed == 0) {
-		start -= prev_donated;
-		avail += prev_donated;
-	} else {
-		start += subreq->consumed;
-		avail -= subreq->consumed;
-	}
-	part = umin(avail, fsize);
-
-	trace_netfs_progress(subreq, start, avail, part);
-
-	if (start + avail >= fend) {
-		if (fpos == start) {
-			/* Flush, unlock and mark for caching any folio we've just read. */
-			subreq->consumed = fend - subreq->start;
-			netfs_unlock_read_folio(subreq, rreq, folioq, slot);
-			folioq_mark2(folioq, slot);
-			if (subreq->consumed >= subreq->len)
-				goto remove_subreq;
-		} else if (fpos < start) {
-			excess = fend - subreq->start;
-
-			spin_lock(&rreq->lock);
-			/* If we complete first on a folio split with the
-			 * preceding subreq, donate to that subreq - otherwise
-			 * we get the responsibility.
-			 */
-			if (subreq->prev_donated != prev_donated) {
-				spin_unlock(&rreq->lock);
-				goto donation_changed;
-			}
+	for (;;) {
+		struct folio *folio;
+		unsigned long long fpos, fend;
+		unsigned int order;
+		size_t fsize;
 
-			if (list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
-				spin_unlock(&rreq->lock);
-				pr_err("Can't donate prior to front\n");
-				goto bad;
-			}
+		if (*notes & COPY_TO_CACHE)
+			set_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
 
-			prev = list_prev_entry(subreq, rreq_link);
-			WRITE_ONCE(prev->next_donated, prev->next_donated + excess);
-			subreq->start += excess;
-			subreq->len -= excess;
-			subreq->transferred -= excess;
-			trace_netfs_donate(rreq, subreq, prev, excess,
-					   netfs_trace_donate_tail_to_prev);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
-
-			if (subreq->consumed >= subreq->len)
-				goto remove_subreq_locked;
-			spin_unlock(&rreq->lock);
-		} else {
-			pr_err("fpos > start\n");
-			goto bad;
-		}
+		folio = folioq_folio(folioq, slot);
+		if (WARN_ONCE(!folio_test_locked(folio),
+			      "R=%08x: folio %lx is not locked\n",
+			      rreq->debug_id, folio->index))
+			trace_netfs_folio(folio, netfs_folio_trace_not_locked);
 
-		/* Advance the rolling buffer to the next folio. */
+		order = folioq_folio_order(folioq, slot);
+		rreq->front_folio_order = order;
+		fsize = PAGE_SIZE << order;
+		fpos = folio_pos(folio);
+		fend = umin(fpos + fsize, rreq->i_size);
+
+		trace_netfs_collect_folio(rreq, folio, fend, collected_to);
+
+		/* Unlock any folio we've transferred all of. */
+		if (collected_to < fend)
+			break;
+
+		netfs_unlock_read_folio(rreq, folioq, slot);
+		WRITE_ONCE(rreq->cleaned_to, fpos + fsize);
+		*notes |= MADE_PROGRESS;
+
+		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
+
+		/* Clean up the head folioq.  If we clear an entire folioq, then
+		 * we can get rid of it provided it's not also the tail folioq
+		 * being filled by the issuer.
+		 */
+		folioq_clear(folioq, slot);
 		slot++;
 		if (slot >= folioq_nr_slots(folioq)) {
+			folioq = rolling_buffer_delete_spent(&rreq->buffer);
+			if (!folioq)
+				goto done;
 			slot = 0;
-			folioq = folioq->next;
-			subreq->curr_folioq = folioq;
 			trace_netfs_folioq(folioq, netfs_trace_folioq_read_progress);
 		}
-		subreq->curr_folioq_slot = slot;
-		if (folioq && folioq_folio(folioq, slot))
-			subreq->curr_folio_order = folioq->orders[slot];
-		cond_resched();
-		goto next_folio;
+
+		if (fpos + fsize >= collected_to)
+			break;
 	}
 
-	/* Deal with partial progress. */
-	if (subreq->transferred < subreq->len)
-		return false;
+	rreq->buffer.tail = folioq;
+done:
+	rreq->buffer.first_tail_slot = slot;
+}
 
-	/* Donate the remaining downloaded data to one of the neighbouring
-	 * subrequests.  Note that we may race with them doing the same thing.
+/*
+ * Collect and assess the results of various read subrequests.  We may need to
+ * retry some of the results.
+ *
+ * Note that we have a sequence of subrequests, which may be drawing on
+ * different sources and may or may not be the same size or starting position
+ * and may not even correspond in boundary alignment.
+ */
+static void netfs_collect_read_results(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *front, *remove;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	unsigned int notes;
+
+	_enter("%llx-%llx", rreq->start, rreq->start + rreq->len);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_collect);
+	trace_netfs_collect(rreq);
+
+reassess:
+	if (rreq->origin == NETFS_READAHEAD ||
+	    rreq->origin == NETFS_READPAGE ||
+	    rreq->origin == NETFS_READ_FOR_WRITE)
+		notes = BUFFERED;
+	else
+		notes = 0;
+
+	/* Remove completed subrequests from the front of the stream and
+	 * advance the completion point.  We stop when we hit something that's
+	 * in progress.  The issuer thread may be adding stuff to the tail
+	 * whilst we're doing this.
 	 */
-	spin_lock(&rreq->lock);
+	front = READ_ONCE(stream->front);
+	while (front) {
+		size_t transferred;
+
+		trace_netfs_collect_sreq(rreq, front);
+		_debug("sreq [%x] %llx %zx/%zx",
+		       front->debug_index, front->start, front->transferred, front->len);
+
+		if (stream->collected_to < front->start) {
+			trace_netfs_collect_gap(rreq, stream, front->start, 'F');
+			stream->collected_to = front->start;
+		}
+
+		if (test_bit(NETFS_SREQ_IN_PROGRESS, &front->flags))
+			notes |= HIT_PENDING;
+		smp_rmb(); /* Read counters after IN_PROGRESS flag. */
+		transferred = READ_ONCE(front->transferred);
+
+		/* If we can now collect the next folio, do so.  We don't want
+		 * to defer this as we have to decide whether we need to copy
+		 * to the cache or not, and that may differ between adjacent
+		 * subreqs.
+		 */
+		if (notes & BUFFERED) {
+			size_t fsize = PAGE_SIZE << rreq->front_folio_order;
+
+			/* Clear the tail of a short read. */
+			if (!(notes & HIT_PENDING) &&
+			    front->error == 0 &&
+			    transferred < front->len &&
+			    (test_bit(NETFS_SREQ_HIT_EOF, &front->flags) ||
+			     test_bit(NETFS_SREQ_CLEAR_TAIL, &front->flags))) {
+				netfs_clear_unread(front);
+				transferred = front->transferred = front->len;
+				trace_netfs_sreq(front, netfs_sreq_trace_clear);
+			}
 
-	if (subreq->prev_donated != prev_donated ||
-	    subreq->next_donated != next_donated) {
+			stream->collected_to = front->start + transferred;
+			rreq->collected_to = stream->collected_to;
+
+			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &front->flags))
+				notes |= COPY_TO_CACHE;
+
+			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
+				rreq->abandon_to = front->start + front->len;
+				front->transferred = front->len;
+				transferred = front->len;
+				trace_netfs_rreq(rreq, netfs_rreq_trace_set_abandon);
+			}
+			if (front->start + transferred >= rreq->cleaned_to + fsize ||
+			    test_bit(NETFS_SREQ_HIT_EOF, &front->flags))
+				netfs_read_unlock_folios(rreq, &notes);
+		} else {
+			stream->collected_to = front->start + transferred;
+			rreq->collected_to = stream->collected_to;
+		}
+
+		/* Stall if the front is still undergoing I/O. */
+		if (notes & HIT_PENDING)
+			break;
+
+		if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
+			if (!stream->failed) {
+				stream->error = front->error;
+				rreq->error = front->error;
+				set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+				stream->failed = true;
+			}
+			notes |= MADE_PROGRESS | ABANDON_SREQ;
+		} else if (test_bit(NETFS_SREQ_NEED_RETRY, &front->flags)) {
+			stream->need_retry = true;
+			notes |= NEED_RETRY | MADE_PROGRESS;
+			break;
+		} else {
+			if (!stream->failed)
+				stream->transferred = stream->collected_to - rreq->start;
+			notes |= MADE_PROGRESS;
+		}
+
+		/* Remove if completely consumed. */
+		stream->source = front->source;
+		spin_lock(&rreq->lock);
+
+		remove = front;
+		trace_netfs_sreq(front, netfs_sreq_trace_discard);
+		list_del_init(&front->rreq_link);
+		front = list_first_entry_or_null(&stream->subrequests,
+						 struct netfs_io_subrequest, rreq_link);
+		stream->front = front;
 		spin_unlock(&rreq->lock);
-		cond_resched();
-		goto donation_changed;
+		netfs_put_subrequest(remove, false,
+				     notes & ABANDON_SREQ ?
+				     netfs_sreq_trace_put_abandon :
+				     netfs_sreq_trace_put_done);
 	}
 
-	/* Deal with the trickiest case: that this subreq is in the middle of a
-	 * folio, not touching either edge, but finishes first.  In such a
-	 * case, we donate to the previous subreq, if there is one and if it is
-	 * contiguous, so that the donation is only handled when that completes
-	 * - and remove this subreq from the list.
-	 *
-	 * If the previous subreq finished first, we will have acquired their
-	 * donation and should be able to unlock folios and/or donate nextwards.
-	 */
-	if (!subreq->consumed &&
-	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
-	    subreq->start == prev->start + prev->len) {
-		prev = list_prev_entry(subreq, rreq_link);
-		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
-		subreq->start += subreq->len;
-		subreq->len = 0;
-		subreq->transferred = 0;
-		trace_netfs_donate(rreq, subreq, prev, subreq->len,
-				   netfs_trace_donate_to_prev);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
-		goto remove_subreq_locked;
-	}
+	trace_netfs_collect_stream(rreq, stream);
+	trace_netfs_collect_state(rreq, rreq->collected_to, notes);
 
-	/* If we can't donate down the chain, donate up the chain instead. */
-	excess = subreq->len - subreq->consumed + next_donated;
+	if (!(notes & BUFFERED))
+		rreq->cleaned_to = rreq->collected_to;
 
-	if (!subreq->consumed)
-		excess += prev_donated;
+	if (notes & NEED_RETRY)
+		goto need_retry;
+	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &rreq->flags)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_unpause);
+		clear_bit_unlock(NETFS_RREQ_PAUSE, &rreq->flags);
+		smp_mb__after_atomic(); /* Set PAUSE before task state */
+		wake_up(&rreq->waitq);
+	}
 
-	if (list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-		rreq->prev_donated = excess;
-		trace_netfs_donate(rreq, subreq, NULL, excess,
-				   netfs_trace_donate_to_deferred_next);
-	} else {
-		next = list_next_entry(subreq, rreq_link);
-		WRITE_ONCE(next->prev_donated, excess);
-		trace_netfs_donate(rreq, subreq, next, excess,
-				   netfs_trace_donate_to_next);
+	if (notes & MADE_PROGRESS) {
+		//cond_resched();
+		goto reassess;
 	}
-	trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_next);
-	subreq->len = subreq->consumed;
-	subreq->transferred = subreq->consumed;
-	goto remove_subreq_locked;
-
-remove_subreq:
-	spin_lock(&rreq->lock);
-remove_subreq_locked:
-	subreq->consumed = subreq->len;
-	list_del(&subreq->rreq_link);
-	spin_unlock(&rreq->lock);
-	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_consumed);
-	return true;
-
-bad:
-	/* Errr... prev and next both donated to us, but insufficient to finish
-	 * the folio.
+
+out:
+	_leave(" = %x", notes);
+	return;
+
+need_retry:
+	/* Okay...  We're going to have to retry parts of the stream.  Note
+	 * that any partially completed op will have had any wholly transferred
+	 * folios removed from it.
 	 */
-	printk("R=%08x[%x] s=%llx-%llx %zx/%zx/%zx\n",
-	       rreq->debug_id, subreq->debug_index,
-	       subreq->start, subreq->start + subreq->transferred - 1,
-	       subreq->consumed, subreq->transferred, subreq->len);
-	printk("folio: %llx-%llx\n", fpos, fend - 1);
-	printk("donated: prev=%zx next=%zx\n", prev_donated, next_donated);
-	printk("s=%llx av=%zx part=%zx\n", start, avail, part);
-	BUG();
+	_debug("retry");
+	netfs_retry_reads(rreq);
+	goto out;
 }
 
 /*
@@ -324,12 +343,13 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq)
 static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	unsigned int i;
 
 	/* Collect unbuffered reads and direct reads, adding up the transfer
 	 * sizes until we find the first short or failed subrequest.
 	 */
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
 		rreq->transferred += subreq->transferred;
 
 		if (subreq->transferred < subreq->len ||
@@ -366,22 +386,12 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
  */
 static void netfs_rreq_assess_single(struct netfs_io_request *rreq)
 {
-	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
-	subreq = list_first_entry_or_null(&stream->subrequests,
-					  struct netfs_io_subrequest, rreq_link);
-	if (subreq) {
-		if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-			rreq->error = subreq->error;
-		else
-			rreq->transferred = subreq->transferred;
-
-		if (!rreq->error && subreq->source == NETFS_DOWNLOAD_FROM_SERVER &&
-		    fscache_resources_valid(&rreq->cache_resources)) {
-			trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
-			netfs_single_mark_inode_dirty(rreq->inode);
-		}
+	if (!rreq->error && stream->source == NETFS_DOWNLOAD_FROM_SERVER &&
+	    fscache_resources_valid(&rreq->cache_resources)) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
+		netfs_single_mark_inode_dirty(rreq->inode);
 	}
 
 	if (rreq->iocb) {
@@ -395,21 +405,32 @@ static void netfs_rreq_assess_single(struct netfs_io_request *rreq)
 }
 
 /*
- * Assess the state of a read request and decide what to do next.
+ * Perform the collection of subrequests and folios.
  *
  * Note that we're in normal kernel thread context at this point, possibly
  * running on a workqueue.
  */
-void netfs_rreq_terminated(struct netfs_io_request *rreq)
+static void netfs_read_collection(struct netfs_io_request *rreq)
 {
-	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
-	//netfs_rreq_is_still_valid(rreq);
+	netfs_collect_read_results(rreq);
 
-	if (test_and_clear_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags)) {
-		netfs_retry_reads(rreq);
+	/* We're done when the app thread has finished posting subreqs and the
+	 * queue is empty.
+	 */
+	if (!test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags))
+		return;
+	smp_rmb(); /* Read ALL_QUEUED before subreq lists. */
+
+	if (!list_empty(&stream->subrequests))
 		return;
-	}
+
+	/* Okay, declare that all I/O is complete. */
+	rreq->transferred = stream->transferred;
+	trace_netfs_rreq(rreq, netfs_rreq_trace_complete);
+
+	//netfs_rreq_is_still_valid(rreq);
 
 	switch (rreq->origin) {
 	case NETFS_DIO_READ:
@@ -430,8 +451,35 @@ void netfs_rreq_terminated(struct netfs_io_request *rreq)
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_clear_subrequests(rreq, false);
 	netfs_unlock_abandoned_read_pages(rreq);
-	if (unlikely(test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)))
-		netfs_pgpriv2_write_to_the_cache(rreq);
+	if (unlikely(rreq->copy_to_cache))
+		netfs_pgpriv2_end_copy_to_cache(rreq);
+}
+
+void netfs_read_collection_worker(struct work_struct *work)
+{
+	struct netfs_io_request *rreq = container_of(work, struct netfs_io_request, work);
+
+	netfs_see_request(rreq, netfs_rreq_trace_see_work);
+	if (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
+		netfs_read_collection(rreq);
+	netfs_put_request(rreq, false, netfs_rreq_trace_put_work);
+}
+
+/*
+ * Wake the collection work item.
+ */
+void netfs_wake_read_collector(struct netfs_io_request *rreq)
+{
+	if (test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
+		if (!work_pending(&rreq->work)) {
+			netfs_get_request(rreq, netfs_rreq_trace_get_work);
+			if (!queue_work(system_unbound_wq, &rreq->work))
+				netfs_put_request(rreq, true, netfs_rreq_trace_put_work_nq);
+		}
+	} else {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wake_queue);
+		wake_up(&rreq->waitq);
+	}
 }
 
 /**
@@ -447,17 +495,22 @@ void netfs_rreq_terminated(struct netfs_io_request *rreq)
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
-
-	might_sleep();
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	size_t fsize = PAGE_SIZE << rreq->front_folio_order;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_progress);
 
-	if (subreq->transferred > subreq->consumed &&
+	/* If we are at the head of the queue, wake up the collector,
+	 * getting a ref to it if we were the ones to do so.
+	 */
+	if (subreq->start + subreq->transferred > rreq->cleaned_to + fsize &&
 	    (rreq->origin == NETFS_READAHEAD ||
 	     rreq->origin == NETFS_READPAGE ||
-	     rreq->origin == NETFS_READ_FOR_WRITE)) {
-		netfs_consume_read_data(subreq);
+	     rreq->origin == NETFS_READ_FOR_WRITE) &&
+	    list_is_first(&subreq->rreq_link, &stream->subrequests)
+	    ) {
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+		netfs_wake_read_collector(rreq);
 	}
 }
 EXPORT_SYMBOL(netfs_read_subreq_progress);
@@ -481,8 +534,7 @@ EXPORT_SYMBOL(netfs_read_subreq_progress);
 void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
-
-	might_sleep();
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
 	switch (subreq->source) {
 	case NETFS_READ_FROM_CACHE:
@@ -495,86 +547,156 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq)
 		break;
 	}
 
-	if (rreq->origin != NETFS_DIO_READ) {
-		/* Collect buffered reads.
-		 *
-		 * If the read completed validly short, then we can clear the
-		 * tail before going on to unlock the folios.
-		 */
-		if (subreq->error == 0 && subreq->transferred < subreq->len &&
-		    (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags) ||
-		     test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags))) {
-			netfs_clear_unread(subreq);
-			subreq->transferred = subreq->len;
-			trace_netfs_sreq(subreq, netfs_sreq_trace_clear);
-		}
-		if (subreq->transferred > subreq->consumed &&
-		    (rreq->origin == NETFS_READAHEAD ||
-		     rreq->origin == NETFS_READPAGE ||
-		     rreq->origin == NETFS_READ_FOR_WRITE)) {
-			netfs_consume_read_data(subreq);
-			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-		}
-		rreq->transferred += subreq->transferred;
-	}
-
 	/* Deal with retry requests, short reads and errors.  If we retry
 	 * but don't make progress, we abandon the attempt.
 	 */
 	if (!subreq->error && subreq->transferred < subreq->len) {
 		if (test_bit(NETFS_SREQ_HIT_EOF, &subreq->flags)) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_hit_eof);
+		} else if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_need_clear);
+		} else if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_need_retry);
+		} else if (test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
+			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_partial_read);
 		} else {
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			subreq->error = -ENODATA;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
-			if (subreq->transferred > subreq->consumed) {
-				/* If we didn't read new data, abandon retry. */
-				if (subreq->retry_count &&
-				    test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
-					__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-					set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
-				}
-			} else if (test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
-				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
-			} else {
-				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-				subreq->error = -ENODATA;
-			}
 		}
 	}
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
-
 	if (unlikely(subreq->error < 0)) {
 		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
 		if (subreq->source == NETFS_READ_FROM_CACHE) {
 			netfs_stat(&netfs_n_rh_read_failed);
+			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		} else {
 			netfs_stat(&netfs_n_rh_download_failed);
-			set_bit(NETFS_RREQ_FAILED, &rreq->flags);
-			rreq->error = subreq->error;
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		}
+		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
+		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
 	}
 
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
+
+	clear_bit_unlock(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	smp_mb__after_atomic(); /* Clear IN_PROGRESS before task state */
 
-	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
+	/* If we are at the head of the queue, wake up the collector. */
+	if (list_is_first(&subreq->rreq_link, &stream->subrequests))
+		netfs_wake_read_collector(rreq);
+
+	netfs_put_subrequest(subreq, true, netfs_sreq_trace_put_terminated);
 }
 EXPORT_SYMBOL(netfs_read_subreq_terminated);
 
-/**
- * netfs_read_subreq_termination_worker - Workqueue helper for read termination
- * @work: The subreq->work in the I/O request that has been terminated.
- *
- * Helper function to jump to netfs_read_subreq_terminated() from the
- * subrequest work item.
+/*
+ * Handle termination of a read from the cache.
  */
-void netfs_read_subreq_termination_worker(struct work_struct *work)
+void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool was_async)
 {
-	struct netfs_io_subrequest *subreq =
-		container_of(work, struct netfs_io_subrequest, work);
+	struct netfs_io_subrequest *subreq = priv;
 
+	if (transferred_or_error > 0) {
+		subreq->error = 0;
+		if (transferred_or_error > 0) {
+			subreq->transferred += transferred_or_error;
+			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+		}
+	} else {
+		subreq->error = transferred_or_error;
+	}
 	netfs_read_subreq_terminated(subreq);
 }
-EXPORT_SYMBOL(netfs_read_subreq_termination_worker);
+
+/*
+ * Wait for the read operation to complete, successfully or otherwise.
+ */
+ssize_t netfs_wait_for_read(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	DEFINE_WAIT(myself);
+	ssize_t ret;
+
+	for (;;) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
+		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
+
+		subreq = list_first_entry_or_null(&stream->subrequests,
+						  struct netfs_io_subrequest, rreq_link);
+		if (subreq &&
+		    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
+		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
+			__set_current_state(TASK_RUNNING);
+			netfs_read_collection(rreq);
+			continue;
+		}
+
+		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
+			break;
+
+		schedule();
+		trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
+	}
+
+	finish_wait(&rreq->waitq, &myself);
+
+	ret = rreq->error;
+	if (ret == 0) {
+		ret = rreq->transferred;
+		switch (rreq->origin) {
+		case NETFS_DIO_READ:
+		case NETFS_READ_SINGLE:
+			ret = rreq->transferred;
+			break;
+		default:
+			if (rreq->submitted < rreq->len) {
+				trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
+				ret = -EIO;
+			}
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Wait for a paused read operation to unpause or complete in some manner.
+ */
+void netfs_wait_for_pause(struct netfs_io_request *rreq)
+{
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	DEFINE_WAIT(myself);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_pause);
+
+	for (;;) {
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
+		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
+
+		subreq = list_first_entry_or_null(&stream->subrequests,
+						  struct netfs_io_subrequest, rreq_link);
+		if (subreq &&
+		    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
+		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
+			__set_current_state(TASK_RUNNING);
+			netfs_read_collection(rreq);
+			continue;
+		}
+
+		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||
+		    !test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+			break;
+
+		schedule();
+		trace_netfs_rreq(rreq, netfs_rreq_trace_woke_queue);
+	}
+
+	finish_wait(&rreq->waitq, &myself);
+}
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 9eee5af6b327..cf7727060215 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -13,54 +13,12 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
-/*
- * [DEPRECATED] Mark page as requiring copy-to-cache using PG_private_2.  The
- * third mark in the folio queue is used to indicate that this folio needs
- * writing.
- */
-void netfs_pgpriv2_mark_copy_to_cache(struct netfs_io_subrequest *subreq,
-				      struct netfs_io_request *rreq,
-				      struct folio_queue *folioq,
-				      int slot)
-{
-	struct folio *folio = folioq_folio(folioq, slot);
-
-	trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
-	folio_start_private_2(folio);
-	folioq_mark3(folioq, slot);
-}
-
-/*
- * [DEPRECATED] Cancel PG_private_2 on all marked folios in the event of an
- * unrecoverable error.
- */
-static void netfs_pgpriv2_cancel(struct rolling_buffer *buffer)
-{
-	struct folio_queue *folioq = buffer->tail;
-	struct folio *folio;
-	int slot;
-
-	while (folioq) {
-		if (!folioq->marks3) {
-			folioq = folioq->next;
-			continue;
-		}
-
-		slot = __ffs(folioq->marks3);
-		folio = folioq_folio(folioq, slot);
-
-		trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
-		folio_end_private_2(folio);
-		folioq_unmark3(folioq, slot);
-	}
-}
-
 /*
  * [DEPRECATED] Copy a folio to the cache with PG_private_2 set.
  */
-static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio *folio)
+static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio *folio)
 {
-	struct netfs_io_stream *cache  = &wreq->io_streams[1];
+	struct netfs_io_stream *cache = &creq->io_streams[1];
 	size_t fsize = folio_size(folio), flen = fsize;
 	loff_t fpos = folio_pos(folio), i_size;
 	bool to_eof = false;
@@ -71,17 +29,17 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 	 * of the page to beyond it, but cannot move i_size into or through the
 	 * page since we have it locked.
 	 */
-	i_size = i_size_read(wreq->inode);
+	i_size = i_size_read(creq->inode);
 
 	if (fpos >= i_size) {
 		/* mmap beyond eof. */
 		_debug("beyond eof");
 		folio_end_private_2(folio);
-		return 0;
+		return;
 	}
 
-	if (fpos + fsize > wreq->i_size)
-		wreq->i_size = i_size;
+	if (fpos + fsize > creq->i_size)
+		creq->i_size = i_size;
 
 	if (flen > i_size - fpos) {
 		flen = i_size - fpos;
@@ -95,8 +53,10 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 	trace_netfs_folio(folio, netfs_folio_trace_store_copy);
 
 	/* Attach the folio to the rolling buffer. */
-	if (rolling_buffer_append(&wreq->buffer, folio, 0) < 0)
-		return -ENOMEM;
+	if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
+		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
+		return;
+	}
 
 	cache->submit_extendable_to = fsize;
 	cache->submit_off = 0;
@@ -110,11 +70,11 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 	do {
 		ssize_t part;
 
-		wreq->buffer.iter.iov_offset = cache->submit_off;
+		creq->buffer.iter.iov_offset = cache->submit_off;
 
-		atomic64_set(&wreq->issued_to, fpos + cache->submit_off);
+		atomic64_set(&creq->issued_to, fpos + cache->submit_off);
 		cache->submit_extendable_to = fsize - cache->submit_off;
-		part = netfs_advance_write(wreq, cache, fpos + cache->submit_off,
+		part = netfs_advance_write(creq, cache, fpos + cache->submit_off,
 					   cache->submit_len, to_eof);
 		cache->submit_off += part;
 		if (part > cache->submit_len)
@@ -123,98 +83,95 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 			cache->submit_len -= part;
 	} while (cache->submit_len > 0);
 
-	wreq->buffer.iter.iov_offset = 0;
-	rolling_buffer_advance(&wreq->buffer, fsize);
-	atomic64_set(&wreq->issued_to, fpos + fsize);
+	creq->buffer.iter.iov_offset = 0;
+	rolling_buffer_advance(&creq->buffer, fsize);
+	atomic64_set(&creq->issued_to, fpos + fsize);
 
 	if (flen < fsize)
-		netfs_issue_write(wreq, cache);
-
-	_leave(" = 0");
-	return 0;
+		netfs_issue_write(creq, cache);
 }
 
 /*
- * [DEPRECATED] Go through the buffer and write any folios that are marked with
- * the third mark to the cache.
+ * [DEPRECATED] Set up copying to the cache.
  */
-void netfs_pgpriv2_write_to_the_cache(struct netfs_io_request *rreq)
+static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
+	struct netfs_io_request *rreq, struct folio *folio)
 {
-	struct netfs_io_request *wreq;
-	struct folio_queue *folioq;
-	struct folio *folio;
-	int error = 0;
-	int slot = 0;
-
-	_enter("");
+	struct netfs_io_request *creq;
 
 	if (!fscache_resources_valid(&rreq->cache_resources))
-		goto couldnt_start;
+		goto cancel;
 
-	/* Need the first folio to be able to set up the op. */
-	for (folioq = rreq->buffer.tail; folioq; folioq = folioq->next) {
-		if (folioq->marks3) {
-			slot = __ffs(folioq->marks3);
-			break;
-		}
-	}
-	if (!folioq)
-		return;
-	folio = folioq_folio(folioq, slot);
-
-	wreq = netfs_create_write_req(rreq->mapping, NULL, folio_pos(folio),
+	creq = netfs_create_write_req(rreq->mapping, NULL, folio_pos(folio),
 				      NETFS_PGPRIV2_COPY_TO_CACHE);
-	if (IS_ERR(wreq)) {
-		kleave(" [create %ld]", PTR_ERR(wreq));
-		goto couldnt_start;
-	}
+	if (IS_ERR(creq))
+		goto cancel;
 
-	trace_netfs_write(wreq, netfs_write_trace_copy_to_cache);
+	if (!creq->io_streams[1].avail)
+		goto cancel_put;
+
+	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
-	if (!wreq->io_streams[1].avail) {
-		netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-		goto couldnt_start;
-	}
+	rreq->copy_to_cache = creq;
+	return creq;
+
+cancel_put:
+	netfs_put_request(creq, false, netfs_rreq_trace_put_return);
+cancel:
+	rreq->copy_to_cache = ERR_PTR(-ENOBUFS);
+	clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
+	return ERR_PTR(-ENOBUFS);
+}
 
-	for (;;) {
-		error = netfs_pgpriv2_copy_folio(wreq, folio);
-		if (error < 0)
-			break;
+/*
+ * [DEPRECATED] Mark page as requiring copy-to-cache using PG_private_2 and add
+ * it to the copy write request.
+ */
+void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *folio)
+{
+	struct netfs_io_request *creq = rreq->copy_to_cache;
 
-		folioq_unmark3(folioq, slot);
-		if (!folioq->marks3) {
-			folioq = folioq->next;
-			if (!folioq)
-				break;
-		}
+	if (!creq)
+		creq = netfs_pgpriv2_begin_copy_to_cache(rreq, folio);
+	if (IS_ERR(creq))
+		return;
 
-		slot = __ffs(folioq->marks3);
-		folio = folioq_folio(folioq, slot);
-	}
+	trace_netfs_folio(folio, netfs_folio_trace_copy_to_cache);
+	folio_start_private_2(folio);
+	netfs_pgpriv2_copy_folio(creq, folio);
+}
+
+/*
+ * [DEPRECATED] End writing to the cache, flushing out any outstanding writes.
+ */
+void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq)
+{
+	struct netfs_io_request *creq = rreq->copy_to_cache;
+
+	if (IS_ERR_OR_NULL(creq))
+		return;
 
-	netfs_issue_write(wreq, &wreq->io_streams[1]);
+	netfs_issue_write(creq, &creq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+	set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
 
-	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-	_leave(" = %d", error);
-couldnt_start:
-	netfs_pgpriv2_cancel(&rreq->buffer);
+	netfs_put_request(creq, false, netfs_rreq_trace_put_return);
+	creq->copy_to_cache = NULL;
 }
 
 /*
  * [DEPRECATED] Remove the PG_private_2 mark from any folios we've finished
  * copying.
  */
-bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
+bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *creq)
 {
-	struct folio_queue *folioq = wreq->buffer.tail;
-	unsigned long long collected_to = wreq->collected_to;
-	unsigned int slot = wreq->buffer.first_tail_slot;
+	struct folio_queue *folioq = creq->buffer.tail;
+	unsigned long long collected_to = creq->collected_to;
+	unsigned int slot = creq->buffer.first_tail_slot;
 	bool made_progress = false;
 
 	if (slot >= folioq_nr_slots(folioq)) {
-		folioq = rolling_buffer_delete_spent(&wreq->buffer);
+		folioq = rolling_buffer_delete_spent(&creq->buffer);
 		slot = 0;
 	}
 
@@ -226,16 +183,16 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 		folio = folioq_folio(folioq, slot);
 		if (WARN_ONCE(!folio_test_private_2(folio),
 			      "R=%08x: folio %lx is not marked private_2\n",
-			      wreq->debug_id, folio->index))
+			      creq->debug_id, folio->index))
 			trace_netfs_folio(folio, netfs_folio_trace_not_under_wback);
 
 		fpos = folio_pos(folio);
 		fsize = folio_size(folio);
 		flen = fsize;
 
-		fend = min_t(unsigned long long, fpos + flen, wreq->i_size);
+		fend = min_t(unsigned long long, fpos + flen, creq->i_size);
 
-		trace_netfs_collect_folio(wreq, folio, fend, collected_to);
+		trace_netfs_collect_folio(creq, folio, fend, collected_to);
 
 		/* Unlock any folio we've transferred all of. */
 		if (collected_to < fend)
@@ -243,7 +200,7 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 
 		trace_netfs_folio(folio, netfs_folio_trace_end_copy);
 		folio_end_private_2(folio);
-		wreq->cleaned_to = fpos + fsize;
+		creq->cleaned_to = fpos + fsize;
 		made_progress = true;
 
 		/* Clean up the head folioq.  If we clear an entire folioq, then
@@ -253,7 +210,7 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 		folioq_clear(folioq, slot);
 		slot++;
 		if (slot >= folioq_nr_slots(folioq)) {
-			folioq = rolling_buffer_delete_spent(&wreq->buffer);
+			folioq = rolling_buffer_delete_spent(&creq->buffer);
 			if (!folioq)
 				goto done;
 			slot = 0;
@@ -263,8 +220,8 @@ bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
 			break;
 	}
 
-	wreq->buffer.tail = folioq;
+	creq->buffer.tail = folioq;
 done:
-	wreq->buffer.first_tail_slot = slot;
+	creq->buffer.first_tail_slot = slot;
 	return made_progress;
 }
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index a33bd06e80f8..bf6f26525b0d 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -12,15 +12,7 @@
 static void netfs_reissue_read(struct netfs_io_request *rreq,
 			       struct netfs_io_subrequest *subreq)
 {
-	struct iov_iter *io_iter = &subreq->io_iter;
-
-	if (iov_iter_is_folioq(io_iter)) {
-		subreq->curr_folioq = (struct folio_queue *)io_iter->folioq;
-		subreq->curr_folioq_slot = io_iter->folioq_slot;
-		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
-	}
-
-	atomic_inc(&rreq->nr_outstanding);
+	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 	subreq->rreq->netfs_ops->issue_read(subreq);
@@ -33,13 +25,12 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
 static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 {
 	struct netfs_io_subrequest *subreq;
-	struct netfs_io_stream *stream0 = &rreq->io_streams[0];
-	LIST_HEAD(sublist);
-	LIST_HEAD(queue);
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	struct list_head *next;
 
 	_enter("R=%x", rreq->debug_id);
 
-	if (list_empty(&rreq->subrequests))
+	if (list_empty(&stream->subrequests))
 		return;
 
 	if (rreq->netfs_ops->retry_request)
@@ -50,9 +41,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	 */
 	if (!rreq->netfs_ops->prepare_read &&
 	    !rreq->cache_resources.ops) {
-		struct netfs_io_subrequest *subreq;
-
-		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
@@ -75,48 +64,44 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	 * populating with smaller subrequests.  In the event that the subreq
 	 * we just launched finishes before we insert the next subreq, it'll
 	 * fill in rreq->prev_donated instead.
-
+	 *
 	 * Note: Alternatively, we could split the tail subrequest right before
 	 * we reissue it and fix up the donations under lock.
 	 */
-	list_splice_init(&rreq->subrequests, &queue);
+	next = stream->subrequests.next;
 
 	do {
-		struct netfs_io_subrequest *from;
+		struct netfs_io_subrequest *from, *to, *tmp;
 		struct iov_iter source;
 		unsigned long long start, len;
-		size_t part, deferred_next_donated = 0;
+		size_t part;
 		bool boundary = false;
 
 		/* Go through the subreqs and find the next span of contiguous
 		 * buffer that we then rejig (cifs, for example, needs the
 		 * rsize renegotiating) and reissue.
 		 */
-		from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
-		list_move_tail(&from->rreq_link, &sublist);
+		from = list_entry(next, struct netfs_io_subrequest, rreq_link);
+		to = from;
 		start = from->start + from->transferred;
 		len   = from->len   - from->transferred;
 
-		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
+		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx",
 		       rreq->debug_id, from->debug_index,
-		       from->start, from->consumed, from->transferred, from->len);
+		       from->start, from->transferred, from->len);
 
 		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
 			goto abandon;
 
-		deferred_next_donated = from->next_donated;
-		while ((subreq = list_first_entry_or_null(
-				&queue, struct netfs_io_subrequest, rreq_link))) {
-			if (subreq->start != start + len ||
-			    subreq->transferred > 0 ||
+		list_for_each_continue(next, &stream->subrequests) {
+			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
+			if (subreq->start + subreq->transferred != start + len ||
+			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
 			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 				break;
-			list_move_tail(&subreq->rreq_link, &sublist);
-			len += subreq->len;
-			deferred_next_donated = subreq->next_donated;
-			if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
-				break;
+			to = subreq;
+			len += to->len;
 		}
 
 		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
@@ -129,37 +114,30 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		source.count = len;
 
 		/* Work through the sublist. */
-		while ((subreq = list_first_entry_or_null(
-				&sublist, struct netfs_io_subrequest, rreq_link))) {
-			list_del(&subreq->rreq_link);
-
+		subreq = from;
+		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
+			if (!len)
+				break;
 			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->start	= start - subreq->transferred;
 			subreq->len	= len   + subreq->transferred;
-			stream0->sreq_max_len = subreq->len;
-
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 			subreq->retry_count++;
 
-			spin_lock(&rreq->lock);
-			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-			subreq->prev_donated += rreq->prev_donated;
-			rreq->prev_donated = 0;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-			spin_unlock(&rreq->lock);
-
-			BUG_ON(!len);
 
 			/* Renegotiate max_len (rsize) */
+			stream->sreq_max_len = subreq->len;
 			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
 				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+				goto abandon;
 			}
 
-			part = umin(len, stream0->sreq_max_len);
-			if (unlikely(rreq->io_streams[0].sreq_max_segs))
-				part = netfs_limit_iter(&source, 0, part, stream0->sreq_max_segs);
+			part = umin(len, stream->sreq_max_len);
+			if (unlikely(stream->sreq_max_segs))
+				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
 			subreq->len = subreq->transferred + part;
 			subreq->io_iter = source;
 			iov_iter_truncate(&subreq->io_iter, part);
@@ -169,57 +147,105 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			if (!len) {
 				if (boundary)
 					__set_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
-				subreq->next_donated = deferred_next_donated;
 			} else {
 				__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
-				subreq->next_donated = 0;
 			}
 
+			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 			netfs_reissue_read(rreq, subreq);
-			if (!len)
+			if (subreq == to)
 				break;
-
-			/* If we ran out of subrequests, allocate another. */
-			if (list_empty(&sublist)) {
-				subreq = netfs_alloc_subrequest(rreq);
-				if (!subreq)
-					goto abandon;
-				subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
-				subreq->start = start;
-
-				/* We get two refs, but need just one. */
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_new);
-				trace_netfs_sreq(subreq, netfs_sreq_trace_split);
-				list_add_tail(&subreq->rreq_link, &sublist);
-			}
 		}
 
 		/* If we managed to use fewer subreqs, we can discard the
-		 * excess.
+		 * excess; if we used the same number, then we're done.
 		 */
-		while ((subreq = list_first_entry_or_null(
-				&sublist, struct netfs_io_subrequest, rreq_link))) {
-			trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
-			list_del(&subreq->rreq_link);
-			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
+		if (!len) {
+			if (subreq == to)
+				continue;
+			list_for_each_entry_safe_from(subreq, tmp,
+						      &stream->subrequests, rreq_link) {
+				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
+				list_del(&subreq->rreq_link);
+				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
+				if (subreq == to)
+					break;
+			}
+			continue;
 		}
 
-	} while (!list_empty(&queue));
+		/* We ran out of subrequests, so we need to allocate some more
+		 * and insert them after.
+		 */
+		do {
+			subreq = netfs_alloc_subrequest(rreq);
+			if (!subreq) {
+				subreq = to;
+				goto abandon_after;
+			}
+			subreq->source		= NETFS_DOWNLOAD_FROM_SERVER;
+			subreq->start		= start;
+			subreq->len		= len;
+			subreq->debug_index	= atomic_inc_return(&rreq->subreq_counter);
+			subreq->stream_nr	= stream->stream_nr;
+			subreq->retry_count	= 1;
+
+			trace_netfs_sreq_ref(rreq->debug_id, subreq->debug_index,
+					     refcount_read(&subreq->ref),
+					     netfs_sreq_trace_new);
+			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+
+			list_add(&subreq->rreq_link, &to->rreq_link);
+			to = list_next_entry(to, rreq_link);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+
+			stream->sreq_max_len	= umin(len, rreq->rsize);
+			stream->sreq_max_segs	= 0;
+			if (unlikely(stream->sreq_max_segs))
+				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
+
+			netfs_stat(&netfs_n_rh_download);
+			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
+				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
+				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+				goto abandon;
+			}
+
+			part = umin(len, stream->sreq_max_len);
+			subreq->len = subreq->transferred + part;
+			subreq->io_iter = source;
+			iov_iter_truncate(&subreq->io_iter, part);
+			iov_iter_advance(&source, part);
+
+			len -= part;
+			start += part;
+			if (!len && boundary) {
+				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
+				boundary = false;
+			}
+
+			netfs_reissue_read(rreq, subreq);
+		} while (len);
+
+	} while (!list_is_head(next, &stream->subrequests));
 
 	return;
 
-	/* If we hit ENOMEM, fail all remaining subrequests */
+	/* If we hit an error, fail all remaining incomplete subrequests */
+abandon_after:
+	if (list_is_last(&subreq->rreq_link, &stream->subrequests))
+		return;
+	subreq = list_next_entry(subreq, rreq_link);
 abandon:
-	list_splice_init(&sublist, &queue);
-	list_for_each_entry(subreq, &queue, rreq_link) {
-		if (!subreq->error)
-			subreq->error = -ENOMEM;
-		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+	list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
+		if (!subreq->error &&
+		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
+		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
+			continue;
+		subreq->error = -ENOMEM;
+		__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 	}
-	spin_lock(&rreq->lock);
-	list_splice_tail_init(&queue, &rreq->subrequests);
-	spin_unlock(&rreq->lock);
 }
 
 /*
@@ -227,14 +253,19 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
  */
 void netfs_retry_reads(struct netfs_io_request *rreq)
 {
-	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
+	struct netfs_io_subrequest *subreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
-	atomic_inc(&rreq->nr_outstanding);
+	/* Wait for all outstanding I/O to quiesce before performing retries as
+	 * we may need to renegotiate the I/O sizes.
+	 */
+	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
+		wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+	}
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
 	netfs_retry_read_subrequests(rreq);
-
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq);
 }
 
 /*
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 2a66c5fde071..14bc61107182 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -77,6 +77,7 @@ static void netfs_single_read_cache(struct netfs_io_request *rreq,
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
+	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
 	netfs_stat(&netfs_n_rh_read);
 	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_FAIL,
 			netfs_cache_read_terminated, subreq);
@@ -88,28 +89,28 @@ static void netfs_single_read_cache(struct netfs_io_request *rreq,
  */
 static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 {
+	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	struct netfs_io_subrequest *subreq;
 	int ret = 0;
 
-	atomic_set(&rreq->nr_outstanding, 1);
-
 	subreq = netfs_alloc_subrequest(rreq);
-	if (!subreq) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!subreq)
+		return -ENOMEM;
 
 	subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
 	subreq->start	= 0;
 	subreq->len	= rreq->len;
 	subreq->io_iter	= rreq->buffer.iter;
 
-	atomic_inc(&rreq->nr_outstanding);
+	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
-	spin_lock_bh(&rreq->lock);
-	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+	spin_lock(&rreq->lock);
+	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-	spin_unlock_bh(&rreq->lock);
+	stream->front = subreq;
+	/* Store list pointers before active flag */
+	smp_store_release(&stream->active, true);
+	spin_unlock(&rreq->lock);
 
 	netfs_single_cache_prepare_read(rreq, subreq);
 	switch (subreq->source) {
@@ -137,14 +138,12 @@ static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 		break;
 	}
 
-out:
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		netfs_rreq_terminated(rreq);
+	smp_wmb(); /* Write lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 	return ret;
 cancel:
-	atomic_dec(&rreq->nr_outstanding);
 	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
-	goto out;
+	return ret;
 }
 
 /**
@@ -185,13 +184,7 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	rreq->buffer.iter = *iter;
 	netfs_single_dispatch_read(rreq);
 
-	trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
-	wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
-		    TASK_UNINTERRUPTIBLE);
-
-	ret = rreq->error;
-	if (ret == 0)
-		ret = rreq->transferred;
+	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, true, netfs_rreq_trace_put_return);
 	return ret;
 
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index d54526d2e751..1b7f53d01b8d 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -289,7 +289,9 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		goto need_retry;
 	if ((notes & MADE_PROGRESS) && test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 		trace_netfs_rreq(wreq, netfs_rreq_trace_unpause);
-		clear_and_wake_up_bit(NETFS_RREQ_PAUSE, &wreq->flags);
+		clear_bit_unlock(NETFS_RREQ_PAUSE, &wreq->flags);
+		smp_mb__after_atomic(); /* Set PAUSE before task state */
+		wake_up(&wreq->waitq);
 	}
 
 	if (notes & NEED_REASSESS) {
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 6f14a7c2f040..69727411683e 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -723,7 +723,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 		rolling_buffer_advance(&wreq->buffer, part);
 		if (test_bit(NETFS_RREQ_PAUSE, &wreq->flags)) {
 			trace_netfs_rreq(wreq, netfs_rreq_trace_wait_pause);
-			wait_on_bit(&wreq->flags, NETFS_RREQ_PAUSE, TASK_UNINTERRUPTIBLE);
+			wait_event(wreq->waitq, !test_bit(NETFS_RREQ_PAUSE, &wreq->flags));
 		}
 		if (test_bit(NETFS_RREQ_FAILED, &wreq->flags))
 			break;
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index f3d5e37d4698..c841a851dd73 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -93,15 +93,21 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
 			if (!len)
 				break;
-			/* Renegotiate max_len (wsize) */
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+
+			subreq->start	= start;
+			subreq->len	= len;
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 			subreq->retry_count++;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+
+			/* Renegotiate max_len (wsize) */
+			stream->sreq_max_len = len;
 			stream->prepare_write(subreq);
 
-			part = min(len, stream->sreq_max_len);
+			part = umin(len, stream->sreq_max_len);
+			if (unlikely(stream->sreq_max_segs))
+				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
 			subreq->len = part;
-			subreq->start = start;
 			subreq->transferred = 0;
 			len -= part;
 			start += part;
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 7c9cc6945d18..000522a34985 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1322,6 +1322,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		} else if (rdata->got_bytes > 0) {
 			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 		}
+		if (rdata->got_bytes)
+			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 	}
 
 	rdata->credits.value = 0;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ce57d8697c7c..81c76e1b7209 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4607,7 +4607,8 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
 		}
-		__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
+		if (rdata->got_bytes)
+			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 	}
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
 			      server->credits, server->in_flight,
@@ -4616,7 +4617,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	rdata->subreq.error = rdata->result;
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
-	queue_work(cifsiod_wq, &rdata->subreq.work);
+	netfs_read_subreq_terminated(&rdata->subreq);
 	release_mid(mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 27e62f7d2940..071d05d81d38 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -181,9 +181,6 @@ struct netfs_io_subrequest {
 	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
-	size_t			consumed;	/* Amount of read data consumed */
-	size_t			prev_donated;	/* Amount of data donated from previous subreq */
-	size_t			next_donated;	/* Amount of data donated from next subreq */
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
@@ -191,9 +188,6 @@ struct netfs_io_subrequest {
 	u8			retry_count;	/* The number of retries (0 on initial pass) */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
-	unsigned char		curr_folioq_slot; /* Folio currently being read */
-	unsigned char		curr_folio_order; /* Order of folio */
-	struct folio_queue	*curr_folioq;	/* Queue segment in which current folio resides */
 	unsigned long		flags;
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
@@ -236,15 +230,16 @@ struct netfs_io_request {
 	struct address_space	*mapping;	/* The mapping being accessed */
 	struct kiocb		*iocb;		/* AIO completion vector */
 	struct netfs_cache_resources cache_resources;
+	struct netfs_io_request	*copy_to_cache;	/* Request to write just-read data to the cache */
 	struct readahead_control *ractl;	/* Readahead descriptor */
 	struct list_head	proc_link;	/* Link in netfs_iorequests */
-	struct list_head	subrequests;	/* Contributory I/O operations */
 	struct netfs_io_stream	io_streams[2];	/* Streams of parallel I/O operations */
 #define NR_IO_STREAMS 2 //wreq->nr_io_streams
 	struct netfs_group	*group;		/* Writeback group being written back */
 	struct rolling_buffer	buffer;		/* Unencrypted buffer */
 #define NETFS_ROLLBUF_PUT_MARK		ROLLBUF_MARK_1
 #define NETFS_ROLLBUF_PAGECACHE_MARK	ROLLBUF_MARK_2
+	wait_queue_head_t	waitq;		/* Processor waiter */
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
 	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
@@ -255,7 +250,6 @@ struct netfs_io_request {
 	atomic_t		subreq_counter;	/* Next subreq->debug_index */
 	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
 	spinlock_t		lock;		/* Lock for queuing subreqs */
-	atomic_t		nr_outstanding;	/* Number of ops in progress */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
@@ -267,14 +261,17 @@ struct netfs_io_request {
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
+	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
-	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
+	unsigned char		front_folio_order; /* Order (size) of front folio */
 	refcount_t		ref;
 	unsigned long		flags;
+#define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
+#define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
@@ -439,7 +436,6 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 /* (Sub)request management API. */
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);
 void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq);
-void netfs_read_subreq_termination_worker(struct work_struct *work);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
 			  enum netfs_sreq_ref_trace what);
 void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 6df2e7313371..6e699cadcb29 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -50,18 +50,23 @@
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_copy,		"COPY   ")	\
 	EM(netfs_rreq_trace_collect,		"COLLECT")	\
+	EM(netfs_rreq_trace_complete,		"COMPLET")	\
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
+	EM(netfs_rreq_trace_set_abandon,	"S-ABNDN")	\
 	EM(netfs_rreq_trace_set_pause,		"PAUSE  ")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
 	EM(netfs_rreq_trace_unlock_pgpriv2,	"UNLCK-2")	\
 	EM(netfs_rreq_trace_unmark,		"UNMARK ")	\
 	EM(netfs_rreq_trace_wait_ip,		"WAIT-IP")	\
 	EM(netfs_rreq_trace_wait_pause,		"WT-PAUS")	\
+	EM(netfs_rreq_trace_wait_queue,		"WAIT-Q ")	\
 	EM(netfs_rreq_trace_wake_ip,		"WAKE-IP")	\
+	EM(netfs_rreq_trace_wake_queue,		"WAKE-Q ")	\
+	EM(netfs_rreq_trace_woke_queue,		"WOKE-Q ")	\
 	EM(netfs_rreq_trace_unpause,		"UNPAUSE")	\
 	E_(netfs_rreq_trace_write_done,		"WR-DONE")
 
@@ -81,6 +86,7 @@
 	EM(netfs_sreq_trace_cache_nowrite,	"CA-NW")	\
 	EM(netfs_sreq_trace_cache_prepare,	"CA-PR")	\
 	EM(netfs_sreq_trace_cache_write,	"CA-WR")	\
+	EM(netfs_sreq_trace_cancel,		"CANCL")	\
 	EM(netfs_sreq_trace_clear,		"CLEAR")	\
 	EM(netfs_sreq_trace_discard,		"DSCRD")	\
 	EM(netfs_sreq_trace_donate_to_prev,	"DON-P")	\
@@ -91,6 +97,9 @@
 	EM(netfs_sreq_trace_hit_eof,		"EOF  ")	\
 	EM(netfs_sreq_trace_io_progress,	"IO   ")	\
 	EM(netfs_sreq_trace_limited,		"LIMIT")	\
+	EM(netfs_sreq_trace_need_clear,		"N-CLR")	\
+	EM(netfs_sreq_trace_partial_read,	"PARTR")	\
+	EM(netfs_sreq_trace_need_retry,		"NRTRY")	\
 	EM(netfs_sreq_trace_prepare,		"PREP ")	\
 	EM(netfs_sreq_trace_prep_failed,	"PRPFL")	\
 	EM(netfs_sreq_trace_progress,		"PRGRS")	\
@@ -136,6 +145,7 @@
 	EM(netfs_sreq_trace_get_submit,		"GET SUBMIT")	\
 	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
+	EM(netfs_sreq_trace_put_abandon,	"PUT ABANDON")	\
 	EM(netfs_sreq_trace_put_cancel,		"PUT CANCEL ")	\
 	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\
 	EM(netfs_sreq_trace_put_consumed,	"PUT CONSUME")	\
@@ -176,6 +186,7 @@
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_not_under_wback,	"!wback")	\
+	EM(netfs_folio_trace_not_locked,	"!locked")	\
 	EM(netfs_folio_trace_put,		"put")		\
 	EM(netfs_folio_trace_read,		"read")		\
 	EM(netfs_folio_trace_read_done,		"read-done")	\
@@ -204,7 +215,6 @@
 	EM(netfs_trace_folioq_clear,		"clear")	\
 	EM(netfs_trace_folioq_delete,		"delete")	\
 	EM(netfs_trace_folioq_make_space,	"make-space")	\
-	EM(netfs_trace_folioq_prep_write,	"prep-wr")	\
 	EM(netfs_trace_folioq_rollbuf_init,	"roll-init")	\
 	E_(netfs_trace_folioq_read_progress,	"r-progress")
 
@@ -352,7 +362,7 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->len	= sreq->len;
 		    __entry->transferred = sreq->transferred;
 		    __entry->start	= sreq->start;
-		    __entry->slot	= sreq->curr_folioq_slot;
+		    __entry->slot	= sreq->io_iter.folioq_slot;
 			   ),
 
 	    TP_printk("R=%08x[%x] %s %s f=%02x s=%llx %zx/%zx s=%u e=%d",
@@ -701,71 +711,6 @@ TRACE_EVENT(netfs_collect_stream,
 		      __entry->collected_to, __entry->front)
 	    );
 
-TRACE_EVENT(netfs_progress,
-	    TP_PROTO(const struct netfs_io_subrequest *subreq,
-		     unsigned long long start, size_t avail, size_t part),
-
-	    TP_ARGS(subreq, start, avail, part),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq)
-		    __field(unsigned int,		subreq)
-		    __field(unsigned int,		consumed)
-		    __field(unsigned int,		transferred)
-		    __field(unsigned long long,		f_start)
-		    __field(unsigned int,		f_avail)
-		    __field(unsigned int,		f_part)
-		    __field(unsigned char,		slot)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->rreq	= subreq->rreq->debug_id;
-		    __entry->subreq	= subreq->debug_index;
-		    __entry->consumed	= subreq->consumed;
-		    __entry->transferred = subreq->transferred;
-		    __entry->f_start	= start;
-		    __entry->f_avail	= avail;
-		    __entry->f_part	= part;
-		    __entry->slot	= subreq->curr_folioq_slot;
-			   ),
-
-	    TP_printk("R=%08x[%02x] s=%llx ct=%x/%x pa=%x/%x sl=%x",
-		      __entry->rreq, __entry->subreq, __entry->f_start,
-		      __entry->consumed, __entry->transferred,
-		      __entry->f_part, __entry->f_avail,  __entry->slot)
-	    );
-
-TRACE_EVENT(netfs_donate,
-	    TP_PROTO(const struct netfs_io_request *rreq,
-		     const struct netfs_io_subrequest *from,
-		     const struct netfs_io_subrequest *to,
-		     size_t amount,
-		     enum netfs_donate_trace trace),
-
-	    TP_ARGS(rreq, from, to, amount, trace),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq)
-		    __field(unsigned int,		from)
-		    __field(unsigned int,		to)
-		    __field(unsigned int,		amount)
-		    __field(enum netfs_donate_trace,	trace)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->rreq	= rreq->debug_id;
-		    __entry->from	= from->debug_index;
-		    __entry->to		= to ? to->debug_index : -1;
-		    __entry->amount	= amount;
-		    __entry->trace	= trace;
-			   ),
-
-	    TP_printk("R=%08x[%02x] -> [%02x] %s am=%x",
-		      __entry->rreq, __entry->from, __entry->to,
-		      __print_symbolic(__entry->trace, netfs_donate_traces),
-		      __entry->amount)
-	    );
-
 TRACE_EVENT(netfs_folioq,
 	    TP_PROTO(const struct folio_queue *fq,
 		     enum netfs_folioq_trace trace),



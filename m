Return-Path: <linux-fsdevel+bounces-79394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMMUOUU/qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:18:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6384520131C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18A7D30B89F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327633B7B74;
	Wed,  4 Mar 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwTdCHfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7B3C6A26
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633152; cv=none; b=WH0NAkHFEIwqA07f+xZYFSIi8wYRXWFe5lmnK8E5EdH4+R52KOs1CddIpgNdOAyRPExJx1GHhV3L0tTJoh7LAeDQvTEaTEMwfd/CjFcccYV89eepZVwXWVEXdjSpX7hSupDyMgEFP7MVSq4c5kJps7OdRB54bchYBCYJZ8T5azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633152; c=relaxed/simple;
	bh=TuZnYI39f5RfCICU/8dhs9pGeMrI9fS33hd1tHsHaY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG3k48Zinu1rv0Ejncq60GoNVMJW8pnzS7595L3nhTVYwBxX1pARn3jPokFI9BTlYhpgy6xDpDyst4RTf8uc4jtzkyZ2paYlKRszjawlqCQ8yNJb5G/h0+JXu137UO55NKYn1JgtoUpN2SYGsmUMwIAYBueHzz9iuQyM3fj+05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwTdCHfl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueAy1C9dyf36Ulh0bO4AsfQc+xdRNBBtxeu03XadWig=;
	b=cwTdCHfli6b4xJOCo7WLczzqJX+gigN4qrMwu5jMyKgJlYpphNDo01MsQfHxk0lRMfqktz
	Vfn9xRHBTOPog/Daz890a2MJpsJ4+qTJjXvrw9WbFyK3lozaY9aTl+Xlw4ueEV9lUko9UY
	hoJoJlF77RSVkzYDHffZg72HIfeV3Fk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-yGYdlF_xOg2DRcg8R7qREg-1; Wed,
 04 Mar 2026 09:05:38 -0500
X-MC-Unique: yGYdlF_xOg2DRcg8R7qREg-1
X-Mimecast-MFC-AGG-ID: yGYdlF_xOg2DRcg8R7qREg_1772633136
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91BF718002C9;
	Wed,  4 Mar 2026 14:05:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 534B01958DC2;
	Wed,  4 Mar 2026 14:05:31 +0000 (UTC)
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
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab the buffers on request
Date: Wed,  4 Mar 2026 14:03:24 +0000
Message-ID: <20260304140328.112636-18-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 6384520131C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79394-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,infradead.org:email]
X-Rspamd-Action: no action

To try and simplify how subrequests are generated in netfslib, with the
move to bvecq for buffer handling, change netfslib in the following ways:

 (1) ->prepare_xxx(), buffer selection and ->issue_xxx() are now collapsed
     together such that one ->issue_xxx() call is made with the subrequest
     defined to the maximum extent; the filesystem then reduces the length
     of the subrequest and calls back to netfslib to grab a slice of the
     buffer, which may reduce the subrequest further if a maximum segment
     limit is set.  The filesystem can then dispatch the operation.

 (2) To allow buffer slicing to be done upon request by the filesystem, a
     dispatch context is now maintained by netfslib and this is passed to
     ->issue_xxx() which then calls netfs_prepare_xxx_buffer().  This also
     permits the context for retry to be kept separate from that of initial
     dispatch.

 (3) The use of iov_iter is pushed down to the filesystem.  Netfslib now
     provides the filesystem with a bvecq holding the buffer rather than an
     iov_iter.  The bvecq can be duplicated and headers/trailers attached
     to hold protocol and several bvecqs can be linked together to create a
     compound operation.

 (4) The ->issue_xxx() functions now return an error code that allows them
     to return an error without having to terminate the subrequest.
     Netfslib will handle the error immediately if it can but may request
     termination and punt responsibility to the result collector.

     ->issue_xxx() can return 0 if synchronously compete and -EIOCBQUEUED
     if the operation will complete (or already has completed)
     asynchronously.

 (5) During writeback, the code now builds up an accumulation of buffered
     data before issuing writes on each stream (one server, one cache).  It
     asks each stream for an estimate of how much data to accumulate before
     it starts generating subrequests on the stream.  It is not required to
     use up all the data accumulated on a stream at that time unless we hit
     the end of the pagecache.

 (6) During read-gaps, in which there are two gaps on either end of a dirty
     streaming write page that need to be filled, a buffer is constructed
     consisting of the two ends plus a sink page repeated to cover the
     middle portion.  This is passed to the server as a single write.  For
     something like Ceph, this should probably be done either as a
     vectored/sparse read or as two separate reads (if different Ceph
     objects are involved).

 (7) During unbuffered/DIO read/write, there is a single contiguous file
     region to be written or read as a single stream.  The dispatching
     function just creates subrequests and calls ->issue_xxx() repeatedly
     to eat through the bufferage.

 (8) During buffered read, there is a single contiguous file region, to
     read as a single stream - however, this stream may be stitched
     together from subrequests to multiple sources.  Which sources are used
     where is now determined by querying the cache to find the next couple
     of extents in which it has data; netfslib uses this to direct the
     subrequests towards the appropriate sources.

     Each subrequest is given the maximum length in the current extent and
     then ->issue_read() is called.  The filesystem then limits the size
     and slices off a piece of the buffer for that extent.

 (9) The cache now uses fiemap internally to find out the occupied regions
     of a cachefile rather than SEEK_DATA/SEEK_HOLE.  In future, it should
     keep track of the regions itself - including regions of zeros.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c             |  34 +-
 fs/afs/dir.c                 |   8 +-
 fs/afs/file.c                |  27 +-
 fs/afs/fsclient.c            |   8 +-
 fs/afs/internal.h            |  10 +-
 fs/afs/write.c               |  35 +-
 fs/afs/yfsclient.c           |   6 +-
 fs/cachefiles/io.c           | 339 ++++++++++------
 fs/ceph/addr.c               | 109 +++---
 fs/netfs/Makefile            |   2 +-
 fs/netfs/buffered_read.c     | 392 ++++++++++++-------
 fs/netfs/buffered_write.c    |   2 +-
 fs/netfs/direct_read.c       |  90 ++---
 fs/netfs/direct_write.c      | 153 +++++---
 fs/netfs/fscache_io.c        |   6 -
 fs/netfs/internal.h          |  71 +++-
 fs/netfs/iterator.c          |  13 +-
 fs/netfs/misc.c              |  31 ++
 fs/netfs/objects.c           |   3 -
 fs/netfs/read_collect.c      |  33 +-
 fs/netfs/read_retry.c        | 215 +++++-----
 fs/netfs/read_single.c       | 181 +++++----
 fs/netfs/write_collect.c     |  39 +-
 fs/netfs/write_issue.c       | 735 +++++++++++++++++++++--------------
 fs/netfs/write_retry.c       | 145 +++----
 fs/nfs/fscache.c             |  13 +-
 fs/smb/client/cifssmb.c      |  13 +-
 fs/smb/client/file.c         | 149 +++----
 fs/smb/client/smb2ops.c      |   9 +-
 fs/smb/client/smb2pdu.c      |  28 +-
 fs/smb/client/transport.c    |  15 +-
 include/linux/fscache.h      |  19 +
 include/linux/netfs.h        | 122 +++---
 include/trace/events/netfs.h |  43 +-
 net/9p/client.c              |   8 +-
 35 files changed, 1885 insertions(+), 1221 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..66501514bc81 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -51,29 +51,54 @@ static void v9fs_begin_writeback(struct netfs_io_request *wreq)
 /*
  * Issue a subrequest to write to the server.
  */
-static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
+static int v9fs_issue_write(struct netfs_io_subrequest *subreq,
+			     struct netfs_write_context *wctx)
 {
+	struct iov_iter iter;
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
 	int err, len;
 
-	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	subreq->len = umin(subreq->len, fid->clnt->msize - P9_IOHDRSZ);
+
+	err = netfs_prepare_write_buffer(subreq, wctx, INT_MAX);
+	if (err < 0)
+		return err;
+
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
+	len = p9_client_write(fid, subreq->start, &iter, &err);
 	if (len > 0)
 		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	netfs_write_subrequest_terminated(subreq, len ?: err);
+	return err;
 }
 
 /**
  * v9fs_issue_read - Issue a read from 9P
  * @subreq: The read to make
+ * @rctx: Read generation context
  */
-static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
+static int v9fs_issue_read(struct netfs_io_subrequest *subreq,
+			   struct netfs_read_context *rctx)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
+	struct iov_iter iter;
 	struct p9_fid *fid = rreq->netfs_priv;
 	unsigned long long pos = subreq->start + subreq->transferred;
 	int total, err;
 
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	err = netfs_prepare_read_buffer(subreq, rctx, INT_MAX);
+	if (err < 0)
+		return err;
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq, rctx);
+
+	total = p9_client_read(fid, pos, &iter, &err);
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
@@ -89,6 +114,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 
 	subreq->error = err;
 	netfs_read_subreq_terminated(subreq);
+	return -EIOCBQUEUED;
 }
 
 /**
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1d1be7e5923f..f8dbba5237f5 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -255,7 +255,8 @@ static ssize_t afs_do_read_single(struct afs_vnode *dvnode, struct file *file)
 	if (dvnode->directory_size < i_size) {
 		size_t cur_size = dvnode->directory_size;
 
-		ret = netfs_expand_bvecq_buffer(&dvnode->directory, &cur_size, i_size,
+		ret = netfs_expand_bvecq_buffer(&dvnode->directory, &cur_size,
+						round_up(i_size, PAGE_SIZE),
 						mapping_gfp_mask(dvnode->netfs.inode.i_mapping));
 		dvnode->directory_size = cur_size;
 		if (ret < 0)
@@ -2210,9 +2211,10 @@ int afs_single_writepages(struct address_space *mapping,
 	if (is_dir ?
 	    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags) :
 	    atomic64_read(&dvnode->cb_expires_at) != AFS_NO_CB_PROMISE) {
+		size_t len = i_size_read(&dvnode->netfs.inode);
 		iov_iter_bvec_queue(&iter, ITER_SOURCE, dvnode->directory, 0, 0,
-				    i_size_read(&dvnode->netfs.inode));
-		ret = netfs_writeback_single(mapping, wbc, &iter);
+				    round_up(len, PAGE_SIZE));
+		ret = netfs_writeback_single(mapping, wbc, &iter, len);
 	}
 
 	up_read(&dvnode->validate_lock);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index f609366fd2ac..93830d08f0f4 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -329,11 +329,13 @@ void afs_fetch_data_immediate_cancel(struct afs_call *call)
 /*
  * Fetch file data from the volume.
  */
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
+static int afs_issue_read(struct netfs_io_subrequest *subreq,
+			  struct netfs_read_context *rctx)
 {
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct key *key = subreq->rreq->netfs_priv;
+	int ret;
 
 	_enter("%s{%llx:%llu.%u},%x,,,",
 	       vnode->volume->name,
@@ -342,19 +344,21 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 	       vnode->fid.unique,
 	       key_serial(key));
 
+	ret = netfs_prepare_read_buffer(subreq, rctx, INT_MAX);
+	if (ret < 0)
+		return ret;
+
 	op = afs_alloc_operation(key, vnode->volume);
-	if (IS_ERR(op)) {
-		subreq->error = PTR_ERR(op);
-		netfs_read_subreq_terminated(subreq);
-		return;
-	}
+	if (IS_ERR(op))
+		return PTR_ERR(op);
 
 	afs_op_set_vnode(op, 0, vnode);
 
 	op->fetch.subreq = subreq;
 	op->ops		= &afs_fetch_data_operation;
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq, rctx);
 
 	if (subreq->rreq->origin == NETFS_READAHEAD ||
 	    subreq->rreq->iocb) {
@@ -363,18 +367,19 @@ static void afs_issue_read(struct netfs_io_subrequest *subreq)
 		if (!afs_begin_vnode_operation(op)) {
 			subreq->error = afs_put_operation(op);
 			netfs_read_subreq_terminated(subreq);
-			return;
+			return -EIOCBQUEUED;
 		}
 
 		if (!afs_select_fileserver(op)) {
-			afs_end_read(op);
-			return;
+			afs_end_read(op); /* Error recorded here. */
+			return -EIOCBQUEUED;
 		}
 
 		afs_issue_read_call(op);
 	} else {
 		afs_do_sync_operation(op);
 	}
+	return -EIOCBQUEUED;
 }
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
@@ -454,7 +459,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.update_i_size		= afs_update_i_size,
 	.invalidate_cache	= afs_netfs_invalidate_cache,
 	.begin_writeback	= afs_begin_writeback,
-	.prepare_write		= afs_prepare_write,
+	.estimate_write		= afs_estimate_write,
 	.issue_write		= afs_issue_write,
 	.retry_request		= afs_retry_request,
 };
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 95494d5f2b8a..f59a9db4bb0e 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -339,7 +339,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		if (call->remaining == 0)
 			goto no_more_data;
 
-		call->iter = &subreq->io_iter;
+		iov_iter_bvec_queue(&call->def_iter, ITER_DEST, subreq->content.bvecq,
+				    subreq->content.slot, subreq->content.offset, subreq->len);
+
 		call->iov_len = umin(call->remaining, subreq->len - subreq->transferred);
 		call->unmarshall++;
 		fallthrough;
@@ -1085,7 +1087,7 @@ static void afs_fs_store_data64(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->write_iter = op->store.write_iter;
+	call->write_iter = &op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1139,7 +1141,7 @@ void afs_fs_store_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->write_iter = op->store.write_iter;
+	call->write_iter = &op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9bf5d2f1dbc4..ed4cf2c3891b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -906,7 +906,7 @@ struct afs_operation {
 			afs_lock_type_t type;
 		} lock;
 		struct {
-			struct iov_iter	*write_iter;
+			struct iov_iter	write_iter;
 			loff_t	pos;
 			loff_t	size;
 			loff_t	i_size;
@@ -1680,8 +1680,12 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 /*
  * write.c
  */
-void afs_prepare_write(struct netfs_io_subrequest *subreq);
-void afs_issue_write(struct netfs_io_subrequest *subreq);
+int afs_estimate_write(struct netfs_io_request *wreq,
+		       struct netfs_io_stream *stream,
+		       const struct netfs_write_context *wctx,
+		       struct netfs_write_estimate *estimate);
+int afs_issue_write(struct netfs_io_subrequest *subreq,
+		    struct netfs_write_context *wctx);
 void afs_begin_writeback(struct netfs_io_request *wreq);
 void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *stream);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 93ad86ff3345..40af94a6ae0c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -84,17 +84,21 @@ static const struct afs_operation_ops afs_store_data_operation = {
 };
 
 /*
- * Prepare a subrequest to write to the server.  This sets the max_len
- * parameter.
+ * Estimate the maximum size of a write we can send to the server.
  */
-void afs_prepare_write(struct netfs_io_subrequest *subreq)
+int afs_estimate_write(struct netfs_io_request *wreq,
+		       struct netfs_io_stream *stream,
+		       const struct netfs_write_context *wctx,
+		       struct netfs_write_estimate *estimate)
 {
-	struct netfs_io_stream *stream = &subreq->rreq->io_streams[subreq->stream_nr];
+	unsigned long long limit = ULLONG_MAX - wctx->issue_from;
+	unsigned long long max_len = 256 * 1024 * 1024;
 
 	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
-	//	subreq->max_len = 512 * 1024;
-	//else
-	stream->sreq_max_len = 256 * 1024 * 1024;
+	//	max_len = 512 * 1024;
+
+	estimate->issue_at = wctx->issue_from + umin(max_len, limit);
+	return 0;
 }
 
 /*
@@ -140,12 +144,15 @@ static void afs_issue_write_worker(struct work_struct *work)
 	op->flags		|= AFS_OPERATION_UNINTR;
 	op->ops			= &afs_store_data_operation;
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	afs_begin_vnode_operation(op);
 
-	op->store.write_iter	= &subreq->io_iter;
 	op->store.i_size	= umax(pos + len, vnode->netfs.remote_i_size);
 	op->mtime		= inode_get_mtime(&vnode->netfs.inode);
 
+	iov_iter_bvec_queue(&op->store.write_iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
 	afs_wait_for_operation(op);
 	ret = afs_put_operation(op);
 	switch (ret) {
@@ -169,11 +176,19 @@ static void afs_issue_write_worker(struct work_struct *work)
 	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len);
 }
 
-void afs_issue_write(struct netfs_io_subrequest *subreq)
+int afs_issue_write(struct netfs_io_subrequest *subreq,
+		    struct netfs_write_context *wctx)
 {
+	int ret;
+
+	ret = netfs_prepare_write_buffer(subreq, wctx, INT_MAX);
+	if (ret < 0)
+		return ret;
+
 	subreq->work.func = afs_issue_write_worker;
 	if (!queue_work(system_dfl_wq, &subreq->work))
 		WARN_ON_ONCE(1);
+	return -EIOCBQUEUED;
 }
 
 /*
@@ -184,6 +199,8 @@ void afs_begin_writeback(struct netfs_io_request *wreq)
 {
 	if (S_ISREG(wreq->inode->i_mode))
 		afs_get_writeback_key(wreq);
+
+	wreq->io_streams[0].avail = true;
 }
 
 /*
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 24fb562ebd33..ffd1d4c87290 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -385,7 +385,9 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		if (call->remaining == 0)
 			goto no_more_data;
 
-		call->iter = &subreq->io_iter;
+		iov_iter_bvec_queue(&call->def_iter, ITER_DEST, subreq->content.bvecq,
+				    subreq->content.slot, subreq->content.offset, subreq->len);
+
 		call->iov_len = min(call->remaining, subreq->len - subreq->transferred);
 		call->unmarshall++;
 		fallthrough;
@@ -1357,7 +1359,7 @@ void yfs_fs_store_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->write_iter = op->store.write_iter;
+	call->write_iter = &op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 2c3edc91a5b0..a611769aa53a 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 #include <linux/bio.h>
 #include <linux/falloc.h>
+#include <linux/fiemap.h>
 #include <linux/sched/mm.h>
 #include <trace/events/fscache.h>
 #include <trace/events/netfs.h>
@@ -26,7 +27,10 @@ struct cachefiles_kiocb {
 	};
 	struct cachefiles_object *object;
 	netfs_io_terminated_t	term_func;
-	void			*term_func_priv;
+	union {
+		struct netfs_io_subrequest *subreq;
+		void			*term_func_priv;
+	};
 	bool			was_async;
 	unsigned int		inval_counter;	/* Copy of cookie->inval_counter */
 	u64			b_writing;
@@ -193,61 +197,208 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 }
 
 /*
- * Query the occupancy of the cache in a region, returning where the next chunk
- * of data starts and how long it is.
+ * Handle completion of a read from the cache issued by netfslib.
  */
-static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
-				      loff_t start, size_t len, size_t granularity,
-				      loff_t *_data_start, size_t *_data_len)
+static void cachefiles_issue_read_complete(struct kiocb *iocb, long ret)
 {
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct netfs_io_subrequest *subreq = ki->subreq;
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld", ret);
+
+	if (ret < 0) {
+		subreq->error = -ESTALE;
+		trace_cachefiles_io_error(ki->object, inode, ret,
+					  cachefiles_trace_read_error);
+	}
+
+	if (ret >= 0) {
+		if (ki->object->cookie->inval_counter == ki->inval_counter) {
+			subreq->error = 0;
+			if (ret > 0) {
+				subreq->transferred += ret;
+				__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+			}
+		} else {
+			subreq->error = -ESTALE;
+		}
+	}
+
+	netfs_read_subreq_terminated(subreq);
+	cachefiles_put_kiocb(ki);
+}
+
+/*
+ * Issue a read operation to the cache.
+ */
+static int cachefiles_issue_read(struct netfs_io_subrequest *subreq,
+				 struct netfs_read_context *rctx)
+{
+	struct netfs_cache_resources *cres = &subreq->rreq->cache_resources;
 	struct cachefiles_object *object;
+	struct cachefiles_kiocb *ki;
+	struct iov_iter iter;
 	struct file *file;
-	loff_t off, off2;
-
-	*_data_start = -1;
-	*_data_len = 0;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
 
 	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
 		return -ENOBUFS;
 
+	fscache_count_read();
 	object = cachefiles_cres_object(cres);
 	file = cachefiles_cres_file(cres);
-	granularity = max_t(size_t, object->volume->cache->bsize, granularity);
 
 	_enter("%pD,%li,%llx,%zx/%llx",
-	       file, file_inode(file)->i_ino, start, len,
+	       file, file_inode(file)->i_ino, subreq->start, subreq->len,
 	       i_size_read(file_inode(file)));
 
-	off = cachefiles_inject_read_error();
-	if (off == 0)
-		off = vfs_llseek(file, start, SEEK_DATA);
-	if (off == -ENXIO)
-		return -ENODATA; /* Beyond EOF */
-	if (off < 0 && off >= (loff_t)-MAX_ERRNO)
-		return -ENOBUFS; /* Error. */
-	if (round_up(off, granularity) >= start + len)
-		return -ENODATA; /* No data in range */
-
-	off2 = cachefiles_inject_read_error();
-	if (off2 == 0)
-		off2 = vfs_llseek(file, off, SEEK_HOLE);
-	if (off2 == -ENXIO)
-		return -ENODATA; /* Beyond EOF */
-	if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO)
-		return -ENOBUFS; /* Error. */
-
-	/* Round away partial blocks */
-	off = round_up(off, granularity);
-	off2 = round_down(off2, granularity);
-	if (off2 <= off)
-		return -ENODATA;
-
-	*_data_start = off;
-	if (off2 > start + len)
-		*_data_len = len;
-	else
-		*_data_len = off2 - off;
-	return 0;
+	if (subreq->len > MAX_RW_COUNT)
+		subreq->len = MAX_RW_COUNT;
+
+	ret = netfs_prepare_read_buffer(subreq, rctx, BIO_MAX_VECS);
+	if (ret < 0)
+		return ret;
+
+	iov_iter_bvec_queue(&iter, ITER_DEST, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
+	ki = kzalloc_obj(struct cachefiles_kiocb);
+	if (!ki)
+		return -ENOMEM;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_pos		= subreq->start;
+	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->iocb.ki_complete	= cachefiles_issue_read_complete;
+	ki->object		= object;
+	ki->inval_counter	= cres->inval_counter;
+	ki->subreq		= subreq;
+	ki->was_async		= true;
+
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq, rctx);
+
+	get_file(ki->iocb.ki_filp);
+	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
+
+	trace_cachefiles_read(object, file_inode(file), ki->iocb.ki_pos, subreq->len);
+	old_nofs = memalloc_nofs_save();
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = vfs_iocb_iter_read(file, &ki->iocb, &iter);
+	memalloc_nofs_restore(old_nofs);
+
+	switch (ret) {
+	case -EIOCBQUEUED:
+		cachefiles_put_kiocb(ki);
+		break;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		fallthrough;
+	default:
+		ki->was_async = false;
+		cachefiles_issue_read_complete(&ki->iocb, ret);
+		break;
+	}
+
+	_leave(" = %zd", ret);
+	return -EIOCBQUEUED;
+}
+
+struct cachefiles_fiemap_info {
+	struct fiemap_extent_info	fieinfo;
+	struct fscache_occupancy	*occ;
+};
+
+/*
+ * Record a couple of logical extents in the read context.
+ */
+static int cachefiles_fiemap_fill(struct fiemap_extent_info *fieinfo,
+				  const struct fiemap_extent *extent)
+{
+	struct cachefiles_fiemap_info *cfie =
+		container_of(fieinfo, struct cachefiles_fiemap_info, fieinfo);
+	struct fscache_occupancy *occ = cfie->occ;
+	unsigned long long start = extent->fe_logical;
+	unsigned long long end = start + extent->fe_length;
+	int ex = occ->nr_extents;
+
+	_enter("%llx-%llx %x", start, end, extent->fe_flags);
+
+	if (start >= occ->query_to)
+		return 1;
+
+	if (ex == 0) {
+		occ->no_more_cache = false;
+		goto fill_extent;
+	}
+
+	if (start == occ->cached_to[ex - 1]) {
+		occ->cached_to[ex - 1] = end;
+		goto stop_check;
+	}
+
+	if (ex >= fieinfo->fi_extents_max)
+		return 1;
+
+fill_extent:
+	occ->cached_from[ex]	= start;
+	occ->cached_to[ex]	= end;
+	occ->cached_type[ex]	= FSCACHE_EXTENT_DATA;
+	occ->nr_extents++;
+stop_check:
+	occ->query_from = end;
+	return end >= occ->query_to ? 1 : 0;
+}
+
+/*
+ * Query the occupancy of the cache in a region, returning the extent of the
+ * next chunk of cached data and the next hole.
+ */
+static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
+				      struct fscache_occupancy *occ)
+{
+	struct cachefiles_fiemap_info cfie = {
+		.fieinfo.fi_fill	= cachefiles_fiemap_fill,
+		.fieinfo.fi_extents_max	= INT_MAX,
+		.occ			= occ,
+	};
+	struct cachefiles_object *object;
+	struct inode *inode;
+	struct file *file;
+	int ret;
+
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+		return -ENOBUFS;
+
+	object = cachefiles_cres_object(cres);
+	file = cachefiles_cres_file(cres);
+	inode = file_inode(file);
+	occ->granularity = umax(object->volume->cache->bsize, occ->granularity);
+
+	_enter("%pD,%li,%llx-%llx,%llx",
+	       file, file_inode(file)->i_ino, occ->query_from, occ->query_to,
+	       i_size_read(inode));
+
+	if (!inode->i_op->fiemap)
+		return -EOPNOTSUPP;
+
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = inode->i_op->fiemap(inode, &cfie.fieinfo, occ->query_from,
+					  occ->query_to - occ->query_from);
+	return ret;
 }
 
 /*
@@ -489,18 +640,6 @@ cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
 	return ret;
 }
 
-/*
- * Prepare a read operation, shortening it to a cached/uncached
- * boundary as appropriate.
- */
-static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *subreq,
-						    unsigned long long i_size)
-{
-	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
-					  subreq->start, &subreq->len, i_size,
-					  &subreq->flags, subreq->rreq->inode->i_ino);
-}
-
 /*
  * Prepare an on-demand read operation, shortening it to a cached/uncached
  * boundary as appropriate.
@@ -599,62 +738,46 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 				    cachefiles_has_space_for_write);
 }
 
-static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				    loff_t *_start, size_t *_len, size_t upper_len,
-				    loff_t i_size, bool no_space_allocated_yet)
+static int cachefiles_estimate_write(struct netfs_io_request *wreq,
+				     struct netfs_io_stream *stream,
+				     const struct netfs_write_context *wctx,
+				     struct netfs_write_estimate *estimate)
 {
-	struct cachefiles_object *object = cachefiles_cres_object(cres);
-	struct cachefiles_cache *cache = object->volume->cache;
-	const struct cred *saved_cred;
-	int ret;
-
-	if (!cachefiles_cres_file(cres)) {
-		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
-			return -ENOBUFS;
-		if (!cachefiles_cres_file(cres))
-			return -ENOBUFS;
-	}
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
-					 _start, _len, upper_len,
-					 no_space_allocated_yet);
-	cachefiles_end_secure(cache, saved_cred);
-	return ret;
+	estimate->issue_at = wctx->issue_from + MAX_RW_COUNT;
+	estimate->max_segs = BIO_MAX_VECS;
+	return 0;
 }
 
-static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
+static int cachefiles_issue_write(struct netfs_io_subrequest *subreq,
+				  struct netfs_write_context *wctx)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &wreq->cache_resources;
-	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
-
-	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct iov_iter iter;
+	const struct cred *saved_cred;
+	size_t off, pre, post, old_len = subreq->len, len;
+	loff_t start = subreq->start;
+	int ret;
 
-	stream->sreq_max_len = MAX_RW_COUNT;
-	stream->sreq_max_segs = BIO_MAX_VECS;
+	_enter("W=%x[%x] %llx-%llx",
+	       wreq->debug_id, subreq->debug_index, start, start + old_len - 1);
 
 	if (!cachefiles_cres_file(cres)) {
 		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
-			return netfs_prepare_write_failed(subreq);
+			return -EINVAL;
 		if (!cachefiles_cres_file(cres))
-			return netfs_prepare_write_failed(subreq);
+			return -EINVAL;
 	}
-}
 
-static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *wreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &wreq->cache_resources;
-	struct cachefiles_object *object = cachefiles_cres_object(cres);
-	struct cachefiles_cache *cache = object->volume->cache;
-	const struct cred *saved_cred;
-	size_t off, pre, post, len = subreq->len;
-	loff_t start = subreq->start;
-	int ret;
+	ret = netfs_prepare_write_buffer(subreq, wctx, BIO_MAX_VECS);
+	if (ret < 0)
+		return ret;
 
-	_enter("W=%x[%x] %llx-%llx",
-	       wreq->debug_id, subreq->debug_index, start, start + len - 1);
+	len = subreq->len;
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
 
 	/* We need to start on the cache granularity boundary */
 	off = start & (CACHEFILES_DIO_BLOCK_SIZE - 1);
@@ -663,23 +786,24 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 		if (pre >= len) {
 			fscache_count_dio_misfit();
 			netfs_write_subrequest_terminated(subreq, len);
-			return;
+			return 0;
 		}
 		subreq->transferred += pre;
 		start += pre;
 		len -= pre;
-		iov_iter_advance(&subreq->io_iter, pre);
+		iov_iter_advance(&iter, pre);
 	}
 
+	/* We also need to end on the cache granularity boundary */
 	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
 	if (post) {
 		len -= post;
 		if (len == 0) {
 			fscache_count_dio_misfit();
 			netfs_write_subrequest_terminated(subreq, post);
-			return;
+			return 0;
 		}
-		iov_iter_truncate(&subreq->io_iter, len);
+		iov_iter_truncate(&iter, len);
 	}
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_prepare);
@@ -687,15 +811,13 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 	ret = __cachefiles_prepare_write(object, cachefiles_cres_file(cres),
 					 &start, &len, len, true);
 	cachefiles_end_secure(cache, saved_cred);
-	if (ret < 0) {
-		netfs_write_subrequest_terminated(subreq, ret);
-		return;
-	}
+	if (ret < 0)
+		return ret;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_cache_write);
-	cachefiles_write(&subreq->rreq->cache_resources,
-			 subreq->start, &subreq->io_iter,
+	cachefiles_write(&subreq->rreq->cache_resources, subreq->start, &iter,
 			 netfs_write_subrequest_terminated, subreq);
+	return -EIOCBQUEUED;
 }
 
 /*
@@ -714,10 +836,9 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.end_operation		= cachefiles_end_operation,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.issue_read		= cachefiles_issue_read,
 	.issue_write		= cachefiles_issue_write,
-	.prepare_read		= cachefiles_prepare_read,
-	.prepare_write		= cachefiles_prepare_write,
-	.prepare_write_subreq	= cachefiles_prepare_write_subreq,
+	.estimate_write		= cachefiles_estimate_write,
 	.prepare_ondemand_read	= cachefiles_prepare_ondemand_read,
 	.query_occupancy	= cachefiles_query_occupancy,
 };
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..a9a8c01e171c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -269,7 +269,8 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
 }
 
-static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
+static int ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq,
+				      struct netfs_read_context *rctx)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
@@ -278,7 +279,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	ssize_t err = 0;
+	ssize_t err;
 	size_t len;
 	int mode;
 
@@ -287,21 +288,29 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
 
-	if (subreq->start >= inode->i_size)
+	if (subreq->start >= inode->i_size) {
+		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+		err = 0;
 		goto out;
+	}
+
+	err = netfs_subreq_get_buffer(subreq, rctx, UINT_MAX);
+	if (err < 0)
+		return err;
 
 	/* We need to fetch the inline data. */
 	mode = ceph_try_to_choose_auth_mds(inode, CEPH_STAT_CAP_INLINE_DATA);
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR, mode);
-	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
-		goto out;
-	}
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
 	req->r_ino1 = ci->i_vino;
 	req->r_args.getattr.mask = cpu_to_le32(CEPH_STAT_CAP_INLINE_DATA);
 	req->r_num_caps = 2;
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq, rctx);
+
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	if (err < 0)
 		goto out;
@@ -311,7 +320,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	if (iinfo->inline_version == CEPH_INLINE_NONE) {
 		/* The data got uninlined */
 		ceph_mdsc_put_request(req);
-		return false;
+		return 1;
 	}
 
 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
@@ -328,26 +337,11 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
 	subreq->error = err;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(subreq);
-	return true;
+	return -EIOCBQUEUED;
 }
 
-static int ceph_netfs_prepare_read(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct inode *inode = rreq->inode;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
-	u64 objno, objoff;
-	u32 xlen;
-
-	/* Truncate the extent at the end of the current block */
-	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
-				      &objno, &objoff, &xlen);
-	rreq->io_streams[0].sreq_max_len = umin(xlen, fsc->mount_options->rsize);
-	return 0;
-}
-
-static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
+static int ceph_netfs_issue_read(struct netfs_io_subrequest *subreq,
+				 struct netfs_read_context *rctx)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
@@ -356,48 +350,60 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_vino vino = ceph_vino(inode);
+	u64 objno, objoff, len, off = subreq->start;
+	u32 maxlen;
 	int err;
-	u64 len;
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
-	u64 off = subreq->start;
 	int extent_cnt;
 
-	if (ceph_inode_is_shutdown(inode)) {
-		err = -EIO;
-		goto out;
+	if (ceph_inode_is_shutdown(inode))
+		return -EIO;
+
+	if (ceph_has_inline_data(ci)) {
+		err = ceph_netfs_issue_op_inline(subreq, rctx);
+		if (err != 1)
+			return err;
 	}
 
-	if (ceph_has_inline_data(ci) && ceph_netfs_issue_op_inline(subreq))
-		return;
+	/* Truncate the extent at the end of the current block */
+	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
+				      &objno, &objoff, &maxlen);
+	maxlen = umin(maxlen, fsc->mount_options->rsize);
+	len = umin(subreq->len, maxlen);
+	subreq->len = len;
 
 	// TODO: This rounding here is slightly dodgy.  It *should* work, for
 	// now, as the cache only deals in blocks that are a multiple of
 	// PAGE_SIZE and fscrypt blocks are at most PAGE_SIZE.  What needs to
 	// happen is for the fscrypt driving to be moved into netfslib and the
 	// data in the cache also to be stored encrypted.
-	len = subreq->len;
 	ceph_fscrypt_adjust_off_and_len(inode, &off, &len);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout, vino,
 			off, &len, 0, 1, sparse ? CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ,
 			CEPH_OSD_FLAG_READ, NULL, ci->i_truncate_seq,
 			ci->i_truncate_size, false);
-	if (IS_ERR(req)) {
-		err = PTR_ERR(req);
-		req = NULL;
-		goto out;
-	}
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	if (sparse) {
 		extent_cnt = __ceph_sparse_read_ext_count(inode, len);
 		err = ceph_alloc_sparse_ext_map(&req->r_ops[0], extent_cnt);
-		if (err)
-			goto out;
+		if (err) {
+			ceph_osdc_put_request(req);
+			return err;
+		}
 	}
 
 	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
 	      ceph_vinop(inode), subreq->start, subreq->len, len);
 
+	err = netfs_subreq_get_buffer(subreq, rctx, UINT_MAX);
+	if (err < 0) {
+		ceph_osdc_put_request(req);
+		return err;
+	}
+
 	/*
 	 * FIXME: For now, use CEPH_OSD_DATA_TYPE_PAGES instead of _ITER for
 	 * encrypted inodes. We'd need infrastructure that handles an iov_iter
@@ -422,7 +428,8 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		if (err < 0) {
 			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
 			      ceph_vinop(inode), err);
-			goto out;
+			ceph_osdc_put_request(req);
+			return -EIO;
 		}
 
 		/* should always give us a page-aligned read */
@@ -436,23 +443,20 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
 	}
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-		err = -EIO;
-		goto out;
+		ceph_osdc_put_request(req);
+		return -EIO;
 	}
 	req->r_callback = finish_netfs_read;
 	req->r_priv = subreq;
 	req->r_inode = inode;
 	ihold(inode);
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq, rctx);
 	ceph_osdc_start_request(req->r_osdc, req);
-out:
 	ceph_osdc_put_request(req);
-	if (err) {
-		subreq->error = err;
-		netfs_read_subreq_terminated(subreq);
-	}
-	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
+	doutc(cl, "%llx.%llx result -EIOCBQUEUED\n", ceph_vinop(inode));
+	return -EIOCBQUEUED;
 }
 
 static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
@@ -538,7 +542,6 @@ static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 const struct netfs_request_ops ceph_netfs_ops = {
 	.init_request		= ceph_init_request,
 	.free_request		= ceph_netfs_free_request,
-	.prepare_read		= ceph_netfs_prepare_read,
 	.issue_read		= ceph_netfs_issue_read,
 	.expand_readahead	= ceph_netfs_expand_readahead,
 	.check_write_begin	= ceph_netfs_check_write_begin,
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 0621e6870cbd..421dd0be413b 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -12,13 +12,13 @@ netfs-y := \
 	misc.o \
 	objects.o \
 	read_collect.o \
-	read_pgpriv2.o \
 	read_retry.o \
 	read_single.o \
 	write_collect.o \
 	write_issue.o \
 	write_retry.o
 
+netfs-$(CONFIG_NETFS_PGPRIV2) += read_pgpriv2.o
 netfs-$(CONFIG_NETFS_STATS) += stats.o
 
 netfs-$(CONFIG_FSCACHE) += \
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index d5d5a7520cbe..32e27f8f420a 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -9,6 +9,15 @@
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
+struct netfs_buffered_read_context {
+	struct netfs_read_context r;
+	struct fscache_occupancy cache;		/* List of cached extents */
+	unsigned long long	i_size;		/* Size of file */
+	size_t			buffered;	/* Amount in buffer */
+	struct readahead_control *ractl;	/* Readahead source buffer */
+	struct bvecq_pos	dispatch_cursor; /* Cursor from which we dispatch ops */
+};
+
 static void netfs_cache_expand_readahead(struct netfs_io_request *rreq,
 					 unsigned long long *_start,
 					 unsigned long long *_len,
@@ -54,15 +63,18 @@ static void netfs_rreq_expand(struct netfs_io_request *rreq,
 	}
 }
 
+/*
+ * Clear any remaining pages in the readahead request.
+ */
 static void netfs_clear_to_ra_end(struct netfs_io_request *rreq,
-				  struct readahead_control *ractl)
+				  struct netfs_buffered_read_context *rctx)
 {
 	struct folio_batch batch;
 
 	folio_batch_init(&batch);
 
 	for (;;) {
-		batch.nr = __readahead_batch(ractl, (struct page **)batch.folios,
+		batch.nr = __readahead_batch(rctx->ractl, (struct page **)batch.folios,
 					     PAGEVEC_SIZE);
 		if (!batch.nr)
 			break;
@@ -86,32 +98,25 @@ static int netfs_begin_cache_read(struct netfs_io_request *rreq, struct netfs_in
 }
 
 /*
- * netfs_prepare_read_iterator - Prepare the subreq iterator for I/O
- * @subreq: The subrequest to be set up
- *
- * Prepare the I/O iterator representing the read buffer on a subrequest for
- * the filesystem to use for I/O (it can be passed directly to a socket).  This
- * is intended to be called from the ->issue_read() method once the filesystem
- * has trimmed the request to the size it wants.
- *
- * Returns the limited size if successful and -ENOMEM if insufficient memory
- * available.
+ * Prepare the I/O buffer on a buffered read subrequest for the filesystem to
+ * use as a bvec queue.
  *
  * [!] NOTE: This must be run in the same thread as ->issue_read() was called
  * in as we access the readahead_control struct.
  */
-static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
-					   struct readahead_control *ractl)
+static int netfs_prepare_buffered_read_buffer(struct netfs_io_subrequest *subreq,
+					      struct netfs_read_context *base_rctx,
+					      unsigned int max_segs)
 {
+	struct netfs_buffered_read_context *rctx =
+		container_of(base_rctx, struct netfs_buffered_read_context, r);
 	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	ssize_t extracted;
-	size_t rsize = subreq->len;
 
-	if (subreq->source == NETFS_DOWNLOAD_FROM_SERVER)
-		rsize = umin(rsize, stream->sreq_max_len);
+	_enter("R=%08x[%x] l=%zx s=%u",
+	       rreq->debug_id, subreq->debug_index, subreq->len, max_segs);
 
-	if (ractl) {
+	if (rctx->ractl) {
 		/* If we don't have sufficient folios in the rolling buffer,
 		 * extract a bvecq's worth from the readahead region at a time
 		 * into the buffer.  Note that this acquires a ref on each page
@@ -120,67 +125,108 @@ static ssize_t netfs_prepare_read_iterator(struct netfs_io_subrequest *subreq,
 		 */
 		struct folio_batch put_batch;
 
+		_debug("ractl %zx < %zx", rctx->buffered, subreq->len);
+
 		folio_batch_init(&put_batch);
-		while (rreq->submitted < subreq->start + rsize) {
+		while (rctx->buffered < subreq->len) {
 			ssize_t added;
 
-			added = bvecq_load_from_ra(&rreq->load_cursor, ractl,
+			added = bvecq_load_from_ra(&rreq->load_cursor, rctx->ractl,
 						   &put_batch);
 			if (added < 0)
 				return added;
-			rreq->submitted += added;
+			rctx->buffered += added;
 		}
 		folio_batch_release(&put_batch);
 	}
 
-	bvecq_pos_attach(&subreq->dispatch_pos, &rreq->dispatch_cursor);
-	extracted = bvecq_slice(&rreq->dispatch_cursor, subreq->len,
-				stream->sreq_max_segs, &subreq->nr_segs);
+	bvecq_pos_attach(&subreq->dispatch_pos, &rctx->dispatch_cursor);
+	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+	extracted = bvecq_slice(&rctx->dispatch_cursor, subreq->len,
+				max_segs, &subreq->nr_segs);
 	if (extracted < 0)
 		return extracted;
-	if (extracted < rsize) {
+
+	rctx->buffered -= extracted;
+	if (extracted < subreq->len) {
 		subreq->len = extracted;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
 	}
 
-	return subreq->len;
+	return 0;
 }
 
-static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_request *rreq,
-						     struct netfs_io_subrequest *subreq,
-						     loff_t i_size)
+/**
+ * netfs_prepare_read_buffer - Get the buffer for a subrequest
+ * @subreq: The subrequest to get the buffer for
+ * @rctx: Read context
+ * @max_segs: Maximum number of segments in buffer (or INT_MAX)
+ *
+ * Extract a slice of buffer from the stream and attach it to the subrequest as
+ * a bio_vec queue.  The maximum amount of data attached is set by
+ * @subreq->len, but this may be shortened if @max_segs would be exceeded.
+ *
+ * [!] NOTE: This must be run in the same thread as ->issue_read() was called
+ * in as we access the readahead_control struct if there is one.
+ */
+int netfs_prepare_read_buffer(struct netfs_io_subrequest *subreq,
+			      struct netfs_read_context *rctx,
+			      unsigned int max_segs)
 {
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	enum netfs_io_source source;
-
-	if (!cres->ops)
-		return NETFS_DOWNLOAD_FROM_SERVER;
-	source = cres->ops->prepare_read(subreq, i_size);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-	return source;
-
+	switch (subreq->rreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_FOR_WRITE:
+		if (rctx->retrying)
+			return netfs_prepare_buffered_read_retry_buffer(subreq, rctx, max_segs);
+		return netfs_prepare_buffered_read_buffer(subreq, rctx, max_segs);
+
+	case NETFS_UNBUFFERED_READ:
+	case NETFS_DIO_READ:
+	case NETFS_READ_GAPS:
+		return netfs_prepare_unbuffered_read_buffer(subreq, rctx, max_segs);
+	case NETFS_READ_SINGLE:
+		return netfs_prepare_read_single_buffer(subreq, rctx, max_segs);
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
 }
+EXPORT_SYMBOL(netfs_prepare_read_buffer);
 
-/*
- * Issue a read against the cache.
- * - Eats the caller's ref on subreq.
- */
-static void netfs_read_cache_to_pagecache(struct netfs_io_request *rreq,
-					  struct netfs_io_subrequest *subreq)
+int netfs_read_query_cache(struct netfs_io_request *rreq,
+			   struct fscache_occupancy *occ)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 
-	netfs_stat(&netfs_n_rh_read);
-	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_IGNORE,
-			netfs_cache_read_terminated, subreq);
+	occ->granularity = PAGE_SIZE;
+	occ->no_more_cache = true;
+	if (occ->query_from >= occ->query_to)
+		return 0;
+	if (!cres->ops)
+		return 0;
+	occ->query_from = round_up(occ->query_from, occ->granularity);
+	return cres->ops->query_occupancy(cres, occ);
 }
 
-static void netfs_queue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq,
-			     bool last_subreq)
+/**
+ * netfs_mark_read_submission - Mark a read subrequest as being ready for submission
+ * @subreq: The subrequest to be marked
+ * @rctx: Read context supplied to ->issue_read()
+ *
+ * Calling this marks a read subrequest as being ready for submission and makes
+ * it available to the collection thread.  After calling this, the filesystem's
+ * ->issue_read() method must invoke netfs_read_subreq_terminated() to end the
+ * subrequest and must return -EIOCBQUEUED.
+ */
+void netfs_mark_read_submission(struct netfs_io_subrequest *subreq,
+				struct netfs_read_context *rctx)
 {
+	struct netfs_io_request *rreq = subreq->rreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 
+	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
+
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* We add to the end of the list whilst the collector may be walking
@@ -188,49 +234,57 @@ static void netfs_queue_read(struct netfs_io_request *rreq,
 	 * remove entries off of the front.
 	 */
 	spin_lock(&rreq->lock);
-	list_add_tail(&subreq->rreq_link, &stream->subrequests);
-	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front = subreq;
-		if (!stream->active) {
-			stream->collected_to = stream->front->start;
-			/* Store list pointers before active flag */
-			smp_store_release(&stream->active, true);
+	if (list_empty(&subreq->rreq_link)) {
+		list_add_tail(&subreq->rreq_link, &stream->subrequests);
+		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
+			stream->front = subreq;
+			if (!stream->active) {
+				stream->collected_to = stream->front->start;
+				/* Store list pointers before active flag */
+				smp_store_release(&stream->active, true);
+			}
 		}
 	}
 
-	if (last_subreq) {
+	rreq->submitted += subreq->len;
+	rctx->start = subreq->start + subreq->len;
+	if (rctx->start >= rctx->stop) {
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		trace_netfs_rreq(rreq, netfs_rreq_trace_all_queued);
 	}
 
 	spin_unlock(&rreq->lock);
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 }
+EXPORT_SYMBOL(netfs_mark_read_submission);
 
-static void netfs_issue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq,
-			     struct readahead_control *ractl)
+static int netfs_issue_read(struct netfs_io_request *rreq,
+			    struct netfs_io_subrequest *subreq,
+			    struct netfs_buffered_read_context *rctx)
 {
-	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-			    subreq->content.slot, subreq->content.offset, subreq->len);
+	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
 
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
-		rreq->netfs_ops->issue_read(subreq);
-		break;
-	case NETFS_READ_FROM_CACHE:
-		netfs_read_cache_to_pagecache(rreq, subreq);
-		break;
+		return rreq->netfs_ops->issue_read(subreq, &rctx->r);
+	case NETFS_READ_FROM_CACHE: {
+		struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+		netfs_stat(&netfs_n_rh_read);
+		cres->ops->issue_read(subreq, &rctx->r);
+		return -EIOCBQUEUED;
+	}
 	default:
-		bvecq_zero(&rreq->dispatch_cursor, subreq->len);
+		netfs_mark_read_submission(subreq, &rctx->r);
+		bvecq_zero(&rctx->dispatch_cursor, subreq->len);
 		subreq->transferred = subreq->len;
 		subreq->error = 0;
-		iov_iter_zero(subreq->len, &subreq->io_iter);
-		subreq->transferred = subreq->len;
 		netfs_read_subreq_terminated(subreq);
-		if (ractl)
-			netfs_clear_to_ra_end(rreq, ractl);
-		break;
+		if (rctx->ractl)
+			netfs_clear_to_ra_end(rreq, rctx);
+		return 0;
 	}
 }
 
@@ -242,95 +296,134 @@ static void netfs_issue_read(struct netfs_io_request *rreq,
 static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 				    struct readahead_control *ractl)
 {
+	struct netfs_buffered_read_context rctx = {
+		.cache.query_from	= rreq->start,
+		.cache.query_to		= rreq->start + rreq->len,
+		.cache.cached_from[0]	= ULLONG_MAX,
+		.cache.cached_to[0]	= ULLONG_MAX,
+		.r.start		= rreq->start,
+		.r.stop			= rreq->start + rreq->len,
+		.i_size			= rreq->i_size,
+		.ractl			= ractl,
+	};
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
-	unsigned long long start = rreq->start;
-	ssize_t size = rreq->len;
 	int ret = 0;
 
 	_enter("R=%08x", rreq->debug_id);
 
-	bvecq_pos_attach(&rreq->dispatch_cursor, &rreq->load_cursor);
-	bvecq_pos_attach(&rreq->collect_cursor, &rreq->dispatch_cursor);
+	bvecq_pos_attach(&rctx.dispatch_cursor, &rreq->load_cursor);
+	bvecq_pos_attach(&rreq->collect_cursor, &rctx.dispatch_cursor);
+
 
 	do {
 		struct netfs_io_subrequest *subreq;
-		enum netfs_io_source source = NETFS_SOURCE_UNKNOWN;
-		ssize_t slice;
+		struct fscache_occupancy *occ = &rctx.cache;
+		unsigned long long hole_to = ULLONG_MAX, cache_to = ULLONG_MAX;
 
-		subreq = netfs_alloc_subrequest(rreq);
-		if (!subreq) {
-			ret = -ENOMEM;
-			break;
-		}
-
-		subreq->start	= start;
-		subreq->len	= size;
-
-		rreq->io_streams[0].sreq_max_len = MAX_RW_COUNT;
-		rreq->io_streams[0].sreq_max_segs = INT_MAX;
-
-		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
-		subreq->source = source;
-		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-			unsigned long long zp = umin(ictx->zero_point, rreq->i_size);
-			size_t len = subreq->len;
-
-			if (unlikely(rreq->origin == NETFS_READ_SINGLE))
-				zp = rreq->i_size;
-			if (subreq->start >= zp) {
-				subreq->source = source = NETFS_FILL_WITH_ZEROES;
-				goto fill_with_zeroes;
+		/* If we don't have any, find out the next couple of data
+		 * extents from the cache, containing of following the
+		 * specified start offset.  Holes have to be fetched from the
+		 * server; data regions from the cache.
+		 */
+		if (!occ->no_more_cache) {
+			if (!occ->nr_extents) {
+				ret = netfs_read_query_cache(rreq, &rctx.cache);
+				if (ret < 0)
+					break;
+				if (occ->no_more_cache) {
+					occ->cached_from[0] = ULLONG_MAX;
+					occ->cached_to[0] = ULLONG_MAX;
+					occ->nr_extents = 0;
+				}
 			}
 
-			if (len > zp - subreq->start)
-				len = zp - subreq->start;
-			if (len == 0) {
-				pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
-				       rreq->debug_id, subreq->debug_index,
-				       subreq->len, size,
-				       subreq->start, ictx->zero_point, rreq->i_size);
-				break;
-			}
-			subreq->len = len;
+			/* Shuffle down the extent list to evict used-up or
+			 * useless extents.
+			 */
+			if (occ->nr_extents) {
+				hole_to  = round_up(occ->cached_from[0], occ->granularity);
+				cache_to = round_down(occ->cached_to[0], occ->granularity);
+				if (hole_to > cache_to) {
+					occ->cached_to[0] = rctx.r.start;
+				} else {
+					occ->cached_from[0] = hole_to;
+					occ->cached_to[0] = cache_to;
+				}
 
-			netfs_stat(&netfs_n_rh_download);
-			if (rreq->netfs_ops->prepare_read) {
-				ret = rreq->netfs_ops->prepare_read(subreq);
-				if (ret < 0) {
-					subreq->error = ret;
-					/* Not queued - release both refs. */
-					netfs_put_subrequest(subreq,
-							     netfs_sreq_trace_put_cancel);
-					netfs_put_subrequest(subreq,
-							     netfs_sreq_trace_put_cancel);
-					break;
+				if (rctx.r.start >= occ->cached_to[0]) {
+					for (int i = 1; i < occ->nr_extents; i++) {
+						occ->cached_from[i - 1] = occ->cached_from[i];
+						occ->cached_to[i - 1]   = occ->cached_to[i];
+						occ->cached_type[i - 1] = occ->cached_type[i];
+					}
+					occ->nr_extents--;
+					continue;
 				}
-				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 			}
-			goto issue;
 		}
 
-	fill_with_zeroes:
-		if (source == NETFS_FILL_WITH_ZEROES) {
+		subreq = netfs_alloc_subrequest(rreq);
+		if (!subreq) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		subreq->start = rctx.r.start;
+
+		hole_to  = occ->cached_from[0];
+		cache_to = occ->cached_to[0];
+
+		_debug("rsub %llx %llx-%llx", subreq->start, hole_to, cache_to);
+
+		if (occ->nr_extents &&
+		    rctx.r.start >= hole_to && rctx.r.start < cache_to) {
+			/* Overlap with a cached region, where the cache may
+			 * record a block of zeroes.
+			 */
+			_debug("cached");
+			subreq->len = cache_to - rctx.r.start;
+			if (occ->cached_type[0] == FSCACHE_EXTENT_ZERO) {
+				subreq->source = NETFS_FILL_WITH_ZEROES;
+				netfs_stat(&netfs_n_rh_zero);
+			} else {
+				subreq->source = NETFS_READ_FROM_CACHE;
+			}
+		} else if (subreq->start >= ictx->zero_point &&
+			   subreq->start < rctx.r.stop) {
+			/* If this range lies beyond the zero-point, that part
+			 * can just be cleared locally.
+			 */
+			_debug("zero %llx-%llx", rctx.r.start, rctx.r.stop);
+			subreq->len = rctx.r.stop - rctx.r.start;
 			subreq->source = NETFS_FILL_WITH_ZEROES;
-			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
-			goto issue;
+		} else {
+			/* Read a cache hole from the server.  If any part of
+			 * this range lies beyond the zero-point or the EOF,
+			 * that part can just be cleared locally.
+			 */
+			unsigned long long zlimit = umin(rctx.i_size, ictx->zero_point);
+			unsigned long long limit = min3(zlimit, rctx.r.stop, hole_to);
+
+			_debug("limit %llx %llx", rctx.i_size, ictx->zero_point);
+			_debug("download %llx-%llx", rctx.r.start, rctx.r.stop);
+			subreq->len = umin(limit - subreq->start, ULONG_MAX);
+			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
+			if (rreq->cache_resources.ops)
+				__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
+			netfs_stat(&netfs_n_rh_download);
 		}
 
-		if (source == NETFS_READ_FROM_CACHE) {
-			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-			goto issue;
+		if (subreq->len == 0) {
+			pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%llx s=%llx z=%llx i=%llx",
+			       rreq->debug_id, subreq->debug_index,
+			       subreq->len, rctx.r.stop - subreq->start,
+			       subreq->start, ictx->zero_point, rreq->i_size);
+			break;
 		}
 
-		pr_err("Unexpected read source %u\n", source);
-		WARN_ON_ONCE(1);
-		break;
-
-	issue:
-		slice = netfs_prepare_read_iterator(subreq, ractl);
-		if (slice < 0) {
-			ret = slice;
+		ret = netfs_issue_read(rreq, subreq, &rctx);
+		if (ret != 0 && ret != -EIOCBQUEUED) {
 			subreq->error = ret;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
 			/* Not queued - release both refs. */
@@ -338,15 +431,12 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
 			break;
 		}
-		size -= slice;
-		start += slice;
+		ret = 0;
 
-		netfs_queue_read(rreq, subreq, size <= 0);
-		netfs_issue_read(rreq, subreq, ractl);
 		cond_resched();
-	} while (size > 0);
+	} while (rctx.r.start < rctx.r.stop);
 
-	if (unlikely(size > 0)) {
+	if (unlikely(rctx.r.start < rctx.r.stop)) {
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		netfs_wake_collector(rreq);
@@ -356,7 +446,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 	cmpxchg(&rreq->error, 0, ret);
 
 	bvecq_pos_detach(&rreq->load_cursor);
-	bvecq_pos_detach(&rreq->dispatch_cursor);
+	bvecq_pos_detach(&rctx.dispatch_cursor);
 }
 
 /**
@@ -382,6 +472,8 @@ void netfs_readahead(struct readahead_control *ractl)
 	size_t size = readahead_length(ractl);
 	int ret;
 
+	_enter("");
+
 	rreq = netfs_alloc_request(ractl->mapping, ractl->file, start, size,
 				   NETFS_READAHEAD);
 	if (IS_ERR(rreq))
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 22a4d61631c9..c3834a589a7d 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -267,7 +267,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * a file that's open for reading as ->read_folio() then has to
 		 * be able to flush it.
 		 */
-		if ((file->f_mode & FMODE_READ) ||
+		if (//(file->f_mode & FMODE_READ) ||
 		    netfs_is_cache_enabled(ctx)) {
 			if (finfo) {
 				netfs_stat(&netfs_n_wh_wstream_conflict);
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index c8704c4a95a9..c435664b4f79 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -16,18 +16,41 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+int netfs_prepare_unbuffered_read_buffer(struct netfs_io_subrequest *subreq,
+					 struct netfs_read_context *base_rctx,
+					 unsigned int max_segs)
+{
+	struct netfs_unbuffered_read_context *rctx =
+		container_of(base_rctx, struct netfs_unbuffered_read_context, r);
+	size_t len;
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &rctx->dispatch_cursor);
+	bvecq_pos_attach(&subreq->content, &rctx->dispatch_cursor);
+	len = bvecq_slice(&rctx->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	rctx->r.start += subreq->len;
+	return 0;
+}
+
 /*
  * Perform a read to a buffer from the server, slicing up the region to be read
  * according to the network rsize.
  */
 static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 {
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
-	unsigned long long start = rreq->start;
-	ssize_t size = rreq->len;
+	struct netfs_unbuffered_read_context rctx = {
+		.r.start	= rreq->start,
+		.r.stop		= rreq->start + rreq->len,
+	};
 	int ret = 0;
 
-	bvecq_pos_attach(&rreq->dispatch_cursor, &rreq->load_cursor);
+	bvecq_pos_transfer(&rctx.dispatch_cursor, &rreq->load_cursor);
 
 	do {
 		struct netfs_io_subrequest *subreq;
@@ -39,67 +62,36 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_io_request *rreq)
 		}
 
 		subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
-		subreq->start	= start;
-		subreq->len	= size;
-
-		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-
-		spin_lock(&rreq->lock);
-		list_add_tail(&subreq->rreq_link, &stream->subrequests);
-		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-			stream->front = subreq;
-			if (!stream->active) {
-				stream->collected_to = stream->front->start;
-				/* Store list pointers before active flag */
-				smp_store_release(&stream->active, true);
-			}
-		}
-		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-		spin_unlock(&rreq->lock);
+		subreq->start	= rctx.r.start;
+		subreq->len	= rctx.r.stop - rctx.r.start;
 
 		netfs_stat(&netfs_n_rh_download);
-		if (rreq->netfs_ops->prepare_read) {
-			ret = rreq->netfs_ops->prepare_read(subreq);
-			if (ret < 0) {
-				netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
-				break;
-			}
-		}
 
-		bvecq_pos_attach(&subreq->dispatch_pos, &rreq->dispatch_cursor);
-		bvecq_pos_attach(&subreq->content, &rreq->dispatch_cursor);
-		subreq->len = bvecq_slice(&rreq->dispatch_cursor,
-					  umin(size, stream->sreq_max_len),
-					  stream->sreq_max_segs,
-					  &subreq->nr_segs);
-
-		size -= subreq->len;
-		start += subreq->len;
-		rreq->submitted += subreq->len;
-		if (size <= 0) {
-			smp_wmb(); /* Write lists before ALL_QUEUED. */
-			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+		ret = rreq->netfs_ops->issue_read(subreq, &rctx.r);
+		if (ret != 0 && ret != -EIOCBQUEUED) {
+			subreq->error = ret;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
+			/* Not queued - release both refs. */
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
+			break;
 		}
 
-		iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-				    subreq->content.slot, subreq->content.offset, subreq->len);
-
-		rreq->netfs_ops->issue_read(subreq);
-
+		ret = 0;
 		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
 			netfs_wait_for_paused_read(rreq);
 		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
 			break;
 		cond_resched();
-	} while (size > 0);
+	} while (rctx.r.start < rctx.r.stop);
 
-	if (unlikely(size > 0)) {
+	if (unlikely(rctx.r.start < rctx.r.stop)) {
 		smp_wmb(); /* Write lists before ALL_QUEUED. */
 		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
 		netfs_wake_collector(rreq);
 	}
 
-	bvecq_pos_detach(&rreq->dispatch_cursor);
+	bvecq_pos_detach(&rctx.dispatch_cursor);
 	return ret;
 }
 
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index bb224d837b78..cf7d2798c50e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,6 +9,39 @@
 #include <linux/uio.h>
 #include "internal.h"
 
+struct netfs_unbuf_write_context {
+	struct netfs_write_context wctx;
+	struct bvecq_pos	dispatch_cursor; /* Dispatch position in buffer */
+};
+
+/*
+ * Prepare the buffer for an unbuffered/DIO write.
+ */
+int netfs_prepare_unbuffered_write_buffer(struct netfs_io_subrequest *subreq,
+					  struct netfs_write_context *wctx,
+					  unsigned int max_segs)
+{
+	struct netfs_unbuf_write_context *uctx =
+		container_of(wctx, struct netfs_unbuf_write_context, wctx);
+	size_t len;
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &uctx->dispatch_cursor);
+	bvecq_pos_attach(&subreq->content, &uctx->dispatch_cursor);
+	len = bvecq_slice(&uctx->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	// TODO: Wait here for completion of prev subreq
+
+	wctx->issue_from += subreq->len;
+	wctx->buffered   -= subreq->len;
+	return 0;
+}
+
 /*
  * Perform the cleanup rituals after an unbuffered write is complete.
  */
@@ -64,7 +97,8 @@ static void netfs_unbuffered_write_done(struct netfs_io_request *wreq)
  */
 static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 					   struct netfs_io_stream *stream,
-					   struct netfs_io_subrequest *subreq)
+					   struct netfs_io_subrequest *subreq,
+					   struct netfs_unbuf_write_context *uctx)
 {
 	trace_netfs_collect_sreq(wreq, subreq);
 
@@ -74,9 +108,9 @@ static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 
 	wreq->transferred += subreq->transferred;
 	if (subreq->transferred < subreq->len) {
-		bvecq_pos_detach(&wreq->dispatch_cursor);
-		bvecq_pos_transfer(&wreq->dispatch_cursor, &subreq->dispatch_pos);
-		bvecq_pos_advance(&wreq->dispatch_cursor, subreq->transferred);
+		bvecq_pos_detach(&uctx->dispatch_cursor);
+		bvecq_pos_transfer(&uctx->dispatch_cursor, &subreq->dispatch_pos);
+		bvecq_pos_advance(&uctx->dispatch_cursor, subreq->transferred);
 	}
 
 	stream->collected_to = subreq->start + subreq->transferred;
@@ -85,6 +119,7 @@ static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 
 	trace_netfs_collect_stream(wreq, stream);
 	trace_netfs_collect_state(wreq, wreq->collected_to, 0);
+	/* TODO: Progressively clean up wreq->direct_bq */
 }
 
 /*
@@ -98,68 +133,68 @@ static void netfs_unbuffered_write_collect(struct netfs_io_request *wreq,
 static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *subreq = NULL;
+	struct netfs_unbuf_write_context uctx = {
+		.wctx.issue_from	= wreq->start,
+		.wctx.buffered		= wreq->len,
+	};
+	struct netfs_write_context *wctx = &uctx.wctx;
 	struct netfs_io_stream *stream = &wreq->io_streams[0];
 	int ret;
 
 	_enter("%llx", wreq->len);
 
-	bvecq_pos_attach(&wreq->dispatch_cursor, &wreq->load_cursor);
-	bvecq_pos_attach(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	bvecq_pos_attach(&uctx.dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_attach(&wreq->collect_cursor, &uctx.dispatch_cursor);
 
 	if (wreq->origin == NETFS_DIO_WRITE)
 		inode_dio_begin(wreq->inode);
 
-	stream->collected_to = wreq->start;
-
 	for (;;) {
 		bool retry = false;
 
 		if (!subreq) {
-			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
-			subreq = stream->construct;
-			stream->construct = NULL;
-			stream->front = NULL;
+			subreq = netfs_alloc_write_subreq(wreq, stream, wctx);
+			if (!subreq)
+				return -ENOMEM;
 		}
 
-		/* Check if (re-)preparation failed. */
-		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
-			netfs_write_subrequest_terminated(subreq, subreq->error);
-			wreq->error = subreq->error;
+		ret = stream->issue_write(subreq, wctx);
+		switch (ret) {
+		case 0:
+			/* Already completed synchronously. */
 			break;
-		}
-
-		bvecq_pos_attach(&subreq->dispatch_pos, &wreq->dispatch_cursor);
-		subreq->len = bvecq_slice(&wreq->dispatch_cursor, stream->sreq_max_len,
-					  stream->sreq_max_segs, &subreq->nr_segs);
-		bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
-
-		iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
-				    subreq->content.bvecq, subreq->content.slot,
-				    subreq->content.offset,
-				    subreq->len);
-
-		if (!iov_iter_count(&subreq->io_iter))
+		case -EIOCBQUEUED:
+			/* Async, need to wait. */
+			ret = netfs_wait_for_in_progress_subreq(wreq, subreq);
+			if (ret < 0) {
+				if (ret == -EAGAIN) {
+					retry = true;
+					break;
+				}
+				netfs_put_subrequest(subreq, netfs_sreq_trace_put_failed);
+				subreq = NULL;
+				ret = subreq->error;
+				goto failed;
+			}
 			break;
-
-		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-		stream->issue_write(subreq);
-
-		/* Async, need to wait. */
-		netfs_wait_for_in_progress_stream(wreq, stream);
-
-		if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+		case -EAGAIN:
+			/* Need to retry. */
+			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 			retry = true;
-		} else if (test_bit(NETFS_SREQ_FAILED, &subreq->flags)) {
-			ret = subreq->error;
+			break;
+		default:
+			/* Probably failed before dispatch. */
+			subreq->error = ret;
 			wreq->error = ret;
-			netfs_see_subrequest(subreq, netfs_sreq_trace_see_failed);
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_cancel);
+			netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
 			subreq = NULL;
-			break;
+			goto failed;
 		}
-		ret = 0;
 
 		if (!retry) {
-			netfs_unbuffered_write_collect(wreq, stream, subreq);
+			netfs_unbuffered_write_collect(wreq, stream, subreq, &uctx);
 			subreq = NULL;
 			if (wreq->transferred >= wreq->len)
 				break;
@@ -171,20 +206,21 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			continue;
 		}
 
-		/* We need to retry the last subrequest, so first reset the
-		 * iterator, taking into account what, if anything, we managed
-		 * to transfer.
+		/* We need to retry the last subrequest, so first wind back the
+		 * buffer position.
 		 */
 		subreq->error = -EAGAIN;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 		bvecq_pos_detach(&subreq->content);
-		bvecq_pos_detach(&wreq->dispatch_cursor);
-		bvecq_pos_transfer(&wreq->dispatch_cursor, &subreq->dispatch_pos);
+		bvecq_pos_detach(&uctx.dispatch_cursor);
+		bvecq_pos_transfer(&uctx.dispatch_cursor, &subreq->dispatch_pos);
 
 		if (subreq->transferred > 0) {
 			wreq->transferred += subreq->transferred;
-			bvecq_pos_advance(&wreq->dispatch_cursor, subreq->transferred);
+			wctx->issue_from -= subreq->len - subreq->transferred;
+			wctx->buffered   += subreq->len - subreq->transferred;
+			bvecq_pos_advance(&uctx.dispatch_cursor, subreq->transferred);
 		}
 
 		if (stream->source == NETFS_UPLOAD_TO_SERVER &&
@@ -192,24 +228,21 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 			wreq->netfs_ops->retry_request(wreq, stream);
 
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
-		subreq->start		= wreq->start + wreq->transferred;
-		subreq->len		= wreq->len   - wreq->transferred;
+		__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+		subreq->start		= wctx->issue_from;
+		subreq->len		= wctx->buffered;
 		subreq->transferred	= 0;
 		subreq->retry_count	+= 1;
-		stream->sreq_max_len	= UINT_MAX;
-		stream->sreq_max_segs	= INT_MAX;
 
 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-		stream->prepare_write(subreq);
 
 		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 		netfs_stat(&netfs_n_wh_retry_write_subreq);
 	}
 
-	bvecq_pos_detach(&wreq->dispatch_cursor);
-	bvecq_pos_detach(&wreq->load_cursor);
+failed:
+	bvecq_pos_detach(&uctx.dispatch_cursor);
 	netfs_unbuffered_write_done(wreq);
 	_leave(" = %d", ret);
 	return ret;
@@ -263,9 +296,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		 * we have to save the source buffer as the iterator is only
 		 * good until we return.  In such a case, extract an iterator
 		 * to represent as much of the the output buffer as we can
-		 * manage.  Note that the extraction might not be able to
-		 * allocate a sufficiently large bvec array and may shorten the
-		 * request.
+		 * manage.  Note that the extraction may shorten the request.
 		 */
 		ssize_t n = netfs_extract_iter(iter, len, INT_MAX, iocb->ki_pos,
 					       &wreq->load_cursor.bvecq, 0);
@@ -280,8 +311,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		       wreq->load_cursor.bvecq->max_segs);
 	}
 
-	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
-
 	/* Copy the data into the bounce buffer and encrypt it. */
 	// TODO
 
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 37f05b4d3469..70b10ac23a27 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -239,10 +239,6 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 				    fscache_access_io_write) < 0)
 		goto abandon_free;
 
-	ret = cres->ops->prepare_write(cres, &start, &len, len, i_size, false);
-	if (ret < 0)
-		goto abandon_end;
-
 	/* TODO: Consider clearing page bits now for space the write isn't
 	 * covering.  This is more complicated than it appears when THPs are
 	 * taken into account.
@@ -252,8 +248,6 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 	fscache_write(cres, start, &iter, fscache_wreq_done, wreq);
 	return;
 
-abandon_end:
-	return fscache_wreq_done(wreq, ret);
 abandon_free:
 	kfree(wreq);
 abandon:
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 19d1e31b840b..3a7b7d6f1e89 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -19,9 +19,16 @@
 
 #define pr_fmt(fmt) "netfs: " fmt
 
+struct netfs_unbuffered_read_context {
+	struct netfs_read_context r;
+	struct bvecq_pos	dispatch_cursor; /* Dispatch position in buffer */
+};
+
 /*
  * buffered_read.c
  */
+int netfs_read_query_cache(struct netfs_io_request *rreq,
+			   struct fscache_occupancy *occ);
 void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
@@ -118,6 +125,20 @@ static inline bool bvecq_is_full(const struct bvecq *bvecq)
 	return bvecq->nr_segs >= bvecq->max_segs;
 }
 
+/*
+ * direct_read.c
+ */
+int netfs_prepare_unbuffered_read_buffer(struct netfs_io_subrequest *subreq,
+					 struct netfs_read_context *rctx,
+					 unsigned int max_segs);
+
+/*
+ * direct_write.c
+ */
+int netfs_prepare_unbuffered_write_buffer(struct netfs_io_subrequest *subreq,
+					  struct netfs_write_context *wctx,
+					  unsigned int max_segs);
+
 /*
  * main.c
  */
@@ -154,6 +175,8 @@ struct bvecq *netfs_buffer_make_space(struct netfs_io_request *rreq,
 				      enum netfs_bvecq_trace trace);
 void netfs_wake_collector(struct netfs_io_request *rreq);
 void netfs_subreq_clear_in_progress(struct netfs_io_subrequest *subreq);
+int netfs_wait_for_in_progress_subreq(struct netfs_io_request *rreq,
+				      struct netfs_io_subrequest *subreq);
 void netfs_wait_for_in_progress_stream(struct netfs_io_request *rreq,
 				       struct netfs_io_stream *stream);
 ssize_t netfs_wait_for_read(struct netfs_io_request *rreq);
@@ -197,16 +220,48 @@ void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error);
 /*
  * read_pgpriv2.c
  */
+#ifdef CONFIG_NETFS_PGPRIV2
 void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *folio);
 void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq);
 bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq);
+static inline bool netfs_using_pgpriv2(const struct netfs_io_request *rreq)
+{
+	return test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
+}
+#else
+static inline void netfs_pgpriv2_copy_to_cache(struct netfs_io_request *rreq, struct folio *folio)
+{
+}
+static inline void netfs_pgpriv2_end_copy_to_cache(struct netfs_io_request *rreq)
+{
+}
+static inline bool netfs_pgpriv2_unlock_copied_folios(struct netfs_io_request *wreq)
+{
+	return true;
+}
+static inline bool netfs_using_pgpriv2(const struct netfs_io_request *rreq)
+{
+	return false;
+}
+#endif
 
 /*
  * read_retry.c
  */
+int netfs_prepare_buffered_read_retry_buffer(struct netfs_io_subrequest *subreq,
+					     struct netfs_read_context *base_rctx,
+					     unsigned int max_segs);
+int netfs_reset_for_read_retry(struct netfs_io_subrequest *subreq);
 void netfs_retry_reads(struct netfs_io_request *rreq);
 void netfs_unlock_abandoned_read_pages(struct netfs_io_request *rreq);
 
+/*
+ * read_single.c
+ */
+int netfs_prepare_read_single_buffer(struct netfs_io_subrequest *subreq,
+				     struct netfs_read_context *rctx,
+				     unsigned int max_segs);
+
 /*
  * stats.c
  */
@@ -282,16 +337,9 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 						struct file *file,
 						loff_t start,
 						enum netfs_io_origin origin);
-void netfs_prepare_write(struct netfs_io_request *wreq,
-			 struct netfs_io_stream *stream,
-			 loff_t start);
-void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq);
-void netfs_issue_write(struct netfs_io_request *wreq,
-		       struct netfs_io_stream *stream);
-size_t netfs_advance_write(struct netfs_io_request *wreq,
-			   struct netfs_io_stream *stream,
-			   loff_t start, size_t len, bool to_eof);
+struct netfs_io_subrequest *netfs_alloc_write_subreq(struct netfs_io_request *wreq,
+						     struct netfs_io_stream *stream,
+						     struct netfs_write_context *wctx);
 struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
 int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *folio, size_t copied, bool to_page_end,
@@ -302,6 +350,9 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
 /*
  * write_retry.c
  */
+int netfs_prepare_write_retry_buffer(struct netfs_io_subrequest *subreq,
+				     struct netfs_write_context *wctx,
+				     unsigned int max_segs);
 void netfs_retry_writes(struct netfs_io_request *wreq);
 
 /*
diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index eda6e2ca02e7..78cf98068e97 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -103,16 +103,24 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_se
 			got = iov_iter_extract_pages(orig, &pages, orig_len - extracted,
 						     bq->max_segs - bq->nr_segs,
 						     extraction_flags, &offset);
+
 			if (got < 0) {
 				pr_err("Couldn't get user pages (rc=%zd)\n", got);
 				ret = got;
-				break;
+				goto out;
+			}
+
+			if (got == 0) {
+				pr_err("extract_pages gave nothing from %zu/%zu\n",
+				       extracted, orig_len);
+				ret = -EIO;
+				goto out;
 			}
 
 			if (got > orig_len - extracted) {
 				pr_err("get_pages rc=%zd more than %zu\n",
 				       got, orig_len - extracted);
-				break;
+				goto out;
 			}
 
 			extracted += got;
@@ -131,6 +139,7 @@ ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_se
 		} while (extracted < orig_len && !bvecq_is_full(bq));
 	} while (extracted < orig_len && max_segs > 0);
 
+out:
 	return extracted ?: ret;
 }
 EXPORT_SYMBOL_GPL(netfs_extract_iter);
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index a19724389147..b96be273a1fe 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -232,6 +232,37 @@ void netfs_subreq_clear_in_progress(struct netfs_io_subrequest *subreq)
 		netfs_wake_collector(rreq);
 }
 
+/*
+ * Wait for a subrequest to come to completion.
+ */
+int netfs_wait_for_in_progress_subreq(struct netfs_io_request *rreq,
+				      struct netfs_io_subrequest *subreq)
+{
+	if (netfs_check_subreq_in_progress(subreq)) {
+		DEFINE_WAIT(myself);
+
+		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_quiesce);
+		for (;;) {
+			prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
+
+			if (!netfs_check_subreq_in_progress(subreq))
+				break;
+
+			trace_netfs_sreq(subreq, netfs_sreq_trace_wait_for);
+			schedule();
+		}
+
+		trace_netfs_rreq(rreq, netfs_rreq_trace_waited_quiesce);
+		finish_wait(&rreq->waitq, &myself);
+	}
+
+	if (test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
+		return -EAGAIN;
+	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+		return subreq->error;
+	return 0;
+}
+
 /*
  * Wait for all outstanding I/O in a stream to quiesce.
  */
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index c92cdbad04de..dfa68addba27 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -46,8 +46,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->i_size	= i_size_read(inode);
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
 	rreq->wsize	= INT_MAX;
-	rreq->io_streams[0].sreq_max_len = ULONG_MAX;
-	rreq->io_streams[0].sreq_max_segs = 0;
 	spin_lock_init(&rreq->lock);
 	INIT_LIST_HEAD(&rreq->io_streams[0].subrequests);
 	INIT_LIST_HEAD(&rreq->io_streams[1].subrequests);
@@ -134,7 +132,6 @@ static void netfs_deinit_request(struct netfs_io_request *rreq)
 	if (rreq->cache_resources.ops)
 		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
 	bvecq_pos_detach(&rreq->load_cursor);
-	bvecq_pos_detach(&rreq->dispatch_cursor);
 	bvecq_pos_detach(&rreq->collect_cursor);
 
 	if (atomic_dec_and_test(&ictx->io_count))
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 20c80df8914f..b80cd8b3674c 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -36,6 +36,7 @@ static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
 
 	if (subreq->start + subreq->transferred >= subreq->rreq->i_size)
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
+	trace_netfs_rreq(subreq->rreq, netfs_rreq_trace_zero_unread);
 }
 
 /*
@@ -58,7 +59,7 @@ static void netfs_unlock_read_folio(struct netfs_io_request *rreq,
 	flush_dcache_folio(folio);
 	folio_mark_uptodate(folio);
 
-	if (!test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags)) {
+	if (!netfs_using_pgpriv2(rreq)) {
 		finfo = netfs_folio_info(folio);
 		if (finfo) {
 			trace_netfs_folio(folio, netfs_folio_trace_filled_gaps);
@@ -263,8 +264,7 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 				transferred = front->len;
 				trace_netfs_rreq(rreq, netfs_rreq_trace_set_abandon);
 			}
-			if (front->start + transferred >= rreq->cleaned_to + fsize ||
-			    test_bit(NETFS_SREQ_HIT_EOF, &front->flags))
+			if (front->start + transferred >= rreq->cleaned_to + fsize)
 				netfs_read_unlock_folios(rreq, &notes);
 		} else {
 			stream->collected_to = front->start + transferred;
@@ -381,31 +381,6 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		inode_dio_end(rreq->inode);
 }
 
-/*
- * Do processing after reading a monolithic single object.
- */
-static void netfs_rreq_assess_single(struct netfs_io_request *rreq)
-{
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
-
-	if (!rreq->error && stream->source == NETFS_DOWNLOAD_FROM_SERVER &&
-	    fscache_resources_valid(&rreq->cache_resources)) {
-		trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
-		netfs_single_mark_inode_dirty(rreq->inode);
-	}
-
-	if (rreq->iocb) {
-		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete) {
-			trace_netfs_rreq(rreq, netfs_rreq_trace_ki_complete);
-			rreq->iocb->ki_complete(
-				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
-		}
-	}
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-}
-
 /*
  * Perform the collection of subrequests and folios.
  *
@@ -441,7 +416,7 @@ bool netfs_read_collection(struct netfs_io_request *rreq)
 		netfs_rreq_assess_dio(rreq);
 		break;
 	case NETFS_READ_SINGLE:
-		netfs_rreq_assess_single(rreq);
+		WARN_ON_ONCE(1);
 		break;
 	default:
 		break;
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 68a5fece9012..2cdfc40f3ee2 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -9,19 +9,61 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static void netfs_reissue_read(struct netfs_io_request *rreq,
-			       struct netfs_io_subrequest *subreq)
+struct netfs_read_retry_context {
+	struct netfs_read_context r;
+	struct bvecq_pos	dispatch_cursor; /* Dispatch position in buffer */
+};
+
+/*
+ * Prepare the I/O buffer on a buffered read subrequest for the filesystem to
+ * use as a bvec queue.
+ */
+int netfs_prepare_buffered_read_retry_buffer(struct netfs_io_subrequest *subreq,
+					     struct netfs_read_context *base_rctx,
+					     unsigned int max_segs)
 {
+	struct netfs_read_retry_context *rctx =
+		container_of(base_rctx, struct netfs_read_retry_context, r);
+	size_t len;
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &rctx->dispatch_cursor);
 	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-			    subreq->content.slot, subreq->content.offset, subreq->len);
-	iov_iter_advance(&subreq->io_iter, subreq->transferred);
+	len = bvecq_slice(&rctx->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+	rctx->r.start += subreq->len;
+	return 0;
+}
 
-	subreq->error = 0;
+/*
+ * Reset the state of the subrequest and discard any buffering so that we can
+ * retry (where this may include sending it to the server instead of the
+ * cache).
+ */
+int netfs_reset_for_read_retry(struct netfs_io_subrequest *subreq)
+{
+	trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+
+	if (subreq->retry_count > 3) {
+		trace_netfs_sreq(subreq, netfs_sreq_trace_too_many_retries);
+		return subreq->error;
+	}
+
+	subreq->retry_count++;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+	__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+	__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_stat(&netfs_n_rh_retry_read_subreq);
-	subreq->rreq->netfs_ops->issue_read(subreq);
+	bvecq_pos_detach(&subreq->content);
+	bvecq_pos_detach(&subreq->dispatch_pos);
+	subreq->error = 0;
+	subreq->transferred = 0;
+	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
+	netfs_stat(&netfs_n_wh_retry_write_subreq);
+	return 0;
 }
 
 /*
@@ -30,10 +72,13 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
  */
 static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 {
+	struct netfs_read_retry_context rctx = {
+		.r.retrying = true,
+	};
 	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
-	struct bvecq_pos dispatch_cursor = {};
 	struct list_head *next;
+	int ret;
 
 	_enter("R=%x", rreq->debug_id);
 
@@ -43,47 +88,17 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	if (rreq->netfs_ops->retry_request)
 		rreq->netfs_ops->retry_request(rreq, NULL);
 
-	/* If there's no renegotiation to do, just resend each retryable subreq
-	 * up to the first permanently failed one.
-	 */
-	if (!rreq->netfs_ops->prepare_read &&
-	    !rreq->cache_resources.ops) {
-		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-				break;
-			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-				subreq->retry_count++;
-				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_read(rreq, subreq);
-			}
-		}
-		return;
-	}
-
 	/* Okay, we need to renegotiate all the download requests and flip any
 	 * failed cache reads over to being download requests and negotiate
-	 * those also.  All fully successful subreqs have been removed from the
-	 * list and any spare data from those has been donated.
-	 *
-	 * What we do is decant the list and rebuild it one subreq at a time so
-	 * that we don't end up with donations jumping over a gap we're busy
-	 * populating with smaller subrequests.  In the event that the subreq
-	 * we just launched finishes before we insert the next subreq, it'll
-	 * fill in rreq->prev_donated instead.
-	 *
-	 * Note: Alternatively, we could split the tail subrequest right before
-	 * we reissue it and fix up the donations under lock.
+	 * those also.
 	 */
 	next = stream->subrequests.next;
 
 	do {
 		struct netfs_io_subrequest *from, *to, *tmp;
-		unsigned long long start, len;
-		size_t part;
-		bool boundary = false, subreq_superfluous = false;
+		bool subreq_superfluous = false;
 
-		bvecq_pos_detach(&dispatch_cursor);
+		bvecq_pos_detach(&rctx.dispatch_cursor);
 
 		/* Go through the subreqs and find the next span of contiguous
 		 * buffer that we then rejig (cifs, for example, needs the
@@ -91,82 +106,65 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		 */
 		from = list_entry(next, struct netfs_io_subrequest, rreq_link);
 		to = from;
-		start = from->start + from->transferred;
-		len   = from->len   - from->transferred;
+		rctx.r.start = from->start + from->transferred;
+		rctx.r.stop  = from->start + from->len - from->transferred;
 
 		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx",
 		       rreq->debug_id, from->debug_index,
 		       from->start, from->transferred, from->len);
 
-		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+		if (!test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
 			goto abandon;
 
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
-			if (subreq->start + subreq->transferred != start + len ||
-			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
+			if (subreq->start + subreq->transferred != rctx.r.stop ||
 			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 				break;
 			to = subreq;
-			len += to->len;
+			rctx.r.stop += to->len;
 		}
 
-		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
+		_debug(" - range: %llx-%llx %llx",
+		       rctx.r.start, rctx.r.stop, rctx.r.stop - rctx.r.start);
 
 		/* Determine the set of buffers we're going to use.  Each
-		 * subreq gets a subset of a single overall contiguous buffer.
+		 * subreq takes a subset of a single overall contiguous buffer.
 		 */
-		bvecq_pos_transfer(&dispatch_cursor, &from->dispatch_pos);
-		bvecq_pos_advance(&dispatch_cursor, from->transferred);
+		bvecq_pos_transfer(&rctx.dispatch_cursor, &from->dispatch_pos);
+		bvecq_pos_advance(&rctx.dispatch_cursor, from->transferred);
 
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-			if (!len) {
+			if (rctx.r.start >= rctx.r.stop) {
 				subreq_superfluous = true;
 				break;
 			}
 			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
-			subreq->start	= start - subreq->transferred;
-			subreq->len	= len   + subreq->transferred;
-			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-			subreq->retry_count++;
-
-			bvecq_pos_detach(&subreq->dispatch_pos);
-			bvecq_pos_detach(&subreq->content);
-
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+			subreq->start	= rctx.r.start;
+			subreq->len	= rctx.r.stop - rctx.r.start;
 
-			/* Renegotiate max_len (rsize) */
-			stream->sreq_max_len = subreq->len;
-			stream->sreq_max_segs = INT_MAX;
-			if (rreq->netfs_ops->prepare_read &&
-			    rreq->netfs_ops->prepare_read(subreq) < 0) {
-				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
+			ret = netfs_reset_for_read_retry(subreq);
+			if (ret < 0) {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+				rreq->error = ret;
 				goto abandon;
 			}
 
-			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-
-			len -= part;
-			start += part;
-			if (!len) {
-				if (boundary)
-					__set_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
-			} else {
-				__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
+			netfs_stat(&netfs_n_rh_download);
+			ret = rreq->netfs_ops->issue_read(subreq, &rctx.r);
+			if (ret < 0 && ret != -EIOCBQUEUED) {
+				if (ret == -ENOMEM)
+					goto abandon;
+				subreq->error = ret;
+				if (ret != -EAGAIN) {
+					__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+					goto abandon_after;
+				}
+				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+				netfs_read_subreq_terminated(subreq);
 			}
-
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_read(rreq, subreq);
 			if (subreq == to) {
 				subreq_superfluous = false;
 				break;
@@ -176,7 +174,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		/* If we managed to use fewer subreqs, we can discard the
 		 * excess; if we used the same number, then we're done.
 		 */
-		if (!len) {
+		if (rctx.r.start >= rctx.r.stop) {
 			if (!subreq_superfluous)
 				continue;
 			list_for_each_entry_safe_from(subreq, tmp,
@@ -200,8 +198,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				goto abandon_after;
 			}
 			subreq->source		= NETFS_DOWNLOAD_FROM_SERVER;
-			subreq->start		= start;
-			subreq->len		= len;
+			subreq->start		= rctx.r.start;
+			subreq->len		= rctx.r.stop - rctx.r.start;
 			subreq->stream_nr	= stream->stream_nr;
 			subreq->retry_count	= 1;
 
@@ -213,37 +211,26 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
-			stream->sreq_max_len	= umin(len, rreq->rsize);
-			stream->sreq_max_segs	= INT_MAX;
-
 			netfs_stat(&netfs_n_rh_download);
-			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
-				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
-				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-				goto abandon;
-			}
-
-			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-
-			len -= part;
-			start += part;
-			if (!len && boundary) {
-				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
-				boundary = false;
+			ret = rreq->netfs_ops->issue_read(subreq, &rctx.r);
+			if (ret < 0 && ret != -EIOCBQUEUED) {
+				if (ret == -ENOMEM)
+					goto abandon;
+				subreq->error = ret;
+				if (ret != -EAGAIN) {
+					__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+					goto abandon_after;
+				}
+				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+				netfs_read_subreq_terminated(subreq);
 			}
 
-			netfs_reissue_read(rreq, subreq);
-		} while (len);
+		} while (rctx.r.start < rctx.r.stop);
 
 	} while (!list_is_head(next, &stream->subrequests));
 
 out:
-	bvecq_pos_detach(&dispatch_cursor);
+	bvecq_pos_detach(&rctx.dispatch_cursor);
 	return;
 
 	/* If we hit an error, fail all remaining incomplete subrequests */
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 0f49d6aab874..5b3a0b07be82 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -16,6 +16,25 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+struct netfs_read_single_context {
+	struct netfs_read_context r;
+	struct fscache_occupancy cache;		/* List of cached extents */
+};
+
+int netfs_prepare_read_single_buffer(struct netfs_io_subrequest *subreq,
+				     struct netfs_read_context *base_rctx,
+				     unsigned int max_segs)
+{
+	struct netfs_read_single_context *rctx =
+		container_of(base_rctx, struct netfs_read_single_context, r);
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &subreq->rreq->load_cursor);
+	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+
+	rctx->r.start += subreq->len;
+	return 0;
+}
+
 /**
  * netfs_single_mark_inode_dirty - Mark a single, monolithic object inode dirty
  * @inode: The inode to mark
@@ -58,97 +77,95 @@ static int netfs_single_begin_cache_read(struct netfs_io_request *rreq, struct n
 	return fscache_begin_read_operation(&rreq->cache_resources, netfs_i_cookie(ctx));
 }
 
-static void netfs_single_cache_prepare_read(struct netfs_io_request *rreq,
-					    struct netfs_io_subrequest *subreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	if (!cres->ops) {
-		subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
-		return;
-	}
-	subreq->source = cres->ops->prepare_read(subreq, rreq->i_size);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-
-}
-
-static void netfs_single_read_cache(struct netfs_io_request *rreq,
-				    struct netfs_io_subrequest *subreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	_enter("R=%08x[%x]", rreq->debug_id, subreq->debug_index);
-	netfs_stat(&netfs_n_rh_read);
-	cres->ops->read(cres, subreq->start, &subreq->io_iter, NETFS_READ_HOLE_FAIL,
-			netfs_cache_read_terminated, subreq);
-}
-
 /*
  * Perform a read to a buffer from the cache or the server.  Only a single
  * subreq is permitted as the object must be fetched in a single transaction.
  */
 static int netfs_single_dispatch_read(struct netfs_io_request *rreq)
 {
-	struct netfs_io_stream *stream = &rreq->io_streams[0];
+	struct netfs_read_single_context rctx = {
+		.cache.query_from	= rreq->start,
+		.cache.query_to		= rreq->start + rreq->len,
+		.cache.cached_from[0]	= ULLONG_MAX,
+		.cache.cached_to[0]	= ULLONG_MAX,
+		.r.start		= rreq->start,
+		.r.stop			= rreq->start + rreq->len,
+	};
 	struct netfs_io_subrequest *subreq;
-	int ret = 0;
+	int ret;
+
+	ret = netfs_read_query_cache(rreq, &rctx.cache);
+	if (ret < 0)
+		return ret;
 
 	subreq = netfs_alloc_subrequest(rreq);
 	if (!subreq)
 		return -ENOMEM;
 
-	subreq->source		= NETFS_SOURCE_UNKNOWN;
-	subreq->start		= 0;
-	subreq->len		= rreq->len;
-
-	bvecq_pos_attach(&subreq->dispatch_pos, &rreq->dispatch_cursor);
-	bvecq_pos_attach(&subreq->content, &rreq->dispatch_cursor);
+	subreq->start	= 0;
+	subreq->len	= rreq->len;
 
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_DEST, subreq->content.bvecq,
-			    subreq->content.slot, subreq->content.offset, subreq->len);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
-	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+	/* Try to use the cache if the cache content matches the size of the
+	 * remote file.
+	 */
+	if (rctx.cache.nr_extents == 1 &&
+	    rctx.cache.cached_from[0] == 0 &&
+	    rctx.cache.cached_to[0] == rreq->len) {
+		struct netfs_cache_resources *cres = &rreq->cache_resources;
+
+		subreq->source = NETFS_READ_FROM_CACHE;
+		netfs_stat(&netfs_n_rh_read);
+		ret = cres->ops->issue_read(subreq, &rctx.r);
+		if (ret == -EIOCBQUEUED)
+			ret = netfs_wait_for_in_progress_subreq(rreq, subreq);
+		if (ret == -ENOMEM)
+			goto cancel;
+		if (ret == 0)
+			goto success;
+
+		/* Didn't manage to retrieve from the cache, so toss it to the
+		 * server instead.
+		 */
+		if (netfs_reset_for_read_retry(subreq) < 0)
+			goto cancel;
+	}
 
-	spin_lock(&rreq->lock);
-	list_add_tail(&subreq->rreq_link, &stream->subrequests);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-	stream->front = subreq;
-	/* Store list pointers before active flag */
-	smp_store_release(&stream->active, true);
-	spin_unlock(&rreq->lock);
+	__set_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
 
-	netfs_single_cache_prepare_read(rreq, subreq);
-	switch (subreq->source) {
-	case NETFS_DOWNLOAD_FROM_SERVER:
+	/* Try to send it to the cache. */
+	for (;;) {
+		subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 		netfs_stat(&netfs_n_rh_download);
-		if (rreq->netfs_ops->prepare_read) {
-			ret = rreq->netfs_ops->prepare_read(subreq);
-			if (ret < 0)
-				goto cancel;
-		}
-
-		rreq->netfs_ops->issue_read(subreq);
-		rreq->submitted += subreq->len;
-		break;
-	case NETFS_READ_FROM_CACHE:
-		trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-		netfs_single_read_cache(rreq, subreq);
-		rreq->submitted += subreq->len;
-		ret = 0;
-		break;
-	default:
-		pr_warn("Unexpected single-read source %u\n", subreq->source);
-		WARN_ON_ONCE(true);
-		ret = -EIO;
-		break;
+		ret = rreq->netfs_ops->issue_read(subreq, &rctx.r);
+		if (ret == -EIOCBQUEUED)
+			ret = netfs_wait_for_in_progress_subreq(rreq, subreq);
+		if (ret == 0)
+			goto success;
+		if (ret == -ENOMEM)
+			goto cancel;
+		if (ret != -EAGAIN)
+			goto failed;
+		if (netfs_reset_for_read_retry(subreq) < 0)
+			goto cancel;
 	}
 
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
-	return ret;
+success:
+	rreq->transferred = subreq->transferred;
+	list_del_init(&subreq->rreq_link);
+	netfs_put_subrequest(subreq, netfs_sreq_trace_put_consumed);
+	return 0;
 cancel:
+	rreq->error = ret;
+	list_del_init(&subreq->rreq_link);
 	netfs_put_subrequest(subreq, netfs_sreq_trace_put_cancel);
 	return ret;
+failed:
+	rreq->error = ret;
+	list_del_init(&subreq->rreq_link);
+	netfs_put_subrequest(subreq, netfs_sreq_trace_put_failed);
+	return ret;
 }
 
 /**
@@ -179,7 +196,7 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	if (IS_ERR(rreq))
 		return PTR_ERR(rreq);
 
-	ret = netfs_extract_iter(iter, rreq->len, INT_MAX, 0, &rreq->dispatch_cursor.bvecq, 0);
+	ret = netfs_extract_iter(iter, rreq->len, INT_MAX, 0, &rreq->load_cursor.bvecq, 0);
 	if (ret < 0)
 		goto cleanup_free;
 
@@ -190,9 +207,29 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	netfs_stat(&netfs_n_rh_read_single);
 	trace_netfs_read(rreq, 0, rreq->len, netfs_read_trace_read_single);
 
-	netfs_single_dispatch_read(rreq);
+	ret = netfs_single_dispatch_read(rreq);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_complete);
+	if (ret == 0) {
+		task_io_account_read(rreq->transferred);
+
+		if (test_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags) &&
+		    fscache_resources_valid(&rreq->cache_resources)) {
+			trace_netfs_rreq(rreq, netfs_rreq_trace_dirty);
+			netfs_single_mark_inode_dirty(rreq->inode);
+		}
+		ret = rreq->transferred;
+	}
+
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+
+	netfs_wake_rreq_flag(rreq, NETFS_RREQ_IN_PROGRESS, netfs_rreq_trace_wake_ip);
+	/* As we cleared NETFS_RREQ_IN_PROGRESS, we acquired its ref. */
+	netfs_put_request(rreq, netfs_rreq_trace_put_work_ip);
+
+	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 
-	ret = netfs_wait_for_read(rreq);
 	netfs_put_request(rreq, netfs_rreq_trace_put_return);
 	return ret;
 
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index ed11086346b0..741b43a77db8 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -28,8 +28,8 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
 	       rreq->origin, rreq->error);
 	pr_err("  st=%llx tsl=%zx/%llx/%llx\n",
 	       rreq->start, rreq->transferred, rreq->submitted, rreq->len);
-	pr_err("  cci=%llx/%llx/%llx\n",
-	       rreq->cleaned_to, rreq->collected_to, atomic64_read(&rreq->issued_to));
+	pr_err("  cci=%llx/%llx\n",
+	       rreq->cleaned_to, rreq->collected_to);
 	pr_err("  iw=%pSR\n", rreq->netfs_ops->issue_write);
 	for (int i = 0; i < NR_IO_STREAMS; i++) {
 		const struct netfs_io_subrequest *sreq;
@@ -38,8 +38,9 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
 		pr_err("  str[%x] s=%x e=%d acnf=%u,%u,%u,%u\n",
 		       s->stream_nr, s->source, s->error,
 		       s->avail, s->active, s->need_retry, s->failed);
-		pr_err("  str[%x] ct=%llx t=%zx\n",
-		       s->stream_nr, s->collected_to, s->transferred);
+		pr_err("  str[%x] it=%llx ct=%llx t=%zx\n",
+		       s->stream_nr, atomic64_read(&s->issued_to),
+		       s->collected_to, s->transferred);
 		list_for_each_entry(sreq, &s->subrequests, rreq_link) {
 			pr_err("  sreq[%x:%x] sc=%u s=%llx t=%zx/%zx r=%d f=%lx\n",
 			       sreq->stream_nr, sreq->debug_index, sreq->source,
@@ -56,7 +57,7 @@ static void netfs_dump_request(const struct netfs_io_request *rreq)
  */
 int netfs_folio_written_back(struct folio *folio)
 {
-	enum netfs_folio_trace why = netfs_folio_trace_clear;
+	enum netfs_folio_trace why = netfs_folio_trace_endwb;
 	struct netfs_inode *ictx = netfs_inode(folio->mapping->host);
 	struct netfs_folio *finfo;
 	struct netfs_group *group = NULL;
@@ -76,13 +77,13 @@ int netfs_folio_written_back(struct folio *folio)
 		group = finfo->netfs_group;
 		gcount++;
 		kfree(finfo);
-		why = netfs_folio_trace_clear_s;
+		why = netfs_folio_trace_endwb_s;
 		goto end_wb;
 	}
 
 	if ((group = netfs_folio_group(folio))) {
 		if (group == NETFS_FOLIO_COPY_TO_CACHE) {
-			why = netfs_folio_trace_clear_cc;
+			why = netfs_folio_trace_endwb_cc;
 			folio_detach_private(folio);
 			goto end_wb;
 		}
@@ -95,7 +96,7 @@ int netfs_folio_written_back(struct folio *folio)
 		if (!folio_test_dirty(folio)) {
 			folio_detach_private(folio);
 			gcount++;
-			why = netfs_folio_trace_clear_g;
+			why = netfs_folio_trace_endwb_g;
 		}
 	}
 
@@ -212,9 +213,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
 
 reassess_streams:
-	/* Order reading the issued_to point before reading the queue it refers to. */
-	issued_to = atomic64_read_acquire(&wreq->issued_to);
-	smp_rmb();
+	issued_to = ULLONG_MAX;
 	collected_to = ULLONG_MAX;
 	if (wreq->origin == NETFS_WRITEBACK ||
 	    wreq->origin == NETFS_WRITETHROUGH ||
@@ -229,13 +228,25 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	 * to the tail whilst we're doing this.
 	 */
 	for (s = 0; s < NR_IO_STREAMS; s++) {
+		unsigned long long s_issued_to;
+
 		stream = &wreq->io_streams[s];
-		/* Read active flag before list pointers */
+		/* Read active flag before issued_to */
 		if (!smp_load_acquire(&stream->active))
 			continue;
 
-		front = stream->front;
-		while (front) {
+		for (;;) {
+			/* Order reading the issued_to point before reading the
+			 * queue it refers to.
+			 */
+			s_issued_to = atomic64_read_acquire(&stream->issued_to);
+			if (s_issued_to < issued_to)
+				issued_to = s_issued_to;
+
+			front = stream->front;
+			if (!front)
+				break;
+
 			trace_netfs_collect_sreq(wreq, front);
 			//_debug("sreq [%x] %llx %zx/%zx",
 			//       front->debug_index, front->start, front->transferred, front->len);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 5d4d8dbfe877..f8d308ccb574 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -36,6 +36,46 @@
 #include <linux/pagemap.h>
 #include "internal.h"
 
+#define NOTE_UPLOAD_AVAIL	0x001	/* Upload is available */
+#define NOTE_CACHE_AVAIL	0x002	/* Local cache is available */
+#define NOTE_CACHE_COPY		0x004	/* Copy folio to cache */
+#define NOTE_UPLOAD		0x008	/* Upload folio to server */
+#define NOTE_UPLOAD_STARTED	0x010	/* Upload started */
+#define NOTE_STREAMW		0x020	/* Folio is from a streaming write */
+#define NOTE_DISCONTIG_BEFORE	0x040	/* Folio discontiguous with the previous folio */
+#define NOTE_DISCONTIG_AFTER	0x080	/* Folio discontiguous with the next folio */
+#define NOTE_TO_EOF		0x100	/* Data in folio ends at EOF */
+#define NOTE_FLUSH_ANYWAY	0x200	/* Flush data, even if not hit estimated limit */
+
+#define NOTES__KEEP_MASK (NOTE_UPLOAD_AVAIL | NOTE_CACHE_AVAIL | NOTE_UPLOAD_STARTED)
+
+struct netfs_wb_context {
+	struct netfs_write_context wctx;
+	struct netfs_write_estimate estimate;
+	struct bvecq_pos	dispatch_cursor; /* Folio queue anchor for issue_at */
+	bool			buffering;	/* T if has data attached, needs issuing */
+};
+
+struct netfs_wb_params {
+	unsigned long long	last_end;	/* End file pos of previous folio */
+	unsigned long long	folio_start;	/* File pos of folio */
+	unsigned int		folio_len;	/* Length of folio */
+	unsigned int		dirty_offset;	/* Offset of dirty region in folio */
+	unsigned int		dirty_len;	/* Length of dirty region in folio */
+	unsigned int		notes;		/* Notes on applicability */
+	struct bvecq_pos	dispatch_cursor; /* Folio queue anchor for issue_at */
+	struct netfs_wb_context	w[2];
+};
+
+struct netfs_write_single {
+	struct netfs_write_context wctx;
+	struct bvecq_pos	dispatch_cursor; /* Buffer */
+};
+
+static int netfs_prepare_write_single_buffer(struct netfs_io_subrequest *subreq,
+					     struct netfs_write_context *wctx,
+					     unsigned int max_segs);
+
 /*
  * Kill all dirty folios in the event of an unrecoverable error, starting with
  * a locked folio we've already obtained from writeback_iter().
@@ -113,65 +153,49 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	wreq->io_streams[0].stream_nr		= 0;
 	wreq->io_streams[0].source		= NETFS_UPLOAD_TO_SERVER;
-	wreq->io_streams[0].prepare_write	= ictx->ops->prepare_write;
+	wreq->io_streams[0].applicable		= NOTE_UPLOAD;
+	wreq->io_streams[0].estimate_write	= ictx->ops->estimate_write;
 	wreq->io_streams[0].issue_write		= ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	= start;
 	wreq->io_streams[0].transferred		= 0;
 
 	wreq->io_streams[1].stream_nr		= 1;
 	wreq->io_streams[1].source		= NETFS_WRITE_TO_CACHE;
+	wreq->io_streams[1].applicable		= NOTE_CACHE_COPY;
 	wreq->io_streams[1].collected_to	= start;
 	wreq->io_streams[1].transferred		= 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
 		wreq->io_streams[1].active	= true;
-		wreq->io_streams[1].prepare_write = wreq->cache_resources.ops->prepare_write_subreq;
+		wreq->io_streams[1].estimate_write = wreq->cache_resources.ops->estimate_write;
 		wreq->io_streams[1].issue_write = wreq->cache_resources.ops->issue_write;
 	}
 
 	return wreq;
 }
 
-/**
- * netfs_prepare_write_failed - Note write preparation failed
- * @subreq: The subrequest to mark
- *
- * Mark a subrequest to note that preparation for write failed.
- */
-void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq)
-{
-	__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prep_failed);
-}
-EXPORT_SYMBOL(netfs_prepare_write_failed);
-
 /*
- * Prepare a write subrequest.  We need to allocate a new subrequest
- * if we don't have one.
+ * Allocate and prepare a write subrequest.
  */
-void netfs_prepare_write(struct netfs_io_request *wreq,
-			 struct netfs_io_stream *stream,
-			 loff_t start)
+struct netfs_io_subrequest *netfs_alloc_write_subreq(struct netfs_io_request *wreq,
+						     struct netfs_io_stream *stream,
+						     struct netfs_write_context *wctx)
 {
 	struct netfs_io_subrequest *subreq;
 
 	subreq = netfs_alloc_subrequest(wreq);
 	subreq->source		= stream->source;
-	subreq->start		= start;
+	subreq->start		= wctx->issue_from;
+	subreq->len		= wctx->buffered;
 	subreq->stream_nr	= stream->stream_nr;
 
-	bvecq_pos_attach(&subreq->dispatch_pos, &wreq->dispatch_cursor);
-
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
-	stream->sreq_max_len	= UINT_MAX;
-	stream->sreq_max_segs	= INT_MAX;
 	switch (stream->source) {
 	case NETFS_UPLOAD_TO_SERVER:
 		netfs_stat(&netfs_n_wh_upload);
-		stream->sreq_max_len = wreq->wsize;
 		break;
 	case NETFS_WRITE_TO_CACHE:
 		netfs_stat(&netfs_n_wh_write);
@@ -181,9 +205,6 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 		break;
 	}
 
-	if (stream->prepare_write)
-		stream->prepare_write(subreq);
-
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 
 	/* We add to the end of the list whilst the collector may be walking
@@ -194,83 +215,47 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
 		stream->front = subreq;
-		if (!stream->active) {
-			stream->collected_to = stream->front->start;
-			/* Write list pointers before active flag */
-			smp_store_release(&stream->active, true);
-		}
+		if (stream->collected_to == 0)
+			stream->collected_to = subreq->start;
 	}
 
 	spin_unlock(&wreq->lock);
-
-	stream->construct = subreq;
+	return subreq;
 }
 
 /*
- * Set the I/O iterator for the filesystem/cache to use and dispatch the I/O
- * operation.  The operation may be asynchronous and should call
- * netfs_write_subrequest_terminated() when complete.
+ * Prepare the buffer for a buffered write.
  */
-static void netfs_do_issue_write(struct netfs_io_stream *stream,
-				 struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *wreq = subreq->rreq;
-
-	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
-
-	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-		return netfs_write_subrequest_terminated(subreq, subreq->error);
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	stream->issue_write(subreq);
-}
-
-void netfs_reissue_write(struct netfs_io_stream *stream,
-			 struct netfs_io_subrequest *subreq)
+static int netfs_prepare_buffered_write_buffer(struct netfs_io_subrequest *subreq,
+					       struct netfs_write_context *wctx,
+					       unsigned int max_segs)
 {
-	// TODO: Use encrypted buffer
-	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
-			    subreq->content.bvecq, subreq->content.slot,
-			    subreq->content.offset,
-			    subreq->len);
-	iov_iter_advance(&subreq->io_iter, subreq->transferred);
-
-	subreq->retry_count++;
-	subreq->error = 0;
-	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-	netfs_stat(&netfs_n_wh_retry_write_subreq);
-	netfs_do_issue_write(stream, subreq);
-}
+	struct netfs_wb_context *wbctx =
+		container_of(wctx, struct netfs_wb_context, wctx);
+	struct netfs_io_stream *stream = &subreq->rreq->io_streams[subreq->stream_nr];
+	ssize_t len;
 
-void netfs_issue_write(struct netfs_io_request *wreq,
-		       struct netfs_io_stream *stream)
-{
-	struct netfs_io_subrequest *subreq = stream->construct;
+	_enter("%zx,{,%u,%u},%u",
+	       subreq->len, wbctx->dispatch_cursor.slot, wbctx->dispatch_cursor.offset, max_segs);
 
-	if (!subreq)
-		return;
+	bvecq_pos_attach(&subreq->dispatch_pos, &wbctx->dispatch_cursor);
 
 	/* If we have a write to the cache, we need to round out the first and
 	 * last entries (only those as the data will be on virtually contiguous
 	 * folios) to cache DIO boundaries.
 	 */
 	if (subreq->source == NETFS_WRITE_TO_CACHE) {
-		struct bvecq_pos tmp_pos;
 		struct bio_vec *bv;
 		struct bvecq *bq;
 		size_t dio_size = PAGE_SIZE;
-		size_t disp, len;
-		int ret;
+		size_t disp, dlen;
 
-		bvecq_pos_attach(&tmp_pos, &subreq->dispatch_pos);
-		ret = bvecq_extract(&tmp_pos, subreq->len, INT_MAX, &subreq->content.bvecq);
-		bvecq_pos_detach(&tmp_pos);
-		if (ret < 0) {
-			netfs_write_subrequest_terminated(subreq, -ENOMEM);
-			return;
-		}
+		len = bvecq_extract(&wbctx->dispatch_cursor, subreq->len, max_segs,
+				    &subreq->content.bvecq);
+		if (len < 0)
+			return -ENOMEM;
+
+		_debug("extract %zx/%zx", len, subreq->len);
 
 		/* Round the first entry down. */
 		bq = subreq->content.bvecq;
@@ -288,96 +273,276 @@ void netfs_issue_write(struct netfs_io_request *wreq,
 		while (bq->next)
 			bq = bq->next;
 		bv = &bq->bv[bq->nr_segs - 1];
-		len = round_up(bv->bv_len, dio_size - 1);
-		if (len > bv->bv_len) {
-			subreq->len += len - bv->bv_len;
-			bv->bv_len = len;
+		dlen = round_up(bv->bv_len, dio_size - 1);
+		if (dlen > bv->bv_len) {
+			subreq->len += dlen - bv->bv_len;
+			bv->bv_len = dlen;
 		}
 	} else {
-		bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+		bvecq_pos_attach(&subreq->content, &wbctx->dispatch_cursor);
+		len = bvecq_slice(&wbctx->dispatch_cursor, subreq->len, max_segs,
+				  &subreq->nr_segs);
+
+		if (len < subreq->len) {
+			subreq->len = len;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+		}
 	}
 
-	iov_iter_bvec_queue(&subreq->io_iter, ITER_SOURCE,
-			    subreq->content.bvecq, subreq->content.slot,
-			    subreq->content.offset,
-			    subreq->len);
+	wctx->issue_from += len;
+	wctx->buffered   -= len;
+	if (wctx->buffered == 0) {
+		wbctx->buffering = false;
+		bvecq_pos_detach(&wbctx->dispatch_cursor);
+	}
+	/* Order loading the queue before updating the issue_to point */
+	atomic64_set_release(&stream->issued_to, wctx->issue_from);
+	return 0;
+}
+
+/**
+ * netfs_prepare_write_buffer - Get the buffer for a subrequest
+ * @subreq: The subrequest to get the buffer for
+ * @wctx: Write context
+ * @max_segs: Maximum number of segments in buffer (or INT_MAX)
+ *
+ * Extract a slice of buffer from the stream and attach it to the subrequest as
+ * a bio_vec queue.  The maximum amount of data attached is set by
+ * @subreq->len, but this may be shortened if @max_segs would be exceeded.
+ */
+int netfs_prepare_write_buffer(struct netfs_io_subrequest *subreq,
+			       struct netfs_write_context *wctx,
+			       unsigned int max_segs)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+
+	switch (rreq->origin) {
+	case NETFS_WRITEBACK:
+	case NETFS_WRITETHROUGH:
+		if (test_bit(NETFS_RREQ_RETRYING, &rreq->flags))
+			return netfs_prepare_write_retry_buffer(subreq, wctx, max_segs);
+		return netfs_prepare_buffered_write_buffer(subreq, wctx, max_segs);
+
+	case NETFS_UNBUFFERED_WRITE:
+	case NETFS_DIO_WRITE:
+		return netfs_prepare_unbuffered_write_buffer(subreq, wctx, max_segs);
+
+	case NETFS_WRITEBACK_SINGLE:
+		return netfs_prepare_write_single_buffer(subreq, wctx, max_segs);
+
+	case NETFS_PGPRIV2_COPY_TO_CACHE:
+#if 0
+		ret = netfs_extract_iter(&wctx->unbuff_iter, subreq->len,
+					 max_segs, &subreq->content, 0);
+		if (ret < 0)
+			return ret;
+		if (ret < subreq->len) {
+			subreq->len = ret;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+		}
+
+		wctx->issue_from += subreq->len;
+		wctx->buffered   -= subreq->len;
+		return 0;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+}
+EXPORT_SYMBOL(netfs_prepare_write_buffer);
+
+/*
+ * Issue writes for a stream.
+ */
+static int netfs_issue_writes(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      struct netfs_wb_params *params)
+{
+	for (;;) {
+		struct netfs_io_subrequest *subreq;
+		struct netfs_wb_context *wbctx = &params->w[stream->stream_nr];
+		struct netfs_write_context *wctx = &wbctx->wctx;
+		int ret;
+
+		subreq = netfs_alloc_write_subreq(wreq, stream, wctx);
+		if (!subreq)
+			return -ENOMEM;
+
+		ret = stream->issue_write(subreq, wctx);
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			return ret;
+
+		if (wctx->buffered == 0) {
+			if (stream->stream_nr == 0)
+				params->notes &= ~NOTE_UPLOAD_STARTED;
+			return 0;
+		}
 
-	stream->construct = NULL;
-	netfs_do_issue_write(stream, subreq);
+		if (!(params->notes & NOTE_FLUSH_ANYWAY)) {
+			wbctx->estimate.issue_at = ULLONG_MAX;
+			wbctx->estimate.max_segs = INT_MAX;
+			stream->estimate_write(wreq, stream, wctx, &wbctx->estimate);
+			if (wctx->issue_from + wctx->buffered < wbctx->estimate.issue_at &&
+			    wbctx->estimate.max_segs > 0)
+				return 0;
+		}
+	}
 }
 
 /*
- * Add data to the write subrequest, dispatching each as we fill it up or if it
- * is discontiguous with the previous.  We only fill one part at a time so that
- * we can avoid overrunning the credits obtained (cifs) and try to parallelise
- * content-crypto preparation with network writes.
+ * See which streams need writes issuing and issue them.
  */
-size_t netfs_advance_write(struct netfs_io_request *wreq,
-			   struct netfs_io_stream *stream,
-			   loff_t start, size_t len, bool to_eof)
+static int netfs_issue_streams(struct netfs_io_request *wreq,
+			       struct netfs_wb_params *params)
 {
-	struct netfs_io_subrequest *subreq = stream->construct;
-	size_t part;
+	_enter("%x", params->notes);
+
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_wb_context *wbctx = &params->w[s];
+		struct netfs_write_context *wctx = &wbctx->wctx;
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
+		unsigned long long dirty_start;
+		bool discontig_before = params->notes & NOTE_DISCONTIG_BEFORE;
+		int ret;
+
+		/* If the current folio doesn't contribute to this stream, see
+		 * if we need to flush it.
+		 */
+		if (!(params->notes & stream->applicable)) {
+			if (!wbctx->buffering) {
+				atomic64_set_release(&stream->issued_to,
+						     params->folio_start + params->folio_len);
+				continue;
+			}
+			discontig_before = true;
+		}
+
+		/* Issue writes if we meet a discontiguity before the current
+		 * folio.  Even if the filesystem can do sparse/vectored
+		 * writes, we still generate a subreq per contiguous region
+		 * rather than generating separate extent lists.
+		 */
+		if (wbctx->buffering && discontig_before) {
+			params->notes |= NOTE_FLUSH_ANYWAY;
+			ret = netfs_issue_writes(wreq, stream, params);
+			if (ret < 0)
+				return ret;
+			wbctx->buffering = false;
+			params->notes &= ~NOTE_FLUSH_ANYWAY;
+		}
+
+		if (!(params->notes & stream->applicable)) {
+			atomic64_set_release(&stream->issued_to,
+					     params->folio_start + params->folio_len);
+			continue;
+		}
 
-	if (!stream->avail) {
-		_leave("no write");
-		return len;
+		/* If we're not currently buffering on this stream, we need to
+		 * get an estimate of when we need to issue a write.  It might
+		 * be within the starting folio.
+		 */
+		dirty_start = params->folio_start + params->dirty_offset;
+		if (!wbctx->buffering) {
+			wbctx->buffering = true;
+			wctx->issue_from = dirty_start;
+			bvecq_pos_attach(&wbctx->dispatch_cursor, &params->dispatch_cursor);
+			wbctx->estimate.issue_at = ULLONG_MAX;
+			wbctx->estimate.max_segs = INT_MAX;
+			stream->estimate_write(wreq, stream, wctx, &wbctx->estimate);
+		}
+
+		wctx->buffered += params->dirty_len;
+		wbctx->estimate.max_segs--;
+
+		/* Poke the filesystem to issue writes when we hit the limit it
+		 * set or if the data ends before the end of the page.
+		 */
+		if (params->notes & NOTE_DISCONTIG_AFTER)
+			params->notes |= NOTE_FLUSH_ANYWAY;
+		_debug("[%u] %llx + %x >= %llx, %u %x",
+		       s, dirty_start, params->dirty_len, wbctx->estimate.issue_at,
+		       wbctx->estimate.max_segs, params->notes);
+		if (dirty_start + params->dirty_len >= wbctx->estimate.issue_at ||
+		    wbctx->estimate.max_segs <= 0 ||
+		    (params->notes & NOTE_FLUSH_ANYWAY)) {
+			ret = netfs_issue_writes(wreq, stream, params);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
-	_enter("R=%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
+	return 0;
+}
+
+/*
+ * End the issuing of writes, let the collector know we're done.
+ */
+static void netfs_end_issue_write(struct netfs_io_request *wreq,
+				  struct netfs_wb_params *params)
+{
+	bool needs_poke = true;
+
+	params->notes |= NOTE_FLUSH_ANYWAY;
 
-	if (subreq && start != subreq->start + subreq->len) {
-		netfs_issue_write(wreq, stream);
-		subreq = NULL;
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_wb_context *wbctx = &params->w[s];
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
+		int ret;
+
+		if (wbctx->buffering) {
+			ret = netfs_issue_writes(wreq, stream, params);
+			if (ret < 0) {
+				/* Leave the error somewhere the completion
+				 * path can pick it up if there isn't already
+				 * another error logged.
+				 */
+				cmpxchg(&wreq->error, 0, ret);
+			}
+			wbctx->buffering = false;
+		}
 	}
 
-	if (!stream->construct)
-		netfs_prepare_write(wreq, stream, start);
-	subreq = stream->construct;
+	smp_wmb(); /* Write subreq lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
 
-	part = umin(stream->sreq_max_len - subreq->len, len);
-	_debug("part %zx/%zx %zx/%zx", subreq->len, stream->sreq_max_len, part, len);
-	subreq->len += part;
-	subreq->nr_segs++;
+	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_stream *stream = &wreq->io_streams[s];
 
-	if (subreq->len >= stream->sreq_max_len ||
-	    subreq->nr_segs >= stream->sreq_max_segs ||
-	    to_eof) {
-		netfs_issue_write(wreq, stream);
-		subreq = NULL;
+		if (!stream->active)
+			continue;
+		if (!list_empty(&stream->subrequests))
+			needs_poke = false;
 	}
 
-	return part;
+	if (needs_poke)
+		netfs_wake_collector(wreq);
 }
 
 /*
- * Write some of a pending folio data back to the server.
+ * Queue a folio for writeback.
  */
-static int netfs_write_folio(struct netfs_io_request *wreq,
-			     struct writeback_control *wbc,
-			     struct folio *folio)
+static int netfs_queue_wb_folio(struct netfs_io_request *wreq,
+				struct writeback_control *wbc,
+				struct folio *folio,
+				struct netfs_wb_params *params)
 {
-	struct netfs_io_stream *upload = &wreq->io_streams[0];
-	struct netfs_io_stream *cache  = &wreq->io_streams[1];
-	struct netfs_io_stream *stream;
 	struct netfs_group *fgroup; /* TODO: Use this with ceph */
 	struct netfs_folio *finfo;
 	struct bvecq *queue = wreq->load_cursor.bvecq;
 	unsigned int slot;
 	size_t fsize = folio_size(folio), flen = fsize, foff = 0;
 	loff_t fpos = folio_pos(folio), i_size;
-	bool to_eof = false, streamw = false;
-	bool debug = false;
 	int ret;
 
-	_enter("");
+	_enter("%x", params->notes);
 
 	/* Institute a new bvec queue segment if the current one is full or if
 	 * we encounter a discontiguity.  The discontiguity break is important
 	 * when it comes to bulk unlocking folios by file range.
 	 */
 	if (bvecq_is_full(queue) ||
-	    (fpos != wreq->last_end && wreq->last_end > 0)) {
+	    (fpos != params->last_end && params->last_end > 0)) {
 		ret = bvecq_buffer_make_space(&wreq->load_cursor);
 		if (ret < 0) {
 			folio_unlock(folio);
@@ -386,10 +551,10 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 
 		queue = wreq->load_cursor.bvecq;
 		queue->fpos = fpos;
-		if (fpos != wreq->last_end)
+		if (fpos != params->last_end)
 			queue->discontig = true;
-		bvecq_pos_move(&wreq->dispatch_cursor, queue);
-		wreq->dispatch_cursor.slot = 0;
+		bvecq_pos_move(&params->dispatch_cursor, queue);
+		params->dispatch_cursor.slot = 0;
 	}
 
 	/* netfs_perform_write() may shift i_size around the page or from out
@@ -417,23 +582,36 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (finfo) {
 		foff = finfo->dirty_offset;
 		flen = foff + finfo->dirty_len;
-		streamw = true;
+		params->notes |= NOTE_STREAMW;
+		if (foff > 0)
+			params->notes |= NOTE_DISCONTIG_BEFORE;
+		if (flen < fsize)
+			params->notes |= NOTE_DISCONTIG_AFTER;
 	}
 
+	if (params->last_end && fpos != params->last_end)
+		params->notes |= NOTE_DISCONTIG_BEFORE;
+	params->last_end = fpos + fsize;
+
 	if (wreq->origin == NETFS_WRITETHROUGH) {
-		to_eof = false;
 		if (flen > i_size - fpos)
 			flen = i_size - fpos;
+		/* EOF may be changing. */
 	} else if (flen > i_size - fpos) {
 		flen = i_size - fpos;
-		if (!streamw)
+		if (!(params->notes & NOTE_STREAMW))
 			folio_zero_segment(folio, flen, fsize);
-		to_eof = true;
+		params->notes |= NOTE_TO_EOF;
 	} else if (flen == i_size - fpos) {
-		to_eof = true;
+		params->notes |= NOTE_TO_EOF;
 	}
 	flen -= foff;
 
+	params->folio_start	= fpos;
+	params->folio_len	= fsize;
+	params->dirty_offset	= foff;
+	params->dirty_len	= flen;
+
 	_debug("folio %zx %zx %zx", foff, flen, fsize);
 
 	/* Deal with discontinuities in the stream of dirty pages.  These can
@@ -453,22 +631,31 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	 *     write-back group.
 	 */
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		netfs_issue_write(wreq, upload);
+		if (!(params->notes & NOTE_CACHE_AVAIL)) {
+			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
+			goto cancel_folio;
+		}
+		params->notes |= NOTE_CACHE_COPY;
+		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
 	} else if (fgroup != wreq->group) {
 		/* We can't write this page to the server yet. */
 		kdebug("wrong group");
-		folio_redirty_for_writepage(wbc, folio);
-		folio_unlock(folio);
-		netfs_issue_write(wreq, upload);
-		netfs_issue_write(wreq, cache);
-		return 0;
+		goto skip_folio;
+	} else if (!(params->notes & (NOTE_UPLOAD_AVAIL | NOTE_CACHE_AVAIL))) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		goto cancel_folio_discard;
+	} else {
+		if (params->notes & NOTE_UPLOAD_STARTED) {
+			params->notes |= NOTE_UPLOAD;
+			trace_netfs_folio(folio, netfs_folio_trace_store_plus);
+		} else {
+			params->notes |= NOTE_UPLOAD | NOTE_UPLOAD_STARTED;
+			trace_netfs_folio(folio, netfs_folio_trace_store);
+		}
+		if (params->notes & NOTE_CACHE_AVAIL)
+			params->notes |= NOTE_CACHE_COPY;
 	}
 
-	if (foff > 0)
-		netfs_issue_write(wreq, upload);
-	if (streamw)
-		netfs_issue_write(wreq, cache);
-
 	/* Flip the page to the writeback state and unlock.  If we're called
 	 * from write-through, then the page has already been put into the wb
 	 * state.
@@ -477,24 +664,6 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		folio_start_writeback(folio);
 	folio_unlock(folio);
 
-	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		if (!cache->avail) {
-			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
-			netfs_issue_write(wreq, upload);
-			netfs_folio_written_back(folio);
-			return 0;
-		}
-		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
-	} else if (!upload->avail && !cache->avail) {
-		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
-		netfs_folio_written_back(folio);
-		return 0;
-	} else if (!upload->construct) {
-		trace_netfs_folio(folio, netfs_folio_trace_store);
-	} else {
-		trace_netfs_folio(folio, netfs_folio_trace_store_plus);
-	}
-
 	/* Attach the folio to the rolling buffer. */
 	slot = queue->nr_segs;
 	bvec_set_folio(&queue->bv[slot], folio, flen, foff);
@@ -502,103 +671,28 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	wreq->load_cursor.slot = slot + 1;
 	wreq->load_cursor.offset = 0;
 	trace_netfs_bv_slot(queue, slot);
+	trace_netfs_wback(wreq, folio, params->notes);
 
-	/* Move the submission point forward to allow for write-streaming data
-	 * not starting at the front of the page.  We don't do write-streaming
-	 * with the cache as the cache requires DIO alignment.
-	 *
-	 * Also skip uploading for data that's been read and just needs copying
-	 * to the cache.
-	 */
-	for (int s = 0; s < NR_IO_STREAMS; s++) {
-		stream = &wreq->io_streams[s];
-		stream->submit_off = foff;
-		stream->submit_len = flen;
-		if (!stream->avail ||
-		    (stream->source == NETFS_WRITE_TO_CACHE && streamw) ||
-		    (stream->source == NETFS_UPLOAD_TO_SERVER &&
-		     fgroup == NETFS_FOLIO_COPY_TO_CACHE)) {
-			stream->submit_off = UINT_MAX;
-			stream->submit_len = 0;
-		}
-	}
-
-	/* Attach the folio to one or more subrequests.  For a big folio, we
-	 * could end up with thousands of subrequests if the wsize is small -
-	 * but we might need to wait during the creation of subrequests for
-	 * network resources (eg. SMB credits).
-	 */
-	for (;;) {
-		ssize_t part;
-		size_t lowest_off = ULONG_MAX;
-		int choose_s = -1;
-
-		/* Always add to the lowest-submitted stream first. */
-		for (int s = 0; s < NR_IO_STREAMS; s++) {
-			stream = &wreq->io_streams[s];
-			if (stream->submit_len > 0 &&
-			    stream->submit_off < lowest_off) {
-				lowest_off = stream->submit_off;
-				choose_s = s;
-			}
-		}
-
-		if (choose_s < 0)
-			break;
-		stream = &wreq->io_streams[choose_s];
-
-		/* Advance the cursor. */
-		wreq->dispatch_cursor.offset = stream->submit_off;
-
-		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
-		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
-					   stream->submit_len, to_eof);
-		stream->submit_off += part;
-		if (part > stream->submit_len)
-			stream->submit_len = 0;
-		else
-			stream->submit_len -= part;
-		if (part > 0)
-			debug = true;
-	}
-
-	bvecq_buffer_step(&wreq->dispatch_cursor);
-	/* Order loading the queue before updating the issue_to point */
-	atomic64_set_release(&wreq->issued_to, fpos + fsize);
-
-	if (!debug)
-		kdebug("R=%x: No submit", wreq->debug_id);
-
-	if (foff + flen < fsize)
-		for (int s = 0; s < NR_IO_STREAMS; s++)
-			netfs_issue_write(wreq, &wreq->io_streams[s]);
-
-	_leave(" = 0");
+out:
+	_leave(" = %x", params->notes);
 	return 0;
-}
-
-/*
- * End the issuing of writes, letting the collector know we're done.
- */
-static void netfs_end_issue_write(struct netfs_io_request *wreq)
-{
-	bool needs_poke = true;
-
-	smp_wmb(); /* Write subreq lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
-
-	for (int s = 0; s < NR_IO_STREAMS; s++) {
-		struct netfs_io_stream *stream = &wreq->io_streams[s];
 
-		if (!stream->active)
-			continue;
-		if (!list_empty(&stream->subrequests))
-			needs_poke = false;
-		netfs_issue_write(wreq, stream);
-	}
-
-	if (needs_poke)
-		netfs_wake_collector(wreq);
+skip_folio:
+	ret = folio_redirty_for_writepage(wbc, folio);
+	folio_unlock(folio);
+	if (ret < 0)
+		return ret;
+	params->notes |= NOTE_DISCONTIG_BEFORE;
+	goto out;
+cancel_folio_discard:
+	netfs_put_group(fgroup);
+cancel_folio:
+	folio_detach_private(folio);
+	kfree(finfo);
+	folio_unlock(folio);
+	folio_cancel_dirty(folio);
+	params->notes |= NOTE_DISCONTIG_BEFORE;
+	goto out;
 }
 
 /*
@@ -609,6 +703,7 @@ int netfs_writepages(struct address_space *mapping,
 {
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct netfs_io_request *wreq = NULL;
+	struct netfs_wb_params params = {};
 	struct folio *folio;
 	int error = 0;
 
@@ -634,35 +729,47 @@ int netfs_writepages(struct address_space *mapping,
 
 	if (bvecq_buffer_init(&wreq->load_cursor, wreq->debug_id) < 0)
 		goto nomem;
-	bvecq_pos_attach(&wreq->dispatch_cursor, &wreq->load_cursor);
-	bvecq_pos_attach(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	bvecq_pos_attach(&params.dispatch_cursor, &wreq->load_cursor);
+	bvecq_pos_attach(&wreq->collect_cursor, &wreq->load_cursor);
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
-	do {
-		_debug("wbiter %lx %llx", folio->index, atomic64_read(&wreq->issued_to));
+	if (wreq->io_streams[1].avail)
+		params.notes |= NOTE_CACHE_AVAIL;
 
-		/* It appears we don't have to handle cyclic writeback wrapping. */
-		WARN_ON_ONCE(wreq && folio_pos(folio) < atomic64_read(&wreq->issued_to));
+	do {
+		_debug("wbiter %lx", folio->index);
 
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
 			wreq->netfs_ops->begin_writeback(wreq);
+			if (wreq->io_streams[0].avail) {
+				params.notes |= NOTE_UPLOAD_AVAIL;
+				/* Order setting the active flag after other fields. */
+				smp_store_release(&wreq->io_streams[0].active, true);
+			}
 		}
 
-		error = netfs_write_folio(wreq, wbc, folio);
+		params.notes &= NOTES__KEEP_MASK;
+		error = netfs_queue_wb_folio(wreq, wbc, folio, &params);
+		if (error < 0)
+			break;
+		error = netfs_issue_streams(wreq, &params);
 		if (error < 0)
 			break;
+
 	} while ((folio = writeback_iter(mapping, wbc, folio, &error)));
 
-	netfs_end_issue_write(wreq);
+	netfs_end_issue_write(wreq, &params);
 
 	mutex_unlock(&ictx->wb_lock);
 	bvecq_pos_detach(&wreq->load_cursor);
-	bvecq_pos_detach(&wreq->dispatch_cursor);
+	bvecq_pos_detach(&params.dispatch_cursor);
+	bvecq_pos_detach(&params.w[0].dispatch_cursor);
+	bvecq_pos_detach(&params.w[1].dispatch_cursor);
 	netfs_wake_collector(wreq);
 
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
@@ -713,6 +820,9 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio *folio, size_t copied, bool to_page_end,
 			       struct folio **writethrough_cache)
 {
+	struct netfs_wb_params params = {};
+	int ret;
+
 	_enter("R=%x ws=%u cp=%zu tp=%u",
 	       wreq->debug_id, wreq->wsize, copied, to_page_end);
 
@@ -735,7 +845,10 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 		return 0;
 
 	*writethrough_cache = NULL;
-	return netfs_write_folio(wreq, wbc, folio);
+	ret = netfs_queue_wb_folio(wreq, wbc, folio, &params);
+	if (ret < 0)
+		return ret;
+	return netfs_issue_streams(wreq, &params);
 }
 
 /*
@@ -744,15 +857,19 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *writethrough_cache)
 {
+	struct netfs_wb_params params = {};
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	ssize_t ret;
 
 	_enter("R=%x", wreq->debug_id);
 
-	if (writethrough_cache)
-		netfs_write_folio(wreq, wbc, writethrough_cache);
+	if (writethrough_cache) {
+		ret = netfs_queue_wb_folio(wreq, wbc, writethrough_cache, &params);
+		if (ret == 0)
+			ret = netfs_issue_streams(wreq, &params);
+	}
 
-	netfs_end_issue_write(wreq);
+	netfs_end_issue_write(wreq, &params);
 
 	mutex_unlock(&ictx->wb_lock);
 
@@ -764,23 +881,46 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
 	return ret;
 }
 
+/*
+ * Prepare a buffer for a single monolithic write.
+ */
+static int netfs_prepare_write_single_buffer(struct netfs_io_subrequest *subreq,
+					     struct netfs_write_context *wctx,
+					     unsigned int max_segs)
+{
+	struct netfs_write_single *wsctx =
+		container_of(wctx, struct netfs_write_single, wctx);
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &wsctx->dispatch_cursor);
+	bvecq_pos_attach(&subreq->content, &subreq->dispatch_pos);
+
+	wctx->issue_from += subreq->len;
+	wctx->buffered   -= subreq->len;
+	subreq->rreq->submitted += subreq->len;
+	return 0;
+}
+
 /**
  * netfs_writeback_single - Write back a monolithic payload
  * @mapping: The mapping to write from
  * @wbc: Hints from the VM
- * @iter: Data to write.
+ * @iter: Data to write
+ * @len: Amount of data to write
  *
  * Write a monolithic, non-pagecache object back to the server and/or
  * the cache.  There's a maximum of one subrequest per stream.
  */
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
-			   struct iov_iter *iter)
+			   struct iov_iter *iter,
+			   size_t len)
 {
 	struct netfs_io_request *wreq;
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	int ret;
 
+	_enter("%zx,%zx", iov_iter_count(iter), len);
+
 	if (!mutex_trylock(&ictx->wb_lock)) {
 		if (wbc->sync_mode == WB_SYNC_NONE) {
 			netfs_stat(&netfs_n_wb_lock_skip);
@@ -795,9 +935,10 @@ int netfs_writeback_single(struct address_space *mapping,
 		ret = PTR_ERR(wreq);
 		goto couldnt_start;
 	}
-	wreq->len = iov_iter_count(iter);
 
-	ret = netfs_extract_iter(iter, wreq->len, INT_MAX, 0, &wreq->dispatch_cursor.bvecq, 0);
+	wreq->len = len;
+
+	ret = netfs_extract_iter(iter, len, INT_MAX, 0, &wreq->load_cursor.bvecq, 0);
 	if (ret < 0)
 		goto cleanup_free;
 	if (ret < wreq->len) {
@@ -805,29 +946,39 @@ int netfs_writeback_single(struct address_space *mapping,
 		goto cleanup_free;
 	}
 
-	bvecq_pos_attach(&wreq->collect_cursor, &wreq->dispatch_cursor);
+	bvecq_pos_attach(&wreq->collect_cursor, &wreq->load_cursor);
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &wreq->flags);
 	trace_netfs_write(wreq, netfs_write_trace_writeback_single);
 	netfs_stat(&netfs_n_wh_writepages);
 
-	if (__test_and_set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+	if (test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
 		wreq->netfs_ops->begin_writeback(wreq);
 
 	for (int s = 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_write_single wsctx = {
+			.wctx.issue_from	= 0,
+			.wctx.buffered		= iov_iter_count(iter),
+		};
 		struct netfs_io_subrequest *subreq;
 		struct netfs_io_stream *stream = &wreq->io_streams[s];
 
 		if (!stream->avail)
 			continue;
 
-		netfs_prepare_write(wreq, stream, 0);
+		subreq = netfs_alloc_write_subreq(wreq, stream, &wsctx.wctx);
+		if (!subreq) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		bvecq_pos_attach(&wsctx.dispatch_cursor, &wreq->load_cursor);
 
-		subreq = stream->construct;
-		subreq->len = wreq->len;
-		stream->submit_len = subreq->len;
+		ret = stream->issue_write(subreq, &wsctx.wctx);
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			netfs_write_subrequest_terminated(subreq, ret);
 
-		netfs_issue_write(wreq, stream);
+		bvecq_pos_detach(&wsctx.dispatch_cursor);
 	}
 
 	wreq->submitted = wreq->len;
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index b9352bf45c4b..e43c7d4787b2 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -11,13 +11,52 @@
 #include <linux/slab.h>
 #include "internal.h"
 
+struct netfs_write_retry_context {
+	struct netfs_write_context wctx;
+	struct bvecq_pos	dispatch_cursor; /* Dispatch position in buffer */
+};
+
+/*
+ * Prepare the write buffer for a retry.  We can't necessarily reuse the write
+ * buffer from the previous run of a subrequest because the filesystem is
+ * permitted to modify it (add headers/trailers, encrypt it).  Further, the
+ * subrequest may now be a different size (e.g. cifs has to negotiate for
+ * maximum transfer size).  Also, we can't look at *stream as that may still
+ * refer to the source material being broken up into original subrequests.
+ */
+int netfs_prepare_write_retry_buffer(struct netfs_io_subrequest *subreq,
+				     struct netfs_write_context *wctx,
+				     unsigned int max_segs)
+{
+	struct netfs_write_retry_context *yctx =
+		container_of(wctx, struct netfs_write_retry_context, wctx);
+	size_t len;
+
+	bvecq_pos_attach(&subreq->dispatch_pos, &yctx->dispatch_cursor);
+	bvecq_pos_attach(&subreq->content, &yctx->dispatch_cursor);
+	len = bvecq_slice(&yctx->dispatch_cursor, subreq->len, max_segs,
+			  &subreq->nr_segs);
+
+	if (len < subreq->len) {
+		subreq->len = len;
+		trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
+	}
+
+	wctx->issue_from += len;
+	wctx->buffered   -= len;
+	if (wctx->buffered == 0)
+		bvecq_pos_detach(&yctx->dispatch_cursor);
+	return 0;
+}
+
 /*
- * Perform retries on the streams that need it.
+ * Perform retries on the streams that need it.  This only has to deal with
+ * buffered writes; unbuffered write retry is handled in direct_write.c.
  */
 static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				     struct netfs_io_stream *stream)
 {
-	struct bvecq_pos dispatch_cursor = {};
+	struct netfs_write_retry_context yctx = {};
 	struct list_head *next;
 
 	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
@@ -32,30 +71,15 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 	if (unlikely(stream->failed))
 		return;
 
-	/* If there's no renegotiation to do, just resend each failed subreq. */
-	if (!stream->prepare_write) {
-		struct netfs_io_subrequest *subreq;
-
-		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
-			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
-				break;
-			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-				netfs_reissue_write(stream, subreq);
-			}
-		}
-		return;
-	}
-
 	next = stream->subrequests.next;
 
 	do {
+		struct netfs_write_context *wctx = &yctx.wctx;
 		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
 		unsigned long long start, len;
-		size_t part;
-		bool boundary = false;
+		int ret;
 
-		bvecq_pos_detach(&dispatch_cursor);
+		bvecq_pos_detach(&yctx.dispatch_cursor);
 
 		/* Go through the stream and find the next span of contiguous
 		 * data that we then rejig (cifs, for example, needs the wsize
@@ -73,7 +97,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		list_for_each_continue(next, &stream->subrequests) {
 			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start + subreq->transferred != start + len ||
-			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
 			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 				break;
 			to = subreq;
@@ -83,43 +106,40 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
-		bvecq_pos_transfer(&dispatch_cursor, &from->dispatch_pos);
-		bvecq_pos_advance(&dispatch_cursor, from->transferred);
+		bvecq_pos_transfer(&yctx.dispatch_cursor, &from->dispatch_pos);
+		bvecq_pos_advance(&yctx.dispatch_cursor, from->transferred);
+		wctx->issue_from = start;
+		wctx->buffered = len;
 
 		/* Work through the sublist. */
 		subreq = from;
 		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
-			if (!len)
+			if (!wctx->buffered)
 				break;
 
-			subreq->start	= start;
-			subreq->len	= len;
-			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-
 			bvecq_pos_detach(&subreq->dispatch_pos);
 			bvecq_pos_detach(&subreq->content);
+			subreq->content.bvecq = NULL;
+			subreq->content.slot = 0;
+			subreq->content.offset = 0;
 
-			/* Renegotiate max_len (wsize) */
-			stream->sreq_max_len = len;
-			stream->sreq_max_segs = INT_MAX;
-			stream->prepare_write(subreq);
-
-			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-			subreq->transferred = 0;
-			len -= part;
-			start += part;
-			if (len && subreq == to &&
-			    __test_and_clear_bit(NETFS_SREQ_BOUNDARY, &to->flags))
-				boundary = true;
-
+			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+			__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
+			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+			subreq->start		= wctx->issue_from;
+			subreq->len		= wctx->buffered;
+			subreq->transferred	= 0;
+			subreq->retry_count	+= 1;
+			subreq->error		= 0;
+
+			netfs_stat(&netfs_n_wh_retry_write_subreq);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			netfs_reissue_write(stream, subreq);
+			ret = stream->issue_write(subreq, wctx);
+			if (ret < 0 && ret != -EIOCBQUEUED)
+				netfs_write_subrequest_terminated(subreq, ret);
+
 			if (subreq == to)
 				break;
 		}
@@ -160,12 +180,9 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
-			stream->sreq_max_len	= len;
-			stream->sreq_max_segs	= INT_MAX;
 			switch (stream->source) {
 			case NETFS_UPLOAD_TO_SERVER:
 				netfs_stat(&netfs_n_wh_upload);
-				stream->sreq_max_len = umin(len, wreq->wsize);
 				break;
 			case NETFS_WRITE_TO_CACHE:
 				netfs_stat(&netfs_n_wh_write);
@@ -174,32 +191,16 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				WARN_ON_ONCE(1);
 			}
 
-			stream->prepare_write(subreq);
-
-			bvecq_pos_attach(&subreq->dispatch_pos, &dispatch_cursor);
-			part = bvecq_slice(&dispatch_cursor,
-					   umin(len, stream->sreq_max_len),
-					   stream->sreq_max_segs,
-					   &subreq->nr_segs);
-			subreq->len = subreq->transferred + part;
-
-			len -= part;
-			start += part;
-			if (!len && boundary) {
-				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
-				boundary = false;
-			}
-
-			netfs_reissue_write(stream, subreq);
-			if (!len)
-				break;
+			ret = stream->issue_write(subreq, wctx);
+			if (ret < 0 && ret != -EIOCBQUEUED)
+				netfs_write_subrequest_terminated(subreq, ret);
 
 		} while (len);
 
 	} while (!list_is_head(next, &stream->subrequests));
 
 out:
-	bvecq_pos_detach(&dispatch_cursor);
+	bvecq_pos_detach(&yctx.dispatch_cursor);
 }
 
 /*
@@ -237,4 +238,6 @@ void netfs_retry_writes(struct netfs_io_request *wreq)
 			netfs_retry_write_stream(wreq, stream);
 		}
 	}
+
+	pr_notice("Retrying\n");
 }
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 9b7fdad4a920..1f42fb5dc443 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -296,7 +296,8 @@ static struct nfs_netfs_io_data *nfs_netfs_alloc(struct netfs_io_subrequest *sre
 	return netfs;
 }
 
-static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
+static int nfs_netfs_issue_read(struct netfs_io_subrequest *sreq,
+				struct netfs_read_context *rctx)
 {
 	struct nfs_netfs_io_data	*netfs;
 	struct nfs_pageio_descriptor	pgio;
@@ -314,10 +315,11 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 			     &nfs_async_read_completion_ops);
 
 	netfs = nfs_netfs_alloc(sreq);
-	if (!netfs) {
-		sreq->error = -ENOMEM;
-		return netfs_read_subreq_terminated(sreq);
-	}
+	if (!netfs)
+		return -ENOMEM;
+
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(sreq, rctx);
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
@@ -332,6 +334,7 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 out:
 	nfs_pageio_complete_read(&pgio);
 	nfs_netfs_put(netfs);
+	return -EIOCBQUEUED;
 }
 
 void nfs_netfs_initiate_read(struct nfs_pgio_header *hdr)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 3990a9012264..c09232ceba35 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1466,8 +1466,7 @@ cifs_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 1,
-				 .rq_iter = rdata->subreq.io_iter };
+				 .rq_nvec = 1};
 	struct cifs_credits credits = {
 		.value = 1,
 		.instance = 0,
@@ -1481,6 +1480,11 @@ cifs_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		 __func__, mid->mid, mid->mid_state, rdata->result,
 		 rdata->subreq.len);
 
+	if (rdata->got_bytes)
+		iov_iter_bvec_queue(&rqst.rq_iter, ITER_DEST,
+				    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+				    rdata->subreq.content.offset, rdata->subreq.len);
+
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		/* result already set, check signature */
@@ -2002,7 +2006,10 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 1;
-	rqst.rq_iter = wdata->subreq.io_iter;
+
+	iov_iter_bvec_queue(&rqst.rq_iter, ITER_DEST,
+			    wdata->subreq.content.bvecq, wdata->subreq.content.slot,
+			    wdata->subreq.content.offset, wdata->subreq.len);
 
 	cifs_dbg(FYI, "async write at %llu %zu bytes\n",
 		 wdata->subreq.start, wdata->subreq.len);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 18f31d4eb98d..aca299520968 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -44,18 +44,36 @@ static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush);
  * Prepare a subrequest to upload to the server.  We need to allocate credits
  * so that we know the maximum amount of data that we can include in it.
  */
-static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
+static int cifs_estimate_write(struct netfs_io_request *wreq,
+			       struct netfs_io_stream *stream,
+			       const struct netfs_write_context *wctx,
+			       struct netfs_write_estimate *estimate)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(wreq->inode->i_sb);
+
+	estimate->issue_at = wctx->issue_from + cifs_sb->ctx->wsize;
+	return 0;
+}
+
+/*
+ * Issue a subrequest to upload to the server.
+ */
+static int cifs_issue_write(struct netfs_io_subrequest *subreq,
+			    struct netfs_write_context *wctx)
 {
 	struct cifs_io_subrequest *wdata =
 		container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = wdata->req;
-	struct netfs_io_stream *stream = &req->rreq.io_streams[subreq->stream_nr];
 	struct TCP_Server_Info *server;
 	struct cifsFileInfo *open_file = req->cfile;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(wdata->rreq->inode->i_sb);
-	size_t wsize = req->rreq.wsize;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(subreq->rreq->inode->i_sb);
+	unsigned int max_segs = INT_MAX;
+	size_t len;
 	int rc;
 
+	if (cifs_forced_shutdown(cifs_sb))
+		return smb_EIO(smb_eio_trace_forced_shutdown);
+
 	if (!wdata->have_xid) {
 		wdata->xid = get_xid();
 		wdata->have_xid = true;
@@ -74,18 +92,16 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		if (rc < 0) {
 			if (rc == -EAGAIN)
 				goto retry;
-			subreq->error = rc;
-			return netfs_prepare_write_failed(subreq);
+			return rc;
 		}
 	}
 
-	rc = server->ops->wait_mtu_credits(server, wsize, &stream->sreq_max_len,
-					   &wdata->credits);
-	if (rc < 0) {
-		subreq->error = rc;
-		return netfs_prepare_write_failed(subreq);
-	}
+	len = umin(subreq->len, cifs_sb->ctx->wsize);
+	rc = server->ops->wait_mtu_credits(server, len, &len, &wdata->credits);
+	if (rc < 0)
+		return rc;
 
+	subreq->len = len;
 	wdata->credits.rreq_debug_id = subreq->rreq->debug_id;
 	wdata->credits.rreq_debug_index = subreq->debug_index;
 	wdata->credits.in_flight_check = 1;
@@ -101,39 +117,29 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		const struct smbdirect_socket_parameters *sp =
 			smbd_get_parameters(server->smbd_conn);
 
-		stream->sreq_max_segs = sp->max_frmr_depth;
+		max_segs = sp->max_frmr_depth;
 	}
 #endif
-}
-
-/*
- * Issue a subrequest to upload to the server.
- */
-static void cifs_issue_write(struct netfs_io_subrequest *subreq)
-{
-	struct cifs_io_subrequest *wdata =
-		container_of(subreq, struct cifs_io_subrequest, subreq);
-	struct cifs_sb_info *sbi = CIFS_SB(subreq->rreq->inode->i_sb);
-	int rc;
 
-	if (cifs_forced_shutdown(sbi)) {
-		rc = smb_EIO(smb_eio_trace_forced_shutdown);
-		goto fail;
+	rc = netfs_prepare_write_buffer(subreq, wctx, max_segs);
+	if (rc < 0) {
+		add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
+		return rc;
 	}
 
-	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
+	rc = adjust_credits(server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
-		goto fail;
+		goto fail_with_credits;
 
 	rc = -EAGAIN;
 	if (wdata->req->cfile->invalidHandle)
-		goto fail;
+		goto fail_with_credits;
 
 	wdata->server->ops->async_writev(wdata);
 out:
-	return;
+	return -EIOCBQUEUED;
 
-fail:
+fail_with_credits:
 	if (rc == -EAGAIN)
 		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 	else
@@ -149,17 +155,26 @@ static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
 }
 
 /*
- * Negotiate the size of a read operation on behalf of the netfs library.
+ * Issue a read operation on behalf of the netfs helper functions.  We're asked
+ * to make a read of a certain size at a point in the file.  We are permitted
+ * to only read a portion of that, but as long as we read something, the netfs
+ * helper will call us again so that we can issue another read.
  */
-static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
+static int cifs_issue_read(struct netfs_io_subrequest *subreq,
+			   struct netfs_read_context *rctx)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server;
+	struct TCP_Server_Info *server = rdata->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	size_t size;
-	int rc = 0;
+	unsigned int max_segs = INT_MAX;
+	size_t len;
+	int rc;
+
+	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
+		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
+		 subreq->transferred, subreq->len);
 
 	if (!rdata->have_xid) {
 		rdata->xid = get_xid();
@@ -173,17 +188,15 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 		cifs_negotiate_rsize(server, cifs_sb->ctx,
 				     tlink_tcon(req->cfile->tlink));
 
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
-					   &size, &rdata->credits);
+	len = umin(subreq->len, cifs_sb->ctx->rsize);
+	rc = server->ops->wait_mtu_credits(server, len, &len, &rdata->credits);
 	if (rc)
 		return rc;
 
-	rreq->io_streams[0].sreq_max_len = size;
-
-	rdata->credits.in_flight_check = 1;
+	subreq->len = len;
 	rdata->credits.rreq_debug_id = rreq->debug_id;
 	rdata->credits.rreq_debug_index = subreq->debug_index;
-
+	rdata->credits.in_flight_check = 1;
 	trace_smb3_rw_credits(rdata->rreq->debug_id,
 			      rdata->subreq.debug_index,
 			      rdata->credits.value,
@@ -195,33 +208,17 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 		const struct smbdirect_socket_parameters *sp =
 			smbd_get_parameters(server->smbd_conn);
 
-		rreq->io_streams[0].sreq_max_segs = sp->max_frmr_depth;
+		max_segs = sp->max_frmr_depth;
 	}
 #endif
-	return 0;
-}
-
-/*
- * Issue a read operation on behalf of the netfs helper functions.  We're asked
- * to make a read of a certain size at a point in the file.  We are permitted
- * to only read a portion of that, but as long as we read something, the netfs
- * helper will call us again so that we can issue another read.
- */
-static void cifs_issue_read(struct netfs_io_subrequest *subreq)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
-	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
-	struct TCP_Server_Info *server = rdata->server;
-	int rc = 0;
 
-	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
-		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
-		 subreq->transferred, subreq->len);
+	rc = netfs_prepare_read_buffer(subreq, rctx, max_segs);
+	if (rc < 0)
+		goto fail_with_credits;
 
 	rc = adjust_credits(server, rdata, cifs_trace_rw_credits_issue_read_adjust);
 	if (rc)
-		goto failed;
+		goto fail_with_credits;
 
 	if (req->cfile->invalidHandle) {
 		do {
@@ -235,15 +232,24 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	    subreq->rreq->origin != NETFS_DIO_READ)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	/* After this point, we're not allowed to return an error. */
+	netfs_mark_read_submission(subreq, rctx);
+
 	rc = rdata->server->ops->async_readv(rdata);
-	if (rc)
-		goto failed;
-	return;
+	if (rc) {
+		subreq->error = rc;
+		netfs_read_subreq_terminated(subreq);
+	}
+	return -EIOCBQUEUED;
 
+fail_with_credits:
+	if (rc == -EAGAIN)
+		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+	else
+		trace_netfs_sreq(subreq, netfs_sreq_trace_fail);
+	add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 failed:
-	subreq->error = rc;
-	netfs_read_subreq_terminated(subreq);
+	return rc;
 }
 
 /*
@@ -353,11 +359,10 @@ const struct netfs_request_ops cifs_req_ops = {
 	.init_request		= cifs_init_request,
 	.free_request		= cifs_free_request,
 	.free_subrequest	= cifs_free_subrequest,
-	.prepare_read		= cifs_prepare_read,
 	.issue_read		= cifs_issue_read,
 	.done			= cifs_rreq_done,
 	.begin_writeback	= cifs_begin_writeback,
-	.prepare_write		= cifs_prepare_write,
+	.estimate_write		= cifs_estimate_write,
 	.issue_write		= cifs_issue_write,
 	.invalidate_cache	= cifs_netfs_invalidate_cache,
 };
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7223a8deaa58..c4aa11a13cef 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4705,6 +4705,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
 	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct iov_iter iter;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	size_t copied;
 	bool use_rdma_mr = false;
@@ -4777,6 +4778,10 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 	pad_len = data_offset - server->vals->read_rsp_size;
 
+	iov_iter_bvec_queue(&iter, ITER_DEST,
+			    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+			    rdata->subreq.content.offset, rdata->subreq.len);
+
 	if (buf_len <= data_offset) {
 		/* read response payload is in pages */
 		cur_page_idx = pad_len / PAGE_SIZE;
@@ -4806,7 +4811,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 		/* Copy the data to the output I/O iterator. */
 		rdata->result = cifs_copy_bvecq_to_iter(buffer, buffer_len,
-							cur_off, &rdata->subreq.io_iter);
+							cur_off, &iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4819,7 +4824,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
 		WARN_ONCE(buffer, "read data can be either in buf or in buffer");
-		copied = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_iter);
+		copied = copy_to_iter(buf + data_offset, data_len, &iter);
 		if (copied == 0)
 			return smb_EIO2(smb_eio_trace_rx_copy_to_iter, copied, data_len);
 		rdata->got_bytes = copied;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ef655acf673d..71961776c4ab 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4562,9 +4562,13 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	 */
 	if (rdata && smb3_use_rdma_offload(io_parms)) {
 		struct smbdirect_buffer_descriptor_v1 *v1;
+		struct iov_iter iter;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->subreq.io_iter,
+		iov_iter_bvec_queue(&iter, ITER_DEST,
+				    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+				    rdata->subreq.content.offset, rdata->subreq.len);
+		rdata->mr = smbd_register_mr(server->smbd_conn, &iter,
 					     true, need_invalidate);
 		if (!rdata->mr)
 			return -EAGAIN;
@@ -4629,9 +4633,10 @@ smb2_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	unsigned int rreq_debug_id = rdata->rreq->debug_id;
 	unsigned int subreq_debug_index = rdata->subreq.debug_index;
 
-	if (rdata->got_bytes) {
-		rqst.rq_iter	  = rdata->subreq.io_iter;
-	}
+	if (rdata->got_bytes)
+		iov_iter_bvec_queue(&rqst.rq_iter, ITER_DEST,
+				    rdata->subreq.content.bvecq, rdata->subreq.content.slot,
+				    rdata->subreq.content.offset, rdata->subreq.len);
 
 	WARN_ONCE(rdata->server != server,
 		  "rdata server %p != mid server %p",
@@ -5119,7 +5124,9 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		goto out;
 
 	rqst.rq_iov = iov;
-	rqst.rq_iter = wdata->subreq.io_iter;
+	iov_iter_bvec_queue(&rqst.rq_iter, ITER_SOURCE,
+			    wdata->subreq.content.bvecq, wdata->subreq.content.slot,
+			    wdata->subreq.content.offset, wdata->subreq.len);
 
 	rqst.rq_iov[0].iov_len = total_len - 1;
 	rqst.rq_iov[0].iov_base = (char *)req;
@@ -5158,9 +5165,14 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	 */
 	if (smb3_use_rdma_offload(io_parms)) {
 		struct smbdirect_buffer_descriptor_v1 *v1;
+		struct iov_iter iter;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->subreq.io_iter,
+		iov_iter_bvec_queue(&iter, ITER_SOURCE,
+				    wdata->subreq.content.bvecq, wdata->subreq.content.slot,
+				    wdata->subreq.content.offset, wdata->subreq.len);
+
+		wdata->mr = smbd_register_mr(server->smbd_conn, &iter,
 					     false, need_invalidate);
 		if (!wdata->mr) {
 			rc = -EAGAIN;
@@ -5199,8 +5211,8 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		smb2_set_replay(server, &rqst);
 	}
 
-	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
-		 io_parms->offset, io_parms->length, iov_iter_count(&wdata->subreq.io_iter));
+	cifs_dbg(FYI, "async write at %llu %u bytes len=%zx\n",
+		 io_parms->offset, io_parms->length, wdata->subreq.len);
 
 	if (wdata->credits.value > 0) {
 		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->subreq.len,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 75697f6d2566..9daa98332d34 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1265,12 +1265,19 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	}
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (rdata->mr)
+	if (rdata->mr) {
 		length = data_len; /* An RDMA read is already done. */
-	else
+	} else {
+#endif
+		struct iov_iter iter;
+
+		iov_iter_bvec_queue(&iter, ITER_DEST, rdata->subreq.content.bvecq,
+				    rdata->subreq.content.slot, rdata->subreq.content.offset,
+				    data_len);
+		length = cifs_read_iter_from_socket(server, &iter, data_len);
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	}
 #endif
-		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
-						    data_len);
 	if (length > 0)
 		rdata->got_bytes += length;
 	server->total_read += length;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 58fdb9605425..637f46c68d84 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -147,6 +147,25 @@ struct fscache_cookie {
 	};
 };
 
+enum fscache_extent_type {
+	FSCACHE_EXTENT_DATA,
+	FSCACHE_EXTENT_ZERO,
+} __mode(byte);
+
+/*
+ * Cache occupancy information.
+ */
+struct fscache_occupancy {
+	unsigned long long	query_from;	/* Point to query from */
+	unsigned long long	query_to;	/* Point to query to */
+	unsigned long long	cached_from[2];	/* Point at which cache extents start */
+	unsigned long long	cached_to[2];	/* Point at which cache extents end */
+	unsigned int		granularity;	/* Granularity desired */
+	u8			nr_extents;	/* Number of cache extents */
+	enum fscache_extent_type cached_type[2];	/* Type of cache extent */
+	bool			no_more_cache;	/* No more cached data */
+};
+
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 05abb3425962..57d57ed161d6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -76,7 +76,7 @@ struct netfs_inode {
 #endif
 	struct mutex		wb_lock;	/* Writeback serialisation */
 	loff_t			remote_i_size;	/* Size of the remote file */
-	loff_t			zero_point;	/* Size after which we assume there's no data
+	unsigned long long	zero_point;	/* Size after which we assume there's no data
 						 * on the server */
 	atomic_t		io_count;	/* Number of outstanding reqs */
 	unsigned long		flags;
@@ -136,6 +136,39 @@ static inline struct netfs_group *netfs_folio_group(struct folio *folio)
 	return priv;
 }
 
+/*
+ * The buffering context for netfslib reads.  The fields here are available for
+ * the filesystem to view, but it must not modify them.  The struct is provided
+ * to ->issue_read() and should be passed to the functions for buffer
+ * extraction and the marking of read submission.
+ */
+struct netfs_read_context {
+	unsigned long long	start;		/* Point to read from */
+	unsigned long long	stop;		/* Point to read to */
+	bool			retrying;	/* T if retrying a read */
+};
+
+/*
+ * The buffering context for netfslib writes.  The fields here are available
+ * for the filesystem to view, but it must not modify them.  The struct is
+ * provided to ->issue_write() and should be passed to the function for buffer
+ * extraction.
+ */
+struct netfs_write_context {
+	unsigned long long	issue_from;	/* Current issue point */
+	size_t			buffered;	/* Amount in buffer */
+};
+
+/*
+ * Estimate of maximum write subrequest for writeback.  The filesystem is
+ * responsible for filling this in when called from ->estimate_write(), though
+ * netfslib will preset infinite defaults.
+ */
+struct netfs_write_estimate {
+	unsigned long long	issue_at;	/* Point at which we must submit */
+	int			max_segs;	/* Max number of segments in a single RPC */
+};
+
 /*
  * Stream of I/O subrequests going to a particular destination, such as the
  * server or the local cache.  This is mainly intended for writing where we may
@@ -143,13 +176,15 @@ static inline struct netfs_group *netfs_folio_group(struct folio *folio)
  */
 struct netfs_io_stream {
 	/* Submission tracking */
-	struct netfs_io_subrequest *construct;	/* Op being constructed */
-	size_t			sreq_max_len;	/* Maximum size of a subrequest */
-	unsigned int		sreq_max_segs;	/* 0 or max number of segments in an iterator */
-	unsigned int		submit_off;	/* Folio offset we're submitting from */
-	unsigned int		submit_len;	/* Amount of data left to submit */
-	void (*prepare_write)(struct netfs_io_subrequest *subreq);
-	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	u8			applicable;	/* What sources are applicable (NOTE_* mask) */
+	int (*estimate_write)(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      const struct netfs_write_context *wctx,
+			      struct netfs_write_estimate *estimate);
+	int (*issue_write)(struct netfs_io_subrequest *subreq,
+			   struct netfs_write_context *wctx);
+	atomic64_t		issued_to;	/* Point to which can be considered issued */
+
 	/* Collection tracking */
 	struct list_head	subrequests;	/* Contributory I/O operations */
 	struct netfs_io_subrequest *front;	/* Op being collected */
@@ -189,14 +224,13 @@ struct netfs_io_subrequest {
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct bvecq_pos	dispatch_pos;	/* Bookmark in the combined queue of the start */
 	struct bvecq_pos	content;	/* The (copied) content of the subrequest */
-	struct iov_iter		io_iter;	/* Iterator for this subrequest */
 	unsigned long long	start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
+	unsigned int		nr_segs;	/* Number of segments in content */
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
-	unsigned int		nr_segs;	/* Number of segs in io_iter */
 	u8			retry_count;	/* The number of retries (0 on initial pass) */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
@@ -205,7 +239,6 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
 #define NETFS_SREQ_MADE_PROGRESS	4	/* Set if we transferred at least some data */
 #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
-#define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */
 #define NETFS_SREQ_HIT_EOF		7	/* Set if short due to EOF */
 #define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when the subrequest completes */
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
@@ -252,18 +285,16 @@ struct netfs_io_request {
 	struct netfs_group	*group;		/* Writeback group being written back */
 	struct bvecq_pos	collect_cursor;	/* Clear-up point of I/O buffer */
 	struct bvecq_pos	load_cursor;	/* Point at which new folios are loaded in */
-	struct bvecq_pos	dispatch_cursor; /* Point from which buffers are dispatched */
+	//struct bvecq_pos	dispatch_cursor; /* Point from which buffers are dispatched */
 	wait_queue_head_t	waitq;		/* Processor waiter */
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
-	unsigned long long	last_end;	/* End pos of last folio submitted */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	long			error;		/* 0 or error that occurred */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
-	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
@@ -289,8 +320,10 @@ struct netfs_io_request {
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	10	/* Copy current folio to cache from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	11	/* Need to write to the server */
 #define NETFS_RREQ_USE_IO_ITER		12	/* Use ->io_iter rather than ->i_pages */
+#ifdef CONFIG_NETFS_PGPRIV2
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
+#endif
 	const struct netfs_request_ops *netfs_ops;
 };
 
@@ -306,8 +339,7 @@ struct netfs_request_ops {
 
 	/* Read request handling */
 	void (*expand_readahead)(struct netfs_io_request *rreq);
-	int (*prepare_read)(struct netfs_io_subrequest *subreq);
-	void (*issue_read)(struct netfs_io_subrequest *subreq);
+	int (*issue_read)(struct netfs_io_subrequest *subreq, struct netfs_read_context *rctx);
 	bool (*is_still_valid)(struct netfs_io_request *rreq);
 	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
 				 struct folio **foliop, void **_fsdata);
@@ -319,8 +351,12 @@ struct netfs_request_ops {
 
 	/* Write request handling */
 	void (*begin_writeback)(struct netfs_io_request *wreq);
-	void (*prepare_write)(struct netfs_io_subrequest *subreq);
-	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	int (*estimate_write)(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      const struct netfs_write_context *wctx,
+			      struct netfs_write_estimate *estimate);
+	int (*issue_write)(struct netfs_io_subrequest *subreq,
+			   struct netfs_write_context *wctx);
 	void (*retry_request)(struct netfs_io_request *wreq, struct netfs_io_stream *stream);
 	void (*invalidate_cache)(struct netfs_io_request *wreq);
 };
@@ -355,8 +391,19 @@ struct netfs_cache_ops {
 		     netfs_io_terminated_t term_func,
 		     void *term_func_priv);
 
+	/* Estimate the amount of data that can be written in an op. */
+	int (*estimate_write)(struct netfs_io_request *wreq,
+			      struct netfs_io_stream *stream,
+			      const struct netfs_write_context *wctx,
+			      struct netfs_write_estimate *estimate);
+
+	/* Read data from the cache for a netfs subrequest. */
+	int (*issue_read)(struct netfs_io_subrequest *subreq,
+			  struct netfs_read_context *rctx);
+
 	/* Write data to the cache from a netfs subrequest. */
-	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	int (*issue_write)(struct netfs_io_subrequest *subreq,
+			   struct netfs_write_context *wctx);
 
 	/* Expand readahead request */
 	void (*expand_readahead)(struct netfs_cache_resources *cres,
@@ -364,26 +411,6 @@ struct netfs_cache_ops {
 				 unsigned long long *_len,
 				 unsigned long long i_size);
 
-	/* Prepare a read operation, shortening it to a cached/uncached
-	 * boundary as appropriate.
-	 */
-	enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-					     unsigned long long i_size);
-
-	/* Prepare a write subrequest, working out if we're allowed to do it
-	 * and finding out the maximum amount of data to gather before
-	 * attempting to submit.  If we're not permitted to do it, the
-	 * subrequest should be marked failed.
-	 */
-	void (*prepare_write_subreq)(struct netfs_io_subrequest *subreq);
-
-	/* Prepare a write operation, working out what part of the write we can
-	 * actually do.
-	 */
-	int (*prepare_write)(struct netfs_cache_resources *cres,
-			     loff_t *_start, size_t *_len, size_t upper_len,
-			     loff_t i_size, bool no_space_allocated_yet);
-
 	/* Prepare an on-demand read operation, shortening it to a cached/uncached
 	 * boundary as appropriate.
 	 */
@@ -396,8 +423,7 @@ struct netfs_cache_ops {
 	 * next chunk of data starts and how long it is.
 	 */
 	int (*query_occupancy)(struct netfs_cache_resources *cres,
-			       loff_t start, size_t len, size_t granularity,
-			       loff_t *_data_start, size_t *_data_len);
+			       struct fscache_occupancy *occ);
 };
 
 /* High-level read API. */
@@ -421,10 +447,9 @@ void netfs_single_mark_inode_dirty(struct inode *inode);
 ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_iter *iter);
 int netfs_writeback_single(struct address_space *mapping,
 			   struct writeback_control *wbc,
-			   struct iov_iter *iter);
+			   struct iov_iter *iter, size_t len);
 
 /* Address operations API */
-struct readahead_control;
 void netfs_readahead(struct readahead_control *);
 int netfs_read_folio(struct file *, struct folio *);
 int netfs_write_begin(struct netfs_inode *, struct file *,
@@ -442,6 +467,8 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
 
 /* (Sub)request management API. */
+void netfs_mark_read_submission(struct netfs_io_subrequest *subreq,
+				struct netfs_read_context *rctx);
 void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);
 void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq);
 void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
@@ -451,9 +478,12 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 ssize_t netfs_extract_iter(struct iov_iter *orig, size_t orig_len, size_t max_segs,
 			   unsigned long long fpos, struct bvecq **_bvecq_head,
 			   iov_iter_extraction_t extraction_flags);
-size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
-			size_t max_size, size_t max_segs);
-void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);
+int netfs_prepare_read_buffer(struct netfs_io_subrequest *subreq,
+			      struct netfs_read_context *rctx,
+			      unsigned int max_segs);
+int netfs_prepare_write_buffer(struct netfs_io_subrequest *subreq,
+			       struct netfs_write_context *wctx,
+			       unsigned int max_segs);
 void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error);
 
 int netfs_start_io_read(struct inode *inode);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 899b85d7ef92..6283e7d2ae5a 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -49,6 +49,7 @@
 	E_(NETFS_PGPRIV2_COPY_TO_CACHE,		"2C")
 
 #define netfs_rreq_traces					\
+	EM(netfs_rreq_trace_all_queued,		"ALL-Q  ")	\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
 	EM(netfs_rreq_trace_collect,		"COLLECT")	\
 	EM(netfs_rreq_trace_complete,		"COMPLET")	\
@@ -76,7 +77,8 @@
 	EM(netfs_rreq_trace_waited_quiesce,	"DONE-QUIESCE")	\
 	EM(netfs_rreq_trace_wake_ip,		"WAKE-IP")	\
 	EM(netfs_rreq_trace_wake_queue,		"WAKE-Q ")	\
-	E_(netfs_rreq_trace_write_done,		"WR-DONE")
+	EM(netfs_rreq_trace_write_done,		"WR-DONE")	\
+	E_(netfs_rreq_trace_zero_unread,	"ZERO-UR")
 
 #define netfs_sreq_sources					\
 	EM(NETFS_SOURCE_UNKNOWN,		"----")		\
@@ -125,6 +127,7 @@
 	EM(netfs_sreq_trace_superfluous,	"SPRFL")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
 	EM(netfs_sreq_trace_too_much,		"!TOOM")	\
+	EM(netfs_sreq_trace_too_many_retries,	"!RETR")	\
 	EM(netfs_sreq_trace_wait_for,		"_WAIT")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
 	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\
@@ -188,12 +191,12 @@
 	EM(netfs_folio_trace_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
-	EM(netfs_folio_trace_clear,		"clear")	\
-	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
-	EM(netfs_folio_trace_clear_g,		"clear-g")	\
-	EM(netfs_folio_trace_clear_s,		"clear-s")	\
 	EM(netfs_folio_trace_copy_to_cache,	"mark-copy")	\
 	EM(netfs_folio_trace_end_copy,		"end-copy")	\
+	EM(netfs_folio_trace_endwb,		"endwb")	\
+	EM(netfs_folio_trace_endwb_cc,		"endwb-cc")	\
+	EM(netfs_folio_trace_endwb_g,		"endwb-g")	\
+	EM(netfs_folio_trace_endwb_s,		"endwb-s")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
 	EM(netfs_folio_trace_kill_cc,		"kill-cc")	\
@@ -491,6 +494,7 @@ TRACE_EVENT(netfs_folio,
 	    TP_STRUCT__entry(
 		    __field(ino_t,			ino)
 		    __field(pgoff_t,			index)
+		    __field(unsigned long,		pfn)
 		    __field(unsigned int,		nr)
 		    __field(enum netfs_folio_trace,	why)
 			     ),
@@ -501,13 +505,40 @@ TRACE_EVENT(netfs_folio,
 		    __entry->why = why;
 		    __entry->index = folio->index;
 		    __entry->nr = folio_nr_pages(folio);
+		    __entry->pfn = folio_pfn(folio);
 			   ),
 
-	    TP_printk("i=%05lx ix=%05lx-%05lx %s",
+	    TP_printk("p=%lx i=%05lx ix=%05lx-%05lx %s",
+		      __entry->pfn,
 		      __entry->ino, __entry->index, __entry->index + __entry->nr - 1,
 		      __print_symbolic(__entry->why, netfs_folio_traces))
 	    );
 
+TRACE_EVENT(netfs_wback,
+	    TP_PROTO(struct netfs_io_request *wreq, struct folio *folio, unsigned int notes),
+
+	    TP_ARGS(wreq, folio, notes),
+
+	    TP_STRUCT__entry(
+		    __field(pgoff_t,			index)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		nr)
+		    __field(unsigned int,		notes)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->wreq = wreq->debug_id;
+		    __entry->notes = notes;
+		    __entry->index = folio->index;
+		    __entry->nr = folio_nr_pages(folio);
+			   ),
+
+	    TP_printk("R=%08x ix=%05lx-%05lx n=%02x",
+		      __entry->wreq,
+		      __entry->index, __entry->index + __entry->nr - 1,
+		      __entry->notes)
+	    );
+
 TRACE_EVENT(netfs_write_iter,
 	    TP_PROTO(const struct kiocb *iocb, const struct iov_iter *from),
 
diff --git a/net/9p/client.c b/net/9p/client.c
index f0dcf252af7e..8d365c000553 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1561,6 +1561,7 @@ void
 p9_client_write_subreq(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
+	struct iov_iter iter;
 	struct p9_fid *fid = wreq->netfs_priv;
 	struct p9_client *clnt = fid->clnt;
 	struct p9_req_t *req;
@@ -1571,14 +1572,17 @@ p9_client_write_subreq(struct netfs_io_subrequest *subreq)
 	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %d\n",
 		 fid->fid, start, len);
 
+	iov_iter_bvec_queue(&iter, ITER_SOURCE, subreq->content.bvecq,
+			    subreq->content.slot, subreq->content.offset, subreq->len);
+
 	/* Don't bother zerocopy for small IO (< 1024) */
 	if (clnt->trans_mod->zc_request && len > 1024) {
-		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &subreq->io_iter,
+		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &iter,
 				       0, wreq->len, P9_ZC_HDR_SZ, "dqd",
 				       fid->fid, start, len);
 	} else {
 		req = p9_client_rpc(clnt, P9_TWRITE, "dqV", fid->fid,
-				    start, len, &subreq->io_iter);
+				    start, len, &iter);
 	}
 	if (IS_ERR(req)) {
 		netfs_write_subrequest_terminated(subreq, PTR_ERR(req));



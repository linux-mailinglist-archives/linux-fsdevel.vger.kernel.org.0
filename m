Return-Path: <linux-fsdevel+bounces-37546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF42D9F3BD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D368162329
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192251F759E;
	Mon, 16 Dec 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWjQ1Je5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D41F7555
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381878; cv=none; b=XCTJdd4Ol2s5jva610QICLRfHuVRmClL5hINlFpUp4mdpsG0RpFg/XgpS1IY6+GNsYq1eTgpHUBTYPcrlGMhHmdybP5BgWBxGrYAosocTUgvMzZOL0D1QakQxJMty8DwhuguvWnpY+yoVab3JRRYRMRNUfxUmw7pjQcRPfWQmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381878; c=relaxed/simple;
	bh=Oy5yYZTTmO+o5qwOfjC4vGsbK9SmJzv/FQWRM/LPoOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COXAigSXCfqIT+N+XENRGQnAqfZ+0byLNAhFzz3p/c7LyiGTZIXxQ4hWjw9AqwK6IDQhxMk3ZfXanAotRDWN3QfDgnJoh3RTORDMvDizp9pQJ2Q29uEGq5PE5pNCckMtKmbW2NUMYK228pTq7vUUlp0OmQky/aD93kw0jPqEVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWjQ1Je5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZi+xeQOrtjBwDxdYglpVJujVSizwyFZu4D9uktqr3k=;
	b=UWjQ1Je5vHbLZQ0USI1CqUFg1bYutiKe78KWPcxBMFyBVe+wVylHo9ZHaxg2isxH2YxXCz
	fPrr6IDlHVof2Sr900Jd2MFLkxOxrpC1E+yh6OjFLXQANNa8jS9bSsoMPVHipHdUh6147q
	WHpuMfax/+LTnb9il77Z0mC1949wma8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-E3Y4WoS9NcGF7eOI9Z_qTw-1; Mon,
 16 Dec 2024 15:44:28 -0500
X-MC-Unique: E3Y4WoS9NcGF7eOI9Z_qTw-1
X-Mimecast-MFC-AGG-ID: E3Y4WoS9NcGF7eOI9Z_qTw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A79319560B5;
	Mon, 16 Dec 2024 20:44:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B51919560B0;
	Mon, 16 Dec 2024 20:44:18 +0000 (UTC)
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
Subject: [PATCH v5 23/32] afs: Eliminate afs_read
Date: Mon, 16 Dec 2024 20:41:13 +0000
Message-ID: <20241216204124.3752367-24-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Now that directory and symlink reads go through netfslib, the afs_read
struct is mostly redundant with almost all data duplicated in the
netfs_io_request and netfs_io_subrequest structs that are also available
any time we're doing a fetch.

Eliminate afs_read by moving the one field we still need there to the
afs_call struct (we may be given a different amount of data than what we
asked for and have to track what remains of that) and using the
netfs_io_subrequest directly instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c      | 96 +++++++++-------------------------------------
 fs/afs/fsclient.c  | 55 +++++++++++++-------------
 fs/afs/inode.c     |  2 +
 fs/afs/internal.h  | 35 ++---------------
 fs/afs/yfsclient.c | 47 +++++++++++------------
 fs/netfs/main.c    |  2 +-
 6 files changed, 72 insertions(+), 165 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 48695a50d2f9..b996f4419c0c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -200,50 +200,12 @@ int afs_release(struct inode *inode, struct file *file)
 	return ret;
 }
 
-/*
- * Allocate a new read record.
- */
-struct afs_read *afs_alloc_read(gfp_t gfp)
-{
-	struct afs_read *req;
-
-	req = kzalloc(sizeof(struct afs_read), gfp);
-	if (req)
-		refcount_set(&req->usage, 1);
-
-	return req;
-}
-
-/*
- * Dispose of a ref to a read record.
- */
-void afs_put_read(struct afs_read *req)
-{
-	if (refcount_dec_and_test(&req->usage)) {
-		if (req->cleanup)
-			req->cleanup(req);
-		key_put(req->key);
-		kfree(req);
-	}
-}
-
 static void afs_fetch_data_notify(struct afs_operation *op)
 {
-	struct afs_read *req = op->fetch.req;
-	struct netfs_io_subrequest *subreq = req->subreq;
-	int error = afs_op_error(op);
-
-	req->error = error;
-	if (subreq) {
-		subreq->rreq->i_size = req->file_size;
-		if (req->pos + req->actual_len >= req->file_size)
-			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
-		subreq->error = error;
-		netfs_read_subreq_terminated(subreq);
-		req->subreq = NULL;
-	} else if (req->done) {
-		req->done(req);
-	}
+	struct netfs_io_subrequest *subreq = op->fetch.subreq;
+
+	subreq->error = afs_op_error(op);
+	netfs_read_subreq_terminated(subreq);
 }
 
 static void afs_fetch_data_success(struct afs_operation *op)
@@ -253,7 +215,7 @@ static void afs_fetch_data_success(struct afs_operation *op)
 	_enter("op=%08x", op->debug_id);
 	afs_vnode_commit_status(op, &op->file[0]);
 	afs_stat_v(vnode, n_fetches);
-	atomic_long_add(op->fetch.req->actual_len, &op->net->n_fetch_bytes);
+	atomic_long_add(op->fetch.subreq->transferred, &op->net->n_fetch_bytes);
 	afs_fetch_data_notify(op);
 }
 
@@ -265,11 +227,10 @@ static void afs_fetch_data_aborted(struct afs_operation *op)
 
 static void afs_fetch_data_put(struct afs_operation *op)
 {
-	op->fetch.req->error = afs_op_error(op);
-	afs_put_read(op->fetch.req);
+	op->fetch.subreq->error = afs_op_error(op);
 }
 
-static const struct afs_operation_ops afs_fetch_data_operation = {
+const struct afs_operation_ops afs_fetch_data_operation = {
 	.issue_afs_rpc	= afs_fs_fetch_data,
 	.issue_yfs_rpc	= yfs_fs_fetch_data,
 	.success	= afs_fetch_data_success,
@@ -281,55 +242,34 @@ static const struct afs_operation_ops afs_fetch_data_operation = {
 /*
  * Fetch file data from the volume.
  */
-int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
+static void afs_read_worker(struct work_struct *work)
 {
+	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
 	struct afs_operation *op;
+	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
+	struct key *key = subreq->rreq->netfs_priv;
 
 	_enter("%s{%llx:%llu.%u},%x,,,",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       key_serial(req->key));
+	       key_serial(key));
 
-	op = afs_alloc_operation(req->key, vnode->volume);
+	op = afs_alloc_operation(key, vnode->volume);
 	if (IS_ERR(op)) {
-		if (req->subreq) {
-			req->subreq->error = PTR_ERR(op);
-			netfs_read_subreq_terminated(req->subreq);
-		}
-		return PTR_ERR(op);
+		subreq->error = PTR_ERR(op);
+		netfs_read_subreq_terminated(subreq);
+		return;
 	}
 
 	afs_op_set_vnode(op, 0, vnode);
 
-	op->fetch.req	= afs_get_read(req);
+	op->fetch.subreq = subreq;
 	op->ops		= &afs_fetch_data_operation;
-	return afs_do_sync_operation(op);
-}
-
-static void afs_read_worker(struct work_struct *work)
-{
-	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
-	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
-	struct afs_read *fsreq;
-
-	fsreq = afs_alloc_read(GFP_NOFS);
-	if (!fsreq) {
-		subreq->error = -ENOMEM;
-		return netfs_read_subreq_terminated(subreq);
-	}
-
-	fsreq->subreq	= subreq;
-	fsreq->pos	= subreq->start + subreq->transferred;
-	fsreq->len	= subreq->len   - subreq->transferred;
-	fsreq->key	= key_get(subreq->rreq->netfs_priv);
-	fsreq->vnode	= vnode;
-	fsreq->iter	= &subreq->io_iter;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	afs_fetch_data(fsreq->vnode, fsreq);
-	afs_put_read(fsreq);
+	afs_do_sync_operation(op);
 }
 
 static void afs_issue_read(struct netfs_io_subrequest *subreq)
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 784f7daab112..d9d224c95454 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -301,19 +301,19 @@ void afs_fs_fetch_status(struct afs_operation *op)
 static int afs_deliver_fs_fetch_data(struct afs_call *call)
 {
 	struct afs_operation *op = call->op;
+	struct netfs_io_subrequest *subreq = op->fetch.subreq;
 	struct afs_vnode_param *vp = &op->file[0];
-	struct afs_read *req = op->fetch.req;
 	const __be32 *bp;
 	size_t count_before;
 	int ret;
 
 	_enter("{%u,%zu,%zu/%llu}",
 	       call->unmarshall, call->iov_len, iov_iter_count(call->iter),
-	       req->actual_len);
+	       call->remaining);
 
 	switch (call->unmarshall) {
 	case 0:
-		req->actual_len = 0;
+		call->remaining = 0;
 		call->unmarshall++;
 		if (call->operation_ID == FSFETCHDATA64) {
 			afs_extract_to_tmp64(call);
@@ -323,8 +323,8 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		}
 		fallthrough;
 
-		/* Extract the returned data length into
-		 * ->actual_len.  This may indicate more or less data than was
+		/* Extract the returned data length into ->remaining.
+		 * This may indicate more or less data than was
 		 * requested will be returned.
 		 */
 	case 1:
@@ -333,42 +333,41 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		if (ret < 0)
 			return ret;
 
-		req->actual_len = be64_to_cpu(call->tmp64);
-		_debug("DATA length: %llu", req->actual_len);
+		call->remaining = be64_to_cpu(call->tmp64);
+		_debug("DATA length: %llu", call->remaining);
 
-		if (req->actual_len == 0)
+		if (call->remaining == 0)
 			goto no_more_data;
 
-		call->iter = req->iter;
-		call->iov_len = min(req->actual_len, req->len);
+		call->iter = &subreq->io_iter;
+		call->iov_len = umin(call->remaining, subreq->len - subreq->transferred);
 		call->unmarshall++;
 		fallthrough;
 
 		/* extract the returned data */
 	case 2:
 		count_before = call->iov_len;
-		_debug("extract data %zu/%llu", count_before, req->actual_len);
+		_debug("extract data %zu/%llu", count_before, call->remaining);
 
 		ret = afs_extract_data(call, true);
-		if (req->subreq) {
-			req->subreq->transferred += count_before - call->iov_len;
-			netfs_read_subreq_progress(req->subreq);
-		}
+		subreq->transferred += count_before - call->iov_len;
+		call->remaining -= count_before - call->iov_len;
+		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
 		call->iter = &call->def_iter;
-		if (req->actual_len <= req->len)
+		if (call->remaining)
 			goto no_more_data;
 
 		/* Discard any excess data the server gave us */
-		afs_extract_discard(call, req->actual_len - req->len);
+		afs_extract_discard(call, call->remaining);
 		call->unmarshall = 3;
 		fallthrough;
 
 	case 3:
 		_debug("extract discard %zu/%llu",
-		       iov_iter_count(call->iter), req->actual_len - req->len);
+		       iov_iter_count(call->iter), call->remaining);
 
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -390,8 +389,8 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		xdr_decode_AFSCallBack(&bp, call, &vp->scb);
 		xdr_decode_AFSVolSync(&bp, &op->volsync);
 
-		req->data_version = vp->scb.status.data_version;
-		req->file_size = vp->scb.status.size;
+		if (subreq->start + subreq->transferred >= vp->scb.status.size)
+			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 
 		call->unmarshall++;
 		fallthrough;
@@ -426,8 +425,8 @@ static const struct afs_call_type afs_RXFSFetchData64 = {
  */
 static void afs_fs_fetch_data64(struct afs_operation *op)
 {
+	struct netfs_io_subrequest *subreq = op->fetch.subreq;
 	struct afs_vnode_param *vp = &op->file[0];
-	struct afs_read *req = op->fetch.req;
 	struct afs_call *call;
 	__be32 *bp;
 
@@ -443,10 +442,10 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	bp[1] = htonl(vp->fid.vid);
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
-	bp[4] = htonl(upper_32_bits(req->pos));
-	bp[5] = htonl(lower_32_bits(req->pos));
+	bp[4] = htonl(upper_32_bits(subreq->start + subreq->transferred));
+	bp[5] = htonl(lower_32_bits(subreq->start + subreq->transferred));
 	bp[6] = 0;
-	bp[7] = htonl(lower_32_bits(req->len));
+	bp[7] = htonl(lower_32_bits(subreq->len   - subreq->transferred));
 
 	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
@@ -458,9 +457,9 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
  */
 void afs_fs_fetch_data(struct afs_operation *op)
 {
+	struct netfs_io_subrequest *subreq = op->fetch.subreq;
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_call *call;
-	struct afs_read *req = op->fetch.req;
 	__be32 *bp;
 
 	if (test_bit(AFS_SERVER_FL_HAS_FS64, &op->server->flags))
@@ -472,16 +471,14 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	req->call_debug_id = call->debug_id;
-
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA);
 	bp[1] = htonl(vp->fid.vid);
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
-	bp[4] = htonl(lower_32_bits(req->pos));
-	bp[5] = htonl(lower_32_bits(req->len));
+	bp[4] = htonl(lower_32_bits(subreq->start + subreq->transferred));
+	bp[5] = htonl(lower_32_bits(subreq->len   + subreq->transferred));
 
 	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6934cc30a4ca..0e3c43c40632 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -317,6 +317,8 @@ static void afs_apply_status(struct afs_operation *op,
 			inode_set_ctime_to_ts(inode, t);
 			inode_set_atime_to_ts(inode, t);
 		}
+		if (op->ops == &afs_fetch_data_operation)
+			op->fetch.subreq->rreq->i_size = status->size;
 	}
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 7f170455cf25..39d2e29ed0e0 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -163,6 +163,7 @@ struct afs_call {
 	spinlock_t		state_lock;
 	int			error;		/* error code */
 	u32			abort_code;	/* Remote abort ID or 0 */
+	unsigned long long	remaining;	/* How much is left to receive */
 	unsigned int		max_lifespan;	/* Maximum lifespan in secs to set if not 0 */
 	unsigned		request_size;	/* size of request data */
 	unsigned		reply_max;	/* maximum size of reply */
@@ -232,28 +233,6 @@ static inline struct key *afs_file_key(struct file *file)
 	return af->key;
 }
 
-/*
- * Record of an outstanding read operation on a vnode.
- */
-struct afs_read {
-	loff_t			pos;		/* Where to start reading */
-	loff_t			len;		/* How much we're asking for */
-	loff_t			actual_len;	/* How much we're actually getting */
-	loff_t			file_size;	/* File size returned by server */
-	struct key		*key;		/* The key to use to reissue the read */
-	struct afs_vnode	*vnode;		/* The file being read into. */
-	struct netfs_io_subrequest *subreq;	/* Fscache helper read request this belongs to */
-	afs_dataversion_t	data_version;	/* Version number returned by server */
-	refcount_t		usage;
-	unsigned int		call_debug_id;
-	unsigned int		nr_pages;
-	int			error;
-	void (*done)(struct afs_read *);
-	void (*cleanup)(struct afs_read *);
-	struct iov_iter		*iter;		/* Iterator representing the buffer */
-	struct iov_iter		def_iter;	/* Default iterator */
-};
-
 /*
  * AFS superblock private data
  * - there's one superblock per volume
@@ -911,7 +890,7 @@ struct afs_operation {
 			bool	new_negative;
 		} rename;
 		struct {
-			struct afs_read *req;
+			struct netfs_io_subrequest *subreq;
 		} fetch;
 		struct {
 			afs_lock_type_t type;
@@ -1118,21 +1097,13 @@ extern void afs_dynroot_depopulate(struct super_block *);
 extern const struct address_space_operations afs_file_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
+extern const struct afs_operation_ops afs_fetch_data_operation;
 extern const struct netfs_request_ops afs_req_ops;
 
 extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
-extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
-extern struct afs_read *afs_alloc_read(gfp_t);
-extern void afs_put_read(struct afs_read *);
-
-static inline struct afs_read *afs_get_read(struct afs_read *req)
-{
-	refcount_inc(&req->usage);
-	return req;
-}
 
 /*
  * flock.c
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 368cf277d801..3718d852fabc 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -352,19 +352,19 @@ static int yfs_deliver_status_and_volsync(struct afs_call *call)
 static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 {
 	struct afs_operation *op = call->op;
+	struct netfs_io_subrequest *subreq = op->fetch.subreq;
 	struct afs_vnode_param *vp = &op->file[0];
-	struct afs_read *req = op->fetch.req;
 	const __be32 *bp;
 	size_t count_before;
 	int ret;
 
 	_enter("{%u,%zu, %zu/%llu}",
 	       call->unmarshall, call->iov_len, iov_iter_count(call->iter),
-	       req->actual_len);
+	       call->remaining);
 
 	switch (call->unmarshall) {
 	case 0:
-		req->actual_len = 0;
+		call->remaining = 0;
 		afs_extract_to_tmp64(call);
 		call->unmarshall++;
 		fallthrough;
@@ -379,42 +379,40 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		if (ret < 0)
 			return ret;
 
-		req->actual_len = be64_to_cpu(call->tmp64);
-		_debug("DATA length: %llu", req->actual_len);
+		call->remaining = be64_to_cpu(call->tmp64);
+		_debug("DATA length: %llu", call->remaining);
 
-		if (req->actual_len == 0)
+		if (call->remaining == 0)
 			goto no_more_data;
 
-		call->iter = req->iter;
-		call->iov_len = min(req->actual_len, req->len);
+		call->iter = &subreq->io_iter;
+		call->iov_len = min(call->remaining, subreq->len - subreq->transferred);
 		call->unmarshall++;
 		fallthrough;
 
 		/* extract the returned data */
 	case 2:
 		count_before = call->iov_len;
-		_debug("extract data %zu/%llu", count_before, req->actual_len);
+		_debug("extract data %zu/%llu", count_before, call->remaining);
 
 		ret = afs_extract_data(call, true);
-		if (req->subreq) {
-			req->subreq->transferred += count_before - call->iov_len;
-			netfs_read_subreq_progress(req->subreq);
-		}
+		subreq->transferred += count_before - call->iov_len;
+		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
 		call->iter = &call->def_iter;
-		if (req->actual_len <= req->len)
+		if (call->remaining)
 			goto no_more_data;
 
 		/* Discard any excess data the server gave us */
-		afs_extract_discard(call, req->actual_len - req->len);
+		afs_extract_discard(call, call->remaining);
 		call->unmarshall = 3;
 		fallthrough;
 
 	case 3:
 		_debug("extract discard %zu/%llu",
-		       iov_iter_count(call->iter), req->actual_len - req->len);
+		       iov_iter_count(call->iter), call->remaining);
 
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -439,8 +437,8 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		xdr_decode_YFSCallBack(&bp, call, &vp->scb);
 		xdr_decode_YFSVolSync(&bp, &op->volsync);
 
-		req->data_version = vp->scb.status.data_version;
-		req->file_size = vp->scb.status.size;
+		if (subreq->start + subreq->transferred >= vp->scb.status.size)
+			__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 
 		call->unmarshall++;
 		fallthrough;
@@ -468,14 +466,15 @@ static const struct afs_call_type yfs_RXYFSFetchData64 = {
  */
 void yfs_fs_fetch_data(struct afs_operation *op)
 {
+	struct netfs_io_subrequest *subreq = op->fetch.subreq;
 	struct afs_vnode_param *vp = &op->file[0];
-	struct afs_read *req = op->fetch.req;
 	struct afs_call *call;
 	__be32 *bp;
 
-	_enter(",%x,{%llx:%llu},%llx,%llx",
+	_enter(",%x,{%llx:%llu},%llx,%zx",
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode,
-	       req->pos, req->len);
+	       subreq->start + subreq->transferred,
+	       subreq->len   - subreq->transferred);
 
 	call = afs_alloc_flat_call(op->net, &yfs_RXYFSFetchData64,
 				   sizeof(__be32) * 2 +
@@ -487,15 +486,13 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	req->call_debug_id = call->debug_id;
-
 	/* marshall the parameters */
 	bp = call->request;
 	bp = xdr_encode_u32(bp, YFSFETCHDATA64);
 	bp = xdr_encode_u32(bp, 0); /* RPC flags */
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
-	bp = xdr_encode_u64(bp, req->pos);
-	bp = xdr_encode_u64(bp, req->len);
+	bp = xdr_encode_u64(bp, subreq->start + subreq->transferred);
+	bp = xdr_encode_u64(bp, subreq->len   - subreq->transferred);
 	yfs_check_req(call, bp);
 
 	call->fid = vp->fid;
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 8c1922c0cb42..16760695e667 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -118,7 +118,7 @@ static int __init netfs_init(void)
 		goto error_reqpool;
 
 	netfs_subrequest_slab = kmem_cache_create("netfs_subrequest",
-						  sizeof(struct netfs_io_subrequest), 0,
+						  sizeof(struct netfs_io_subrequest) + 16, 0,
 						  SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
 						  NULL);
 	if (!netfs_subrequest_slab)



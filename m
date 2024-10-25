Return-Path: <linux-fsdevel+bounces-32972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF29B10CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38501F2376A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FEE21CDA0;
	Fri, 25 Oct 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNDJI1rX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD7218930
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888996; cv=none; b=o9pIaqYx3n4DxuPSTaN4kPBEohna5BkY73gHZzxxqjCcUt1D+XJpsii78H6pmrXYzTDGtSxWghqzCG4I1gNufbIlmzFRG/QiSFXe6WsZiXPKLdh+y9VNVG7j7FQcC8e/yr6iIID7wfJe+eAroIQ4QFQrwN9zgVh/hNxWiLyqvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888996; c=relaxed/simple;
	bh=MNtQo4odjxNMj3BCZ1agyY7pevniD79RrGc23AdSIog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv7ch2EyVdXFPf974+hoGswzOmRHWS8l+wVPPHzX7HxlKy4a1uTFk+80PBg9ITW3OZRK4BcN5efoL/rk9Eje7WsWVZvCmsCLBqABGy0uWLN5ZYBVVX0TRaxi0dK1UPKtYIXiROpjdeWX8Jo5VxKWTDaQ1aUSFdRWzDak6bT8mT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNDJI1rX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3RZhgLNwp4XBhAeqXU0ipf2kWSRFYCMCpPsbJQcP0c=;
	b=hNDJI1rX+xHvJPCwTWwGaC56S2Ohu/1ze8+3dacxfiBAlWjXIIzfioRR12eMfThNr4lwZM
	YY9R6Of8vNsrN4OlNlLPZwpDNPpf/vjUtHQ1Cd3gjLuGlEHnRfKNS3rw/q4KqFR/hnjBWO
	KSCOe2yPRHj+IHZayOKpSFtAOUR7iZQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-gCB98WeEMBS0zLhq46Efxw-1; Fri,
 25 Oct 2024 16:43:07 -0400
X-MC-Unique: gCB98WeEMBS0zLhq46Efxw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36EFD1955DD1;
	Fri, 25 Oct 2024 20:43:04 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 548BE1955F43;
	Fri, 25 Oct 2024 20:42:59 +0000 (UTC)
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
Subject: [PATCH v2 25/31] afs: Make {Y,}FS.FetchData an asynchronous operation
Date: Fri, 25 Oct 2024 21:39:52 +0100
Message-ID: <20241025204008.4076565-26-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Make FS.FetchData and YFS.FetchData an asynchronous operation in that the
request is queued in AF_RXRPC and then we return to the caller rather than
waiting.  Processing of the returning packets is then done inline if it's a
synchronous VFS/VM call (readdir, read_folio, sync DIO, prep for write) or
offloaded to a workqueue if asynchronous VM calls (eg. readahead, async
DIO).

This reduces the chain of workqueues invoking workqueues and cuts out some
of the overhead, driving rxrpc data extraction and netfslib read collection
from a thread that's going to block to completion anyway if possible.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c         | 115 +++++++++++++++++++++++++++++++++++++-----
 fs/afs/fs_operation.c |   2 +-
 fs/afs/fsclient.c     |   6 ++-
 fs/afs/internal.h     |   7 +++
 fs/afs/main.c         |   2 +-
 fs/afs/rxrpc.c        |   8 +--
 fs/afs/write.c        |  12 +++++
 fs/afs/yfsclient.c    |   5 +-
 8 files changed, 135 insertions(+), 22 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index b996f4419c0c..e89a98735317 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -225,26 +225,99 @@ static void afs_fetch_data_aborted(struct afs_operation *op)
 	afs_fetch_data_notify(op);
 }
 
-static void afs_fetch_data_put(struct afs_operation *op)
-{
-	op->fetch.subreq->error = afs_op_error(op);
-}
-
 const struct afs_operation_ops afs_fetch_data_operation = {
 	.issue_afs_rpc	= afs_fs_fetch_data,
 	.issue_yfs_rpc	= yfs_fs_fetch_data,
 	.success	= afs_fetch_data_success,
 	.aborted	= afs_fetch_data_aborted,
 	.failed		= afs_fetch_data_notify,
-	.put		= afs_fetch_data_put,
 };
 
+static void afs_issue_read_call(struct afs_operation *op)
+{
+	op->call_responded = false;
+	op->call_error = 0;
+	op->call_abort_code = 0;
+	if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags))
+		yfs_fs_fetch_data(op);
+	else
+		afs_fs_fetch_data(op);
+}
+
+static void afs_end_read(struct afs_operation *op)
+{
+	if (op->call_responded && op->server)
+		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
+
+	if (!afs_op_error(op))
+		afs_fetch_data_success(op);
+	else if (op->cumul_error.aborted)
+		afs_fetch_data_aborted(op);
+	else
+		afs_fetch_data_notify(op);
+
+	afs_end_vnode_operation(op);
+	afs_put_operation(op);
+}
+
+/*
+ * Perform I/O processing on an asynchronous call.  The work item carries a ref
+ * to the call struct that we either need to release or to pass on.
+ */
+static void afs_read_receive(struct afs_call *call)
+{
+	struct afs_operation *op = call->op;
+	enum afs_call_state state;
+
+	_enter("");
+
+	state = READ_ONCE(call->state);
+	if (state == AFS_CALL_COMPLETE)
+		return;
+
+	while (state < AFS_CALL_COMPLETE && READ_ONCE(call->need_attention)) {
+		WRITE_ONCE(call->need_attention, false);
+		afs_deliver_to_call(call);
+		state = READ_ONCE(call->state);
+	}
+
+	if (state < AFS_CALL_COMPLETE) {
+		netfs_read_subreq_progress(op->fetch.subreq);
+		if (rxrpc_kernel_check_life(call->net->socket, call->rxcall))
+			return;
+		/* rxrpc terminated the call. */
+		afs_set_call_complete(call, call->error, call->abort_code);
+	}
+
+	op->call_abort_code	= call->abort_code;
+	op->call_error		= call->error;
+	op->call_responded	= call->responded;
+	afs_put_call(op->call);
+
+	/* If the call failed, then we need to crank the server rotation
+	 * handle and try the next.
+	 */
+	if (afs_select_fileserver(op)) {
+		afs_issue_read_call(op);
+		return;
+	}
+
+	afs_end_read(op);
+}
+
+void afs_fetch_data_async_rx(struct work_struct *work)
+{
+	struct afs_call *call = container_of(work, struct afs_call, async_work);
+
+	afs_read_receive(call);
+	afs_put_call(call);
+}
+
 /*
  * Fetch file data from the volume.
  */
-static void afs_read_worker(struct work_struct *work)
+static void afs_issue_read(struct netfs_io_subrequest *subreq)
 {
-	struct netfs_io_subrequest *subreq = container_of(work, struct netfs_io_subrequest, work);
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
 	struct key *key = subreq->rreq->netfs_priv;
@@ -269,13 +342,27 @@ static void afs_read_worker(struct work_struct *work)
 	op->ops		= &afs_fetch_data_operation;
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	afs_do_sync_operation(op);
-}
 
-static void afs_issue_read(struct netfs_io_subrequest *subreq)
-{
-	INIT_WORK(&subreq->work, afs_read_worker);
-	queue_work(system_long_wq, &subreq->work);
+	if (subreq->rreq->origin == NETFS_READAHEAD ||
+	    subreq->rreq->iocb) {
+		op->flags |= AFS_OPERATION_ASYNC;
+
+		if (!afs_begin_vnode_operation(op)) {
+			subreq->error = PTR_ERR(op);
+			netfs_read_subreq_terminated(subreq);
+			afs_put_operation(op);
+			return;
+		}
+
+		if (!afs_select_fileserver(op)) {
+			afs_end_read(op);
+			return;
+		}
+
+		afs_issue_read_call(op);
+	} else {
+		afs_do_sync_operation(op);
+	}
 }
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 8488ff8183fa..0b1338d65ae6 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -256,7 +256,7 @@ bool afs_begin_vnode_operation(struct afs_operation *op)
 /*
  * Tidy up a filesystem cursor and unlock the vnode.
  */
-static void afs_end_vnode_operation(struct afs_operation *op)
+void afs_end_vnode_operation(struct afs_operation *op)
 {
 	_enter("");
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d9d224c95454..6380cdcfd4fc 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -352,7 +352,6 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		subreq->transferred += count_before - call->iov_len;
 		call->remaining -= count_before - call->iov_len;
-		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
@@ -409,6 +408,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 static const struct afs_call_type afs_RXFSFetchData = {
 	.name		= "FS.FetchData",
 	.op		= afs_FS_FetchData,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= afs_deliver_fs_fetch_data,
 	.destructor	= afs_flat_call_destructor,
 };
@@ -416,6 +416,7 @@ static const struct afs_call_type afs_RXFSFetchData = {
 static const struct afs_call_type afs_RXFSFetchData64 = {
 	.name		= "FS.FetchData64",
 	.op		= afs_FS_FetchData64,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= afs_deliver_fs_fetch_data,
 	.destructor	= afs_flat_call_destructor,
 };
@@ -436,6 +437,9 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA64);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 36125fce0590..c7f0d75eab7f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -202,6 +202,9 @@ struct afs_call_type {
 	/* clean up a call */
 	void (*destructor)(struct afs_call *call);
 
+	/* Async receive processing function */
+	void (*async_rx)(struct work_struct *work);
+
 	/* Work function */
 	void (*work)(struct work_struct *work);
 
@@ -941,6 +944,7 @@ struct afs_operation {
 #define AFS_OPERATION_TRIED_ALL		0x0400	/* Set if we've tried all the fileservers */
 #define AFS_OPERATION_RETRY_SERVER	0x0800	/* Set if we should retry the current server */
 #define AFS_OPERATION_DIR_CONFLICT	0x1000	/* Set if we detected a 3rd-party dir change */
+#define AFS_OPERATION_ASYNC		0x2000	/* Set if should run asynchronously */
 };
 
 /*
@@ -1103,6 +1107,7 @@ extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
+void afs_fetch_data_async_rx(struct work_struct *work);
 
 /*
  * flock.c
@@ -1154,6 +1159,7 @@ extern void afs_fs_store_acl(struct afs_operation *);
 extern struct afs_operation *afs_alloc_operation(struct key *, struct afs_volume *);
 extern int afs_put_operation(struct afs_operation *);
 extern bool afs_begin_vnode_operation(struct afs_operation *);
+extern void afs_end_vnode_operation(struct afs_operation *op);
 extern void afs_wait_for_operation(struct afs_operation *);
 extern int afs_do_sync_operation(struct afs_operation *);
 
@@ -1325,6 +1331,7 @@ extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
 void afs_deferred_put_call(struct afs_call *call);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
+void afs_deliver_to_call(struct afs_call *call);
 void afs_wait_for_call_to_complete(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
diff --git a/fs/afs/main.c b/fs/afs/main.c
index a14f6013e316..1ae0067f772d 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -177,7 +177,7 @@ static int __init afs_init(void)
 	afs_wq = alloc_workqueue("afs", 0, 0);
 	if (!afs_wq)
 		goto error_afs_wq;
-	afs_async_calls = alloc_workqueue("kafsd", WQ_MEM_RECLAIM, 0);
+	afs_async_calls = alloc_workqueue("kafsd", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!afs_async_calls)
 		goto error_async;
 	afs_lock_manager = alloc_workqueue("kafs_lockd", WQ_MEM_RECLAIM, 0);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 9f2a3bb56ec6..94fff4e214b0 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -149,7 +149,8 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->net = net;
 	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
 	refcount_set(&call->ref, 1);
-	INIT_WORK(&call->async_work, afs_process_async_call);
+	INIT_WORK(&call->async_work, type->async_rx ?: afs_process_async_call);
+	INIT_WORK(&call->work, call->type->work);
 	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
@@ -254,8 +255,6 @@ static struct afs_call *afs_get_call(struct afs_call *call,
 static void afs_queue_call_work(struct afs_call *call)
 {
 	if (call->type->work) {
-		INIT_WORK(&call->work, call->type->work);
-
 		afs_get_call(call, afs_call_trace_work);
 		if (!queue_work(afs_wq, &call->work))
 			afs_put_call(call);
@@ -501,7 +500,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 /*
  * deliver messages to a call
  */
-static void afs_deliver_to_call(struct afs_call *call)
+void afs_deliver_to_call(struct afs_call *call)
 {
 	enum afs_call_state state;
 	size_t len;
@@ -803,6 +802,7 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 		return -ENOTSUPP;
 
 	trace_afs_cb_call(call);
+	call->work.func = call->type->work;
 
 	/* pass responsibility for the remainer of this message off to the
 	 * cache manager op */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 17d188aaf101..e87b55792aa8 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -193,6 +193,18 @@ void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *st
 		list_first_entry(&stream->subrequests,
 				 struct netfs_io_subrequest, rreq_link);
 
+	switch (wreq->origin) {
+	case NETFS_READAHEAD:
+	case NETFS_READPAGE:
+	case NETFS_READ_GAPS:
+	case NETFS_READ_SINGLE:
+	case NETFS_READ_FOR_WRITE:
+	case NETFS_DIO_READ:
+		return;
+	default:
+		break;
+	}
+
 	switch (subreq->error) {
 	case -EACCES:
 	case -EPERM:
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 3718d852fabc..4e7d93ee5a08 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -397,7 +397,6 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		ret = afs_extract_data(call, true);
 		subreq->transferred += count_before - call->iov_len;
-		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
@@ -457,6 +456,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 static const struct afs_call_type yfs_RXYFSFetchData64 = {
 	.name		= "YFS.FetchData64",
 	.op		= yfs_FS_FetchData64,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= yfs_deliver_fs_fetch_data64,
 	.destructor	= afs_flat_call_destructor,
 };
@@ -486,6 +486,9 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp = xdr_encode_u32(bp, YFSFETCHDATA64);



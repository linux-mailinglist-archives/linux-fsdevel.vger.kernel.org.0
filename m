Return-Path: <linux-fsdevel+bounces-37548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A79F3BE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DB516CF12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198741F868F;
	Mon, 16 Dec 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHY0rrMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10F1F03F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381888; cv=none; b=uCD/97pgakRD1uNU6ZuvLPqDsXR/aE5x4lFT1NGN6iuGduQLNZz0s6lDgivyVE5BfmnPQ0AtSFCUnoFQNyPlaKLQi6pxsYo82ooi/RSYV+jmDl7TRPfnmiS3J6UaNY0MTRn0vGtvT5ZB9RhxfFxdgcHAGf2ux453bJLEUB0rTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381888; c=relaxed/simple;
	bh=aPjeQrIsJKdxqj6hw6meyNhGFCNm1TWGWHipEOQ5E84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/DvL2z+CopRjKE5VtFF4JSv+i7B93Kxt2Ouf5TNG8M3h0ZjtemvuW3wVQlhDrl78ZOOuKJmHc2ox114hM9rlnztGbeftECvJp7w8DN6l0Y2TEX8OGLPJ9KacqvlaCzkx7idVmlgsirTfrhDEarhtq/KyNzC7nX6W4K8CPCVEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHY0rrMp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVR7KAaWb2YdyN6VbGPBN338Y3hiQN7r1WQyIql0ih0=;
	b=bHY0rrMpt2TQ2+H88c8WkhT1/KAHlIIXCbLMExr/g5XD6AWajwQb5M7itAp/G1xoKUVRTw
	GqFx7/XLo260kmnWRDPMtje5K/fJrmNQ9iPCpXjNq0fc1B53FUglpbosiBny0HD81akBX9
	i2Geyzfu9Qg5fNBc0tBen2UVCXaEbt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-Qopv6JHbPBir263e3m7SYg-1; Mon,
 16 Dec 2024 15:44:41 -0500
X-MC-Unique: Qopv6JHbPBir263e3m7SYg-1
X-Mimecast-MFC-AGG-ID: Qopv6JHbPBir263e3m7SYg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2C141955F41;
	Mon, 16 Dec 2024 20:44:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31F7B19560A2;
	Mon, 16 Dec 2024 20:44:32 +0000 (UTC)
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
Subject: [PATCH v5 25/32] afs: Make {Y,}FS.FetchData an asynchronous operation
Date: Mon, 16 Dec 2024 20:41:15 +0000
Message-ID: <20241216204124.3752367-26-dhowells@redhat.com>
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

Make FS.FetchData and YFS.FetchData an asynchronous operation in that the
request is queued in AF_RXRPC and then we return to the caller rather than
waiting.  Processing of the returning packets is then done inline if it's a
synchronous VFS/VM call (readdir, read_folio, sync DIO, prep for write) or
offloaded to a workqueue if asynchronous VM calls (eg. readahead, async
DIO).

This reduces the chain of workqueues invoking workqueues and cuts out some
of the overhead, driving rxrpc data extraction and netfslib read collection
from a thread that's going to block to completion anyway if possible.

The ->done() call op is also split with ->immediate_cancel() handling the
cancellation on failure to begin the call and ->done() handling the rest.
This means that the AFS async FetchData code doesn't try to terminate the
netfs subrequest twice.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c         | 126 +++++++++++++++++++++++++++++++++++++-----
 fs/afs/fs_operation.c |   2 +-
 fs/afs/fsclient.c     |   9 ++-
 fs/afs/internal.h     |  24 ++++++++
 fs/afs/main.c         |   2 +-
 fs/afs/rxrpc.c        |  25 ++-------
 fs/afs/vlclient.c     |   1 +
 fs/afs/write.c        |  12 ++++
 fs/afs/yfsclient.c    |   6 +-
 9 files changed, 170 insertions(+), 37 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index b996f4419c0c..c296efebb491 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -225,26 +225,111 @@ static void afs_fetch_data_aborted(struct afs_operation *op)
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
+	op->call		= NULL;
+	call->op		= NULL;
+	afs_put_call(call);
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
+void afs_fetch_data_immediate_cancel(struct afs_call *call)
+{
+	if (call->async) {
+		afs_get_call(call, afs_call_trace_wake);
+		if (!queue_work(afs_async_calls, &call->async_work))
+			afs_deferred_put_call(call);
+		flush_work(&call->async_work);
+	}
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
@@ -269,13 +354,26 @@ static void afs_read_worker(struct work_struct *work)
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
+			subreq->error = afs_put_operation(op);
+			netfs_read_subreq_terminated(subreq);
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
index 0175d7a31332..8418813ee043 100644
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
index d9d224c95454..1d9ecd5418d8 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -352,7 +352,6 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		ret = afs_extract_data(call, true);
 		subreq->transferred += count_before - call->iov_len;
 		call->remaining -= count_before - call->iov_len;
-		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
@@ -409,14 +408,18 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 static const struct afs_call_type afs_RXFSFetchData = {
 	.name		= "FS.FetchData",
 	.op		= afs_FS_FetchData,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= afs_deliver_fs_fetch_data,
+	.immediate_cancel = afs_fetch_data_immediate_cancel,
 	.destructor	= afs_flat_call_destructor,
 };
 
 static const struct afs_call_type afs_RXFSFetchData64 = {
 	.name		= "FS.FetchData64",
 	.op		= afs_FS_FetchData64,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= afs_deliver_fs_fetch_data,
+	.immediate_cancel = afs_fetch_data_immediate_cancel,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -436,6 +439,9 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA64);
@@ -1730,6 +1736,7 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
 	.op		= afs_FS_GetCapabilities,
 	.deliver	= afs_deliver_fs_get_capabilities,
 	.done		= afs_fileserver_probe_result,
+	.immediate_cancel = afs_fileserver_probe_result,
 	.destructor	= afs_fs_get_capabilities_destructor,
 };
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 96fc466efd10..cd2c4f85117d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -202,11 +202,17 @@ struct afs_call_type {
 	/* clean up a call */
 	void (*destructor)(struct afs_call *call);
 
+	/* Async receive processing function */
+	void (*async_rx)(struct work_struct *work);
+
 	/* Work function */
 	void (*work)(struct work_struct *work);
 
 	/* Call done function (gets called immediately on success or failure) */
 	void (*done)(struct afs_call *call);
+
+	/* Handle a call being immediately cancelled. */
+	void (*immediate_cancel)(struct afs_call *call);
 };
 
 /*
@@ -942,6 +948,7 @@ struct afs_operation {
 #define AFS_OPERATION_TRIED_ALL		0x0400	/* Set if we've tried all the fileservers */
 #define AFS_OPERATION_RETRY_SERVER	0x0800	/* Set if we should retry the current server */
 #define AFS_OPERATION_DIR_CONFLICT	0x1000	/* Set if we detected a 3rd-party dir change */
+#define AFS_OPERATION_ASYNC		0x2000	/* Set if should run asynchronously */
 };
 
 /*
@@ -1104,6 +1111,8 @@ extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
+void afs_fetch_data_async_rx(struct work_struct *work);
+void afs_fetch_data_immediate_cancel(struct afs_call *call);
 
 /*
  * flock.c
@@ -1155,6 +1164,7 @@ extern void afs_fs_store_acl(struct afs_operation *);
 extern struct afs_operation *afs_alloc_operation(struct key *, struct afs_volume *);
 extern int afs_put_operation(struct afs_operation *);
 extern bool afs_begin_vnode_operation(struct afs_operation *);
+extern void afs_end_vnode_operation(struct afs_operation *op);
 extern void afs_wait_for_operation(struct afs_operation *);
 extern int afs_do_sync_operation(struct afs_operation *);
 
@@ -1326,6 +1336,7 @@ extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
 void afs_deferred_put_call(struct afs_call *call);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
+void afs_deliver_to_call(struct afs_call *call);
 void afs_wait_for_call_to_complete(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
@@ -1336,6 +1347,19 @@ extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
 extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 
+static inline struct afs_call *afs_get_call(struct afs_call *call,
+					    enum afs_call_trace why)
+{
+	int r;
+
+	__refcount_inc(&call->ref, &r);
+
+	trace_afs_call(call->debug_id, why, r + 1,
+		       atomic_read(&call->net->nr_outstanding_calls),
+		       __builtin_return_address(0));
+	return call;
+}
+
 static inline void afs_see_call(struct afs_call *call, enum afs_call_trace why)
 {
 	int r = refcount_read(&call->ref);
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
index a122c6366ce1..886416ea1d96 100644
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
@@ -235,27 +236,12 @@ void afs_deferred_put_call(struct afs_call *call)
 		schedule_work(&call->free_work);
 }
 
-static struct afs_call *afs_get_call(struct afs_call *call,
-				     enum afs_call_trace why)
-{
-	int r;
-
-	__refcount_inc(&call->ref, &r);
-
-	trace_afs_call(call->debug_id, why, r + 1,
-		       atomic_read(&call->net->nr_outstanding_calls),
-		       __builtin_return_address(0));
-	return call;
-}
-
 /*
  * Queue the call for actual work.
  */
 static void afs_queue_call_work(struct afs_call *call)
 {
 	if (call->type->work) {
-		INIT_WORK(&call->work, call->type->work);
-
 		afs_get_call(call, afs_call_trace_work);
 		if (!queue_work(afs_wq, &call->work))
 			afs_put_call(call);
@@ -452,8 +438,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 error_kill_call:
 	if (call->async)
 		afs_see_call(call, afs_call_trace_async_kill);
-	if (call->type->done)
-		call->type->done(call);
+	if (call->type->immediate_cancel)
+		call->type->immediate_cancel(call);
 
 	/* We need to dispose of the extra ref we grabbed for an async call.
 	 * The call, however, might be queued on afs_async_calls and we need to
@@ -508,7 +494,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 /*
  * deliver messages to a call
  */
-static void afs_deliver_to_call(struct afs_call *call)
+void afs_deliver_to_call(struct afs_call *call)
 {
 	enum afs_call_state state;
 	size_t len;
@@ -809,6 +795,7 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 		return -ENOTSUPP;
 
 	trace_afs_cb_call(call);
+	call->work.func = call->type->work;
 
 	/* pass responsibility for the remainer of this message off to the
 	 * cache manager op */
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index cac75f89b64a..adc617a82a86 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -370,6 +370,7 @@ static const struct afs_call_type afs_RXVLGetCapabilities = {
 	.name		= "VL.GetCapabilities",
 	.op		= afs_VL_GetCapabilities,
 	.deliver	= afs_deliver_vl_get_capabilities,
+	.immediate_cancel = afs_vlserver_probe_result,
 	.done		= afs_vlserver_probe_result,
 	.destructor	= afs_destroy_vl_get_capabilities,
 };
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 62570357a0bd..18b0a9f1615e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -196,6 +196,18 @@ void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *st
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
index 3718d852fabc..f57c089f26ee 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -397,7 +397,6 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		ret = afs_extract_data(call, true);
 		subreq->transferred += count_before - call->iov_len;
-		netfs_read_subreq_progress(subreq);
 		if (ret < 0)
 			return ret;
 
@@ -457,7 +456,9 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 static const struct afs_call_type yfs_RXYFSFetchData64 = {
 	.name		= "YFS.FetchData64",
 	.op		= yfs_FS_FetchData64,
+	.async_rx	= afs_fetch_data_async_rx,
 	.deliver	= yfs_deliver_fs_fetch_data64,
+	.immediate_cancel = afs_fetch_data_immediate_cancel,
 	.destructor	= afs_flat_call_destructor,
 };
 
@@ -486,6 +487,9 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp = xdr_encode_u32(bp, YFSFETCHDATA64);



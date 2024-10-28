Return-Path: <linux-fsdevel+bounces-33050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB50F9B2D85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D54F1F22B8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1E41DCB2A;
	Mon, 28 Oct 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zue+3xq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB11DC184;
	Mon, 28 Oct 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112692; cv=none; b=ot0QANg/L32OCtxjj6qHxYfwSRoOhIcjE6/5eYq2w2vVQ/WjMPabP/9N5NKlX0kVbcbH+Ix+71Whu8yYJP1pcXBURvWwbriewjBcTXIaJRcYiBw8Db71/0u3oAsRtwkh0/K2TVlDrYfwDqPhLeEoWccKACITAwLoay781lnUubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112692; c=relaxed/simple;
	bh=4obPxUrzYKCyTfjDkcWbgT9lZNRhEf+R/sXPi3cPcDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFexnaTKw5LOHw9LvVmAktg56T4wDDAd/9q57UkxhzZ8Qx3qRczXdm+N7zUZzizo+1bO0oSRIOyu1EWCiQIhzK5UihuF4yRRVGXzsIKzHp78y2FvVWyDsyZeCo6+zA9dRl0E0EStdpt0cTCk1MX1tp2/7ajZpjPqvzhUigPcEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zue+3xq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46F0C4CEE3;
	Mon, 28 Oct 2024 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112691;
	bh=4obPxUrzYKCyTfjDkcWbgT9lZNRhEf+R/sXPi3cPcDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zue+3xq0FTMe7Kf8ZPwoHbiPlKVCK3YJISPUMTxeAy61o5B1WcidSeAUtpThW7MX6
	 0dkAMB6uLmF01qg5BBJaPhHVJvF426DoC+EDOf+Bw+JGYO3FF9/2njvjZg7R1H1toK
	 A2XxBEvISh5onRGxiRVmy7vWabd2n09+k2MKw6B3Zk3ETGliv/2VrmZodNR8BMNZYI
	 GTJatTfP5Qdc5fK6udSTx5eEpmScFFfY3sILjzPets9AntOZFawBXN+bKbUTeasobO
	 kYYvcXcGcyeWCWxbBSy5YLAwAKMMvfIPHon3vqQwXl5nGeU7ZgYTJmJVTyqkzPSbcm
	 Of8q7Qbb4bBQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 14/32] afs: Fix lock recursion
Date: Mon, 28 Oct 2024 06:49:56 -0400
Message-ID: <20241028105050.3559169-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 610a79ffea02102899a1373fe226d949944a7ed6 ]

afs_wake_up_async_call() can incur lock recursion.  The problem is that it
is called from AF_RXRPC whilst holding the ->notify_lock, but it tries to
take a ref on the afs_call struct in order to pass it to a work queue - but
if the afs_call is already queued, we then have an extraneous ref that must
be put... calling afs_put_call() may call back down into AF_RXRPC through
rxrpc_kernel_shutdown_call(), however, which might try taking the
->notify_lock again.

This case isn't very common, however, so defer it to a workqueue.  The oops
looks something like:

  BUG: spinlock recursion on CPU#0, krxrpcio/7001/1646
   lock: 0xffff888141399b30, .magic: dead4ead, .owner: krxrpcio/7001/1646, .owner_cpu: 0
  CPU: 0 UID: 0 PID: 1646 Comm: krxrpcio/7001 Not tainted 6.12.0-rc2-build3+ #4351
  Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x47/0x70
   do_raw_spin_lock+0x3c/0x90
   rxrpc_kernel_shutdown_call+0x83/0xb0
   afs_put_call+0xd7/0x180
   rxrpc_notify_socket+0xa0/0x190
   rxrpc_input_split_jumbo+0x198/0x1d0
   rxrpc_input_data+0x14b/0x1e0
   ? rxrpc_input_call_packet+0xc2/0x1f0
   rxrpc_input_call_event+0xad/0x6b0
   rxrpc_input_packet_on_conn+0x1e1/0x210
   rxrpc_input_packet+0x3f2/0x4d0
   rxrpc_io_thread+0x243/0x410
   ? __pfx_rxrpc_io_thread+0x10/0x10
   kthread+0xcf/0xe0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x24/0x40
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1394602.1729162732@warthog.procyon.org.uk
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/internal.h |  2 ++
 fs/afs/rxrpc.c    | 83 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 24 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6e1d3c4daf72c..52aab09a32a92 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -130,6 +130,7 @@ struct afs_call {
 	wait_queue_head_t	waitq;		/* processes awaiting completion */
 	struct work_struct	async_work;	/* async I/O processor */
 	struct work_struct	work;		/* actual work processor */
+	struct work_struct	free_work;	/* Deferred free processor */
 	struct rxrpc_call	*rxcall;	/* RxRPC call handle */
 	struct rxrpc_peer	*peer;		/* Remote endpoint */
 	struct key		*key;		/* security for this call */
@@ -1331,6 +1332,7 @@ extern int __net_init afs_open_socket(struct afs_net *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
+void afs_deferred_put_call(struct afs_call *call);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
 void afs_wait_for_call_to_complete(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c453428f3c8ba..9f2a3bb56ec69 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -18,6 +18,7 @@
 
 struct workqueue_struct *afs_async_calls;
 
+static void afs_deferred_free_worker(struct work_struct *work);
 static void afs_wake_up_call_waiter(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_wake_up_async_call(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_process_async_call(struct work_struct *);
@@ -149,6 +150,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->debug_id = atomic_inc_return(&rxrpc_debug_id);
 	refcount_set(&call->ref, 1);
 	INIT_WORK(&call->async_work, afs_process_async_call);
+	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
 	call->iter = &call->def_iter;
@@ -159,6 +161,36 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	return call;
 }
 
+static void afs_free_call(struct afs_call *call)
+{
+	struct afs_net *net = call->net;
+	int o;
+
+	ASSERT(!work_pending(&call->async_work));
+
+	rxrpc_kernel_put_peer(call->peer);
+
+	if (call->rxcall) {
+		rxrpc_kernel_shutdown_call(net->socket, call->rxcall);
+		rxrpc_kernel_put_call(net->socket, call->rxcall);
+		call->rxcall = NULL;
+	}
+	if (call->type->destructor)
+		call->type->destructor(call);
+
+	afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
+	kfree(call->request);
+
+	o = atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
+		       __builtin_return_address(0));
+	kfree(call);
+
+	o = atomic_dec_return(&net->nr_outstanding_calls);
+	if (o == 0)
+		wake_up_var(&net->nr_outstanding_calls);
+}
+
 /*
  * Dispose of a reference on a call.
  */
@@ -173,32 +205,34 @@ void afs_put_call(struct afs_call *call)
 	o = atomic_read(&net->nr_outstanding_calls);
 	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
 		       __builtin_return_address(0));
+	if (zero)
+		afs_free_call(call);
+}
 
-	if (zero) {
-		ASSERT(!work_pending(&call->async_work));
-		ASSERT(call->type->name != NULL);
-
-		rxrpc_kernel_put_peer(call->peer);
-
-		if (call->rxcall) {
-			rxrpc_kernel_shutdown_call(net->socket, call->rxcall);
-			rxrpc_kernel_put_call(net->socket, call->rxcall);
-			call->rxcall = NULL;
-		}
-		if (call->type->destructor)
-			call->type->destructor(call);
+static void afs_deferred_free_worker(struct work_struct *work)
+{
+	struct afs_call *call = container_of(work, struct afs_call, free_work);
 
-		afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
-		kfree(call->request);
+	afs_free_call(call);
+}
 
-		trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
-			       __builtin_return_address(0));
-		kfree(call);
+/*
+ * Dispose of a reference on a call, deferring the cleanup to a workqueue
+ * to avoid lock recursion.
+ */
+void afs_deferred_put_call(struct afs_call *call)
+{
+	struct afs_net *net = call->net;
+	unsigned int debug_id = call->debug_id;
+	bool zero;
+	int r, o;
 
-		o = atomic_dec_return(&net->nr_outstanding_calls);
-		if (o == 0)
-			wake_up_var(&net->nr_outstanding_calls);
-	}
+	zero = __refcount_dec_and_test(&call->ref, &r);
+	o = atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
+		       __builtin_return_address(0));
+	if (zero)
+		schedule_work(&call->free_work);
 }
 
 static struct afs_call *afs_get_call(struct afs_call *call,
@@ -640,7 +674,8 @@ static void afs_wake_up_call_waiter(struct sock *sk, struct rxrpc_call *rxcall,
 }
 
 /*
- * wake up an asynchronous call
+ * Wake up an asynchronous call.  The caller is holding the call notify
+ * spinlock around this, so we can't call afs_put_call().
  */
 static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 				   unsigned long call_user_ID)
@@ -657,7 +692,7 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 			       __builtin_return_address(0));
 
 		if (!queue_work(afs_async_calls, &call->async_work))
-			afs_put_call(call);
+			afs_deferred_put_call(call);
 	}
 }
 
-- 
2.43.0



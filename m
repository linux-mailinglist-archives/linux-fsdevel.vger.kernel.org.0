Return-Path: <linux-fsdevel+bounces-32110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF09A0AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A991C231C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5720C036;
	Wed, 16 Oct 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNy9XcBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F820968C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083281; cv=none; b=Lv6CVF/ebdHM6ie87/4G79FoGQK1pK+ifBxUOnIySnPEtu8wTN4xOr9QvqTHDPcVsUtjaJyTHERXOEHJ32kaQ2TfKTziaO9YNuocBK7x2cK2r5G0pePiGex6i1fHaerGlB/OsgVswmJY4yEVMNxfp/SrAFcdwL1YnhOE+pb3utM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083281; c=relaxed/simple;
	bh=d4TdEGYImTOATqmYhNnQhAKcNmmDYN77hXAU52eRa+A=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=tHQA8k1CR1n2Q9tocNlvCu4vxIsecubKv+thjuQxejbUySGmwZ0CIt3ej+UMM6/wmTBf0FXX5Gr30ID8Q8UnMjccaemIXGf6efhVBW6fM+jflS2WWPSQarguLgfyjtMiXOMzLjNeOaGKpIEuRJaFiqkrgJfTmo4I1Smpnded56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNy9XcBQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729083278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/vwXWikLxT3NlCFu9+QSdoWKDe0l5OvOeeoMjL9Oe+g=;
	b=LNy9XcBQj7QtK7LDKdOTJN7TGBtEkgntinYBD7d3TUL5vnVH8KosIweTtA9OZIRaH1i7wV
	NtSllfLOHLDSLUUkGXZR/eM7cGBZaqlaP7Wrgy7xB2fS/V1+lZh+MqOZbyMsEuxr7s12me
	s4nzy/Ekbh1tw8JIasxO4DkJ6vZU8LE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-GvSg7p37M4qgDT5YjbWO-A-1; Wed,
 16 Oct 2024 08:54:35 -0400
X-MC-Unique: GvSg7p37M4qgDT5YjbWO-A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A0901955F40;
	Wed, 16 Oct 2024 12:54:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E211719560A7;
	Wed, 16 Oct 2024 12:54:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix lock recursion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1114102.1729083271.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Oct 2024 13:54:31 +0100
Message-ID: <1114103.1729083271@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

afs_wake_up_async_call() can incur lock recursion.  The problem is that it
is called from AF_RXRPC whilst holding the ->notify_lock, but it tries to
take a ref on the afs_call struct in order to pass it to a work queue - bu=
t
if the afs_call is already queued, we then have an extraneous ref that mus=
t
be put... calling afs_put_call() may call back down into AF_RXRPC through
rxrpc_kernel_shutdown_call(), however, which might try taking the
->notify_lock again.

This case isn't very common, however, so defer it to a workqueue.  The oop=
s
looks something like:

  BUG: spinlock recursion on CPU#0, krxrpcio/7001/1646
   lock: 0xffff888141399b30, .magic: dead4ead, .owner: krxrpcio/7001/1646,=
 .owner_cpu: 0
  CPU: 0 UID: 0 PID: 1646 Comm: krxrpcio/7001 Not tainted 6.12.0-rc2-build=
3+ #4351
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
    =

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/internal.h |    2 +
 fs/afs/rxrpc.c    |   89 +++++++++++++++++++++++++++++++++++++-----------=
------
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6e1d3c4daf72..52aab09a32a9 100644
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
@@ -1331,6 +1332,7 @@ extern int __net_init afs_open_socket(struct afs_net=
 *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
+void afs_deferred_put_call(struct afs_call *call);
 void afs_make_call(struct afs_call *call, gfp_t gfp);
 void afs_wait_for_call_to_complete(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index c453428f3c8b..5e9df414faf7 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -18,6 +18,7 @@
 =

 struct workqueue_struct *afs_async_calls;
 =

+static void afs_deferred_free_worker(struct work_struct *work);
 static void afs_wake_up_call_waiter(struct sock *, struct rxrpc_call *, u=
nsigned long);
 static void afs_wake_up_async_call(struct sock *, struct rxrpc_call *, un=
signed long);
 static void afs_process_async_call(struct work_struct *);
@@ -148,7 +149,9 @@ static struct afs_call *afs_alloc_call(struct afs_net =
*net,
 	call->net =3D net;
 	call->debug_id =3D atomic_inc_return(&rxrpc_debug_id);
 	refcount_set(&call->ref, 1);
-	INIT_WORK(&call->async_work, afs_process_async_call);
+	INIT_WORK(&call->async_work, type->async_rx ?: afs_process_async_call);
+	INIT_WORK(&call->work, call->type->work);
+	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
 	call->iter =3D &call->def_iter;
@@ -159,6 +162,36 @@ static struct afs_call *afs_alloc_call(struct afs_net=
 *net,
 	return call;
 }
 =

+static void afs_free_call(struct afs_call *call)
+{
+	struct afs_net *net =3D call->net;
+	int o;
+
+	ASSERT(!work_pending(&call->async_work));
+
+	rxrpc_kernel_put_peer(call->peer);
+
+	if (call->rxcall) {
+		rxrpc_kernel_shutdown_call(net->socket, call->rxcall);
+		rxrpc_kernel_put_call(net->socket, call->rxcall);
+		call->rxcall =3D NULL;
+	}
+	if (call->type->destructor)
+		call->type->destructor(call);
+
+	afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_ca=
ll);
+	kfree(call->request);
+
+	o =3D atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
+		       __builtin_return_address(0));
+	kfree(call);
+
+	o =3D atomic_dec_return(&net->nr_outstanding_calls);
+	if (o =3D=3D 0)
+		wake_up_var(&net->nr_outstanding_calls);
+}
+
 /*
  * Dispose of a reference on a call.
  */
@@ -173,32 +206,34 @@ void afs_put_call(struct afs_call *call)
 	o =3D atomic_read(&net->nr_outstanding_calls);
 	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
 		       __builtin_return_address(0));
+	if (zero)
+		afs_free_call(call);
+}
 =

-	if (zero) {
-		ASSERT(!work_pending(&call->async_work));
-		ASSERT(call->type->name !=3D NULL);
-
-		rxrpc_kernel_put_peer(call->peer);
-
-		if (call->rxcall) {
-			rxrpc_kernel_shutdown_call(net->socket, call->rxcall);
-			rxrpc_kernel_put_call(net->socket, call->rxcall);
-			call->rxcall =3D NULL;
-		}
-		if (call->type->destructor)
-			call->type->destructor(call);
+static void afs_deferred_free_worker(struct work_struct *work)
+{
+	struct afs_call *call =3D container_of(work, struct afs_call, free_work)=
;
 =

-		afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_c=
all);
-		kfree(call->request);
+	afs_free_call(call);
+}
 =

-		trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
-			       __builtin_return_address(0));
-		kfree(call);
+/*
+ * Dispose of a reference on a call, deferring the cleanup to a workqueue
+ * to avoid lock recursion.
+ */
+void afs_deferred_put_call(struct afs_call *call)
+{
+	struct afs_net *net =3D call->net;
+	unsigned int debug_id =3D call->debug_id;
+	bool zero;
+	int r, o;
 =

-		o =3D atomic_dec_return(&net->nr_outstanding_calls);
-		if (o =3D=3D 0)
-			wake_up_var(&net->nr_outstanding_calls);
-	}
+	zero =3D __refcount_dec_and_test(&call->ref, &r);
+	o =3D atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
+		       __builtin_return_address(0));
+	if (zero)
+		schedule_work(&call->free_work);
 }
 =

 static struct afs_call *afs_get_call(struct afs_call *call,
@@ -220,8 +255,6 @@ static struct afs_call *afs_get_call(struct afs_call *=
call,
 static void afs_queue_call_work(struct afs_call *call)
 {
 	if (call->type->work) {
-		INIT_WORK(&call->work, call->type->work);
-
 		afs_get_call(call, afs_call_trace_work);
 		if (!queue_work(afs_wq, &call->work))
 			afs_put_call(call);
@@ -640,7 +673,8 @@ static void afs_wake_up_call_waiter(struct sock *sk, s=
truct rxrpc_call *rxcall,
 }
 =

 /*
- * wake up an asynchronous call
+ * Wake up an asynchronous call.  The caller is holding the call notify
+ * spinlock around this, so we can't call afs_put_call().
  */
 static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rx=
call,
 				   unsigned long call_user_ID)
@@ -657,7 +691,7 @@ static void afs_wake_up_async_call(struct sock *sk, st=
ruct rxrpc_call *rxcall,
 			       __builtin_return_address(0));
 =

 		if (!queue_work(afs_async_calls, &call->async_work))
-			afs_put_call(call);
+			afs_deferred_put_call(call);
 	}
 }
 =

@@ -768,6 +802,7 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 		return -ENOTSUPP;
 =

 	trace_afs_cb_call(call);
+	call->work.func =3D call->type->work;
 =

 	/* pass responsibility for the remainer of this message off to the
 	 * cache manager op */



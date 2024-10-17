Return-Path: <linux-fsdevel+bounces-32184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B49A2062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BA91C22346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B541DB540;
	Thu, 17 Oct 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMUJAG+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641C1D9A59
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162744; cv=none; b=QvtrVW+veidqOWY5GdIZrXBGuAyi1K52kFJhae7sleCe3zwhvNDM85SupEVgbezmX5hhxhz+e0p6K5DSgWMv2sHSFDMlWF1KpdN4Guy6pjclueXJrOuPbXMY7EFblv/bR23JFNawIwvoziGF+wvz5/qkdZu5sWwkkiBeBpx7340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162744; c=relaxed/simple;
	bh=87iL6FJn+Z8+drF38nk4+Q0zaXlsZb/97pJYQzLAByE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=b7LSS6HXVLPYqcPbkCR5F/G0esa5AbFlMhmAd5TmaPd3lOHbku3p7mQ3a7fNr6Yk4Yg6w7yRqa6rnrES7xo4x7TW7nO6pxYGXnmlqDkQOGISq5OJBHvsUHvlBgCSJJrPVvUcWXGaq3WbgU4SFPDZhtpBhVBvlmniMtJytg6dA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMUJAG+T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729162740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mewcKZY1pexaCktLiPPOjAIcUuazJvJ1t70Pvtm2u1E=;
	b=KMUJAG+TlitM/z78H0O2mf/u5ogCDdOMx/7ywk83VvRfK36xPJjh7z1CusQmMBEHInAvwu
	sM0ujHPSVCFmTWHXGDp5EvzL6rTVVzganQKuE74hVlz0HUh/JbRD9jl2coIGkiwDfVZaaV
	9us3W6+Clvyn7FZ/+/g4PTuM8jkrXmA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-tRHVCJd9NjyQjrY-wJQiKA-1; Thu,
 17 Oct 2024 06:58:57 -0400
X-MC-Unique: tRHVCJd9NjyQjrY-wJQiKA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C24981955F45;
	Thu, 17 Oct 2024 10:58:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D12BF300019D;
	Thu, 17 Oct 2024 10:58:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1114103.1729083271@warthog.procyon.org.uk>
References: <1114103.1729083271@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] afs: Fix lock recursion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1394601.1729162732.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2024 11:58:52 +0100
Message-ID: <1394602.1729162732@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

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

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/internal.h |    2 +
 fs/afs/rxrpc.c    |   83 ++++++++++++++++++++++++++++++++++++++----------=
------
 2 files changed, 61 insertions(+), 24 deletions(-)

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
index c453428f3c8b..9f2a3bb56ec6 100644
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
@@ -149,6 +150,7 @@ static struct afs_call *afs_alloc_call(struct afs_net =
*net,
 	call->debug_id =3D atomic_inc_return(&rxrpc_debug_id);
 	refcount_set(&call->ref, 1);
 	INIT_WORK(&call->async_work, afs_process_async_call);
+	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
 	call->iter =3D &call->def_iter;
@@ -159,6 +161,36 @@ static struct afs_call *afs_alloc_call(struct afs_net=
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
@@ -173,32 +205,34 @@ void afs_put_call(struct afs_call *call)
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
@@ -640,7 +674,8 @@ static void afs_wake_up_call_waiter(struct sock *sk, s=
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
@@ -657,7 +692,7 @@ static void afs_wake_up_async_call(struct sock *sk, st=
ruct rxrpc_call *rxcall,
 			       __builtin_return_address(0));
 =

 		if (!queue_work(afs_async_calls, &call->async_work))
-			afs_put_call(call);
+			afs_deferred_put_call(call);
 	}
 }
 =



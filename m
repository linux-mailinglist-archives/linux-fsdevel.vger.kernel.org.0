Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DB12305D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfLQPcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 10:32:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727552AbfLQPcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576596728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GHIAAsPf/4vWePLT3PSRPktae0ECpHi5GI6Bh4rJhaA=;
        b=heTNowqC+EP23Q517c7QVHxNq1xIVmcvyeNknIbiF+ARibPaC84wkyWr92No3AlyiOvQp9
        AxpgvRgO9f/wZpH/+v0dAsD4uiGoGz+Obj+nRK4tEtN4NLL3YZc9zUIEHZ9vf/wlYDsl6T
        jp0lJvi88imOtEMpB+mIbJ8m18XeoAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-lZd7XncPMrqXfvtHNWYmTA-1; Tue, 17 Dec 2019 10:32:04 -0500
X-MC-Unique: lZd7XncPMrqXfvtHNWYmTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74678107ACC9;
        Tue, 17 Dec 2019 15:32:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93D601001281;
        Tue, 17 Dec 2019 15:32:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] rxrpc: struct mutex cannot be used for
 rxrpc_call::user_mutex
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Dec 2019 15:32:00 +0000
Message-ID: <157659672074.19580.11641288666811539040.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Standard kernel mutexes cannot be used in any way from interrupt or softirq
context, so the user_mutex which manages access to a call cannot be a mutex
since on a new call the mutex must start off locked and be unlocked within
the softirq handler to prevent userspace interfering with a call we're
setting up.

Commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain
upon mutex API misuse in IRQ contexts") causes big warnings to be splashed
in dmesg for each a new call that comes in from the server.  Whilst it
*seems* like it should be okay, since the accept path trylocks the mutex
when no one else can see it and drops the mutex before it leaves softirq
context, unlocking the mutex causes scheduler magic to happen.

Fix this by switching to using a locking bit and a waitqueue instead.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendmsg/recvmsg")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
cc: Ingo Molnar <mingo@redhat.com>
cc: Will Deacon <will@kernel.org>
cc: Davidlohr Bueso <dave@stgolabs.net>
---

 net/rxrpc/af_rxrpc.c    |   10 +++--
 net/rxrpc/ar-internal.h |    7 +++-
 net/rxrpc/call_accept.c |    4 +-
 net/rxrpc/call_object.c |   89 ++++++++++++++++++++++++++++++++++++++++++++---
 net/rxrpc/input.c       |    2 +
 net/rxrpc/recvmsg.c     |   14 ++++---
 net/rxrpc/sendmsg.c     |   16 ++++----
 7 files changed, 112 insertions(+), 30 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9d3c4d2d893a..28fc1d836d06 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -322,7 +322,7 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 	/* The socket has been unlocked. */
 	if (!IS_ERR(call)) {
 		call->notify_rx = notify_rx;
-		mutex_unlock(&call->user_mutex);
+		rxrpc_user_unlock_call(call);
 	}
 
 	rxrpc_put_peer(cp.peer);
@@ -351,7 +351,7 @@ void rxrpc_kernel_end_call(struct socket *sock, struct rxrpc_call *call)
 {
 	_enter("%d{%d}", call->debug_id, atomic_read(&call->usage));
 
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 	rxrpc_release_call(rxrpc_sk(sock->sk), call);
 
 	/* Make sure we're not going to call back into a kernel service */
@@ -361,7 +361,7 @@ void rxrpc_kernel_end_call(struct socket *sock, struct rxrpc_call *call)
 		spin_unlock_bh(&call->notify_lock);
 	}
 
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	rxrpc_put_call(call, rxrpc_call_put_kernel);
 }
 EXPORT_SYMBOL(rxrpc_kernel_end_call);
@@ -456,14 +456,14 @@ void rxrpc_kernel_set_max_life(struct socket *sock, struct rxrpc_call *call,
 {
 	unsigned long now;
 
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 
 	now = jiffies;
 	hard_timeout += now;
 	WRITE_ONCE(call->expect_term_by, hard_timeout);
 	rxrpc_reduce_call_timer(call, hard_timeout, now, rxrpc_timer_set_for_hard);
 
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 }
 EXPORT_SYMBOL(rxrpc_kernel_set_max_life);
 
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 7c7d10f2e0c1..460fe4bf18f2 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -489,6 +489,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_RX_HEARD,		/* The peer responded at least once to this call */
 	RXRPC_CALL_RX_UNDERRUN,		/* Got data underrun */
 	RXRPC_CALL_IS_INTR,		/* The call is interruptible */
+	RXRPC_CALL_USER_LOCK,		/* The call is locked against user access */
 };
 
 /*
@@ -557,7 +558,6 @@ struct rxrpc_call {
 	struct rxrpc_sock __rcu	*socket;	/* socket responsible */
 	struct rxrpc_net	*rxnet;		/* Network namespace to which call belongs */
 	const struct rxrpc_security *security;	/* applied security module */
-	struct mutex		user_mutex;	/* User access mutex */
 	unsigned long		ack_at;		/* When deferred ACK needs to happen */
 	unsigned long		ack_lost_at;	/* When ACK is figured as lost */
 	unsigned long		resend_at;	/* When next resend needs to happen */
@@ -581,6 +581,7 @@ struct rxrpc_call {
 	struct rb_node		sock_node;	/* Node in rx->calls */
 	struct sk_buff		*tx_pending;	/* Tx socket buffer being filled */
 	wait_queue_head_t	waitq;		/* Wait queue for channel or Tx */
+	struct lockdep_map	user_lock_dep_map; /* Lockdep map for RXRPC_CALL_USER_LOCK */
 	s64			tx_total_len;	/* Total length left to be transmitted (or -1) */
 	__be32			crypto_buf[2];	/* Temporary packet crypto buffer */
 	unsigned long		user_call_ID;	/* user-defined call ID */
@@ -793,6 +794,10 @@ void rxrpc_get_call(struct rxrpc_call *, enum rxrpc_call_trace);
 void rxrpc_put_call(struct rxrpc_call *, enum rxrpc_call_trace);
 void rxrpc_cleanup_call(struct rxrpc_call *);
 void rxrpc_destroy_all_calls(struct rxrpc_net *);
+bool rxrpc_user_trylock_call(struct rxrpc_call *);
+void rxrpc_user_lock_call(struct rxrpc_call *);
+int rxrpc_user_lock_call_interruptible(struct rxrpc_call *);
+void rxrpc_user_unlock_call(struct rxrpc_call *);
 
 static inline bool rxrpc_is_service_call(const struct rxrpc_call *call)
 {
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 135bf5cd8dd5..93040b06a569 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -378,7 +378,7 @@ struct rxrpc_call *rxrpc_new_incoming_call(struct rxrpc_local *local,
 	 * event and userspace is prevented from doing so until the state is
 	 * appropriate.
 	 */
-	if (!mutex_trylock(&call->user_mutex))
+	if (!rxrpc_user_trylock_call(call))
 		BUG();
 
 	/* Make the call live. */
@@ -493,7 +493,7 @@ struct rxrpc_call *rxrpc_accept_call(struct rxrpc_sock *rx,
 	 * We are, however, still holding the socket lock, so other accepts
 	 * must wait for us and no one can add the user ID behind our backs.
 	 */
-	if (mutex_lock_interruptible(&call->user_mutex) < 0) {
+	if (rxrpc_user_lock_call_interruptible(call) < 0) {
 		release_sock(&rx->sk);
 		kleave(" = -ERESTARTSYS");
 		return ERR_PTR(-ERESTARTSYS);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index a31c18c09894..6eb524fbba28 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -54,6 +54,7 @@ static void rxrpc_call_timer_expired(struct timer_list *t)
 }
 
 static struct lock_class_key rxrpc_call_user_mutex_lock_class_key;
+static struct lock_class_key rxrpc_kernel_call_user_mutex_lock_class_key;
 
 /*
  * find an extant server call
@@ -115,14 +116,15 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
 	if (!call->rxtx_annotations)
 		goto nomem_2;
 
-	mutex_init(&call->user_mutex);
-
 	/* Prevent lockdep reporting a deadlock false positive between the afs
 	 * filesystem and sys_sendmsg() via the mmap sem.
 	 */
 	if (rx->sk.sk_kern_sock)
-		lockdep_set_class(&call->user_mutex,
-				  &rxrpc_call_user_mutex_lock_class_key);
+		lockdep_init_map(&call->user_lock_dep_map, "rxrpc_kernel_call",
+				 &rxrpc_kernel_call_user_mutex_lock_class_key, 0);
+	else
+		lockdep_init_map(&call->user_lock_dep_map, "rxrpc_user_call",
+				 &rxrpc_call_user_mutex_lock_class_key, 1);
 
 	timer_setup(&call->timer, rxrpc_call_timer_expired, 0);
 	INIT_WORK(&call->processor, &rxrpc_process_call);
@@ -247,7 +249,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 	/* We need to protect a partially set up call against the user as we
 	 * will be acting outside the socket lock.
 	 */
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 
 	/* Publish the call, even though it is incompletely set up as yet */
 	write_lock(&rx->call_lock);
@@ -317,7 +319,7 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 	trace_rxrpc_call(call->debug_id, rxrpc_call_error,
 			 atomic_read(&call->usage), here, ERR_PTR(ret));
 	rxrpc_release_call(rx, call);
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	rxrpc_put_call(call, rxrpc_call_put);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
@@ -636,3 +638,78 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	atomic_dec(&rxnet->nr_calls);
 	wait_var_event(&rxnet->nr_calls, !atomic_read(&rxnet->nr_calls));
 }
+
+static bool __rxrpc_user_trylock_call(struct rxrpc_call *call)
+{
+	return !test_and_set_bit_lock(RXRPC_CALL_USER_LOCK, &call->flags);
+}
+
+/*
+ * Try to lock a call against other user access.
+ */
+bool rxrpc_user_trylock_call(struct rxrpc_call *call)
+{
+	struct lockdep_map *dep_map = &call->user_lock_dep_map;
+	unsigned long ip = _RET_IP_;
+
+	if (__rxrpc_user_trylock_call(call)) {
+		lock_acquire_exclusive(dep_map, 0, 1, NULL, ip);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Lock a call against other user access.
+ */
+void rxrpc_user_lock_call(struct rxrpc_call *call)
+{
+	struct lockdep_map *dep_map = &call->user_lock_dep_map;
+	unsigned long ip = _RET_IP_;
+
+	might_sleep();
+	lock_acquire_exclusive(dep_map, 0, 0, NULL, ip);
+
+	if (!__rxrpc_user_trylock_call(call)) {
+		lock_contended(dep_map, ip);
+		wait_event(call->waitq, __rxrpc_user_trylock_call(call));
+	}
+	lock_acquired(dep_map, ip);
+}
+
+/*
+ * Interruptibly lock a call against other user access.
+ */
+int rxrpc_user_lock_call_interruptible(struct rxrpc_call *call)
+{
+	struct lockdep_map *dep_map = &call->user_lock_dep_map;
+	unsigned long ip = _RET_IP_;
+	int ret = 0;
+
+	might_sleep();
+	lock_acquire_exclusive(dep_map, 0, 0, NULL, ip);
+
+	if (!__rxrpc_user_trylock_call(call)) {
+		lock_contended(dep_map, ip);
+		ret = wait_event_interruptible(call->waitq, __rxrpc_user_trylock_call(call));
+		if (ret == 0)
+			lock_acquired(dep_map, ip);
+		else
+			lock_release(dep_map, ip);
+	}
+	return ret;
+}
+
+/*
+ * Unlock a call.
+ */
+void rxrpc_user_unlock_call(struct rxrpc_call *call)
+{
+	struct lockdep_map *dep_map = &call->user_lock_dep_map;
+	unsigned long ip = _RET_IP_;
+
+	lock_release(dep_map, ip);
+	clear_bit_unlock(RXRPC_CALL_USER_LOCK, &call->flags);
+	wake_up(&call->waitq);
+}
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 157be1ff8697..9135556ad722 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -1397,7 +1397,7 @@ int rxrpc_input_packet(struct sock *udp_sk, struct sk_buff *skb)
 		if (!call)
 			goto reject_packet;
 		rxrpc_send_ping(call, skb);
-		mutex_unlock(&call->user_mutex);
+		rxrpc_user_unlock_call(call);
 	}
 
 	/* Process a call packet; this either discards or passes on the ref
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 802b712f3d79..296382ff56e1 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -511,12 +511,12 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	/* We're going to drop the socket lock, so we need to lock the call
 	 * against interference by sendmsg.
 	 */
-	if (!mutex_trylock(&call->user_mutex)) {
+	if (!rxrpc_user_trylock_call(call)) {
 		ret = -EWOULDBLOCK;
 		if (flags & MSG_DONTWAIT)
 			goto error_requeue_call;
 		ret = -ERESTARTSYS;
-		if (mutex_lock_interruptible(&call->user_mutex) < 0)
+		if (rxrpc_user_lock_call_interruptible(call) < 0)
 			goto error_requeue_call;
 	}
 
@@ -591,7 +591,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	ret = copied;
 
 error_unlock_call:
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	rxrpc_put_call(call, rxrpc_call_put);
 	trace_rxrpc_recvmsg(call, rxrpc_recvmsg_return, 0, 0, 0, ret);
 	return ret;
@@ -652,7 +652,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 	ASSERTCMP(call->state, !=, RXRPC_CALL_SERVER_ACCEPTING);
 
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 
 	switch (READ_ONCE(call->state)) {
 	case RXRPC_CALL_CLIENT_RECV_REPLY:
@@ -705,7 +705,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 	if (_service)
 		*_service = call->service_id;
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	_leave(" = %d [%zu,%d]", ret, iov_iter_count(iter), *_abort);
 	return ret;
 
@@ -745,7 +745,7 @@ bool rxrpc_kernel_get_reply_time(struct socket *sock, struct rxrpc_call *call,
 	rxrpc_seq_t hard_ack, top, seq;
 	bool success = false;
 
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 
 	if (READ_ONCE(call->state) != RXRPC_CALL_CLIENT_RECV_REPLY)
 		goto out;
@@ -767,7 +767,7 @@ bool rxrpc_kernel_get_reply_time(struct socket *sock, struct rxrpc_call *call,
 	success = true;
 
 out:
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	return success;
 }
 EXPORT_SYMBOL(rxrpc_kernel_get_reply_time);
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 813fd6888142..f903244d7567 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -38,9 +38,9 @@ static int rxrpc_wait_for_tx_window_intr(struct rxrpc_sock *rx,
 			return sock_intr_errno(*timeo);
 
 		trace_rxrpc_transmit(call, rxrpc_transmit_wait);
-		mutex_unlock(&call->user_mutex);
+		rxrpc_user_unlock_call(call);
 		*timeo = schedule_timeout(*timeo);
-		if (mutex_lock_interruptible(&call->user_mutex) < 0)
+		if (rxrpc_user_lock_call_interruptible(call) < 0)
 			return sock_intr_errno(*timeo);
 	}
 }
@@ -668,7 +668,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 			break;
 		}
 
-		ret = mutex_lock_interruptible(&call->user_mutex);
+		ret = rxrpc_user_lock_call_interruptible(call);
 		release_sock(&rx->sk);
 		if (ret < 0) {
 			ret = -ERESTARTSYS;
@@ -737,7 +737,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 	}
 
 out_put_unlock:
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put);
 	_leave(" = %d", ret);
@@ -772,7 +772,7 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	ASSERTCMP(msg->msg_name, ==, NULL);
 	ASSERTCMP(msg->msg_control, ==, NULL);
 
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 
 	_debug("CALL %d USR %lx ST %d on CONN %p",
 	       call->debug_id, call->user_call_ID, call->state, call->conn);
@@ -796,7 +796,7 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 		break;
 	}
 
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	_leave(" = %d", ret);
 	return ret;
 }
@@ -820,13 +820,13 @@ bool rxrpc_kernel_abort_call(struct socket *sock, struct rxrpc_call *call,
 
 	_enter("{%d},%d,%d,%s", call->debug_id, abort_code, error, why);
 
-	mutex_lock(&call->user_mutex);
+	rxrpc_user_lock_call(call);
 
 	aborted = rxrpc_abort_call(why, call, 0, abort_code, error);
 	if (aborted)
 		rxrpc_send_abort_packet(call);
 
-	mutex_unlock(&call->user_mutex);
+	rxrpc_user_unlock_call(call);
 	return aborted;
 }
 EXPORT_SYMBOL(rxrpc_kernel_abort_call);


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D615853A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiG2Qkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiG2QkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9021F89A49
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659112789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4C8W7j5NPnrdc51G4S7kr3EYmKJKbvXbbULFwZwTJw=;
        b=Z4mfHpV/5AXjjzBgdWfkoPwxOoy1aeRUrTg+nWcxAC1L2/DKuHSpePMNePBMATGEzcEEFX
        QP56Uwz8CjZFe+oq5HL49ksup/fZb6a1dT0olt97SJfvlT5gHE20sddjLNmme1TVxL+Y3K
        65FNEhhjIZthouArDZPKhdaS+VTt09M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-4KoOxIzUM5uZbWW_z2vvLA-1; Fri, 29 Jul 2022 12:39:46 -0400
X-MC-Unique: 4KoOxIzUM5uZbWW_z2vvLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A308A3C0ED67;
        Fri, 29 Jul 2022 16:39:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E328C2026D64;
        Fri, 29 Jul 2022 16:39:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] afs: Fix access after dec in put functions
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Jul 2022 17:39:44 +0100
Message-ID: <165911278430.3745403.16526310736054780645.stgit@warthog.procyon.org.uk>
In-Reply-To: <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk>
References: <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reference-putting functions should not access the object being put after
decrementing the refcount unless they reduce the refcount to zero.

Fix a couple of instances of this in afs by copying the information to be
logged by tracepoint to local variables before doing the decrement.

Fixes: 341f741f04be ("afs: Refcount the afs_call struct")
Fixes: 452181936931 ("afs: Trace afs_server usage")
Fixes: 977e5f8ed0ab ("afs: Split the usage count on struct afs_server")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/cmservice.c         |    2 +-
 fs/afs/rxrpc.c             |   11 ++++++-----
 fs/afs/server.c            |   22 +++++++++++++---------
 include/trace/events/afs.h |   12 ++++++------
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index cedd627e1fae..0a090d614e76 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -212,7 +212,7 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
 	 * to maintain cache coherency.
 	 */
 	if (call->server) {
-		trace_afs_server(call->server,
+		trace_afs_server(call->server->debug_id,
 				 refcount_read(&call->server->ref),
 				 atomic_read(&call->server->active),
 				 afs_server_trace_callback);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d9acc43cb6f0..d5c4785c862d 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -152,7 +152,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->iter = &call->def_iter;
 
 	o = atomic_inc_return(&net->nr_outstanding_calls);
-	trace_afs_call(call, afs_call_trace_alloc, 1, o,
+	trace_afs_call(call->debug_id, afs_call_trace_alloc, 1, o,
 		       __builtin_return_address(0));
 	return call;
 }
@@ -163,12 +163,13 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 void afs_put_call(struct afs_call *call)
 {
 	struct afs_net *net = call->net;
+	unsigned int debug_id = call->debug_id;
 	bool zero;
 	int r, o;
 
 	zero = __refcount_dec_and_test(&call->ref, &r);
 	o = atomic_read(&net->nr_outstanding_calls);
-	trace_afs_call(call, afs_call_trace_put, r - 1, o,
+	trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
 		       __builtin_return_address(0));
 
 	if (zero) {
@@ -186,7 +187,7 @@ void afs_put_call(struct afs_call *call)
 		afs_put_addrlist(call->alist);
 		kfree(call->request);
 
-		trace_afs_call(call, afs_call_trace_free, 0, o,
+		trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
 			       __builtin_return_address(0));
 		kfree(call);
 
@@ -203,7 +204,7 @@ static struct afs_call *afs_get_call(struct afs_call *call,
 
 	__refcount_inc(&call->ref, &r);
 
-	trace_afs_call(call, why, r + 1,
+	trace_afs_call(call->debug_id, why, r + 1,
 		       atomic_read(&call->net->nr_outstanding_calls),
 		       __builtin_return_address(0));
 	return call;
@@ -677,7 +678,7 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 	call->need_attention = true;
 
 	if (__refcount_inc_not_zero(&call->ref, &r)) {
-		trace_afs_call(call, afs_call_trace_wake, r + 1,
+		trace_afs_call(call->debug_id, afs_call_trace_wake, r + 1,
 			       atomic_read(&call->net->nr_outstanding_calls),
 			       __builtin_return_address(0));
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index ffed828622b6..bca4b4c55c14 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -243,7 +243,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->rtt = UINT_MAX;
 
 	afs_inc_servers_outstanding(net);
-	trace_afs_server(server, 1, 1, afs_server_trace_alloc);
+	trace_afs_server(server->debug_id, 1, 1, afs_server_trace_alloc);
 	_leave(" = %p", server);
 	return server;
 
@@ -352,10 +352,12 @@ void afs_servers_timer(struct timer_list *timer)
 struct afs_server *afs_get_server(struct afs_server *server,
 				  enum afs_server_trace reason)
 {
+	unsigned int a;
 	int r;
 
 	__refcount_inc(&server->ref, &r);
-	trace_afs_server(server, r + 1, atomic_read(&server->active), reason);
+	a = atomic_read(&server->active);
+	trace_afs_server(server->debug_id, r + 1, a, reason);
 	return server;
 }
 
@@ -372,7 +374,7 @@ static struct afs_server *afs_maybe_use_server(struct afs_server *server,
 		return NULL;
 
 	a = atomic_inc_return(&server->active);
-	trace_afs_server(server, r + 1, a, reason);
+	trace_afs_server(server->debug_id, r + 1, a, reason);
 	return server;
 }
 
@@ -387,7 +389,7 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
 	__refcount_inc(&server->ref, &r);
 	a = atomic_inc_return(&server->active);
 
-	trace_afs_server(server, r + 1, a, reason);
+	trace_afs_server(server->debug_id, r + 1, a, reason);
 	return server;
 }
 
@@ -397,14 +399,16 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
+	unsigned int a;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	a = atomic_inc_return(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
-	trace_afs_server(server, r - 1, atomic_read(&server->active), reason);
+	trace_afs_server(server->debug_id, r - 1, a, reason);
 	if (unlikely(zero))
 		__afs_put_server(net, server);
 }
@@ -441,7 +445,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
 {
 	struct afs_server *server = container_of(rcu, struct afs_server, rcu);
 
-	trace_afs_server(server, refcount_read(&server->ref),
+	trace_afs_server(server->debug_id, refcount_read(&server->ref),
 			 atomic_read(&server->active), afs_server_trace_free);
 	afs_put_addrlist(rcu_access_pointer(server->addresses));
 	kfree(server);
@@ -492,7 +496,7 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 
 		active = atomic_read(&server->active);
 		if (active == 0) {
-			trace_afs_server(server, refcount_read(&server->ref),
+			trace_afs_server(server->debug_id, refcount_read(&server->ref),
 					 active, afs_server_trace_gc);
 			next = rcu_dereference_protected(
 				server->uuid_next, lockdep_is_held(&net->fs_lock.lock));
@@ -558,7 +562,7 @@ void afs_manage_servers(struct work_struct *work)
 		_debug("manage %pU %u", &server->uuid, active);
 
 		if (purging) {
-			trace_afs_server(server, refcount_read(&server->ref),
+			trace_afs_server(server->debug_id, refcount_read(&server->ref),
 					 active, afs_server_trace_purging);
 			if (active != 0)
 				pr_notice("Can't purge s=%08x\n", server->debug_id);
@@ -638,7 +642,7 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 
 	_enter("");
 
-	trace_afs_server(server, refcount_read(&server->ref),
+	trace_afs_server(server->debug_id, refcount_read(&server->ref),
 			 atomic_read(&server->active),
 			 afs_server_trace_update);
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index aa60f42a9763..e9d412d19dbb 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -727,10 +727,10 @@ TRACE_EVENT(afs_cb_call,
 	    );
 
 TRACE_EVENT(afs_call,
-	    TP_PROTO(struct afs_call *call, enum afs_call_trace op,
+	    TP_PROTO(unsigned int call_debug_id, enum afs_call_trace op,
 		     int ref, int outstanding, const void *where),
 
-	    TP_ARGS(call, op, ref, outstanding, where),
+	    TP_ARGS(call_debug_id, op, ref, outstanding, where),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
@@ -741,7 +741,7 @@ TRACE_EVENT(afs_call,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->call = call->debug_id;
+		    __entry->call = call_debug_id;
 		    __entry->op = op;
 		    __entry->ref = ref;
 		    __entry->outstanding = outstanding;
@@ -1433,10 +1433,10 @@ TRACE_EVENT(afs_cb_miss,
 	    );
 
 TRACE_EVENT(afs_server,
-	    TP_PROTO(struct afs_server *server, int ref, int active,
+	    TP_PROTO(unsigned int server_debug_id, int ref, int active,
 		     enum afs_server_trace reason),
 
-	    TP_ARGS(server, ref, active, reason),
+	    TP_ARGS(server_debug_id, ref, active, reason),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		server		)
@@ -1446,7 +1446,7 @@ TRACE_EVENT(afs_server,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->server = server->debug_id;
+		    __entry->server = server_debug_id;
 		    __entry->ref = ref;
 		    __entry->active = active;
 		    __entry->reason = reason;



Return-Path: <linux-fsdevel+bounces-5882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB181138F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710C81C2118D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC832EAE9;
	Wed, 13 Dec 2023 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3+eS6we"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFD310B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V56lkL4K1DOKJM1gg69OrG+ZBlyPTtK87EWqP0nAyjU=;
	b=W3+eS6webXhu7XXlwKFFPy8DJI5LbWA0VMjkMvwfBE+AXI4i2dL4zt+z/ASqtXIGHrozbG
	1Gifs+5I2QBgw75QeKG2gLKkJ6oaILACtqp4zZMBM6XjpCcXV/U2YyppKc//glxj2GkIEb
	6WKs++QXvUn6ExZrmk2XgbPqm0SstAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-hFdqovoEOLWpnr9tXic20w-1; Wed, 13 Dec 2023 08:50:39 -0500
X-MC-Unique: hFdqovoEOLWpnr9tXic20w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ABDF8828C4;
	Wed, 13 Dec 2023 13:50:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDD82166B31;
	Wed, 13 Dec 2023 13:50:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/40] afs: Fold the afs_addr_cursor struct in
Date: Wed, 13 Dec 2023 13:49:42 +0000
Message-ID: <20231213135003.367397-21-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Fold the afs_addr_cursor struct into the afs_operation struct and the
afs_vl_cursor struct and fold its operations into their callers also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c         | 53 -----------------------
 fs/afs/fs_operation.c      | 21 +++++++--
 fs/afs/fs_probe.c          | 41 ++++++++----------
 fs/afs/fsclient.c          | 31 +++++++++-----
 fs/afs/internal.h          | 58 ++++++++++++-------------
 fs/afs/rotate.c            | 71 ++++++++++++++++++------------
 fs/afs/rxrpc.c             | 13 ++----
 fs/afs/server.c            |  6 +--
 fs/afs/vl_probe.c          | 23 +++++-----
 fs/afs/vl_rotate.c         | 88 ++++++++++++++++++++++++++++----------
 fs/afs/vlclient.c          | 34 ++++++++-------
 include/trace/events/afs.h | 18 ++++++--
 12 files changed, 243 insertions(+), 214 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 032e6963c5d8..18c286efa3a5 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -375,56 +375,3 @@ int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *alist,
 	alist->nr_addrs++;
 	return 0;
 }
-
-/*
- * Get an address to try.
- */
-bool afs_iterate_addresses(struct afs_addr_cursor *ac)
-{
-	unsigned long set, failed;
-	int index;
-
-	if (!ac->alist)
-		return false;
-
-	set = ac->alist->responded;
-	failed = ac->alist->probe_failed;
-	_enter("%lx-%lx-%lx,%d", set, failed, ac->tried, ac->index);
-
-	ac->nr_iterations++;
-
-	set &= ~(failed | ac->tried);
-
-	if (!set)
-		return false;
-
-	index = READ_ONCE(ac->alist->preferred);
-	if (test_bit(index, &set))
-		goto selected;
-
-	index = __ffs(set);
-
-selected:
-	ac->index = index;
-	set_bit(index, &ac->tried);
-	ac->call_responded = false;
-	return true;
-}
-
-/*
- * Release an address list cursor.
- */
-void afs_end_cursor(struct afs_addr_cursor *ac)
-{
-	struct afs_addr_list *alist;
-
-	alist = ac->alist;
-	if (alist) {
-		if (ac->call_responded &&
-		    ac->index != alist->preferred &&
-		    test_bit(ac->alist->preferred, &ac->tried))
-			WRITE_ONCE(alist->preferred, ac->index);
-		afs_put_addrlist(alist, afs_alist_trace_put_end_cursor);
-		ac->alist = NULL;
-	}
-}
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index cebe4fad8192..00e22259be36 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -179,6 +179,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 	_enter("");
 
 	while (afs_select_fileserver(op)) {
+		op->call_responded = false;
 		op->call_error = 0;
 		op->call_abort_code = 0;
 		op->cb_s_break = op->server->cb_s_break;
@@ -191,17 +192,19 @@ void afs_wait_for_operation(struct afs_operation *op)
 			op->call_error = -ENOTSUPP;
 
 		if (op->call) {
-			afs_wait_for_call_to_complete(op->call, &op->ac);
+			afs_wait_for_call_to_complete(op->call);
 			op->call_abort_code = op->call->abort_code;
 			op->call_error = op->call->error;
 			op->call_responded = op->call->responded;
-			op->ac.call_responded = true;
-			WRITE_ONCE(op->ac.alist->addrs[op->ac.index].last_error,
+			WRITE_ONCE(op->alist->addrs[op->addr_index].last_error,
 				   op->call_error);
 			afs_put_call(op->call);
 		}
 	}
 
+	if (op->call_responded)
+		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
+
 	if (!afs_op_error(op)) {
 		_debug("success");
 		op->ops->success(op);
@@ -227,6 +230,7 @@ void afs_wait_for_operation(struct afs_operation *op)
  */
 int afs_put_operation(struct afs_operation *op)
 {
+	struct afs_addr_list *alist;
 	int i, ret = afs_op_error(op);
 
 	_enter("op=%08x,%d", op->debug_id, ret);
@@ -249,7 +253,16 @@ int afs_put_operation(struct afs_operation *op)
 		kfree(op->more_files);
 	}
 
-	afs_end_cursor(&op->ac);
+	alist = op->alist;
+	if (alist) {
+		if (op->call_responded &&
+		    op->addr_index != alist->preferred &&
+		    test_bit(alist->preferred, &op->addr_tried))
+			WRITE_ONCE(alist->preferred, op->addr_index);
+		afs_put_addrlist(alist, afs_alist_trace_put_operation);
+		op->alist = NULL;
+	}
+
 	afs_put_serverlist(op->net, op->server_list);
 	afs_put_volume(op->net, op->volume, afs_volume_trace_put_put_op);
 	key_put(op->key);
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 337673e65f87..aef16ac3f577 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -74,11 +74,9 @@ static void afs_done_one_fs_probe(struct afs_net *net, struct afs_server *server
  */
 static void afs_fs_probe_not_done(struct afs_net *net,
 				  struct afs_server *server,
-				  struct afs_addr_cursor *ac)
+				  struct afs_addr_list *alist,
+				  int index)
 {
-	struct afs_addr_list *alist = ac->alist;
-	unsigned int index = ac->index;
-
 	_enter("");
 
 	trace_afs_io_error(0, -ENOMEM, afs_io_error_fs_probe_fail);
@@ -100,10 +98,10 @@ static void afs_fs_probe_not_done(struct afs_net *net,
  */
 void afs_fileserver_probe_result(struct afs_call *call)
 {
-	struct afs_addr_list *alist = call->alist;
-	struct afs_address *addr = &alist->addrs[call->addr_ix];
+	struct afs_addr_list *alist = call->probe_alist;
+	struct afs_address *addr = &alist->addrs[call->probe_index];
 	struct afs_server *server = call->server;
-	unsigned int index = call->addr_ix;
+	unsigned int index = call->probe_index;
 	unsigned int rtt_us = 0, cap0;
 	int ret = call->error;
 
@@ -196,37 +194,36 @@ void afs_fileserver_probe_result(struct afs_call *call)
 void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 			     struct key *key, bool all)
 {
-	struct afs_addr_cursor ac = {
-		.index = 0,
-	};
+	struct afs_addr_list *alist;
+	unsigned int index;
 
 	_enter("%pU", &server->uuid);
 
 	read_lock(&server->fs_lock);
-	ac.alist = rcu_dereference_protected(server->addresses,
-					     lockdep_is_held(&server->fs_lock));
-	afs_get_addrlist(ac.alist, afs_alist_trace_get_probe);
+	alist = rcu_dereference_protected(server->addresses,
+					  lockdep_is_held(&server->fs_lock));
+	afs_get_addrlist(alist, afs_alist_trace_get_probe);
 	read_unlock(&server->fs_lock);
 
 	server->probed_at = jiffies;
-	atomic_set(&server->probe_outstanding, all ? ac.alist->nr_addrs : 1);
+	atomic_set(&server->probe_outstanding, all ? alist->nr_addrs : 1);
 	memset(&server->probe, 0, sizeof(server->probe));
 	server->probe.rtt = UINT_MAX;
 
-	ac.index = ac.alist->preferred;
-	if (ac.index < 0 || ac.index >= ac.alist->nr_addrs)
+	index = alist->preferred;
+	if (index < 0 || index >= alist->nr_addrs)
 		all = true;
 
 	if (all) {
-		for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++)
-			if (!afs_fs_get_capabilities(net, server, &ac, key))
-				afs_fs_probe_not_done(net, server, &ac);
+		for (index = 0; index < alist->nr_addrs; index++)
+			if (!afs_fs_get_capabilities(net, server, alist, index, key))
+				afs_fs_probe_not_done(net, server, alist, index);
 	} else {
-		if (!afs_fs_get_capabilities(net, server, &ac, key))
-			afs_fs_probe_not_done(net, server, &ac);
+		if (!afs_fs_get_capabilities(net, server, alist, index, key))
+			afs_fs_probe_not_done(net, server, alist, index);
 	}
 
-	afs_put_addrlist(ac.alist, afs_alist_trace_put_probe);
+	afs_put_addrlist(alist, afs_alist_trace_put_probe);
 }
 
 /*
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2b64641b20a4..4f98b43b0dde 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1605,10 +1605,8 @@ static const struct afs_call_type afs_RXFSGiveUpAllCallBacks = {
 /*
  * Flush all the callbacks we have on a server.
  */
-int afs_fs_give_up_all_callbacks(struct afs_net *net,
-				 struct afs_server *server,
-				 struct afs_addr_cursor *ac,
-				 struct key *key)
+int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
+				 struct afs_address *addr, struct key *key)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -1621,7 +1619,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 		return -ENOMEM;
 
 	call->key	= key;
-	call->peer	= rxrpc_kernel_get_peer(ac->alist->addrs[ac->index].peer);
+	call->peer	= rxrpc_kernel_get_peer(addr->peer);
 	call->service_id = server->service_id;
 
 	/* marshall the parameters */
@@ -1629,9 +1627,11 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 	*bp++ = htonl(FSGIVEUPALLCALLBACKS);
 
 	call->server = afs_use_server(server, afs_server_trace_give_up_cb);
-	afs_make_call(ac, call, GFP_NOFS);
-	afs_wait_for_call_to_complete(call, ac);
+	afs_make_call(call, GFP_NOFS);
+	afs_wait_for_call_to_complete(call);
 	ret = call->error;
+	if (call->responded)
+		set_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
 	afs_put_call(call);
 	return ret;
 }
@@ -1695,6 +1695,12 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 	return 0;
 }
 
+static void afs_fs_get_capabilities_destructor(struct afs_call *call)
+{
+	afs_put_addrlist(call->probe_alist, afs_alist_trace_put_getcaps);
+	afs_flat_call_destructor(call);
+}
+
 /*
  * FS.GetCapabilities operation type
  */
@@ -1703,7 +1709,7 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
 	.op		= afs_FS_GetCapabilities,
 	.deliver	= afs_deliver_fs_get_capabilities,
 	.done		= afs_fileserver_probe_result,
-	.destructor	= afs_flat_call_destructor,
+	.destructor	= afs_fs_get_capabilities_destructor,
 };
 
 /*
@@ -1713,7 +1719,8 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
  * ->done() - otherwise we return false to indicate we didn't even try.
  */
 bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
-			     struct afs_addr_cursor *ac, struct key *key)
+			     struct afs_addr_list *alist, unsigned int addr_index,
+			     struct key *key)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -1726,7 +1733,9 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 
 	call->key	= key;
 	call->server	= afs_use_server(server, afs_server_trace_get_caps);
-	call->peer	= rxrpc_kernel_get_peer(ac->alist->addrs[ac->index].peer);
+	call->peer	= rxrpc_kernel_get_peer(alist->addrs[addr_index].peer);
+	call->probe_alist = afs_get_addrlist(alist, afs_alist_trace_get_getcaps);
+	call->probe_index = addr_index;
 	call->service_id = server->service_id;
 	call->upgrade	= true;
 	call->async	= true;
@@ -1737,7 +1746,7 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 	*bp++ = htonl(FSGETCAPABILITIES);
 
 	trace_afs_make_fs_call(call, NULL);
-	afs_make_call(ac, call, GFP_NOFS);
+	afs_make_call(call, GFP_NOFS);
 	afs_put_call(call);
 	return true;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3a2aa2af072a..ae33dd8ae49b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -102,7 +102,6 @@ struct afs_addr_list {
  */
 struct afs_call {
 	const struct afs_call_type *type;	/* type of call */
-	struct afs_addr_list	*alist;		/* Address is alist[addr_ix] */
 	wait_queue_head_t	waitq;		/* processes awaiting completion */
 	struct work_struct	async_work;	/* async I/O processor */
 	struct work_struct	work;		/* actual work processor */
@@ -123,6 +122,10 @@ struct afs_call {
 	};
 	void			*buffer;	/* reply receive buffer */
 	union {
+		struct {
+			struct afs_addr_list	*probe_alist;
+			unsigned char		probe_index;	/* Address in ->probe_alist */
+		};
 		struct afs_addr_list	*ret_alist;
 		struct afs_vldb_entry	*ret_vldb;
 		char			*ret_str;
@@ -139,7 +142,6 @@ struct afs_call {
 	unsigned		reply_max;	/* maximum size of reply */
 	unsigned		count2;		/* count used in unmarshalling */
 	unsigned char		unmarshall;	/* unmarshalling phase */
-	unsigned char		addr_ix;	/* Address in ->alist */
 	bool			drop_ref;	/* T if need to drop ref for incoming call */
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
@@ -729,31 +731,23 @@ struct afs_error {
 	bool	aborted;		/* T if ->error is from an abort */
 };
 
-/*
- * Cursor for iterating over a server's address list.
- */
-struct afs_addr_cursor {
-	struct afs_addr_list	*alist;		/* Current address list (pins ref) */
-	unsigned long		tried;		/* Tried addresses */
-	signed char		index;		/* Current address */
-	unsigned short		nr_iterations;	/* Number of address iterations */
-	bool			call_responded;
-};
-
 /*
  * Cursor for iterating over a set of volume location servers.
  */
 struct afs_vl_cursor {
-	struct afs_addr_cursor	ac;
 	struct afs_cell		*cell;		/* The cell we're querying */
 	struct afs_vlserver_list *server_list;	/* Current server list (pins ref) */
 	struct afs_vlserver	*server;	/* Server on which this resides */
+	struct afs_addr_list	*alist;		/* Current address list (pins ref) */
 	struct key		*key;		/* Key for the server */
 	unsigned long		untried_servers; /* Bitmask of untried servers */
+	unsigned long		addr_tried;	/* Tried addresses */
 	struct afs_error	cumul_error;	/* Cumulative error */
+	unsigned int		debug_id;
 	s32			call_abort_code;
 	short			call_error;	/* Error from single call */
 	short			server_index;	/* Current server */
+	signed char		addr_index;	/* Current address */
 	unsigned short		flags;
 #define AFS_VL_CURSOR_STOP	0x0001		/* Set to cease iteration */
 #define AFS_VL_CURSOR_RETRY	0x0002		/* Set to do a retry */
@@ -812,8 +806,6 @@ struct afs_operation {
 	struct timespec64	ctime;		/* Change time to set */
 	struct afs_error	cumul_error;	/* Cumulative error */
 	short			nr_files;	/* Number of entries in file[], more_files */
-	short			call_error;	/* Error from single call */
-	s32			call_abort_code; /* Abort code from single call */
 	unsigned int		debug_id;
 
 	unsigned int		cb_v_break;	/* Volume break counter before op */
@@ -862,16 +854,19 @@ struct afs_operation {
 	};
 
 	/* Fileserver iteration state */
-	struct afs_addr_cursor	ac;
 	struct afs_server_list	*server_list;	/* Current server list (pins ref) */
 	struct afs_server	*server;	/* Server we're using (ref pinned by server_list) */
+	struct afs_addr_list	*alist;		/* Current address list (pins ref) */
 	struct afs_call		*call;
 	unsigned long		untried_servers; /* Bitmask of untried servers */
+	unsigned long		addr_tried;	/* Tried addresses */
+	s32			call_abort_code; /* Abort code from single call */
+	short			call_error;	/* Error from single call */
 	short			server_index;	/* Current server */
 	short			nr_iterations;	/* Number of server iterations */
+	signed char		addr_index;	/* Current address */
 	bool			call_responded;	/* T if the current address responded */
 
-
 	unsigned int		flags;
 #define AFS_OPERATION_STOP		0x0001	/* Set to cease iteration */
 #define AFS_OPERATION_VBUSY		0x0002	/* Set if seen VBUSY */
@@ -981,8 +976,6 @@ extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
 bool afs_addr_list_same(const struct afs_addr_list *a,
 			const struct afs_addr_list *b);
 extern struct afs_vlserver_list *afs_dns_query(struct afs_cell *, time64_t *);
-extern bool afs_iterate_addresses(struct afs_addr_cursor *);
-extern void afs_end_cursor(struct afs_addr_cursor *ac);
 
 extern int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *addr,
 			      __be32 xdr, u16 port);
@@ -1123,10 +1116,11 @@ extern void afs_fs_get_volume_status(struct afs_operation *);
 extern void afs_fs_set_lock(struct afs_operation *);
 extern void afs_fs_extend_lock(struct afs_operation *);
 extern void afs_fs_release_lock(struct afs_operation *);
-extern int afs_fs_give_up_all_callbacks(struct afs_net *, struct afs_server *,
-					struct afs_addr_cursor *, struct key *);
-extern bool afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
-				    struct afs_addr_cursor *, struct key *);
+int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
+				 struct afs_address *addr, struct key *key);
+bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
+			     struct afs_addr_list *alist, unsigned int addr_index,
+			     struct key *key);
 extern void afs_fs_inline_bulk_status(struct afs_operation *);
 
 struct afs_acl {
@@ -1306,8 +1300,8 @@ extern int __net_init afs_open_socket(struct afs_net *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
-extern void afs_make_call(struct afs_addr_cursor *, struct afs_call *, gfp_t);
-void afs_wait_for_call_to_complete(struct afs_call *call, struct afs_addr_cursor *ac);
+void afs_make_call(struct afs_call *call, gfp_t gfp);
+void afs_wait_for_call_to_complete(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
 					    size_t, size_t);
@@ -1325,9 +1319,9 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 	call->op	= op;
 	call->key	= op->key;
 	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
-	call->peer	= rxrpc_kernel_get_peer(op->ac.alist->addrs[op->ac.index].peer);
+	call->peer	= rxrpc_kernel_get_peer(op->alist->addrs[op->addr_index].peer);
 	call->service_id = op->server->service_id;
-	afs_make_call(&op->ac, call, gfp);
+	afs_make_call(call, gfp);
 }
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
@@ -1493,8 +1487,12 @@ extern void afs_fs_exit(void);
 extern struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *,
 							 const char *, int);
 extern struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *, const uuid_t *);
-extern struct afs_call *afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *,
-						struct key *, struct afs_vlserver *, unsigned int);
+struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
+					 struct afs_addr_list *alist,
+					 unsigned int addr_index,
+					 struct key *key,
+					 struct afs_vlserver *server,
+					 unsigned int server_index);
 extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *, const uuid_t *);
 extern char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *);
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 6c1aa9bafc82..a6bda8f44c0f 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -109,19 +109,20 @@ static bool afs_sleep_and_retry(struct afs_operation *op)
  */
 bool afs_select_fileserver(struct afs_operation *op)
 {
-	struct afs_addr_list *alist;
+	struct afs_addr_list *alist = op->alist;
 	struct afs_server *server;
 	struct afs_vnode *vnode = op->file[0].vnode;
+	unsigned long set;
 	unsigned int rtt;
 	s32 abort_code = op->call_abort_code;
-	int error = op->call_error, i;
+	int error = op->call_error, addr_index, i;
 
 	op->nr_iterations++;
 
-	_enter("OP=%x+%x,%llx,%lx[%d],%lx[%d],%d,%d",
+	_enter("OP=%x+%x,%llx,%u{%lx},%u{%lx},%d,%d",
 	       op->debug_id, op->nr_iterations, op->volume->vid,
-	       op->untried_servers, op->server_index,
-	       op->ac.tried, op->ac.index,
+	       op->server_index, op->untried_servers,
+	       op->addr_index, op->addr_tried,
 	       error, abort_code);
 
 	if (op->flags & AFS_OPERATION_STOP) {
@@ -398,12 +399,14 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 restart_from_beginning:
 	_debug("restart");
-	afs_end_cursor(&op->ac);
+	afs_put_addrlist(alist, afs_alist_trace_put_restart_rotate);
+	alist = op->alist = NULL;
 	op->server = NULL;
 	afs_put_serverlist(op->net, op->server_list);
 	op->server_list = NULL;
 start:
 	_debug("start");
+	ASSERTCMP(alist, ==, NULL);
 	/* See if we need to do an update of the volume record.  Note that the
 	 * volume may have moved or even have been deleted.
 	 */
@@ -420,6 +423,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 pick_server:
 	_debug("pick [%lx]", op->untried_servers);
+	ASSERTCMP(alist, ==, NULL);
 
 	error = afs_wait_for_fs_probes(op->server_list, op->untried_servers);
 	if (error < 0) {
@@ -463,7 +467,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 * check it, create a callback intercept, find its address list and
 	 * probe its capabilities before we use it.
 	 */
-	ASSERTCMP(op->ac.alist, ==, NULL);
+	ASSERTCMP(alist, ==, NULL);
 	server = op->server_list->servers[op->server_index].server;
 
 	if (!afs_check_server_record(op, server))
@@ -484,32 +488,34 @@ bool afs_select_fileserver(struct afs_operation *op)
 	read_lock(&server->fs_lock);
 	alist = rcu_dereference_protected(server->addresses,
 					  lockdep_is_held(&server->fs_lock));
-	afs_get_addrlist(alist, afs_alist_trace_get_fsrotate_set);
+	op->alist = afs_get_addrlist(alist, afs_alist_trace_get_fsrotate_set);
 	read_unlock(&server->fs_lock);
 
 retry_server:
-	memset(&op->ac, 0, sizeof(op->ac));
-
-	if (!op->ac.alist)
-		op->ac.alist = alist;
-	else
-		afs_put_addrlist(alist, afs_alist_trace_put_retry_server);
-
-	op->ac.index = -1;
+	op->addr_tried = 0;
+	op->addr_index = -1;
 
 iterate_address:
-	ASSERT(op->ac.alist);
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	if (!afs_iterate_addresses(&op->ac))
+	set = READ_ONCE(alist->responded);
+	set &= ~(READ_ONCE(alist->probe_failed) | op->addr_tried);
+	if (!set)
 		goto out_of_addresses;
 
-	_debug("address [%u] %u/%u %pISp",
-	       op->server_index, op->ac.index, op->ac.alist->nr_addrs,
-	       rxrpc_kernel_remote_addr(op->ac.alist->addrs[op->ac.index].peer));
+	addr_index = READ_ONCE(alist->preferred);
+	if (!test_bit(addr_index, &set))
+		addr_index = __ffs(set);
+
+	op->addr_index = addr_index;
+	set_bit(addr_index, &op->addr_tried);
+	op->alist = alist;
 
 	op->call_responded = false;
+	_debug("address [%u] %u/%u %pISp",
+	       op->server_index, addr_index, alist->nr_addrs,
+	       rxrpc_kernel_remote_addr(alist->addrs[op->addr_index].peer));
 	_leave(" = t");
 	return true;
 
@@ -519,7 +525,6 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 */
 	afs_probe_fileserver(op->net, op->server);
 	if (op->flags & AFS_OPERATION_RETRY_SERVER) {
-		alist = op->ac.alist;
 		error = afs_wait_for_one_fs_probe(
 			op->server, !(op->flags & AFS_OPERATION_UNINTR));
 		switch (error) {
@@ -537,7 +542,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 next_server:
 	_debug("next");
-	afs_end_cursor(&op->ac);
+	ASSERT(alist);
+	if (op->call_responded &&
+	    op->addr_index != READ_ONCE(alist->preferred) &&
+	    test_bit(alist->preferred, &op->addr_tried))
+		WRITE_ONCE(alist->preferred, op->addr_index);
+	afs_put_addrlist(alist, afs_alist_trace_put_next_server);
+	alist = op->alist = NULL;
 	goto pick_server;
 
 no_more_servers:
@@ -557,7 +568,14 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 failed:
 	op->flags |= AFS_OPERATION_STOP;
-	afs_end_cursor(&op->ac);
+	if (alist) {
+		if (op->call_responded &&
+		    op->addr_index != READ_ONCE(alist->preferred) &&
+		    test_bit(alist->preferred, &op->addr_tried))
+			WRITE_ONCE(alist->preferred, op->addr_index);
+		afs_put_addrlist(alist, afs_alist_trace_put_op_failed);
+		op->alist = NULL;
+	}
 	_leave(" = f [failed %d]", afs_op_error(op));
 	return false;
 }
@@ -602,13 +620,12 @@ void afs_dump_edestaddrreq(const struct afs_operation *op)
 					  a->preferred);
 				pr_notice("FC:  - R=%lx F=%lx\n",
 					  a->responded, a->probe_failed);
-				if (a == op->ac.alist)
+				if (a == op->alist)
 					pr_notice("FC:  - current\n");
 			}
 		}
 	}
 
-	pr_notice("AC: t=%lx ax=%u ni=%u\n",
-		  op->ac.tried, op->ac.index, op->ac.nr_iterations);
+	pr_notice("AC: t=%lx ax=%u\n", op->addr_tried, op->addr_index);
 	rcu_read_unlock();
 }
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index e8490b3e9d37..81013bc8bbfd 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -189,7 +189,6 @@ void afs_put_call(struct afs_call *call)
 			call->type->destructor(call);
 
 		afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
-		afs_put_addrlist(call->alist, afs_alist_trace_put_call);
 		kfree(call->request);
 
 		trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
@@ -296,7 +295,7 @@ static void afs_notify_end_request_tx(struct sock *sock,
  * Initiate a call and synchronously queue up the parameters for dispatch.  Any
  * error is stored into the call struct, which the caller must check for.
  */
-void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
+void afs_make_call(struct afs_call *call, gfp_t gfp)
 {
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
@@ -314,9 +313,6 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	       call, call->type->name, key_serial(call->key),
 	       atomic_read(&call->net->nr_outstanding_calls));
 
-	call->addr_ix = ac->index;
-	call->alist = afs_get_addrlist(ac->alist, afs_alist_trace_get_make_call);
-
 	/* Work out the length we're going to transmit.  This is awkward for
 	 * calls such as FS.StoreData where there's an extra injection of data
 	 * after the initial fixed part.
@@ -392,7 +388,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	/* Note that at this point, we may have received the reply or an abort
 	 * - and an asynchronous call may already have completed.
 	 *
-	 * afs_wait_for_call_to_complete(call, ac)
+	 * afs_wait_for_call_to_complete(call)
 	 * must be called to synchronously clean up.
 	 */
 	return;
@@ -577,7 +573,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 /*
  * Wait synchronously for a call to complete.
  */
-void afs_wait_for_call_to_complete(struct afs_call *call, struct afs_addr_cursor *ac)
+void afs_wait_for_call_to_complete(struct afs_call *call)
 {
 	bool rxrpc_complete = false;
 
@@ -627,9 +623,6 @@ void afs_wait_for_call_to_complete(struct afs_call *call, struct afs_addr_cursor
 				afs_set_call_complete(call, -EINTR, 0);
 		}
 	}
-
-	if (call->error == 0 || call->error == -ECONNABORTED)
-		call->responded = true;
 }
 
 /*
diff --git a/fs/afs/server.c b/fs/afs/server.c
index e2c7f65eea33..62d453365689 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -436,12 +436,8 @@ static void __afs_put_server(struct afs_net *net, struct afs_server *server)
 static void afs_give_up_callbacks(struct afs_net *net, struct afs_server *server)
 {
 	struct afs_addr_list *alist = rcu_access_pointer(server->addresses);
-	struct afs_addr_cursor ac = {
-		.alist	= alist,
-		.index	= alist->preferred,
-	};
 
-	afs_fs_give_up_all_callbacks(net, server, &ac, NULL);
+	afs_fs_give_up_all_callbacks(net, server, &alist->addrs[alist->preferred], NULL);
 }
 
 /*
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index d9a99ba9fc78..f868ae5d40e5 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -46,12 +46,12 @@ static void afs_done_one_vl_probe(struct afs_vlserver *server, bool wake_up)
  */
 void afs_vlserver_probe_result(struct afs_call *call)
 {
-	struct afs_addr_list *alist = call->alist;
+	struct afs_addr_list *alist = call->probe_alist;
 	struct afs_vlserver *server = call->vlserver;
-	struct afs_address *addr = &alist->addrs[call->addr_ix];
+	struct afs_address *addr = &alist->addrs[call->probe_index];
 	unsigned int server_index = call->server_index;
 	unsigned int rtt_us = 0;
-	unsigned int index = call->addr_ix;
+	unsigned int index = call->probe_index;
 	bool have_result = false;
 	int ret = call->error;
 
@@ -148,25 +148,25 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 				  unsigned int server_index,
 				  struct afs_error *_e)
 {
-	struct afs_addr_cursor ac = {
-		.index = 0,
-	};
+	struct afs_addr_list *alist;
 	struct afs_call *call;
+	unsigned int index;
 	bool in_progress = false;
 
 	_enter("%s", server->name);
 
 	read_lock(&server->lock);
-	ac.alist = rcu_dereference_protected(server->addresses,
-					     lockdep_is_held(&server->lock));
+	alist = rcu_dereference_protected(server->addresses,
+					  lockdep_is_held(&server->lock));
+	afs_get_addrlist(alist, afs_alist_trace_get_vlprobe);
 	read_unlock(&server->lock);
 
-	atomic_set(&server->probe_outstanding, ac.alist->nr_addrs);
+	atomic_set(&server->probe_outstanding, alist->nr_addrs);
 	memset(&server->probe, 0, sizeof(server->probe));
 	server->probe.rtt = UINT_MAX;
 
-	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
-		call = afs_vl_get_capabilities(net, &ac, key, server,
+	for (index = 0; index < alist->nr_addrs; index++) {
+		call = afs_vl_get_capabilities(net, alist, index, key, server,
 					       server_index);
 		if (!IS_ERR(call)) {
 			afs_prioritise_error(_e, call->error, call->abort_code);
@@ -178,6 +178,7 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 		}
 	}
 
+	afs_put_addrlist(alist, afs_alist_trace_put_vlprobe);
 	return in_progress;
 }
 
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index f895eb94129e..91168528179c 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -17,6 +17,8 @@
 bool afs_begin_vlserver_operation(struct afs_vl_cursor *vc, struct afs_cell *cell,
 				  struct key *key)
 {
+	static atomic_t debug_ids;
+
 	memset(vc, 0, sizeof(*vc));
 	vc->cell = cell;
 	vc->key = key;
@@ -29,6 +31,7 @@ bool afs_begin_vlserver_operation(struct afs_vl_cursor *vc, struct afs_cell *cel
 		return false;
 	}
 
+	vc->debug_id = atomic_inc_return(&debug_ids);
 	return true;
 }
 
@@ -89,17 +92,18 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
  */
 bool afs_select_vlserver(struct afs_vl_cursor *vc)
 {
-	struct afs_addr_list *alist;
+	struct afs_addr_list *alist = vc->alist;
 	struct afs_vlserver *vlserver;
+	unsigned long set, failed;
 	unsigned int rtt;
 	s32 abort_code = vc->call_abort_code;
 	int error = vc->call_error, i;
 
 	vc->nr_iterations++;
 
-	_enter("%lx[%d],%lx[%d],%d,%d",
-	       vc->untried_servers, vc->server_index,
-	       vc->ac.tried, vc->ac.index,
+	_enter("VC=%x+%x,%d{%lx},%d{%lx},%d,%d",
+	       vc->debug_id, vc->nr_iterations, vc->server_index, vc->untried_servers,
+	       vc->addr_index, vc->addr_tried,
 	       error, abort_code);
 
 	if (vc->flags & AFS_VL_CURSOR_STOP) {
@@ -165,7 +169,13 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 restart_from_beginning:
 	_debug("restart");
-	afs_end_cursor(&vc->ac);
+	if (vc->call_responded &&
+	    vc->addr_index != vc->alist->preferred &&
+	    test_bit(alist->preferred, &vc->addr_tried))
+		WRITE_ONCE(alist->preferred, vc->addr_index);
+	afs_put_addrlist(alist, afs_alist_trace_put_vlrotate_restart);
+	alist = vc->alist = NULL;
+
 	afs_put_vlserverlist(vc->cell->net, vc->server_list);
 	vc->server_list = NULL;
 	if (vc->flags & AFS_VL_CURSOR_RETRIED)
@@ -173,6 +183,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	vc->flags |= AFS_VL_CURSOR_RETRIED;
 start:
 	_debug("start");
+	ASSERTCMP(alist, ==, NULL);
 
 	if (!afs_start_vl_iteration(vc))
 		goto failed;
@@ -185,6 +196,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 pick_server:
 	_debug("pick [%lx]", vc->untried_servers);
+	ASSERTCMP(alist, ==, NULL);
 
 	error = afs_wait_for_vl_probes(vc->server_list, vc->untried_servers);
 	if (error < 0) {
@@ -222,7 +234,6 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	 * check it, find its address list and probe its capabilities before we
 	 * use it.
 	 */
-	ASSERTCMP(vc->ac.alist, ==, NULL);
 	vlserver = vc->server_list->servers[vc->server_index].server;
 	vc->server = vlserver;
 
@@ -231,30 +242,48 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	read_lock(&vlserver->lock);
 	alist = rcu_dereference_protected(vlserver->addresses,
 					  lockdep_is_held(&vlserver->lock));
-	afs_get_addrlist(alist, afs_alist_trace_get_vlrotate_set);
+	vc->alist = afs_get_addrlist(alist, afs_alist_trace_get_vlrotate_set);
 	read_unlock(&vlserver->lock);
 
-	memset(&vc->ac, 0, sizeof(vc->ac));
-	vc->ac.alist = alist;
-	vc->ac.index = -1;
+	vc->addr_tried = 0;
+	vc->addr_index = -1;
 
 iterate_address:
-	ASSERT(vc->ac.alist);
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	if (!afs_iterate_addresses(&vc->ac))
+	set = READ_ONCE(alist->responded);
+	failed = READ_ONCE(alist->probe_failed);
+	vc->addr_index = READ_ONCE(alist->preferred);
+
+	_debug("%lx-%lx-%lx,%d", set, failed, vc->addr_tried, vc->addr_index);
+
+	set &= ~(failed | vc->addr_tried);
+
+	if (!set)
 		goto next_server;
 
-	_debug("VL address %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
+	if (!test_bit(vc->addr_index, &set))
+		vc->addr_index = __ffs(set);
+
+	set_bit(vc->addr_index, &vc->addr_tried);
+	vc->alist = alist;
+
+	_debug("VL address %d/%d", vc->addr_index, alist->nr_addrs);
 
 	vc->call_responded = false;
-	_leave(" = t %pISpc", rxrpc_kernel_remote_addr(vc->ac.alist->addrs[vc->ac.index].peer));
+	_leave(" = t %pISpc", rxrpc_kernel_remote_addr(alist->addrs[vc->addr_index].peer));
 	return true;
 
 next_server:
 	_debug("next");
-	afs_end_cursor(&vc->ac);
+	ASSERT(alist);
+	if (vc->call_responded &&
+	    vc->addr_index != alist->preferred &&
+	    test_bit(alist->preferred, &vc->addr_tried))
+		WRITE_ONCE(alist->preferred, vc->addr_index);
+	afs_put_addrlist(alist, afs_alist_trace_put_vlrotate_next);
+	alist = vc->alist = NULL;
 	goto pick_server;
 
 no_more_servers:
@@ -274,8 +303,15 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	}
 
 failed:
+	if (alist) {
+		if (vc->call_responded &&
+		    vc->addr_index != alist->preferred &&
+		    test_bit(alist->preferred, &vc->addr_tried))
+			WRITE_ONCE(alist->preferred, vc->addr_index);
+		afs_put_addrlist(alist, afs_alist_trace_put_vlrotate_fail);
+		alist = vc->alist = NULL;
+	}
 	vc->flags |= AFS_VL_CURSOR_STOP;
-	afs_end_cursor(&vc->ac);
 	_leave(" = f [failed %d]", vc->cumul_error.error);
 	return false;
 }
@@ -299,8 +335,8 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 	pr_notice("DNS: src=%u st=%u lc=%x\n",
 		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
-		  vc->untried_servers, vc->server_index, vc->nr_iterations, vc->flags,
-		  vc->cumul_error.error);
+		  vc->untried_servers, vc->server_index, vc->nr_iterations,
+		  vc->flags, vc->cumul_error.error);
 	pr_notice("VC: call  er=%d ac=%d r=%u\n",
 		  vc->call_error, vc->call_abort_code, vc->call_responded);
 
@@ -320,14 +356,13 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 					  a->preferred);
 				pr_notice("VC:  - R=%lx F=%lx\n",
 					  a->responded, a->probe_failed);
-				if (a == vc->ac.alist)
+				if (a == vc->alist)
 					pr_notice("VC:  - current\n");
 			}
 		}
 	}
 
-	pr_notice("AC: t=%lx ax=%u ni=%u\n",
-		  vc->ac.tried, vc->ac.index, vc->ac.nr_iterations);
+	pr_notice("AC: t=%lx ax=%u\n", vc->addr_tried, vc->addr_index);
 	rcu_read_unlock();
 }
 
@@ -338,6 +373,8 @@ int afs_end_vlserver_operation(struct afs_vl_cursor *vc)
 {
 	struct afs_net *net = vc->cell->net;
 
+	_enter("VC=%x+%x", vc->debug_id, vc->nr_iterations);
+
 	switch (vc->cumul_error.error) {
 	case -EDESTADDRREQ:
 	case -EADDRNOTAVAIL:
@@ -347,7 +384,14 @@ int afs_end_vlserver_operation(struct afs_vl_cursor *vc)
 		break;
 	}
 
-	afs_end_cursor(&vc->ac);
+	if (vc->alist) {
+		if (vc->call_responded &&
+		    vc->addr_index != vc->alist->preferred &&
+		    test_bit(vc->alist->preferred, &vc->addr_tried))
+			WRITE_ONCE(vc->alist->preferred, vc->addr_index);
+		afs_put_addrlist(vc->alist, afs_alist_trace_put_vlrotate_end);
+		vc->alist = NULL;
+	}
 	afs_put_vlserverlist(net, vc->server_list);
 	return vc->cumul_error.error;
 }
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 4bf98a38c3a1..39a0b7614d05 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -149,7 +149,7 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 	call->key = vc->key;
 	call->ret_vldb = entry;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
-	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->peer = rxrpc_kernel_get_peer(vc->alist->addrs[vc->addr_index].peer);
 	call->service_id = vc->server->service_id;
 
 	/* Marshall the parameters */
@@ -161,8 +161,8 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 		memset((void *)bp + volnamesz, 0, padsz);
 
 	trace_afs_make_vl_call(call);
-	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_make_call(call, GFP_KERNEL);
+	afs_wait_for_call_to_complete(call);
 	vc->call_abort_code	= call->abort_code;
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
@@ -290,7 +290,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 	call->key = vc->key;
 	call->ret_alist = NULL;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
-	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->peer = rxrpc_kernel_get_peer(vc->alist->addrs[vc->addr_index].peer);
 	call->service_id = vc->server->service_id;
 
 	/* Marshall the parameters */
@@ -310,8 +310,8 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 		r->uuid.node[i] = htonl(u->node[i]);
 
 	trace_afs_make_vl_call(call);
-	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_make_call(call, GFP_KERNEL);
+	afs_wait_for_call_to_complete(call);
 	vc->call_abort_code	= call->abort_code;
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
@@ -371,6 +371,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 
 static void afs_destroy_vl_get_capabilities(struct afs_call *call)
 {
+	afs_put_addrlist(call->probe_alist, afs_alist_trace_put_vlgetcaps);
 	afs_put_vlserver(call->net, call->vlserver);
 	afs_flat_call_destructor(call);
 }
@@ -394,7 +395,8 @@ static const struct afs_call_type afs_RXVLGetCapabilities = {
  * other end supports.
  */
 struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
-					 struct afs_addr_cursor *ac,
+					 struct afs_addr_list *alist,
+					 unsigned int addr_index,
 					 struct key *key,
 					 struct afs_vlserver *server,
 					 unsigned int server_index)
@@ -411,7 +413,9 @@ struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
 	call->key = key;
 	call->vlserver = afs_get_vlserver(server);
 	call->server_index = server_index;
-	call->peer = rxrpc_kernel_get_peer(ac->alist->addrs[ac->index].peer);
+	call->peer = rxrpc_kernel_get_peer(alist->addrs[addr_index].peer);
+	call->probe_alist = afs_get_addrlist(alist, afs_alist_trace_get_vlgetcaps);
+	call->probe_index = addr_index;
 	call->service_id = server->service_id;
 	call->upgrade = true;
 	call->async = true;
@@ -423,7 +427,7 @@ struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
 
 	/* Can't take a ref on server */
 	trace_afs_make_vl_call(call);
-	afs_make_call(ac, call, GFP_KERNEL);
+	afs_make_call(call, GFP_KERNEL);
 	return call;
 }
 
@@ -658,7 +662,7 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	call->key = vc->key;
 	call->ret_alist = NULL;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
-	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->peer = rxrpc_kernel_get_peer(vc->alist->addrs[vc->addr_index].peer);
 	call->service_id = vc->server->service_id;
 
 	/* Marshall the parameters */
@@ -668,8 +672,8 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	memcpy(bp, uuid, sizeof(*uuid)); /* Type opr_uuid */
 
 	trace_afs_make_vl_call(call);
-	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_make_call(call, GFP_KERNEL);
+	afs_wait_for_call_to_complete(call);
 	vc->call_abort_code	= call->abort_code;
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
@@ -777,7 +781,7 @@ char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
 	call->key = vc->key;
 	call->ret_str = NULL;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
-	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->peer = rxrpc_kernel_get_peer(vc->alist->addrs[vc->addr_index].peer);
 	call->service_id = vc->server->service_id;
 
 	/* marshall the parameters */
@@ -786,8 +790,8 @@ char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
 
 	/* Can't take a ref on server */
 	trace_afs_make_vl_call(call);
-	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_make_call(call, GFP_KERNEL);
+	afs_wait_for_call_to_complete(call);
 	vc->call_abort_code	= call->abort_code;
 	vc->call_error		= call->error;
 	vc->call_responded	= call->responded;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index ed91666ca4cc..0f68d67f52c8 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -204,21 +204,31 @@ enum yfs_cm_operation {
 
 #define afs_alist_traces \
 	EM(afs_alist_trace_alloc,		"ALLOC     ") \
+	EM(afs_alist_trace_get_getcaps,		"GET getcap") \
 	EM(afs_alist_trace_get_fsrotate_set,	"GET fs-rot") \
-	EM(afs_alist_trace_get_make_call,	"GET mkcall") \
 	EM(afs_alist_trace_get_probe,		"GET probe ") \
+	EM(afs_alist_trace_get_vlgetcaps,	"GET vgtcap") \
+	EM(afs_alist_trace_get_vlprobe,		"GET vprobe") \
 	EM(afs_alist_trace_get_vlrotate_set,	"GET vl-rot") \
-	EM(afs_alist_trace_put_call,		"PUT call  ") \
-	EM(afs_alist_trace_put_end_cursor,	"PUT endcur") \
 	EM(afs_alist_trace_put_getaddru,	"PUT GtAdrU") \
+	EM(afs_alist_trace_put_getcaps,		"PUT getcap") \
+	EM(afs_alist_trace_put_next_server,	"PUT nx-srv") \
+	EM(afs_alist_trace_put_op_failed,	"PUT op-fai") \
+	EM(afs_alist_trace_put_operation,	"PUT op    ") \
 	EM(afs_alist_trace_put_parse_empty,	"PUT p-empt") \
 	EM(afs_alist_trace_put_parse_error,	"PUT p-err ") \
 	EM(afs_alist_trace_put_probe,		"PUT probe ") \
-	EM(afs_alist_trace_put_retry_server,	"PUT retry ") \
+	EM(afs_alist_trace_put_restart_rotate,	"PUT rstrot") \
 	EM(afs_alist_trace_put_server,		"PUT server") \
 	EM(afs_alist_trace_put_server_dup,	"PUT sv-dup") \
 	EM(afs_alist_trace_put_server_oom,	"PUT sv-oom") \
 	EM(afs_alist_trace_put_server_update,	"PUT sv-upd") \
+	EM(afs_alist_trace_put_vlgetcaps,	"PUT vgtcap") \
+	EM(afs_alist_trace_put_vlprobe,		"PUT vprobe") \
+	EM(afs_alist_trace_put_vlrotate_end,	"PUT vr-end") \
+	EM(afs_alist_trace_put_vlrotate_fail,	"PUT vr-fai") \
+	EM(afs_alist_trace_put_vlrotate_next,	"PUT vr-nxt") \
+	EM(afs_alist_trace_put_vlrotate_restart,"PUT vr-rst") \
 	EM(afs_alist_trace_put_vlserver,	"PUT vlsrvr") \
 	EM(afs_alist_trace_put_vlserver_old,	"PUT vs-old") \
 	E_(afs_alist_trace_free,		"FREE      ")



Return-Path: <linux-fsdevel+bounces-5878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D7811389
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B203282ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8A2E65B;
	Wed, 13 Dec 2023 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRYVmbc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBB6D60
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hjib9QLALMAPiIUWhwPhaMFho7TCZU0gCuU1atCayiM=;
	b=aRYVmbc/TYfABRyrEdDbLcU6QaCaB+/P0usDYwghf72PZGMLZHXll+faQknRmhP0TBFZyd
	Zx9BVas5KfpseqDCUfH+lCQDrcFJJrGU3NWGyYvLGagukVIicnW7Dh4TBEiJeS8GByuL6C
	gLJIe2f521zrTAD89Z04iMX/lwK6VA4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-esSdtdwpOPKPHkQjb-ABwQ-1; Wed,
 13 Dec 2023 08:50:37 -0500
X-MC-Unique: esSdtdwpOPKPHkQjb-ABwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52A843C2A1D4;
	Wed, 13 Dec 2023 13:50:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3A43C25;
	Wed, 13 Dec 2023 13:50:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/40] afs: Use peer + service_id as call address
Date: Wed, 13 Dec 2023 13:49:41 +0000
Message-ID: <20231213135003.367397-20-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Use the rxrpc_peer plus the service ID as the call address instead of
passing in a sockaddr_srx down to rxrpc.  The peer record is obtained by
using rxrpc_kernel_get_peer().  This avoids the need to repeatedly look up
the peer and allows rxrpc to hold on to resources for it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c | 10 +++-------
 fs/afs/fs_probe.c  |  4 ++--
 fs/afs/fsclient.c  | 14 +++++++++-----
 fs/afs/internal.h  | 18 +++++++++++-------
 fs/afs/rxrpc.c     | 12 ++++++------
 fs/afs/server.c    |  1 +
 fs/afs/vl_list.c   |  3 ++-
 fs/afs/vl_probe.c  |  4 ++--
 fs/afs/vlclient.c  | 14 ++++++++++++--
 9 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 41ef0c879239..032e6963c5d8 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -56,13 +56,12 @@ struct afs_addr_list *afs_get_addrlist(struct afs_addr_list *alist, enum afs_ali
 /*
  * Allocate an address list.
  */
-struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id)
+struct afs_addr_list *afs_alloc_addrlist(unsigned int nr)
 {
 	struct afs_addr_list *alist;
-	unsigned int i;
 	static atomic_t debug_id;
 
-	_enter("%u,%u", nr, service_id);
+	_enter("%u", nr);
 
 	if (nr > AFS_MAX_ADDRESSES)
 		nr = AFS_MAX_ADDRESSES;
@@ -74,9 +73,6 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id)
 	refcount_set(&alist->usage, 1);
 	alist->max_addrs = nr;
 	alist->debug_id = atomic_inc_return(&debug_id);
-
-	for (i = 0; i < nr; i++)
-		alist->addrs[i].service_id = service_id;
 	trace_afs_alist(alist->debug_id, 1, afs_alist_trace_alloc);
 	return alist;
 }
@@ -150,7 +146,7 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 	if (!vllist->servers[0].server)
 		goto error_vl;
 
-	alist = afs_alloc_addrlist(nr, service);
+	alist = afs_alloc_addrlist(nr);
 	if (!alist)
 		goto error;
 
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 18891492c0b4..337673e65f87 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -154,12 +154,12 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_FS_SERVICE) {
 		server->probe.is_yfs = true;
 		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-		addr->service_id = call->service_id;
+		server->service_id = call->service_id;
 	} else {
 		server->probe.not_yfs = true;
 		if (!server->probe.is_yfs) {
 			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-			addr->service_id = call->service_id;
+			server->service_id = call->service_id;
 		}
 		cap0 = ntohl(call->tmp);
 		if (cap0 & AFS3_VICED_CAPABILITY_64BITFILES)
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 2a56dea22519..2b64641b20a4 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1620,7 +1620,9 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 	if (!call)
 		return -ENOMEM;
 
-	call->key = key;
+	call->key	= key;
+	call->peer	= rxrpc_kernel_get_peer(ac->alist->addrs[ac->index].peer);
+	call->service_id = server->service_id;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1722,10 +1724,12 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 	if (!call)
 		return false;
 
-	call->key = key;
-	call->server = afs_use_server(server, afs_server_trace_get_caps);
-	call->upgrade = true;
-	call->async = true;
+	call->key	= key;
+	call->server	= afs_use_server(server, afs_server_trace_get_caps);
+	call->peer	= rxrpc_kernel_get_peer(ac->alist->addrs[ac->index].peer);
+	call->service_id = server->service_id;
+	call->upgrade	= true;
+	call->async	= true;
 	call->max_lifespan = AFS_PROBE_MAX_LIFESPAN;
 
 	/* marshall the parameters */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a321fb83aba1..3a2aa2af072a 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -74,7 +74,6 @@ enum afs_call_state {
 
 struct afs_address {
 	struct rxrpc_peer	*peer;
-	u16			service_id;
 	short			last_error;	/* Last error from this address */
 };
 
@@ -108,6 +107,7 @@ struct afs_call {
 	struct work_struct	async_work;	/* async I/O processor */
 	struct work_struct	work;		/* actual work processor */
 	struct rxrpc_call	*rxcall;	/* RxRPC call handle */
+	struct rxrpc_peer	*peer;		/* Remote endpoint */
 	struct key		*key;		/* security for this call */
 	struct afs_net		*net;		/* The network namespace */
 	struct afs_server	*server;	/* The fileserver record if fs op (pins ref) */
@@ -435,6 +435,7 @@ struct afs_vlserver {
 #define AFS_VLSERVER_PROBE_LOCAL_FAILURE	0x08 /* A local failure prevented a probe */
 	} probe;
 
+	u16			service_id;	/* Service ID we're using */
 	u16			port;
 	u16			name_len;	/* Length of name */
 	char			name[];		/* Server name, case-flattened */
@@ -527,6 +528,7 @@ struct afs_server {
 	refcount_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
+	u16			service_id;	/* Service ID we're using. */
 	unsigned int		rtt;		/* Server's current RTT in uS */
 	unsigned int		debug_id;	/* Debugging ID for traces */
 
@@ -971,7 +973,7 @@ static inline bool afs_is_folio_dirty_mmapped(unsigned long priv)
  * addr_list.c
  */
 struct afs_addr_list *afs_get_addrlist(struct afs_addr_list *alist, enum afs_alist_trace reason);
-extern struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id);
+extern struct afs_addr_list *afs_alloc_addrlist(unsigned int nr);
 extern void afs_put_addrlist(struct afs_addr_list *alist, enum afs_alist_trace reason);
 extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
 						      const char *, size_t, char,
@@ -1318,11 +1320,13 @@ extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
 				    gfp_t gfp)
 {
-	op->call = call;
-	op->type = call->type;
-	call->op = op;
-	call->key = op->key;
-	call->intr = !(op->flags & AFS_OPERATION_UNINTR);
+	op->call	= call;
+	op->type	= call->type;
+	call->op	= op;
+	call->key	= op->key;
+	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
+	call->peer	= rxrpc_kernel_get_peer(op->ac.alist->addrs[op->ac.index].peer);
+	call->service_id = op->server->service_id;
 	afs_make_call(&op->ac, call, gfp);
 }
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 5bbf5a23af85..e8490b3e9d37 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -178,6 +178,8 @@ void afs_put_call(struct afs_call *call)
 		ASSERT(!work_pending(&call->async_work));
 		ASSERT(call->type->name != NULL);
 
+		rxrpc_kernel_put_peer(call->peer);
+
 		if (call->rxcall) {
 			rxrpc_kernel_shutdown_call(net->socket, call->rxcall);
 			rxrpc_kernel_put_call(net->socket, call->rxcall);
@@ -296,8 +298,6 @@ static void afs_notify_end_request_tx(struct sock *sock,
  */
 void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 {
-	struct afs_address *addr = &ac->alist->addrs[ac->index];
-	struct rxrpc_peer *peer = addr->peer;
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
@@ -305,7 +305,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	s64 tx_total_len;
 	int ret;
 
-	_enter(",{%pISp},", rxrpc_kernel_remote_addr(addr->peer));
+	_enter(",{%pISp+%u},", rxrpc_kernel_remote_addr(call->peer), call->service_id);
 
 	ASSERT(call->type != NULL);
 	ASSERT(call->type->name != NULL);
@@ -334,7 +334,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	}
 
 	/* create a call */
-	rxcall = rxrpc_kernel_begin_call(call->net->socket, peer, call->key,
+	rxcall = rxrpc_kernel_begin_call(call->net->socket, call->peer, call->key,
 					 (unsigned long)call,
 					 tx_total_len,
 					 call->max_lifespan,
@@ -342,7 +342,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 					 (call->async ?
 					  afs_wake_up_async_call :
 					  afs_wake_up_call_waiter),
-					 addr->service_id,
+					 call->service_id,
 					 call->upgrade,
 					 (call->intr ? RXRPC_PREINTERRUPTIBLE :
 					  RXRPC_UNINTERRUPTIBLE),
@@ -462,7 +462,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 		max = m + 1;
 		pr_notice("kAFS: Peer reported %s failure on %s [%pISp]\n",
 			  msg, call->type->name,
-			  rxrpc_kernel_remote_addr(call->alist->addrs[call->addr_ix].peer));
+			  rxrpc_kernel_remote_addr(call->peer));
 	}
 }
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 6c13f00b10d8..e2c7f65eea33 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -215,6 +215,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	spin_lock_init(&server->probe_lock);
 	server->cell = cell;
 	server->rtt = UINT_MAX;
+	server->service_id = FS_SERVICE;
 
 	afs_inc_servers_outstanding(net);
 	trace_afs_server(server->debug_id, 1, 1, afs_server_trace_alloc);
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 3a2875933261..5c4cd71caccf 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -23,6 +23,7 @@ struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
 		spin_lock_init(&vlserver->probe_lock);
 		vlserver->rtt = UINT_MAX;
 		vlserver->name_len = name_len;
+		vlserver->service_id = VL_SERVICE;
 		vlserver->port = port;
 		memcpy(vlserver->name, name, name_len);
 	}
@@ -92,7 +93,7 @@ static struct afs_addr_list *afs_extract_vl_addrs(struct afs_net *net,
 	const u8 *b = *_b;
 	int ret = -EINVAL;
 
-	alist = afs_alloc_addrlist(nr_addrs, VL_SERVICE);
+	alist = afs_alloc_addrlist(nr_addrs);
 	if (!alist)
 		return ERR_PTR(-ENOMEM);
 	if (nr_addrs == 0)
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 138f5715619d..d9a99ba9fc78 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -107,12 +107,12 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_VL_SERVICE) {
 		server->probe.flags |= AFS_VLSERVER_PROBE_IS_YFS;
 		set_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-		addr->service_id = call->service_id;
+		server->service_id = call->service_id;
 	} else {
 		server->probe.flags |= AFS_VLSERVER_PROBE_NOT_YFS;
 		if (!(server->probe.flags & AFS_VLSERVER_PROBE_IS_YFS)) {
 			clear_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-			addr->service_id = call->service_id;
+			server->service_id = call->service_id;
 		}
 	}
 
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 8dea7b56b75a..4bf98a38c3a1 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -149,6 +149,8 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 	call->key = vc->key;
 	call->ret_vldb = entry;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
+	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->service_id = vc->server->service_id;
 
 	/* Marshall the parameters */
 	bp = call->request;
@@ -211,7 +213,7 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		count		= ntohl(*bp);
 
 		nentries = min(nentries, count);
-		alist = afs_alloc_addrlist(nentries, FS_SERVICE);
+		alist = afs_alloc_addrlist(nentries);
 		if (!alist)
 			return -ENOMEM;
 		alist->version = uniquifier;
@@ -288,6 +290,8 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 	call->key = vc->key;
 	call->ret_alist = NULL;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
+	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->service_id = vc->server->service_id;
 
 	/* Marshall the parameters */
 	bp = call->request;
@@ -407,6 +411,8 @@ struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
 	call->key = key;
 	call->vlserver = afs_get_vlserver(server);
 	call->server_index = server_index;
+	call->peer = rxrpc_kernel_get_peer(ac->alist->addrs[ac->index].peer);
+	call->service_id = server->service_id;
 	call->upgrade = true;
 	call->async = true;
 	call->max_lifespan = AFS_PROBE_MAX_LIFESPAN;
@@ -462,7 +468,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		if (call->count > YFS_MAXENDPOINTS)
 			return afs_protocol_error(call, afs_eproto_yvl_fsendpt_num);
 
-		alist = afs_alloc_addrlist(call->count, FS_SERVICE);
+		alist = afs_alloc_addrlist(call->count);
 		if (!alist)
 			return -ENOMEM;
 		alist->version = uniquifier;
@@ -652,6 +658,8 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	call->key = vc->key;
 	call->ret_alist = NULL;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
+	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->service_id = vc->server->service_id;
 
 	/* Marshall the parameters */
 	bp = call->request;
@@ -769,6 +777,8 @@ char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
 	call->key = vc->key;
 	call->ret_str = NULL;
 	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
+	call->peer = rxrpc_kernel_get_peer(vc->ac.alist->addrs[vc->ac.index].peer);
+	call->service_id = vc->server->service_id;
 
 	/* marshall the parameters */
 	bp = call->request;



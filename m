Return-Path: <linux-fsdevel+bounces-2549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0847E6D96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCE11C20B07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C8208CF;
	Thu,  9 Nov 2023 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqM/aN5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A842032A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5135AD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiOMoOghDW2gM6XPwKEA4ljEr/sDx94rT67aZBUvCm8=;
	b=PqM/aN5kAW9BUTDleBPn2h0cdNOAC/NTOMInpAiLH5JRX9wScQySCCyEWF6YhrakX/F2Fj
	Uyg5KTXc8w2z88WYv1PyO30S1h87pQP/ts41ydXV9dNk7li6kRJPKbqBbAUU2O1oUQZRNJ
	O6qau+RuHCAX+D/Rkc4oXjMIkrNTIA8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-NLPRZvp4Neq2WAQGb9NCqA-1; Thu,
 09 Nov 2023 10:40:28 -0500
X-MC-Unique: NLPRZvp4Neq2WAQGb9NCqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED2C02810D6A;
	Thu,  9 Nov 2023 15:40:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECC7D369;
	Thu,  9 Nov 2023 15:40:24 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/41] rxrpc, afs: Allow afs to pin rxrpc_peer objects
Date: Thu,  9 Nov 2023 15:39:33 +0000
Message-ID: <20231109154004.3317227-11-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Change rxrpc's API such that:

 (1) A new function, rxrpc_kernel_lookup_peer(), is provided to look up an
     rxrpc_peer record for a remote address and a corresponding function,
     rxrpc_kernel_put_peer(), is provided to dispose of it again.

 (2) When setting up a call, the rxrpc_peer object used during a call is
     now passed in rather than being set up by rxrpc_connect_call().  For
     afs, this meenat passing it to rxrpc_kernel_begin_call() rather than
     the full address (the service ID then has to be passed in as a
     separate parameter).

 (3) A new function, rxrpc_kernel_remote_addr(), is added so that afs can
     get a pointer to the transport address for display purposed, and
     another, rxrpc_kernel_remote_srx(), to gain a pointer to the full
     rxrpc address.

 (4) The function to retrieve the RTT from a call, rxrpc_kernel_get_srtt(),
     is then altered to take a peer.  This now returns the RTT or -1 if
     there are insufficient samples.

 (5) Rename rxrpc_kernel_get_peer() to rxrpc_kernel_call_get_peer().

 (6) Provide a new function, rxrpc_kernel_get_peer(), to get a ref on a
     peer the caller already has.

This allows the afs filesystem to pin the rxrpc_peer records that it is
using, allowing faster lookups and pointer comparisons rather than
comparing sockaddr_rxrpc contents.  It also makes it easier to get hold of
the RTT.  The following changes are made to afs:

 (1) The addr_list struct's addrs[] elements now hold a peer struct pointer
     and a service ID rather than a sockaddr_rxrpc.

 (2) When displaying the transport address, rxrpc_kernel_remote_addr() is
     used.

 (3) The port arg is removed from afs_alloc_addrlist() since it's always
     overridden.

 (4) afs_merge_fs_addr4() and afs_merge_fs_addr6() do peer lookup and may
     now return an error that must be handled.

 (5) afs_find_server() now takes a peer pointer to specify the address.

 (6) afs_find_server(), afs_compare_fs_alists() and afs_merge_fs_addr[46]{}
     now do peer pointer comparison rather than address comparison.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c           | 125 ++++++++++++++++++-----------------
 fs/afs/cmservice.c           |   5 +-
 fs/afs/fs_probe.c            |  11 +--
 fs/afs/internal.h            |  26 ++++----
 fs/afs/proc.c                |   9 +--
 fs/afs/rotate.c              |   6 +-
 fs/afs/rxrpc.c               |  10 +--
 fs/afs/server.c              |  41 ++----------
 fs/afs/vl_alias.c            |  55 +--------------
 fs/afs/vl_list.c             |  15 +++--
 fs/afs/vl_probe.c            |  12 ++--
 fs/afs/vl_rotate.c           |   6 +-
 fs/afs/vlclient.c            |  22 ++++--
 include/net/af_rxrpc.h       |  15 +++--
 include/trace/events/rxrpc.h |   3 +
 net/rxrpc/af_rxrpc.c         |  62 ++++++++++++++---
 net/rxrpc/ar-internal.h      |   2 +-
 net/rxrpc/call_object.c      |  17 ++---
 net/rxrpc/peer_object.c      |  56 ++++++++++------
 net/rxrpc/sendmsg.c          |  11 ++-
 20 files changed, 271 insertions(+), 238 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index ac05a59e9d46..519821f5aedc 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -13,26 +13,33 @@
 #include "internal.h"
 #include "afs_fs.h"
 
+static void afs_free_addrlist(struct rcu_head *rcu)
+{
+	struct afs_addr_list *alist = container_of(rcu, struct afs_addr_list, rcu);
+	unsigned int i;
+
+	for (i = 0; i < alist->nr_addrs; i++)
+		rxrpc_kernel_put_peer(alist->addrs[i].peer);
+}
+
 /*
  * Release an address list.
  */
 void afs_put_addrlist(struct afs_addr_list *alist)
 {
 	if (alist && refcount_dec_and_test(&alist->usage))
-		kfree_rcu(alist, rcu);
+		call_rcu(&alist->rcu, afs_free_addrlist);
 }
 
 /*
  * Allocate an address list.
  */
-struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
-					 unsigned short service,
-					 unsigned short port)
+struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id)
 {
 	struct afs_addr_list *alist;
 	unsigned int i;
 
-	_enter("%u,%u,%u", nr, service, port);
+	_enter("%u,%u", nr, service_id);
 
 	if (nr > AFS_MAX_ADDRESSES)
 		nr = AFS_MAX_ADDRESSES;
@@ -44,16 +51,8 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
 	refcount_set(&alist->usage, 1);
 	alist->max_addrs = nr;
 
-	for (i = 0; i < nr; i++) {
-		struct sockaddr_rxrpc *srx = &alist->addrs[i].srx;
-		srx->srx_family			= AF_RXRPC;
-		srx->srx_service		= service;
-		srx->transport_type		= SOCK_DGRAM;
-		srx->transport_len		= sizeof(srx->transport.sin6);
-		srx->transport.sin6.sin6_family	= AF_INET6;
-		srx->transport.sin6.sin6_port	= htons(port);
-	}
-
+	for (i = 0; i < nr; i++)
+		alist->addrs[i].service_id = service_id;
 	return alist;
 }
 
@@ -126,7 +125,7 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 	if (!vllist->servers[0].server)
 		goto error_vl;
 
-	alist = afs_alloc_addrlist(nr, service, AFS_VL_PORT);
+	alist = afs_alloc_addrlist(nr, service);
 	if (!alist)
 		goto error;
 
@@ -197,9 +196,11 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 		}
 
 		if (family == AF_INET)
-			afs_merge_fs_addr4(alist, x[0], xport);
+			ret = afs_merge_fs_addr4(net, alist, x[0], xport);
 		else
-			afs_merge_fs_addr6(alist, x, xport);
+			ret = afs_merge_fs_addr6(net, alist, x, xport);
+		if (ret < 0)
+			goto error;
 
 	} while (p < end);
 
@@ -271,25 +272,33 @@ struct afs_vlserver_list *afs_dns_query(struct afs_cell *cell, time64_t *_expiry
 /*
  * Merge an IPv4 entry into a fileserver address list.
  */
-void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
+int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *alist,
+		       __be32 xdr, u16 port)
 {
-	struct sockaddr_rxrpc *srx;
-	u32 addr = ntohl(xdr);
+	struct sockaddr_rxrpc srx;
+	struct rxrpc_peer *peer;
 	int i;
 
 	if (alist->nr_addrs >= alist->max_addrs)
-		return;
+		return 0;
 
-	for (i = 0; i < alist->nr_ipv4; i++) {
-		struct sockaddr_in *a = &alist->addrs[i].srx.transport.sin;
-		u32 a_addr = ntohl(a->sin_addr.s_addr);
-		u16 a_port = ntohs(a->sin_port);
+	srx.srx_family = AF_RXRPC;
+	srx.transport_type = SOCK_DGRAM;
+	srx.transport_len = sizeof(srx.transport.sin);
+	srx.transport.sin.sin_family = AF_INET;
+	srx.transport.sin.sin_port = htons(port);
+	srx.transport.sin.sin_addr.s_addr = xdr;
 
-		if (addr == a_addr && port == a_port)
-			return;
-		if (addr == a_addr && port < a_port)
-			break;
-		if (addr < a_addr)
+	peer = rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
+	if (!peer)
+		return -ENOMEM;
+
+	for (i = 0; i < alist->nr_ipv4; i++) {
+		if (peer == alist->addrs[i].peer) {
+			rxrpc_kernel_put_peer(peer);
+			return 0;
+		}
+		if (peer <= alist->addrs[i].peer)
 			break;
 	}
 
@@ -298,38 +307,42 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	srx = &alist->addrs[i].srx;
-	srx->srx_family = AF_RXRPC;
-	srx->transport_type = SOCK_DGRAM;
-	srx->transport_len = sizeof(srx->transport.sin);
-	srx->transport.sin.sin_family = AF_INET;
-	srx->transport.sin.sin_port = htons(port);
-	srx->transport.sin.sin_addr.s_addr = xdr;
+	alist->addrs[i].peer = peer;
 	alist->nr_ipv4++;
 	alist->nr_addrs++;
+	return 0;
 }
 
 /*
  * Merge an IPv6 entry into a fileserver address list.
  */
-void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
+int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *alist,
+		       __be32 *xdr, u16 port)
 {
-	struct sockaddr_rxrpc *srx;
-	int i, diff;
+	struct sockaddr_rxrpc srx;
+	struct rxrpc_peer *peer;
+	int i;
 
 	if (alist->nr_addrs >= alist->max_addrs)
-		return;
+		return 0;
 
-	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-		struct sockaddr_in6 *a = &alist->addrs[i].srx.transport.sin6;
-		u16 a_port = ntohs(a->sin6_port);
+	srx.srx_family = AF_RXRPC;
+	srx.transport_type = SOCK_DGRAM;
+	srx.transport_len = sizeof(srx.transport.sin6);
+	srx.transport.sin6.sin6_family = AF_INET6;
+	srx.transport.sin6.sin6_port = htons(port);
+	memcpy(&srx.transport.sin6.sin6_addr, xdr, 16);
 
-		diff = memcmp(xdr, &a->sin6_addr, 16);
-		if (diff == 0 && port == a_port)
-			return;
-		if (diff == 0 && port < a_port)
-			break;
-		if (diff < 0)
+	peer = rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
+	if (!peer)
+		return -ENOMEM;
+
+	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
+		if (peer == alist->addrs[i].peer) {
+			rxrpc_kernel_put_peer(peer);
+			return 0;
+		}
+		if (peer <= alist->addrs[i].peer)
 			break;
 	}
 
@@ -337,15 +350,9 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 		memmove(alist->addrs + i + 1,
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
-
-	srx = &alist->addrs[i].srx;
-	srx->srx_family = AF_RXRPC;
-	srx->transport_type = SOCK_DGRAM;
-	srx->transport_len = sizeof(srx->transport.sin6);
-	srx->transport.sin6.sin6_family = AF_INET6;
-	srx->transport.sin6.sin6_port = htons(port);
-	memcpy(&srx->transport.sin6.sin6_addr, xdr, 16);
+	alist->addrs[i].peer = peer;
 	alist->nr_addrs++;
+	return 0;
 }
 
 /*
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index d4ddb20d6732..99a3f20bc786 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -146,10 +146,11 @@ static int afs_find_cm_server_by_peer(struct afs_call *call)
 {
 	struct sockaddr_rxrpc srx;
 	struct afs_server *server;
+	struct rxrpc_peer *peer;
 
-	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
+	peer = rxrpc_kernel_get_call_peer(call->net->socket, call->rxcall);
 
-	server = afs_find_server(call->net, &srx);
+	server = afs_find_server(call->net, peer);
 	if (!server) {
 		trace_afs_cm_no_server(call, &srx);
 		return 0;
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 3dd24842f277..58d28b82571e 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -101,6 +101,7 @@ static void afs_fs_probe_not_done(struct afs_net *net,
 void afs_fileserver_probe_result(struct afs_call *call)
 {
 	struct afs_addr_list *alist = call->alist;
+	struct afs_address *addr = &alist->addrs[call->addr_ix];
 	struct afs_server *server = call->server;
 	unsigned int index = call->addr_ix;
 	unsigned int rtt_us = 0, cap0;
@@ -153,12 +154,12 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_FS_SERVICE) {
 		server->probe.is_yfs = true;
 		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-		alist->addrs[index].srx.srx_service = call->service_id;
+		addr->service_id = call->service_id;
 	} else {
 		server->probe.not_yfs = true;
 		if (!server->probe.is_yfs) {
 			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-			alist->addrs[index].srx.srx_service = call->service_id;
+			addr->service_id = call->service_id;
 		}
 		cap0 = ntohl(call->tmp);
 		if (cap0 & AFS3_VICED_CAPABILITY_64BITFILES)
@@ -167,7 +168,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 			clear_bit(AFS_SERVER_FL_HAS_FS64, &server->flags);
 	}
 
-	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	rtt_us = rxrpc_kernel_get_srtt(addr->peer);
 	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
@@ -181,8 +182,8 @@ void afs_fileserver_probe_result(struct afs_call *call)
 out:
 	spin_unlock(&server->probe_lock);
 
-	_debug("probe %pU [%u] %pISpc rtt=%u ret=%d",
-	       &server->uuid, index, &alist->addrs[index].srx.transport,
+	_debug("probe %pU [%u] %pISpc rtt=%d ret=%d",
+	       &server->uuid, index, rxrpc_kernel_remote_addr(alist->addrs[index].peer),
 	       rtt_us, ret);
 
 	return afs_done_one_fs_probe(call->net, server);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ae874baee249..caf89edc0644 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -72,6 +72,11 @@ enum afs_call_state {
 	AFS_CALL_COMPLETE,		/* Completed or failed */
 };
 
+struct afs_address {
+	struct rxrpc_peer	*peer;
+	u16			service_id;
+};
+
 /*
  * List of server addresses.
  */
@@ -87,9 +92,7 @@ struct afs_addr_list {
 	enum dns_lookup_status	status:8;
 	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
-	struct {
-		struct sockaddr_rxrpc	srx;
-	} addrs[] __counted_by(max_addrs);
+	struct afs_address	addrs[] __counted_by(max_addrs);
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
@@ -420,7 +423,7 @@ struct afs_vlserver {
 	atomic_t		probe_outstanding;
 	spinlock_t		probe_lock;
 	struct {
-		unsigned int	rtt;		/* RTT in uS */
+		unsigned int	rtt;		/* Best RTT in uS (or UINT_MAX) */
 		u32		abort_code;
 		short		error;
 		unsigned short	flags;
@@ -537,7 +540,7 @@ struct afs_server {
 	atomic_t		probe_outstanding;
 	spinlock_t		probe_lock;
 	struct {
-		unsigned int	rtt;		/* RTT in uS */
+		unsigned int	rtt;		/* Best RTT in uS (or UINT_MAX) */
 		u32		abort_code;
 		short		error;
 		bool		responded:1;
@@ -963,9 +966,7 @@ static inline struct afs_addr_list *afs_get_addrlist(struct afs_addr_list *alist
 		refcount_inc(&alist->usage);
 	return alist;
 }
-extern struct afs_addr_list *afs_alloc_addrlist(unsigned int,
-						unsigned short,
-						unsigned short);
+extern struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id);
 extern void afs_put_addrlist(struct afs_addr_list *);
 extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
 						      const char *, size_t, char,
@@ -976,8 +977,10 @@ extern struct afs_vlserver_list *afs_dns_query(struct afs_cell *, time64_t *);
 extern bool afs_iterate_addresses(struct afs_addr_cursor *);
 extern int afs_end_cursor(struct afs_addr_cursor *);
 
-extern void afs_merge_fs_addr4(struct afs_addr_list *, __be32, u16);
-extern void afs_merge_fs_addr6(struct afs_addr_list *, __be32 *, u16);
+extern int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *addr,
+			      __be32 xdr, u16 port);
+extern int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *addr,
+			      __be32 *xdr, u16 port);
 
 /*
  * callback.c
@@ -1404,8 +1407,7 @@ extern void __exit afs_clean_up_permit_cache(void);
  */
 extern spinlock_t afs_server_peer_lock;
 
-extern struct afs_server *afs_find_server(struct afs_net *,
-					  const struct sockaddr_rxrpc *);
+extern struct afs_server *afs_find_server(struct afs_net *, const struct rxrpc_peer *);
 extern struct afs_server *afs_find_server_by_uuid(struct afs_net *, const uuid_t *);
 extern struct afs_server *afs_lookup_server(struct afs_cell *, struct key *, const uuid_t *, u32);
 extern struct afs_server *afs_get_server(struct afs_server *, enum afs_server_trace);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index ab9cd986cfd9..8a65a06908d2 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -307,7 +307,7 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 		for (i = 0; i < alist->nr_addrs; i++)
 			seq_printf(m, " %c %pISpc\n",
 				   alist->preferred == i ? '>' : '-',
-				   &alist->addrs[i].srx.transport);
+				   rxrpc_kernel_remote_addr(alist->addrs[i].peer));
 	}
 	seq_printf(m, " info: fl=%lx rtt=%d\n", vlserver->flags, vlserver->rtt);
 	seq_printf(m, " probe: fl=%x e=%d ac=%d out=%d\n",
@@ -398,9 +398,10 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx\n",
 		   alist->version, alist->responded, alist->failed);
 	for (i = 0; i < alist->nr_addrs; i++)
-		seq_printf(m, "    [%x] %pISpc%s\n",
-			   i, &alist->addrs[i].srx.transport,
-			   alist->preferred == i ? "*" : "");
+		seq_printf(m, "    [%x] %pISpc%s rtt=%d\n",
+			   i, rxrpc_kernel_remote_addr(alist->addrs[i].peer),
+			   alist->preferred == i ? "*" : "",
+			   rxrpc_kernel_get_srtt(alist->addrs[i].peer));
 	return 0;
 }
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 993e20d752d9..1c8f26a7f128 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -113,7 +113,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	struct afs_server *server;
 	struct afs_vnode *vnode = op->file[0].vnode;
 	struct afs_error e;
-	u32 rtt;
+	unsigned int rtt;
 	int error = op->ac.error, i;
 
 	_enter("%lx[%d],%lx[%d],%d,%d",
@@ -419,7 +419,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	}
 
 	op->index = -1;
-	rtt = U32_MAX;
+	rtt = UINT_MAX;
 	for (i = 0; i < op->server_list->nr_servers; i++) {
 		struct afs_server *s = op->server_list->servers[i].server;
 
@@ -487,7 +487,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	_debug("address [%u] %u/%u %pISp",
 	       op->index, op->ac.index, op->ac.alist->nr_addrs,
-	       &op->ac.alist->addrs[op->ac.index].srx.transport);
+	       rxrpc_kernel_remote_addr(op->ac.alist->addrs[op->ac.index].peer));
 
 	_leave(" = t");
 	return true;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 2b1a31b4249c..1a18fcbdec80 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -296,7 +296,8 @@ static void afs_notify_end_request_tx(struct sock *sock,
  */
 void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 {
-	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index].srx;
+	struct afs_address *addr = &ac->alist->addrs[ac->index];
+	struct rxrpc_peer *peer = addr->peer;
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
@@ -304,7 +305,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	s64 tx_total_len;
 	int ret;
 
-	_enter(",{%pISp},", &srx->transport);
+	_enter(",{%pISp},", rxrpc_kernel_remote_addr(addr->peer));
 
 	ASSERT(call->type != NULL);
 	ASSERT(call->type->name != NULL);
@@ -333,7 +334,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	}
 
 	/* create a call */
-	rxcall = rxrpc_kernel_begin_call(call->net->socket, srx, call->key,
+	rxcall = rxrpc_kernel_begin_call(call->net->socket, peer, call->key,
 					 (unsigned long)call,
 					 tx_total_len,
 					 call->max_lifespan,
@@ -341,6 +342,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 					 (call->async ?
 					  afs_wake_up_async_call :
 					  afs_wake_up_call_waiter),
+					 addr->service_id,
 					 call->upgrade,
 					 (call->intr ? RXRPC_PREINTERRUPTIBLE :
 					  RXRPC_UNINTERRUPTIBLE),
@@ -461,7 +463,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 		max = m + 1;
 		pr_notice("kAFS: Peer reported %s failure on %s [%pISp]\n",
 			  msg, call->type->name,
-			  &call->alist->addrs[call->addr_ix].srx.transport);
+			  rxrpc_kernel_remote_addr(call->alist->addrs[call->addr_ix].peer));
 	}
 }
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 4b98788c7b12..831254d8ef9c 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -21,13 +21,12 @@ static void __afs_put_server(struct afs_net *, struct afs_server *);
 /*
  * Find a server by one of its addresses.
  */
-struct afs_server *afs_find_server(struct afs_net *net,
-				   const struct sockaddr_rxrpc *srx)
+struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer *peer)
 {
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq = 0;
 
 	rcu_read_lock();
 
@@ -37,37 +36,11 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		server = NULL;
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
-		if (srx->transport.family == AF_INET6) {
-			const struct sockaddr_in6 *a = &srx->transport.sin6, *b;
-			hlist_for_each_entry_rcu(server, &net->fs_addresses6, addr6_link) {
-				alist = rcu_dereference(server->addresses);
-				for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-					b = &alist->addrs[i].srx.transport.sin6;
-					diff = ((u16 __force)a->sin6_port -
-						(u16 __force)b->sin6_port);
-					if (diff == 0)
-						diff = memcmp(&a->sin6_addr,
-							      &b->sin6_addr,
-							      sizeof(struct in6_addr));
-					if (diff == 0)
-						goto found;
-				}
-			}
-		} else {
-			const struct sockaddr_in *a = &srx->transport.sin, *b;
-			hlist_for_each_entry_rcu(server, &net->fs_addresses4, addr4_link) {
-				alist = rcu_dereference(server->addresses);
-				for (i = 0; i < alist->nr_ipv4; i++) {
-					b = &alist->addrs[i].srx.transport.sin;
-					diff = ((u16 __force)a->sin_port -
-						(u16 __force)b->sin_port);
-					if (diff == 0)
-						diff = ((u32 __force)a->sin_addr.s_addr -
-							(u32 __force)b->sin_addr.s_addr);
-					if (diff == 0)
-						goto found;
-				}
-			}
+		hlist_for_each_entry_rcu(server, &net->fs_addresses6, addr6_link) {
+			alist = rcu_dereference(server->addresses);
+			for (i = 0; i < alist->nr_addrs; i++)
+				if (alist->addrs[i].peer == peer)
+					goto found;
 		}
 
 		server = NULL;
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index d3c0df70a1a5..6fdf9f1bedc0 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -32,55 +32,6 @@ static struct afs_volume *afs_sample_volume(struct afs_cell *cell, struct key *k
 	return volume;
 }
 
-/*
- * Compare two addresses.
- */
-static int afs_compare_addrs(const struct sockaddr_rxrpc *srx_a,
-			     const struct sockaddr_rxrpc *srx_b)
-{
-	short port_a, port_b;
-	int addr_a, addr_b, diff;
-
-	diff = (short)srx_a->transport_type - (short)srx_b->transport_type;
-	if (diff)
-		goto out;
-
-	switch (srx_a->transport_type) {
-	case AF_INET: {
-		const struct sockaddr_in *a = &srx_a->transport.sin;
-		const struct sockaddr_in *b = &srx_b->transport.sin;
-		addr_a = ntohl(a->sin_addr.s_addr);
-		addr_b = ntohl(b->sin_addr.s_addr);
-		diff = addr_a - addr_b;
-		if (diff == 0) {
-			port_a = ntohs(a->sin_port);
-			port_b = ntohs(b->sin_port);
-			diff = port_a - port_b;
-		}
-		break;
-	}
-
-	case AF_INET6: {
-		const struct sockaddr_in6 *a = &srx_a->transport.sin6;
-		const struct sockaddr_in6 *b = &srx_b->transport.sin6;
-		diff = memcmp(&a->sin6_addr, &b->sin6_addr, 16);
-		if (diff == 0) {
-			port_a = ntohs(a->sin6_port);
-			port_b = ntohs(b->sin6_port);
-			diff = port_a - port_b;
-		}
-		break;
-	}
-
-	default:
-		WARN_ON(1);
-		diff = 1;
-	}
-
-out:
-	return diff;
-}
-
 /*
  * Compare the address lists of a pair of fileservers.
  */
@@ -94,9 +45,9 @@ static int afs_compare_fs_alists(const struct afs_server *server_a,
 	lb = rcu_dereference(server_b->addresses);
 
 	while (a < la->nr_addrs && b < lb->nr_addrs) {
-		const struct sockaddr_rxrpc *srx_a = &la->addrs[a].srx;
-		const struct sockaddr_rxrpc *srx_b = &lb->addrs[b].srx;
-		int diff = afs_compare_addrs(srx_a, srx_b);
+		unsigned long pa = (unsigned long)la->addrs[a].peer;
+		unsigned long pb = (unsigned long)lb->addrs[b].peer;
+		long diff = pa - pb;
 
 		if (diff < 0) {
 			a++;
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index acc48216136a..ba89140eee9e 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -83,14 +83,15 @@ static u16 afs_extract_le16(const u8 **_b)
 /*
  * Build a VL server address list from a DNS queried server list.
  */
-static struct afs_addr_list *afs_extract_vl_addrs(const u8 **_b, const u8 *end,
+static struct afs_addr_list *afs_extract_vl_addrs(struct afs_net *net,
+						  const u8 **_b, const u8 *end,
 						  u8 nr_addrs, u16 port)
 {
 	struct afs_addr_list *alist;
 	const u8 *b = *_b;
 	int ret = -EINVAL;
 
-	alist = afs_alloc_addrlist(nr_addrs, VL_SERVICE, port);
+	alist = afs_alloc_addrlist(nr_addrs, VL_SERVICE);
 	if (!alist)
 		return ERR_PTR(-ENOMEM);
 	if (nr_addrs == 0)
@@ -109,7 +110,9 @@ static struct afs_addr_list *afs_extract_vl_addrs(const u8 **_b, const u8 *end,
 				goto error;
 			}
 			memcpy(x, b, 4);
-			afs_merge_fs_addr4(alist, x[0], port);
+			ret = afs_merge_fs_addr4(net, alist, x[0], port);
+			if (ret < 0)
+				goto error;
 			b += 4;
 			break;
 
@@ -119,7 +122,9 @@ static struct afs_addr_list *afs_extract_vl_addrs(const u8 **_b, const u8 *end,
 				goto error;
 			}
 			memcpy(x, b, 16);
-			afs_merge_fs_addr6(alist, x, port);
+			ret = afs_merge_fs_addr6(net, alist, x, port);
+			if (ret < 0)
+				goto error;
 			b += 16;
 			break;
 
@@ -247,7 +252,7 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 		/* Extract the addresses - note that we can't skip this as we
 		 * have to advance the payload pointer.
 		 */
-		addrs = afs_extract_vl_addrs(&b, end, bs.nr_addrs, bs.port);
+		addrs = afs_extract_vl_addrs(cell->net, &b, end, bs.nr_addrs, bs.port);
 		if (IS_ERR(addrs)) {
 			ret = PTR_ERR(addrs);
 			goto error_2;
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index bdd9372e3fb2..9551aef07cee 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -48,6 +48,7 @@ void afs_vlserver_probe_result(struct afs_call *call)
 {
 	struct afs_addr_list *alist = call->alist;
 	struct afs_vlserver *server = call->vlserver;
+	struct afs_address *addr = &alist->addrs[call->addr_ix];
 	unsigned int server_index = call->server_index;
 	unsigned int rtt_us = 0;
 	unsigned int index = call->addr_ix;
@@ -106,16 +107,16 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_VL_SERVICE) {
 		server->probe.flags |= AFS_VLSERVER_PROBE_IS_YFS;
 		set_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-		alist->addrs[index].srx.srx_service = call->service_id;
+		addr->service_id = call->service_id;
 	} else {
 		server->probe.flags |= AFS_VLSERVER_PROBE_NOT_YFS;
 		if (!(server->probe.flags & AFS_VLSERVER_PROBE_IS_YFS)) {
 			clear_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-			alist->addrs[index].srx.srx_service = call->service_id;
+			addr->service_id = call->service_id;
 		}
 	}
 
-	rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us);
+	rtt_us = rxrpc_kernel_get_srtt(addr->peer);
 	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		server->rtt = rtt_us;
@@ -130,8 +131,9 @@ void afs_vlserver_probe_result(struct afs_call *call)
 out:
 	spin_unlock(&server->probe_lock);
 
-	_debug("probe [%u][%u] %pISpc rtt=%u ret=%d",
-	       server_index, index, &alist->addrs[index].srx.transport, rtt_us, ret);
+	_debug("probe [%u][%u] %pISpc rtt=%d ret=%d",
+	       server_index, index, rxrpc_kernel_remote_addr(addr->peer),
+	       rtt_us, ret);
 
 	afs_done_one_vl_probe(server, have_result);
 }
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 0d0b54819128..af445e7d3a12 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -86,7 +86,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	struct afs_addr_list *alist;
 	struct afs_vlserver *vlserver;
 	struct afs_error e;
-	u32 rtt;
+	unsigned int rtt;
 	int error = vc->ac.error, i;
 
 	_enter("%lx[%d],%lx[%d],%d,%d",
@@ -188,7 +188,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 		goto selected_server;
 
 	vc->index = -1;
-	rtt = U32_MAX;
+	rtt = UINT_MAX;
 	for (i = 0; i < vc->server_list->nr_servers; i++) {
 		struct afs_vlserver *s = vc->server_list->servers[i].server;
 
@@ -243,7 +243,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 	_debug("VL address %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
 
-	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].srx.transport);
+	_leave(" = t %pISpc", rxrpc_kernel_remote_addr(vc->ac.alist->addrs[vc->ac.index].peer));
 	return true;
 
 next_server:
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 00fca3c66ba6..41e7932d75c6 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -208,7 +208,7 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		count		= ntohl(*bp);
 
 		nentries = min(nentries, count);
-		alist = afs_alloc_addrlist(nentries, FS_SERVICE, AFS_FS_PORT);
+		alist = afs_alloc_addrlist(nentries, FS_SERVICE);
 		if (!alist)
 			return -ENOMEM;
 		alist->version = uniquifier;
@@ -230,9 +230,13 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		alist = call->ret_alist;
 		bp = call->buffer;
 		count = min(call->count, 4U);
-		for (i = 0; i < count; i++)
-			if (alist->nr_addrs < call->count2)
-				afs_merge_fs_addr4(alist, *bp++, AFS_FS_PORT);
+		for (i = 0; i < count; i++) {
+			if (alist->nr_addrs < call->count2) {
+				ret = afs_merge_fs_addr4(call->net, alist, *bp++, AFS_FS_PORT);
+				if (ret < 0)
+					return ret;
+			}
+		}
 
 		call->count -= count;
 		if (call->count > 0)
@@ -450,7 +454,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		if (call->count > YFS_MAXENDPOINTS)
 			return afs_protocol_error(call, afs_eproto_yvl_fsendpt_num);
 
-		alist = afs_alloc_addrlist(call->count, FS_SERVICE, AFS_FS_PORT);
+		alist = afs_alloc_addrlist(call->count, FS_SERVICE);
 		if (!alist)
 			return -ENOMEM;
 		alist->version = uniquifier;
@@ -488,14 +492,18 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			if (ntohl(bp[0]) != sizeof(__be32) * 2)
 				return afs_protocol_error(
 					call, afs_eproto_yvl_fsendpt4_len);
-			afs_merge_fs_addr4(alist, bp[1], ntohl(bp[2]));
+			ret = afs_merge_fs_addr4(call->net, alist, bp[1], ntohl(bp[2]));
+			if (ret < 0)
+				return ret;
 			bp += 3;
 			break;
 		case YFS_ENDPOINT_IPV6:
 			if (ntohl(bp[0]) != sizeof(__be32) * 5)
 				return afs_protocol_error(
 					call, afs_eproto_yvl_fsendpt6_len);
-			afs_merge_fs_addr6(alist, bp + 1, ntohl(bp[5]));
+			ret = afs_merge_fs_addr6(call->net, alist, bp + 1, ntohl(bp[5]));
+			if (ret < 0)
+				return ret;
 			bp += 6;
 			break;
 		default:
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 5531dd08061e..0754c463224a 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -15,6 +15,7 @@ struct key;
 struct sock;
 struct socket;
 struct rxrpc_call;
+struct rxrpc_peer;
 enum rxrpc_abort_reason;
 
 enum rxrpc_interruptibility {
@@ -41,13 +42,14 @@ void rxrpc_kernel_new_call_notification(struct socket *,
 					rxrpc_notify_new_call_t,
 					rxrpc_discard_new_call_t);
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
-					   struct sockaddr_rxrpc *srx,
+					   struct rxrpc_peer *peer,
 					   struct key *key,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
 					   gfp_t gfp,
 					   rxrpc_notify_rx_t notify_rx,
+					   u16 service_id,
 					   bool upgrade,
 					   enum rxrpc_interruptibility interruptibility,
 					   unsigned int debug_id);
@@ -60,9 +62,14 @@ bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
 			     u32, int, enum rxrpc_abort_reason);
 void rxrpc_kernel_shutdown_call(struct socket *sock, struct rxrpc_call *call);
 void rxrpc_kernel_put_call(struct socket *sock, struct rxrpc_call *call);
-void rxrpc_kernel_get_peer(struct socket *, struct rxrpc_call *,
-			   struct sockaddr_rxrpc *);
-bool rxrpc_kernel_get_srtt(struct socket *, struct rxrpc_call *, u32 *);
+struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct socket *sock,
+					    struct sockaddr_rxrpc *srx, gfp_t gfp);
+void rxrpc_kernel_put_peer(struct rxrpc_peer *peer);
+struct rxrpc_peer *rxrpc_kernel_get_peer(struct rxrpc_peer *peer);
+struct rxrpc_peer *rxrpc_kernel_get_call_peer(struct socket *sock, struct rxrpc_call *call);
+const struct sockaddr_rxrpc *rxrpc_kernel_remote_srx(const struct rxrpc_peer *peer);
+const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer);
+unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *);
 int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
 			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
 			       unsigned int);
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4c53a5ef6257..90a1e39d620e 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -178,7 +178,9 @@
 #define rxrpc_peer_traces \
 	EM(rxrpc_peer_free,			"FREE        ") \
 	EM(rxrpc_peer_get_accept,		"GET accept  ") \
+	EM(rxrpc_peer_get_application,		"GET app     ") \
 	EM(rxrpc_peer_get_bundle,		"GET bundle  ") \
+	EM(rxrpc_peer_get_call,			"GET call    ") \
 	EM(rxrpc_peer_get_client_conn,		"GET cln-conn") \
 	EM(rxrpc_peer_get_input,		"GET input   ") \
 	EM(rxrpc_peer_get_input_error,		"GET inpt-err") \
@@ -187,6 +189,7 @@
 	EM(rxrpc_peer_get_service_conn,		"GET srv-conn") \
 	EM(rxrpc_peer_new_client,		"NEW client  ") \
 	EM(rxrpc_peer_new_prealloc,		"NEW prealloc") \
+	EM(rxrpc_peer_put_application,		"PUT app     ") \
 	EM(rxrpc_peer_put_bundle,		"PUT bundle  ") \
 	EM(rxrpc_peer_put_call,			"PUT call    ") \
 	EM(rxrpc_peer_put_conn,			"PUT conn    ") \
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index fa8aec78f63d..465bfe5eb061 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -258,16 +258,62 @@ static int rxrpc_listen(struct socket *sock, int backlog)
 	return ret;
 }
 
+/**
+ * rxrpc_kernel_lookup_peer - Obtain remote transport endpoint for an address
+ * @sock: The socket through which it will be accessed
+ * @srx: The network address
+ * @gfp: Allocation flags
+ *
+ * Lookup or create a remote transport endpoint record for the specified
+ * address and return it with a ref held.
+ */
+struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct socket *sock,
+					    struct sockaddr_rxrpc *srx, gfp_t gfp)
+{
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	int ret;
+
+	ret = rxrpc_validate_address(rx, srx, sizeof(*srx));
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return rxrpc_lookup_peer(rx->local, srx, gfp);
+}
+EXPORT_SYMBOL(rxrpc_kernel_lookup_peer);
+
+/**
+ * rxrpc_kernel_get_peer - Get a reference on a peer
+ * @peer: The peer to get a reference on.
+ *
+ * Get a record for the remote peer in a call.
+ */
+struct rxrpc_peer *rxrpc_kernel_get_peer(struct rxrpc_peer *peer)
+{
+	return peer ? rxrpc_get_peer(peer, rxrpc_peer_get_application) : NULL;
+}
+EXPORT_SYMBOL(rxrpc_kernel_get_peer);
+
+/**
+ * rxrpc_kernel_put_peer - Allow a kernel app to drop a peer reference
+ * @peer: The peer to drop a ref on
+ */
+void rxrpc_kernel_put_peer(struct rxrpc_peer *peer)
+{
+	rxrpc_put_peer(peer, rxrpc_peer_put_application);
+}
+EXPORT_SYMBOL(rxrpc_kernel_put_peer);
+
 /**
  * rxrpc_kernel_begin_call - Allow a kernel service to begin a call
  * @sock: The socket on which to make the call
- * @srx: The address of the peer to contact
+ * @peer: The peer to contact
  * @key: The security context to use (defaults to socket setting)
  * @user_call_ID: The ID to use
  * @tx_total_len: Total length of data to transmit during the call (or -1)
  * @hard_timeout: The maximum lifespan of the call in sec
  * @gfp: The allocation constraints
  * @notify_rx: Where to send notifications instead of socket queue
+ * @service_id: The ID of the service to contact
  * @upgrade: Request service upgrade for call
  * @interruptibility: The call is interruptible, or can be canceled.
  * @debug_id: The debug ID for tracing to be assigned to the call
@@ -280,13 +326,14 @@ static int rxrpc_listen(struct socket *sock, int backlog)
  * supplying @srx and @key.
  */
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
-					   struct sockaddr_rxrpc *srx,
+					   struct rxrpc_peer *peer,
 					   struct key *key,
 					   unsigned long user_call_ID,
 					   s64 tx_total_len,
 					   u32 hard_timeout,
 					   gfp_t gfp,
 					   rxrpc_notify_rx_t notify_rx,
+					   u16 service_id,
 					   bool upgrade,
 					   enum rxrpc_interruptibility interruptibility,
 					   unsigned int debug_id)
@@ -295,13 +342,11 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 	struct rxrpc_call_params p;
 	struct rxrpc_call *call;
 	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	int ret;
 
 	_enter(",,%x,%lx", key_serial(key), user_call_ID);
 
-	ret = rxrpc_validate_address(rx, srx, sizeof(*srx));
-	if (ret < 0)
-		return ERR_PTR(ret);
+	if (WARN_ON_ONCE(peer->local != rx->local))
+		return ERR_PTR(-EIO);
 
 	lock_sock(&rx->sk);
 
@@ -319,12 +364,13 @@ struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
+	cp.peer			= peer;
 	cp.key			= key;
 	cp.security_level	= rx->min_sec_level;
 	cp.exclusive		= false;
 	cp.upgrade		= upgrade;
-	cp.service_id		= srx->srx_service;
-	call = rxrpc_new_client_call(rx, &cp, srx, &p, gfp, debug_id);
+	cp.service_id		= service_id;
+	call = rxrpc_new_client_call(rx, &cp, &p, gfp, debug_id);
 	/* The socket has been unlocked. */
 	if (!IS_ERR(call)) {
 		call->notify_rx = notify_rx;
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index e8e14c6f904d..8eea7a487380 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -364,6 +364,7 @@ struct rxrpc_conn_proto {
 
 struct rxrpc_conn_parameters {
 	struct rxrpc_local	*local;		/* Representation of local endpoint */
+	struct rxrpc_peer	*peer;		/* Representation of remote endpoint */
 	struct key		*key;		/* Security details */
 	bool			exclusive;	/* T if conn is exclusive */
 	bool			upgrade;	/* T if service ID can be upgraded */
@@ -867,7 +868,6 @@ struct rxrpc_call *rxrpc_find_call_by_user_ID(struct rxrpc_sock *, unsigned long
 struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *, gfp_t, unsigned int);
 struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *,
 					 struct rxrpc_conn_parameters *,
-					 struct sockaddr_rxrpc *,
 					 struct rxrpc_call_params *, gfp_t,
 					 unsigned int);
 void rxrpc_start_call_timer(struct rxrpc_call *call);
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 773eecd1e979..beea25ac88f5 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -193,7 +193,6 @@ struct rxrpc_call *rxrpc_alloc_call(struct rxrpc_sock *rx, gfp_t gfp,
  * Allocate a new client call.
  */
 static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
-						  struct sockaddr_rxrpc *srx,
 						  struct rxrpc_conn_parameters *cp,
 						  struct rxrpc_call_params *p,
 						  gfp_t gfp,
@@ -211,10 +210,12 @@ static struct rxrpc_call *rxrpc_alloc_client_call(struct rxrpc_sock *rx,
 	now = ktime_get_real();
 	call->acks_latest_ts	= now;
 	call->cong_tstamp	= now;
-	call->dest_srx		= *srx;
+	call->dest_srx		= cp->peer->srx;
+	call->dest_srx.srx_service = cp->service_id;
 	call->interruptibility	= p->interruptibility;
 	call->tx_total_len	= p->tx_total_len;
 	call->key		= key_get(cp->key);
+	call->peer		= rxrpc_get_peer(cp->peer, rxrpc_peer_get_call);
 	call->local		= rxrpc_get_local(cp->local, rxrpc_local_get_call);
 	call->security_level	= cp->security_level;
 	if (p->kernel)
@@ -306,10 +307,6 @@ static int rxrpc_connect_call(struct rxrpc_call *call, gfp_t gfp)
 
 	_enter("{%d,%lx},", call->debug_id, call->user_call_ID);
 
-	call->peer = rxrpc_lookup_peer(local, &call->dest_srx, gfp);
-	if (!call->peer)
-		goto error;
-
 	ret = rxrpc_look_up_bundle(call, gfp);
 	if (ret < 0)
 		goto error;
@@ -334,7 +331,6 @@ static int rxrpc_connect_call(struct rxrpc_call *call, gfp_t gfp)
  */
 struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 					 struct rxrpc_conn_parameters *cp,
-					 struct sockaddr_rxrpc *srx,
 					 struct rxrpc_call_params *p,
 					 gfp_t gfp,
 					 unsigned int debug_id)
@@ -349,13 +345,18 @@ struct rxrpc_call *rxrpc_new_client_call(struct rxrpc_sock *rx,
 
 	_enter("%p,%lx", rx, p->user_call_ID);
 
+	if (WARN_ON_ONCE(!cp->peer)) {
+		release_sock(&rx->sk);
+		return ERR_PTR(-EIO);
+	}
+
 	limiter = rxrpc_get_call_slot(p, gfp);
 	if (!limiter) {
 		release_sock(&rx->sk);
 		return ERR_PTR(-ERESTARTSYS);
 	}
 
-	call = rxrpc_alloc_client_call(rx, srx, cp, p, gfp, debug_id);
+	call = rxrpc_alloc_client_call(rx, cp, p, gfp, debug_id);
 	if (IS_ERR(call)) {
 		release_sock(&rx->sk);
 		up(limiter);
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 8d7a715a0bb1..65ea57b427a1 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -22,6 +22,8 @@
 #include <net/ip6_route.h>
 #include "ar-internal.h"
 
+static const struct sockaddr_rxrpc rxrpc_null_addr;
+
 /*
  * Hash a peer key.
  */
@@ -457,39 +459,51 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
 }
 
 /**
- * rxrpc_kernel_get_peer - Get the peer address of a call
+ * rxrpc_kernel_get_call_peer - Get the peer address of a call
  * @sock: The socket on which the call is in progress.
  * @call: The call to query
- * @_srx: Where to place the result
  *
- * Get the address of the remote peer in a call.
+ * Get a record for the remote peer in a call.
  */
-void rxrpc_kernel_get_peer(struct socket *sock, struct rxrpc_call *call,
-			   struct sockaddr_rxrpc *_srx)
+struct rxrpc_peer *rxrpc_kernel_get_call_peer(struct socket *sock, struct rxrpc_call *call)
 {
-	*_srx = call->peer->srx;
+	return call->peer;
 }
-EXPORT_SYMBOL(rxrpc_kernel_get_peer);
+EXPORT_SYMBOL(rxrpc_kernel_get_call_peer);
 
 /**
  * rxrpc_kernel_get_srtt - Get a call's peer smoothed RTT
- * @sock: The socket on which the call is in progress.
- * @call: The call to query
- * @_srtt: Where to store the SRTT value.
+ * @peer: The peer to query
  *
- * Get the call's peer smoothed RTT in uS.
+ * Get the call's peer smoothed RTT in uS or UINT_MAX if we have no samples.
  */
-bool rxrpc_kernel_get_srtt(struct socket *sock, struct rxrpc_call *call,
-			   u32 *_srtt)
+unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *peer)
 {
-	struct rxrpc_peer *peer = call->peer;
+	return peer->rtt_count > 0 ? peer->srtt_us >> 3 : UINT_MAX;
+}
+EXPORT_SYMBOL(rxrpc_kernel_get_srtt);
 
-	if (peer->rtt_count == 0) {
-		*_srtt = 1000000; /* 1S */
-		return false;
-	}
+/**
+ * rxrpc_kernel_remote_srx - Get the address of a peer
+ * @peer: The peer to query
+ *
+ * Get a pointer to the address from a peer record.  The caller is responsible
+ * for making sure that the address is not deallocated.
+ */
+const struct sockaddr_rxrpc *rxrpc_kernel_remote_srx(const struct rxrpc_peer *peer)
+{
+	return peer ? &peer->srx : &rxrpc_null_addr;
+}
 
-	*_srtt = call->peer->srtt_us >> 3;
-	return true;
+/**
+ * rxrpc_kernel_remote_addr - Get the peer transport address of a call
+ * @peer: The peer to query
+ *
+ * Get a pointer to the transport address from a peer record.  The caller is
+ * responsible for making sure that the address is not deallocated.
+ */
+const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer)
+{
+	return (const struct sockaddr *)
+		(peer ? &peer->srx.transport : &rxrpc_null_addr.transport);
 }
-EXPORT_SYMBOL(rxrpc_kernel_get_srtt);
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 8e0b94714e84..5677d5690a02 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -572,6 +572,7 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 	__acquires(&call->user_mutex)
 {
 	struct rxrpc_conn_parameters cp;
+	struct rxrpc_peer *peer;
 	struct rxrpc_call *call;
 	struct key *key;
 
@@ -584,21 +585,29 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 		return ERR_PTR(-EDESTADDRREQ);
 	}
 
+	peer = rxrpc_lookup_peer(rx->local, srx, GFP_KERNEL);
+	if (!peer) {
+		release_sock(&rx->sk);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	key = rx->key;
 	if (key && !rx->key->payload.data[0])
 		key = NULL;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
+	cp.peer			= peer;
 	cp.key			= rx->key;
 	cp.security_level	= rx->min_sec_level;
 	cp.exclusive		= rx->exclusive | p->exclusive;
 	cp.upgrade		= p->upgrade;
 	cp.service_id		= srx->srx_service;
-	call = rxrpc_new_client_call(rx, &cp, srx, &p->call, GFP_KERNEL,
+	call = rxrpc_new_client_call(rx, &cp, &p->call, GFP_KERNEL,
 				     atomic_inc_return(&rxrpc_debug_id));
 	/* The socket is now unlocked */
 
+	rxrpc_put_peer(peer, rxrpc_peer_put_application);
 	_leave(" = %p\n", call);
 	return call;
 }



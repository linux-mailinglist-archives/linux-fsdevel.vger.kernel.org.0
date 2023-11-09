Return-Path: <linux-fsdevel+bounces-2552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53587E6D99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856E6B213A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C78C210EE;
	Thu,  9 Nov 2023 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5Xn8ApT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D60208BF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C535B3
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4dlVXYR/OgzB3q7/OE1N/xSxZH+6vZOrVIrcXebDLQ=;
	b=J5Xn8ApTNs8Dn/01xa8AGCV5vsQ6P89/ljBK+9xx5aeU1/ov2qlcmR4ZyMNG3ZRoShzg0u
	y9oJ+P/zQj5iVlsNscxb6g0RidWr+QJHmyv8SPXdXmB/rkWsV0Ulk3U5VTxcRX+MzUtN3B
	fAXYiSxRCVwqqSGRg5+yXzhAQPio3Hw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-1a4l3n0AN-WsaI0UhynKUA-1; Thu, 09 Nov 2023 10:40:29 -0500
X-MC-Unique: 1a4l3n0AN-WsaI0UhynKUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 511028FA222;
	Thu,  9 Nov 2023 15:40:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 700FF492BFA;
	Thu,  9 Nov 2023 15:40:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/41] afs: Turn the afs_addr_list address array into an array of structs
Date: Thu,  9 Nov 2023 15:39:32 +0000
Message-ID: <20231109154004.3317227-10-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Turn the afs_addr_list address array into an array of structs, thereby
allowing per-address (such as RTT) info to be added.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c | 10 +++++-----
 fs/afs/fs_probe.c  |  6 +++---
 fs/afs/internal.h  |  6 +++++-
 fs/afs/proc.c      |  4 ++--
 fs/afs/rotate.c    |  2 +-
 fs/afs/rxrpc.c     |  4 ++--
 fs/afs/server.c    |  4 ++--
 fs/afs/vl_alias.c  |  4 ++--
 fs/afs/vl_probe.c  |  6 +++---
 fs/afs/vl_rotate.c |  2 +-
 10 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index de1ae0bead3b..ac05a59e9d46 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -45,7 +45,7 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr,
 	alist->max_addrs = nr;
 
 	for (i = 0; i < nr; i++) {
-		struct sockaddr_rxrpc *srx = &alist->addrs[i];
+		struct sockaddr_rxrpc *srx = &alist->addrs[i].srx;
 		srx->srx_family			= AF_RXRPC;
 		srx->srx_service		= service;
 		srx->transport_type		= SOCK_DGRAM;
@@ -281,7 +281,7 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 		return;
 
 	for (i = 0; i < alist->nr_ipv4; i++) {
-		struct sockaddr_in *a = &alist->addrs[i].transport.sin;
+		struct sockaddr_in *a = &alist->addrs[i].srx.transport.sin;
 		u32 a_addr = ntohl(a->sin_addr.s_addr);
 		u16 a_port = ntohs(a->sin_port);
 
@@ -298,7 +298,7 @@ void afs_merge_fs_addr4(struct afs_addr_list *alist, __be32 xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	srx = &alist->addrs[i];
+	srx = &alist->addrs[i].srx;
 	srx->srx_family = AF_RXRPC;
 	srx->transport_type = SOCK_DGRAM;
 	srx->transport_len = sizeof(srx->transport.sin);
@@ -321,7 +321,7 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 		return;
 
 	for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-		struct sockaddr_in6 *a = &alist->addrs[i].transport.sin6;
+		struct sockaddr_in6 *a = &alist->addrs[i].srx.transport.sin6;
 		u16 a_port = ntohs(a->sin6_port);
 
 		diff = memcmp(xdr, &a->sin6_addr, 16);
@@ -338,7 +338,7 @@ void afs_merge_fs_addr6(struct afs_addr_list *alist, __be32 *xdr, u16 port)
 			alist->addrs + i,
 			sizeof(alist->addrs[0]) * (alist->nr_addrs - i));
 
-	srx = &alist->addrs[i];
+	srx = &alist->addrs[i].srx;
 	srx->srx_family = AF_RXRPC;
 	srx->transport_type = SOCK_DGRAM;
 	srx->transport_len = sizeof(srx->transport.sin6);
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index daaf3810cc92..3dd24842f277 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -153,12 +153,12 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_FS_SERVICE) {
 		server->probe.is_yfs = true;
 		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-		alist->addrs[index].srx_service = call->service_id;
+		alist->addrs[index].srx.srx_service = call->service_id;
 	} else {
 		server->probe.not_yfs = true;
 		if (!server->probe.is_yfs) {
 			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
-			alist->addrs[index].srx_service = call->service_id;
+			alist->addrs[index].srx.srx_service = call->service_id;
 		}
 		cap0 = ntohl(call->tmp);
 		if (cap0 & AFS3_VICED_CAPABILITY_64BITFILES)
@@ -182,7 +182,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	spin_unlock(&server->probe_lock);
 
 	_debug("probe %pU [%u] %pISpc rtt=%u ret=%d",
-	       &server->uuid, index, &alist->addrs[index].transport,
+	       &server->uuid, index, &alist->addrs[index].srx.transport,
 	       rtt_us, ret);
 
 	return afs_done_one_fs_probe(call->net, server);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5041eae64423..ae874baee249 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -87,7 +87,9 @@ struct afs_addr_list {
 	enum dns_lookup_status	status:8;
 	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
-	struct sockaddr_rxrpc	addrs[];
+	struct {
+		struct sockaddr_rxrpc	srx;
+	} addrs[] __counted_by(max_addrs);
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
 };
 
@@ -968,6 +970,8 @@ extern void afs_put_addrlist(struct afs_addr_list *);
 extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
 						      const char *, size_t, char,
 						      unsigned short, unsigned short);
+bool afs_addr_list_same(const struct afs_addr_list *a,
+			const struct afs_addr_list *b);
 extern struct afs_vlserver_list *afs_dns_query(struct afs_cell *, time64_t *);
 extern bool afs_iterate_addresses(struct afs_addr_cursor *);
 extern int afs_end_cursor(struct afs_addr_cursor *);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 2a0c83d71565..ab9cd986cfd9 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -307,7 +307,7 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 		for (i = 0; i < alist->nr_addrs; i++)
 			seq_printf(m, " %c %pISpc\n",
 				   alist->preferred == i ? '>' : '-',
-				   &alist->addrs[i].transport);
+				   &alist->addrs[i].srx.transport);
 	}
 	seq_printf(m, " info: fl=%lx rtt=%d\n", vlserver->flags, vlserver->rtt);
 	seq_printf(m, " probe: fl=%x e=%d ac=%d out=%d\n",
@@ -399,7 +399,7 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   alist->version, alist->responded, alist->failed);
 	for (i = 0; i < alist->nr_addrs; i++)
 		seq_printf(m, "    [%x] %pISpc%s\n",
-			   i, &alist->addrs[i].transport,
+			   i, &alist->addrs[i].srx.transport,
 			   alist->preferred == i ? "*" : "");
 	return 0;
 }
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 180bcad081dd..993e20d752d9 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -487,7 +487,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 	_debug("address [%u] %u/%u %pISp",
 	       op->index, op->ac.index, op->ac.alist->nr_addrs,
-	       &op->ac.alist->addrs[op->ac.index].transport);
+	       &op->ac.alist->addrs[op->ac.index].srx.transport);
 
 	_leave(" = t");
 	return true;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index ed1644e7683f..2b1a31b4249c 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -296,7 +296,7 @@ static void afs_notify_end_request_tx(struct sock *sock,
  */
 void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 {
-	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index];
+	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index].srx;
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
@@ -461,7 +461,7 @@ static void afs_log_error(struct afs_call *call, s32 remote_abort)
 		max = m + 1;
 		pr_notice("kAFS: Peer reported %s failure on %s [%pISp]\n",
 			  msg, call->type->name,
-			  &call->alist->addrs[call->addr_ix].transport);
+			  &call->alist->addrs[call->addr_ix].srx.transport);
 	}
 }
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index b5237206eac3..4b98788c7b12 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -42,7 +42,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 			hlist_for_each_entry_rcu(server, &net->fs_addresses6, addr6_link) {
 				alist = rcu_dereference(server->addresses);
 				for (i = alist->nr_ipv4; i < alist->nr_addrs; i++) {
-					b = &alist->addrs[i].transport.sin6;
+					b = &alist->addrs[i].srx.transport.sin6;
 					diff = ((u16 __force)a->sin6_port -
 						(u16 __force)b->sin6_port);
 					if (diff == 0)
@@ -58,7 +58,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 			hlist_for_each_entry_rcu(server, &net->fs_addresses4, addr4_link) {
 				alist = rcu_dereference(server->addresses);
 				for (i = 0; i < alist->nr_ipv4; i++) {
-					b = &alist->addrs[i].transport.sin;
+					b = &alist->addrs[i].srx.transport.sin;
 					diff = ((u16 __force)a->sin_port -
 						(u16 __force)b->sin_port);
 					if (diff == 0)
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index f04a80e4f5c3..d3c0df70a1a5 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -94,8 +94,8 @@ static int afs_compare_fs_alists(const struct afs_server *server_a,
 	lb = rcu_dereference(server_b->addresses);
 
 	while (a < la->nr_addrs && b < lb->nr_addrs) {
-		const struct sockaddr_rxrpc *srx_a = &la->addrs[a];
-		const struct sockaddr_rxrpc *srx_b = &lb->addrs[b];
+		const struct sockaddr_rxrpc *srx_a = &la->addrs[a].srx;
+		const struct sockaddr_rxrpc *srx_b = &lb->addrs[b].srx;
 		int diff = afs_compare_addrs(srx_a, srx_b);
 
 		if (diff < 0) {
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 58452b86e672..bdd9372e3fb2 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -106,12 +106,12 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	if (call->service_id == YFS_VL_SERVICE) {
 		server->probe.flags |= AFS_VLSERVER_PROBE_IS_YFS;
 		set_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-		alist->addrs[index].srx_service = call->service_id;
+		alist->addrs[index].srx.srx_service = call->service_id;
 	} else {
 		server->probe.flags |= AFS_VLSERVER_PROBE_NOT_YFS;
 		if (!(server->probe.flags & AFS_VLSERVER_PROBE_IS_YFS)) {
 			clear_bit(AFS_VLSERVER_FL_IS_YFS, &server->flags);
-			alist->addrs[index].srx_service = call->service_id;
+			alist->addrs[index].srx.srx_service = call->service_id;
 		}
 	}
 
@@ -131,7 +131,7 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	spin_unlock(&server->probe_lock);
 
 	_debug("probe [%u][%u] %pISpc rtt=%u ret=%d",
-	       server_index, index, &alist->addrs[index].transport, rtt_us, ret);
+	       server_index, index, &alist->addrs[index].srx.transport, rtt_us, ret);
 
 	afs_done_one_vl_probe(server, have_result);
 }
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 488e58490b16..0d0b54819128 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -243,7 +243,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 
 	_debug("VL address %d/%d", vc->ac.index, vc->ac.alist->nr_addrs);
 
-	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].transport);
+	_leave(" = t %pISpc", &vc->ac.alist->addrs[vc->ac.index].srx.transport);
 	return true;
 
 next_server:



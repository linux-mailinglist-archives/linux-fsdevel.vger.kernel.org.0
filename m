Return-Path: <linux-fsdevel+bounces-2559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672407E6DA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1819B20F58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA2208DD;
	Thu,  9 Nov 2023 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I38sIzO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEE208C7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895E3841
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGUWEf6H7ens+x0vrpV7xBYyqdyHqNsvY2MABBuYEGs=;
	b=I38sIzO3CMWAMSI0NeLcVv2HuORle8GcvGvyouxnsR/alZ1gDJw74KfDTI7mQBF2lWfhkP
	5G7LhLLnaz4A0KMhvKe0fEQWLIMt+dGLdHAbqZLVegLwzUFMbGHLyziBhcjoL0gp72r5d6
	YLaWDBSSuQGSJc6wiBspvJObD+TYk94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-hRH914KwNTevW0KhJr1vmg-1; Thu, 09 Nov 2023 10:40:47 -0500
X-MC-Unique: hRH914KwNTevW0KhJr1vmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE53984AF87;
	Thu,  9 Nov 2023 15:40:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFAC919E99;
	Thu,  9 Nov 2023 15:40:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/41] afs: Add a tracepoint for struct afs_addr_list
Date: Thu,  9 Nov 2023 15:39:42 +0000
Message-ID: <20231109154004.3317227-20-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add a tracepoint to track the lifetime of the afs_addr_list struct.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c         | 33 ++++++++++++++++++++++----
 fs/afs/fs_probe.c          |  4 ++--
 fs/afs/internal.h          | 10 +++-----
 fs/afs/rotate.c            |  4 ++--
 fs/afs/rxrpc.c             |  4 ++--
 fs/afs/server.c            |  9 ++++----
 fs/afs/vl_list.c           | 11 +++++----
 fs/afs/vl_rotate.c         |  9 ++------
 fs/afs/vlclient.c          |  4 ++--
 include/trace/events/afs.h | 47 ++++++++++++++++++++++++++++++++++++++
 10 files changed, 100 insertions(+), 35 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index a1f3c995e328..41ef0c879239 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -20,17 +20,39 @@ static void afs_free_addrlist(struct rcu_head *rcu)
 
 	for (i = 0; i < alist->nr_addrs; i++)
 		rxrpc_kernel_put_peer(alist->addrs[i].peer);
+	trace_afs_alist(alist->debug_id, refcount_read(&alist->usage), afs_alist_trace_free);
+	kfree(alist);
 }
 
 /*
  * Release an address list.
  */
-void afs_put_addrlist(struct afs_addr_list *alist)
+void afs_put_addrlist(struct afs_addr_list *alist, enum afs_alist_trace reason)
 {
-	if (alist && refcount_dec_and_test(&alist->usage))
+	unsigned int debug_id;
+	bool dead;
+	int r;
+
+	if (!alist)
+		return;
+	debug_id = alist->debug_id;
+	dead = __refcount_dec_and_test(&alist->usage, &r);
+	trace_afs_alist(debug_id, r - 1, reason);
+	if (dead)
 		call_rcu(&alist->rcu, afs_free_addrlist);
 }
 
+struct afs_addr_list *afs_get_addrlist(struct afs_addr_list *alist, enum afs_alist_trace reason)
+{
+	int r;
+
+	if (alist) {
+		__refcount_inc(&alist->usage, &r);
+		trace_afs_alist(alist->debug_id, r + 1, reason);
+	}
+	return alist;
+}
+
 /*
  * Allocate an address list.
  */
@@ -38,6 +60,7 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id)
 {
 	struct afs_addr_list *alist;
 	unsigned int i;
+	static atomic_t debug_id;
 
 	_enter("%u,%u", nr, service_id);
 
@@ -50,9 +73,11 @@ struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id)
 
 	refcount_set(&alist->usage, 1);
 	alist->max_addrs = nr;
+	alist->debug_id = atomic_inc_return(&debug_id);
 
 	for (i = 0; i < nr; i++)
 		alist->addrs[i].service_id = service_id;
+	trace_afs_alist(alist->debug_id, 1, afs_alist_trace_alloc);
 	return alist;
 }
 
@@ -217,7 +242,7 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 	       problem, p - text, (int)len, (int)len, text);
 	ret = -EINVAL;
 error:
-	afs_put_addrlist(alist);
+	afs_put_addrlist(alist, afs_alist_trace_put_parse_error);
 error_vl:
 	afs_put_vlserverlist(net, vllist);
 	return ERR_PTR(ret);
@@ -403,7 +428,7 @@ void afs_end_cursor(struct afs_addr_cursor *ac)
 		    ac->index != alist->preferred &&
 		    test_bit(ac->alist->preferred, &ac->tried))
 			WRITE_ONCE(alist->preferred, ac->index);
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_end_cursor);
 		ac->alist = NULL;
 	}
 }
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index fbb91ad775b9..18891492c0b4 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -205,7 +205,7 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	read_lock(&server->fs_lock);
 	ac.alist = rcu_dereference_protected(server->addresses,
 					     lockdep_is_held(&server->fs_lock));
-	afs_get_addrlist(ac.alist);
+	afs_get_addrlist(ac.alist, afs_alist_trace_get_probe);
 	read_unlock(&server->fs_lock);
 
 	server->probed_at = jiffies;
@@ -226,7 +226,7 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 			afs_fs_probe_not_done(net, server, &ac);
 	}
 
-	afs_put_addrlist(ac.alist);
+	afs_put_addrlist(ac.alist, afs_alist_trace_put_probe);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c5b9814e765a..d5a26cea2358 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -85,6 +85,7 @@ struct afs_addr_list {
 	struct rcu_head		rcu;
 	refcount_t		usage;
 	u32			version;	/* Version */
+	unsigned int		debug_id;
 	unsigned char		max_addrs;
 	unsigned char		nr_addrs;
 	unsigned char		preferred;	/* Preferred address */
@@ -968,14 +969,9 @@ static inline bool afs_is_folio_dirty_mmapped(unsigned long priv)
 /*
  * addr_list.c
  */
-static inline struct afs_addr_list *afs_get_addrlist(struct afs_addr_list *alist)
-{
-	if (alist)
-		refcount_inc(&alist->usage);
-	return alist;
-}
+struct afs_addr_list *afs_get_addrlist(struct afs_addr_list *alist, enum afs_alist_trace reason);
 extern struct afs_addr_list *afs_alloc_addrlist(unsigned int nr, u16 service_id);
-extern void afs_put_addrlist(struct afs_addr_list *);
+extern void afs_put_addrlist(struct afs_addr_list *alist, enum afs_alist_trace reason);
 extern struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *,
 						      const char *, size_t, char,
 						      unsigned short, unsigned short);
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a9d9b99b441f..1767c6e67184 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -482,7 +482,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	read_lock(&server->fs_lock);
 	alist = rcu_dereference_protected(server->addresses,
 					  lockdep_is_held(&server->fs_lock));
-	afs_get_addrlist(alist);
+	afs_get_addrlist(alist, afs_alist_trace_get_fsrotate_set);
 	read_unlock(&server->fs_lock);
 
 retry_server:
@@ -491,7 +491,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (!op->ac.alist)
 		op->ac.alist = alist;
 	else
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_retry_server);
 
 	op->ac.index = -1;
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 7408513e24d7..ede7ab4b5dfe 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -187,7 +187,7 @@ void afs_put_call(struct afs_call *call)
 			call->type->destructor(call);
 
 		afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
-		afs_put_addrlist(call->alist);
+		afs_put_addrlist(call->alist, afs_alist_trace_put_call);
 		kfree(call->request);
 
 		trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
@@ -315,7 +315,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	       atomic_read(&call->net->nr_outstanding_calls));
 
 	call->addr_ix = ac->index;
-	call->alist = afs_get_addrlist(ac->alist);
+	call->alist = afs_get_addrlist(ac->alist, afs_alist_trace_get_make_call);
 
 	/* Work out the length we're going to transmit.  This is awkward for
 	 * calls such as FS.StoreData where there's an extra injection of data
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 6a773dcbbf2d..e4c369132935 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -274,13 +274,13 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 
 	candidate = afs_alloc_server(cell, uuid, alist);
 	if (!candidate) {
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_server_oom);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	server = afs_install_server(cell, candidate);
 	if (server != candidate) {
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_server_dup);
 		kfree(candidate);
 	} else {
 		/* Immediately dispatch an asynchronous probe to each interface
@@ -420,7 +420,8 @@ static void afs_server_rcu(struct rcu_head *rcu)
 
 	trace_afs_server(server->debug_id, refcount_read(&server->ref),
 			 atomic_read(&server->active), afs_server_trace_free);
-	afs_put_addrlist(rcu_access_pointer(server->addresses));
+	afs_put_addrlist(rcu_access_pointer(server->addresses),
+			 afs_alist_trace_put_server);
 	kfree(server);
 }
 
@@ -642,7 +643,7 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 		write_unlock(&server->fs_lock);
 	}
 
-	afs_put_addrlist(discard);
+	afs_put_addrlist(discard, afs_alist_trace_put_server_update);
 	_leave(" = t");
 	return true;
 }
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index ba89140eee9e..3a2875933261 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -33,7 +33,8 @@ static void afs_vlserver_rcu(struct rcu_head *rcu)
 {
 	struct afs_vlserver *vlserver = container_of(rcu, struct afs_vlserver, rcu);
 
-	afs_put_addrlist(rcu_access_pointer(vlserver->addresses));
+	afs_put_addrlist(rcu_access_pointer(vlserver->addresses),
+			 afs_alist_trace_put_vlserver);
 	kfree_rcu(vlserver, rcu);
 }
 
@@ -145,7 +146,7 @@ static struct afs_addr_list *afs_extract_vl_addrs(struct afs_net *net,
 
 error:
 	*_b = b;
-	afs_put_addrlist(alist);
+	afs_put_addrlist(alist, afs_alist_trace_put_parse_error);
 	return ERR_PTR(ret);
 }
 
@@ -260,7 +261,7 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 
 		if (vllist->nr_servers >= nr_servers) {
 			_debug("skip %u >= %u", vllist->nr_servers, nr_servers);
-			afs_put_addrlist(addrs);
+			afs_put_addrlist(addrs, afs_alist_trace_put_parse_empty);
 			afs_put_vlserver(cell->net, server);
 			continue;
 		}
@@ -269,7 +270,7 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 		addrs->status = bs.status;
 
 		if (addrs->nr_addrs == 0) {
-			afs_put_addrlist(addrs);
+			afs_put_addrlist(addrs, afs_alist_trace_put_parse_empty);
 			if (!rcu_access_pointer(server->addresses)) {
 				afs_put_vlserver(cell->net, server);
 				continue;
@@ -281,7 +282,7 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 			old = rcu_replace_pointer(server->addresses, old,
 						  lockdep_is_held(&server->lock));
 			write_unlock(&server->lock);
-			afs_put_addrlist(old);
+			afs_put_addrlist(old, afs_alist_trace_put_vlserver_old);
 		}
 
 
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 7ae73418697d..e8fbbeb551bb 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -231,16 +231,11 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	read_lock(&vlserver->lock);
 	alist = rcu_dereference_protected(vlserver->addresses,
 					  lockdep_is_held(&vlserver->lock));
-	afs_get_addrlist(alist);
+	afs_get_addrlist(alist, afs_alist_trace_get_vlrotate_set);
 	read_unlock(&vlserver->lock);
 
 	memset(&vc->ac, 0, sizeof(vc->ac));
-
-	if (!vc->ac.alist)
-		vc->ac.alist = alist;
-	else
-		afs_put_addrlist(alist);
-
+	vc->ac.alist = alist;
 	vc->ac.index = -1;
 
 iterate_address:
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index db7e94584e87..8dea7b56b75a 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -314,7 +314,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 	alist			= call->ret_alist;
 	afs_put_call(call);
 	if (vc->call_error) {
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_getaddru);
 		return ERR_PTR(vc->call_error);
 	}
 	return alist;
@@ -668,7 +668,7 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	alist			= call->ret_alist;
 	afs_put_call(call);
 	if (vc->call_error) {
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_getaddru);
 		return ERR_PTR(vc->call_error);
 	}
 	return alist;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 597677acc6b1..ed91666ca4cc 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -202,6 +202,27 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_use_sbi,		"USE sbi   ") \
 	E_(afs_cell_trace_wait,			"WAIT      ")
 
+#define afs_alist_traces \
+	EM(afs_alist_trace_alloc,		"ALLOC     ") \
+	EM(afs_alist_trace_get_fsrotate_set,	"GET fs-rot") \
+	EM(afs_alist_trace_get_make_call,	"GET mkcall") \
+	EM(afs_alist_trace_get_probe,		"GET probe ") \
+	EM(afs_alist_trace_get_vlrotate_set,	"GET vl-rot") \
+	EM(afs_alist_trace_put_call,		"PUT call  ") \
+	EM(afs_alist_trace_put_end_cursor,	"PUT endcur") \
+	EM(afs_alist_trace_put_getaddru,	"PUT GtAdrU") \
+	EM(afs_alist_trace_put_parse_empty,	"PUT p-empt") \
+	EM(afs_alist_trace_put_parse_error,	"PUT p-err ") \
+	EM(afs_alist_trace_put_probe,		"PUT probe ") \
+	EM(afs_alist_trace_put_retry_server,	"PUT retry ") \
+	EM(afs_alist_trace_put_server,		"PUT server") \
+	EM(afs_alist_trace_put_server_dup,	"PUT sv-dup") \
+	EM(afs_alist_trace_put_server_oom,	"PUT sv-oom") \
+	EM(afs_alist_trace_put_server_update,	"PUT sv-upd") \
+	EM(afs_alist_trace_put_vlserver,	"PUT vlsrvr") \
+	EM(afs_alist_trace_put_vlserver_old,	"PUT vs-old") \
+	E_(afs_alist_trace_free,		"FREE      ")
+
 #define afs_fs_operations \
 	EM(afs_FS_FetchData,			"FS.FetchData") \
 	EM(afs_FS_FetchStatus,			"FS.FetchStatus") \
@@ -420,6 +441,7 @@ enum yfs_cm_operation {
 #define EM(a, b) a,
 #define E_(a, b) a
 
+enum afs_alist_trace		{ afs_alist_traces } __mode(byte);
 enum afs_call_trace		{ afs_call_traces } __mode(byte);
 enum afs_cb_break_reason	{ afs_cb_break_reasons } __mode(byte);
 enum afs_cell_trace		{ afs_cell_traces } __mode(byte);
@@ -443,6 +465,7 @@ enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+afs_alist_traces;
 afs_call_traces;
 afs_server_traces;
 afs_cell_traces;
@@ -1330,6 +1353,30 @@ TRACE_EVENT(afs_cell,
 		      __entry->active)
 	    );
 
+TRACE_EVENT(afs_alist,
+	    TP_PROTO(unsigned int alist_debug_id, int ref, enum afs_alist_trace reason),
+
+	    TP_ARGS(alist_debug_id, ref, reason),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		alist)
+		    __field(int,			ref)
+		    __field(int,			active)
+		    __field(int,			reason)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->alist = alist_debug_id;
+		    __entry->ref = ref;
+		    __entry->reason = reason;
+			   ),
+
+	    TP_printk("AL=%08x %s r=%d",
+		      __entry->alist,
+		      __print_symbolic(__entry->reason, afs_alist_traces),
+		      __entry->ref)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */



Return-Path: <linux-fsdevel+bounces-5873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED3481137F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A6A282791
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A412E65A;
	Wed, 13 Dec 2023 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJW3X8xi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2BC137
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ilVhciIr/zJntY+SWgt0NsMblkInASK+jgWxf84YTc8=;
	b=PJW3X8xiTYiEP9mP7IUi31vjjhXp/307NDA2qf/ryfN3Txgp/d3IsZ+WXf85KT808sKWba
	hEsbwY0xZfskookbSmDcOgiZQPVLcDPg2RbKG5s4vEhXOfWuVYm917vNAI77nJptwc4unM
	ek7J46zy/6bD0gAeQwPoyN3ocE9lz6E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-IKiB_2ndPR2GE8dDXUYRoA-1; Wed,
 13 Dec 2023 08:50:34 -0500
X-MC-Unique: IKiB_2ndPR2GE8dDXUYRoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36E2829AC037;
	Wed, 13 Dec 2023 13:50:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47DED40C6EB9;
	Wed, 13 Dec 2023 13:50:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/40] afs: Add a tracepoint for struct afs_addr_list
Date: Wed, 13 Dec 2023 13:49:39 +0000
Message-ID: <20231213135003.367397-18-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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
index d67c75d4d2bd..d00fda99f401 100644
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
@@ -969,14 +970,9 @@ static inline bool afs_is_folio_dirty_mmapped(unsigned long priv)
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
index a778d53681fe..fa2ba45a5941 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -484,7 +484,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	read_lock(&server->fs_lock);
 	alist = rcu_dereference_protected(server->addresses,
 					  lockdep_is_held(&server->fs_lock));
-	afs_get_addrlist(alist);
+	afs_get_addrlist(alist, afs_alist_trace_get_fsrotate_set);
 	read_unlock(&server->fs_lock);
 
 retry_server:
@@ -493,7 +493,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (!op->ac.alist)
 		op->ac.alist = alist;
 	else
-		afs_put_addrlist(alist);
+		afs_put_addrlist(alist, afs_alist_trace_put_retry_server);
 
 	op->ac.index = -1;
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 0b3e2f20b0e0..5bbf5a23af85 100644
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
index f7791ef13618..6c13f00b10d8 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -275,13 +275,13 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 
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
@@ -421,7 +421,8 @@ static void afs_server_rcu(struct rcu_head *rcu)
 
 	trace_afs_server(server->debug_id, refcount_read(&server->ref),
 			 atomic_read(&server->active), afs_server_trace_free);
-	afs_put_addrlist(rcu_access_pointer(server->addresses));
+	afs_put_addrlist(rcu_access_pointer(server->addresses),
+			 afs_alist_trace_put_server);
 	kfree(server);
 }
 
@@ -643,7 +644,7 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
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



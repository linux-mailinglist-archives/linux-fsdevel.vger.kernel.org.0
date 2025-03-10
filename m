Return-Path: <linux-fsdevel+bounces-43583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29164A59009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D23A16742A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9005229B11;
	Mon, 10 Mar 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igIUfmYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E822288E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599772; cv=none; b=kfvI4lPI9oU7juL4gzTBIQFf0d8wCi6JCD8gqAGYNQgekaHWl86GH/Lt7shL0Y3Q9pB5PMZjHAvxcDcexTWtcVuiGc9HpfvEFmpy/hOihpgOcBvmyO1HCYQv1Rba5xv15e/5eSw1/F4oArhuftEqsTXMXgGpx63R3oh5D6VGBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599772; c=relaxed/simple;
	bh=o20DsNKrxwfd4uUOeuyFaFfER8RAfFI0KRxcGbfOG2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrou+dRHOJC4sYbKMHRMkNxFIIfSTDEA5eY85EXmQA/0DG5PRwWyH3TX9psclk9LzGDnca+WwD1v2wmx3BSE2KtKfssaf5GFAXiEra3Y17drpELk4pEVcTq7WMBHM3xT4IWOQPvoPDbcLolSpiCy3EMoPZ220oRiKskC3E0uJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igIUfmYS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNjcis3bmlUYBwnkEqvwUlaKP/e/GzRt3p3JQQKZgDs=;
	b=igIUfmYSjj6wEcN8jwsiC6M3zbuhQWdTXFaEHmvqeB5r3dfLlt8mXLq0DHrqlFkQ/zuXA4
	D7Bq7H1KhM3SYVr2IqQrbvm7Hzd3tyl0p7CFJmkrUChr7ElGjfobm5ohAkHoV2IqllptOH
	pj6RaEp5og1QVjr8AKYemo/6bxU0C4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611--mMJy9LHNsKUsPexzeT7GQ-1; Mon,
 10 Mar 2025 05:42:47 -0400
X-MC-Unique: -mMJy9LHNsKUsPexzeT7GQ-1
X-Mimecast-MFC-AGG-ID: -mMJy9LHNsKUsPexzeT7GQ_1741599766
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 802F919560B5;
	Mon, 10 Mar 2025 09:42:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0BBB1800366;
	Mon, 10 Mar 2025 09:42:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] afs: Use the per-peer app data provided by rxrpc
Date: Mon, 10 Mar 2025 09:42:02 +0000
Message-ID: <20250310094206.801057-10-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Make use of the per-peer application data that rxrpc now allows the
application to store on the rxrpc_peer struct to hold a back pointer to the
afs_server record that peer represents an endpoint for.

Then, when a call comes in to the AFS cache manager, this can be used to
map it to the correct server record rather than having to use a
UUID-to-server mapping table and having to do an additional lookup.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-14-dhowells@redhat.com/ # v1
---
 fs/afs/addr_list.c         | 50 +++++++++++++++++++++++
 fs/afs/cmservice.c         | 82 ++++++--------------------------------
 fs/afs/fs_probe.c          | 32 ++++++++++-----
 fs/afs/internal.h          |  9 +++--
 fs/afs/proc.c              | 10 ++++-
 fs/afs/rxrpc.c             |  6 +++
 fs/afs/server.c            | 46 ++++++---------------
 include/trace/events/afs.h |  4 +-
 net/rxrpc/peer_object.c    |  4 +-
 9 files changed, 120 insertions(+), 123 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 6d42f85c6be5..e941da5b6dd9 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -362,3 +362,53 @@ int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *alist,
 	alist->nr_addrs++;
 	return 0;
 }
+
+/*
+ * Set the app data on the rxrpc peers an address list points to
+ */
+void afs_set_peer_appdata(struct afs_server *server,
+			  struct afs_addr_list *old_alist,
+			  struct afs_addr_list *new_alist)
+{
+	unsigned long data = (unsigned long)server;
+	int n = 0, o = 0;
+
+	if (!old_alist) {
+		/* New server.  Just set all. */
+		for (; n < new_alist->nr_addrs; n++)
+			rxrpc_kernel_set_peer_data(new_alist->addrs[n].peer, data);
+		return;
+	}
+	if (!new_alist) {
+		/* Dead server.  Just remove all. */
+		for (; o < old_alist->nr_addrs; o++)
+			rxrpc_kernel_set_peer_data(old_alist->addrs[o].peer, 0);
+		return;
+	}
+
+	/* Walk through the two lists simultaneously, setting new peers and
+	 * clearing old ones.  The two lists are ordered by pointer to peer
+	 * record.
+	 */
+	while (n < new_alist->nr_addrs && o < old_alist->nr_addrs) {
+		struct rxrpc_peer *pn = new_alist->addrs[n].peer;
+		struct rxrpc_peer *po = old_alist->addrs[o].peer;
+
+		if (pn == po)
+			continue;
+		if (pn < po) {
+			rxrpc_kernel_set_peer_data(pn, data);
+			n++;
+		} else {
+			rxrpc_kernel_set_peer_data(po, 0);
+			o++;
+		}
+	}
+
+	if (n < new_alist->nr_addrs)
+		for (; n < new_alist->nr_addrs; n++)
+			rxrpc_kernel_set_peer_data(new_alist->addrs[n].peer, data);
+	if (o < old_alist->nr_addrs)
+		for (; o < old_alist->nr_addrs; o++)
+			rxrpc_kernel_set_peer_data(old_alist->addrs[o].peer, 0);
+}
diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 99a3f20bc786..1a906805a9e3 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -138,49 +138,6 @@ bool afs_cm_incoming_call(struct afs_call *call)
 	}
 }
 
-/*
- * Find the server record by peer address and record a probe to the cache
- * manager from a server.
- */
-static int afs_find_cm_server_by_peer(struct afs_call *call)
-{
-	struct sockaddr_rxrpc srx;
-	struct afs_server *server;
-	struct rxrpc_peer *peer;
-
-	peer = rxrpc_kernel_get_call_peer(call->net->socket, call->rxcall);
-
-	server = afs_find_server(call->net, peer);
-	if (!server) {
-		trace_afs_cm_no_server(call, &srx);
-		return 0;
-	}
-
-	call->server = server;
-	return 0;
-}
-
-/*
- * Find the server record by server UUID and record a probe to the cache
- * manager from a server.
- */
-static int afs_find_cm_server_by_uuid(struct afs_call *call,
-				      struct afs_uuid *uuid)
-{
-	struct afs_server *server;
-
-	rcu_read_lock();
-	server = afs_find_server_by_uuid(call->net, call->request);
-	rcu_read_unlock();
-	if (!server) {
-		trace_afs_cm_no_server_u(call, call->request);
-		return 0;
-	}
-
-	call->server = server;
-	return 0;
-}
-
 /*
  * Clean up a cache manager call.
  */
@@ -322,10 +279,7 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-
-	/* we'll need the file server record as that tells us which set of
-	 * vnodes to operate upon */
-	return afs_find_cm_server_by_peer(call);
+	return 0;
 }
 
 /*
@@ -349,18 +303,10 @@ static void SRXAFSCB_InitCallBackState(struct work_struct *work)
  */
 static int afs_deliver_cb_init_call_back_state(struct afs_call *call)
 {
-	int ret;
-
 	_enter("");
 
 	afs_extract_discard(call, 0);
-	ret = afs_extract_data(call, false);
-	if (ret < 0)
-		return ret;
-
-	/* we'll need the file server record as that tells us which set of
-	 * vnodes to operate upon */
-	return afs_find_cm_server_by_peer(call);
+	return afs_extract_data(call, false);
 }
 
 /*
@@ -373,8 +319,6 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 	__be32 *b;
 	int ret;
 
-	_enter("");
-
 	_enter("{%u}", call->unmarshall);
 
 	switch (call->unmarshall) {
@@ -421,9 +365,13 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
 
-	/* we'll need the file server record as that tells us which set of
-	 * vnodes to operate upon */
-	return afs_find_cm_server_by_uuid(call, call->request);
+	if (memcmp(call->request, &call->server->_uuid, sizeof(call->server->_uuid)) != 0) {
+		pr_notice("Callback UUID does not match fileserver UUID\n");
+		trace_afs_cm_no_server_u(call, call->request);
+		return 0;
+	}
+
+	return 0;
 }
 
 /*
@@ -455,7 +403,7 @@ static int afs_deliver_cb_probe(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-	return afs_find_cm_server_by_peer(call);
+	return 0;
 }
 
 /*
@@ -533,7 +481,7 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-	return afs_find_cm_server_by_peer(call);
+	return 0;
 }
 
 /*
@@ -593,7 +541,7 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-	return afs_find_cm_server_by_peer(call);
+	return 0;
 }
 
 /*
@@ -667,9 +615,5 @@ static int afs_deliver_yfs_cb_callback(struct afs_call *call)
 
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
-
-	/* We'll need the file server record as that tells us which set of
-	 * vnodes to operate upon.
-	 */
-	return afs_find_cm_server_by_peer(call);
+	return 0;
 }
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index b516d05b0fef..07a8bfbdd9b9 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -235,20 +235,20 @@ void afs_fileserver_probe_result(struct afs_call *call)
  * Probe all of a fileserver's addresses to find out the best route and to
  * query its capabilities.
  */
-void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
-			     struct afs_addr_list *new_alist, struct key *key)
+int afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
+			    struct afs_addr_list *new_alist, struct key *key)
 {
 	struct afs_endpoint_state *estate, *old;
-	struct afs_addr_list *alist;
+	struct afs_addr_list *old_alist = NULL, *alist;
 	unsigned long unprobed;
 
 	_enter("%pU", &server->uuid);
 
 	estate = kzalloc(sizeof(*estate), GFP_KERNEL);
 	if (!estate)
-		return;
+		return -ENOMEM;
 
-	refcount_set(&estate->ref, 1);
+	refcount_set(&estate->ref, 2);
 	estate->server_id = server->debug_id;
 	estate->rtt = UINT_MAX;
 
@@ -256,21 +256,31 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 
 	old = rcu_dereference_protected(server->endpoint_state,
 					lockdep_is_held(&server->fs_lock));
-	estate->responsive_set = old->responsive_set;
-	estate->addresses = afs_get_addrlist(new_alist ?: old->addresses,
-					     afs_alist_trace_get_estate);
+	if (old) {
+		estate->responsive_set = old->responsive_set;
+		if (!new_alist)
+			new_alist = old->addresses;
+	}
+
+	if (old_alist != new_alist)
+		afs_set_peer_appdata(server, old_alist, new_alist);
+
+	estate->addresses = afs_get_addrlist(new_alist, afs_alist_trace_get_estate);
 	alist = estate->addresses;
 	estate->probe_seq = ++server->probe_counter;
 	atomic_set(&estate->nr_probing, alist->nr_addrs);
 
+	if (new_alist)
+		server->addr_version = new_alist->version;
 	rcu_assign_pointer(server->endpoint_state, estate);
-	set_bit(AFS_ESTATE_SUPERSEDED, &old->flags);
 	write_unlock(&server->fs_lock);
+	if (old)
+		set_bit(AFS_ESTATE_SUPERSEDED, &old->flags);
 
 	trace_afs_estate(estate->server_id, estate->probe_seq, refcount_read(&estate->ref),
 			 afs_estate_trace_alloc_probe);
 
-	afs_get_address_preferences(net, alist);
+	afs_get_address_preferences(net, new_alist);
 
 	server->probed_at = jiffies;
 	unprobed = (1UL << alist->nr_addrs) - 1;
@@ -293,6 +303,8 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 	}
 
 	afs_put_endpoint_state(old, afs_estate_trace_put_probe);
+	afs_put_endpoint_state(estate, afs_estate_trace_put_probe);
+	return 0;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9c8dfde758c3..3321fdafb3c7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1010,6 +1010,9 @@ extern int afs_merge_fs_addr4(struct afs_net *net, struct afs_addr_list *addr,
 			      __be32 xdr, u16 port);
 extern int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *addr,
 			      __be32 *xdr, u16 port);
+void afs_set_peer_appdata(struct afs_server *server,
+			  struct afs_addr_list *old_alist,
+			  struct afs_addr_list *new_alist);
 
 /*
  * addr_prefs.c
@@ -1207,8 +1210,8 @@ struct afs_endpoint_state *afs_get_endpoint_state(struct afs_endpoint_state *est
 						  enum afs_estate_trace where);
 void afs_put_endpoint_state(struct afs_endpoint_state *estate, enum afs_estate_trace where);
 extern void afs_fileserver_probe_result(struct afs_call *);
-void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
-			     struct afs_addr_list *new_addrs, struct key *key);
+int afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
+			    struct afs_addr_list *new_alist, struct key *key);
 int afs_wait_for_fs_probes(struct afs_operation *op, struct afs_server_state *states, bool intr);
 extern void afs_probe_fileserver(struct afs_net *, struct afs_server *);
 extern void afs_fs_probe_dispatcher(struct work_struct *);
@@ -1509,7 +1512,7 @@ extern void __exit afs_clean_up_permit_cache(void);
  */
 extern spinlock_t afs_server_peer_lock;
 
-extern struct afs_server *afs_find_server(struct afs_net *, const struct rxrpc_peer *);
+struct afs_server *afs_find_server(const struct rxrpc_peer *peer);
 extern struct afs_server *afs_find_server_by_uuid(struct afs_net *, const uuid_t *);
 extern struct afs_server *afs_lookup_server(struct afs_cell *, struct key *, const uuid_t *, u32);
 extern struct afs_server *afs_get_server(struct afs_server *, enum afs_server_trace);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 9a3d8eb5da43..40e879c8ca77 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -444,8 +444,6 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	}
 
 	server = list_entry(v, struct afs_server, proc_link);
-	estate = rcu_dereference(server->endpoint_state);
-	alist = estate->addresses;
 	seq_printf(m, "%pU %3d %3d %s\n",
 		   &server->uuid,
 		   refcount_read(&server->ref),
@@ -455,10 +453,16 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   server->flags, server->rtt);
 	seq_printf(m, "  - probe: last=%d\n",
 		   (int)(jiffies - server->probed_at) / HZ);
+
+	estate = rcu_dereference(server->endpoint_state);
+	if (!estate)
+		goto out;
 	failed = estate->failed_set;
 	seq_printf(m, "  - ESTATE pq=%x np=%u rsp=%lx f=%lx\n",
 		   estate->probe_seq, atomic_read(&estate->nr_probing),
 		   estate->responsive_set, estate->failed_set);
+
+	alist = estate->addresses;
 	seq_printf(m, "  - ALIST v=%u ap=%u\n",
 		   alist->version, alist->addr_pref_version);
 	for (i = 0; i < alist->nr_addrs; i++) {
@@ -471,6 +475,8 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 			   rxrpc_kernel_get_srtt(addr->peer),
 			   addr->last_error, addr->prio);
 	}
+
+out:
 	return 0;
 }
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index de9e10575bdd..d5e480a33859 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -766,8 +766,14 @@ static void afs_rx_discard_new_call(struct rxrpc_call *rxcall,
 static void afs_rx_new_call(struct sock *sk, struct rxrpc_call *rxcall,
 			    unsigned long user_call_ID)
 {
+	struct afs_call *call = (struct afs_call *)user_call_ID;
 	struct afs_net *net = afs_sock2net(sk);
 
+	call->peer = rxrpc_kernel_get_call_peer(sk->sk_socket, call->rxcall);
+	call->server = afs_find_server(call->peer);
+	if (!call->server)
+		trace_afs_cm_no_server(call, rxrpc_kernel_remote_srx(call->peer));
+
 	queue_work(afs_wq, &net->charge_preallocation_work);
 }
 
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 923e07c37032..1140773f7aed 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -21,42 +21,13 @@ static void __afs_put_server(struct afs_net *, struct afs_server *);
 /*
  * Find a server by one of its addresses.
  */
-struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer *peer)
+struct afs_server *afs_find_server(const struct rxrpc_peer *peer)
 {
-	const struct afs_endpoint_state *estate;
-	const struct afs_addr_list *alist;
-	struct afs_server *server = NULL;
-	unsigned int i;
-	int seq = 1;
-
-	rcu_read_lock();
-
-	do {
-		if (server)
-			afs_unuse_server_notime(net, server, afs_server_trace_unuse_find_rsq);
-		server = NULL;
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
-
-		hlist_for_each_entry_rcu(server, &net->fs_addresses, addr_link) {
-			estate = rcu_dereference(server->endpoint_state);
-			alist = estate->addresses;
-			for (i = 0; i < alist->nr_addrs; i++)
-				if (alist->addrs[i].peer == peer)
-					goto found;
-		}
+	struct afs_server *server = (struct afs_server *)rxrpc_kernel_get_peer_data(peer);
 
-		server = NULL;
-		continue;
-	found:
-		server = afs_maybe_use_server(server, afs_server_trace_use_by_addr);
-
-	} while (need_seqretry(&net->fs_addr_lock, seq));
-
-	done_seqretry(&net->fs_addr_lock, seq);
-
-	rcu_read_unlock();
-	return server;
+	if (!server)
+		return NULL;
+	return afs_maybe_use_server(server, afs_server_trace_use_cm_call);
 }
 
 /*
@@ -468,9 +439,16 @@ static void afs_give_up_callbacks(struct afs_net *net, struct afs_server *server
  */
 static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 {
+	struct afs_endpoint_state *estate;
+
 	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
 		afs_give_up_callbacks(net, server);
 
+	/* Unbind the rxrpc_peer records from the server. */
+	estate = rcu_access_pointer(server->endpoint_state);
+	if (estate)
+		afs_set_peer_appdata(server, estate->addresses, NULL);
+
 	afs_put_server(net, server, afs_server_trace_destroy);
 }
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 82d20c28dc0d..4d798b9e43bf 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -140,12 +140,10 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_see_expired,	"SEE expd ") \
 	EM(afs_server_trace_unuse_call,		"UNU call ") \
 	EM(afs_server_trace_unuse_create_fail,	"UNU cfail") \
-	EM(afs_server_trace_unuse_find_rsq,	"UNU f-rsq") \
 	EM(afs_server_trace_unuse_slist,	"UNU slist") \
 	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
 	EM(afs_server_trace_unuse_uuid_rsq,	"PUT u-req") \
 	EM(afs_server_trace_update,		"UPDATE   ") \
-	EM(afs_server_trace_use_by_addr,	"USE addr ") \
 	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
 	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
 	EM(afs_server_trace_use_get_caps,	"USE gcaps") \
@@ -1281,7 +1279,7 @@ TRACE_EVENT(afs_bulkstat_error,
 	    );
 
 TRACE_EVENT(afs_cm_no_server,
-	    TP_PROTO(struct afs_call *call, struct sockaddr_rxrpc *srx),
+	    TP_PROTO(struct afs_call *call, const struct sockaddr_rxrpc *srx),
 
 	    TP_ARGS(call, srx),
 
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index a0c0e4d590f5..71b6e07bf161 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -461,7 +461,7 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
 			continue;
 
 		hlist_for_each_entry(peer, &rxnet->peer_hash[i], hash_link) {
-			pr_err("Leaked peer %u {%u} %pISp\n",
+			pr_err("Leaked peer %x {%u} %pISp\n",
 			       peer->debug_id,
 			       refcount_read(&peer->ref),
 			       &peer->srx.transport);
@@ -478,7 +478,7 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
  */
 struct rxrpc_peer *rxrpc_kernel_get_call_peer(struct socket *sock, struct rxrpc_call *call)
 {
-	return call->peer;
+	return rxrpc_get_peer(call->peer, rxrpc_peer_get_application);
 }
 EXPORT_SYMBOL(rxrpc_kernel_get_call_peer);
 



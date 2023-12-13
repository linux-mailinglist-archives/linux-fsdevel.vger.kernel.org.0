Return-Path: <linux-fsdevel+bounces-5888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C672581139B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BA22826CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14492EB0E;
	Wed, 13 Dec 2023 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3AORoka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236B100
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rh4qbkDsLwX6d4hR6qGSDOd9w/xYHcjQ66/NZZW4aHU=;
	b=L3AORoka5l4+FNFQdlb3oEiYtzZ9Fwrr7YpRPT/2cbHz1fLvBpbB/0WlVPh0laxuN7G4nV
	RNu04FTSkM5qnqoeAhRCBR/G4W0LSnRchbDsb8jCYkBc1k30LMwxmZNg0eWxvGpWSoQL+z
	dgFuKi/5LSlJmMRiIU5iMzh/ivnnzNI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-giC_5n8NOKKsqCyMQW914Q-1; Wed,
 13 Dec 2023 08:50:51 -0500
X-MC-Unique: giC_5n8NOKKsqCyMQW914Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C0B43869149;
	Wed, 13 Dec 2023 13:50:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5876DC1596E;
	Wed, 13 Dec 2023 13:50:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/40] afs: Keep a record of the current fileserver endpoint state
Date: Wed, 13 Dec 2023 13:49:50 +0000
Message-ID: <20231213135003.367397-29-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Keep a record of the current fileserver endpoint state, including the probe
state, and replace it when a new probe is started rather than just
squelching the old state and overwriting it.  Clearance of the old state
can cause a race if there's another thread also currently trying to
communicate with that server.

It appears that this race might be the culprit for some occasions where
kafs complains about invalid data in the RPC reply because the rotation
algorithm fell all the way through without actually issuing an RPC call and
the error return got filled in from the probe state (which has a zero error
recorded).  Whatever happens to be in the caller's reply buffer is then
taken as the response.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c      |  19 +--
 fs/afs/fs_probe.c          | 235 ++++++++++++++++++++++---------------
 fs/afs/fsclient.c          |   8 +-
 fs/afs/internal.h          |  66 +++++++----
 fs/afs/proc.c              |  21 ++--
 fs/afs/rotate.c            |  80 +++++++------
 fs/afs/server.c            |  69 +++++++----
 fs/afs/vl_alias.c          |   4 +-
 fs/afs/vl_probe.c          |   2 +-
 fs/afs/vlclient.c          |   4 +-
 include/trace/events/afs.h |  69 ++++++++---
 11 files changed, 366 insertions(+), 211 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index e760e11d5bcb..8c6d827f999d 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -228,6 +228,7 @@ void afs_wait_for_operation(struct afs_operation *op)
  */
 int afs_put_operation(struct afs_operation *op)
 {
+	struct afs_endpoint_state *estate = op->estate;
 	struct afs_addr_list *alist;
 	int i, ret = afs_op_error(op);
 
@@ -251,14 +252,16 @@ int afs_put_operation(struct afs_operation *op)
 		kfree(op->more_files);
 	}
 
-	alist = op->alist;
-	if (alist) {
-		if (op->call_responded &&
-		    op->addr_index != alist->preferred &&
-		    test_bit(alist->preferred, &op->addr_tried))
-			WRITE_ONCE(alist->preferred, op->addr_index);
-		afs_put_addrlist(alist, afs_alist_trace_put_operation);
-		op->alist = NULL;
+	if (estate) {
+		alist = estate->addresses;
+		if (alist) {
+			if (op->call_responded &&
+			    op->addr_index != alist->preferred &&
+			    test_bit(alist->preferred, &op->addr_tried))
+				WRITE_ONCE(alist->preferred, op->addr_index);
+		}
+		afs_put_endpoint_state(estate, afs_estate_trace_put_operation);
+		op->estate = NULL;
 	}
 
 	afs_put_serverlist(op->net, op->server_list);
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index c5702698b18b..a669aee033c5 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -15,6 +15,42 @@
 static unsigned int afs_fs_probe_fast_poll_interval = 30 * HZ;
 static unsigned int afs_fs_probe_slow_poll_interval = 5 * 60 * HZ;
 
+struct afs_endpoint_state *afs_get_endpoint_state(struct afs_endpoint_state *estate,
+						  enum afs_estate_trace where)
+{
+	if (estate) {
+		int r;
+
+		__refcount_inc(&estate->ref, &r);
+		trace_afs_estate(estate->server_id, estate->probe_seq, r, where);
+	}
+	return estate;
+}
+
+static void afs_endpoint_state_rcu(struct rcu_head *rcu)
+{
+	struct afs_endpoint_state *estate = container_of(rcu, struct afs_endpoint_state, rcu);
+
+	trace_afs_estate(estate->server_id, estate->probe_seq, refcount_read(&estate->ref),
+			 afs_estate_trace_free);
+	afs_put_addrlist(estate->addresses, afs_alist_trace_put_estate);
+	kfree(estate);
+}
+
+void afs_put_endpoint_state(struct afs_endpoint_state *estate, enum afs_estate_trace where)
+{
+	if (estate) {
+		unsigned int server_id = estate->server_id, probe_seq = estate->probe_seq;
+		bool dead;
+		int r;
+
+		dead = __refcount_dec_and_test(&estate->ref, &r);
+		trace_afs_estate(server_id, probe_seq, r, where);
+		if (dead)
+			call_rcu(&estate->rcu, afs_endpoint_state_rcu);
+	}
+}
+
 /*
  * Start the probe polling timer.  We have to supply it with an inc on the
  * outstanding server count.
@@ -38,9 +74,10 @@ static void afs_schedule_fs_probe(struct afs_net *net,
 /*
  * Handle the completion of a set of probes.
  */
-static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server)
+static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server,
+				  struct afs_endpoint_state *estate)
 {
-	bool responded = server->probe.responded;
+	bool responded = estate->responded;
 
 	write_seqlock(&net->fs_lock);
 	if (responded) {
@@ -50,6 +87,7 @@ static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server
 		clear_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
 		list_add_tail(&server->probe_link, &net->fs_probe_fast);
 	}
+
 	write_sequnlock(&net->fs_lock);
 
 	afs_schedule_fs_probe(net, server, !responded);
@@ -58,12 +96,13 @@ static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server
 /*
  * Handle the completion of a probe.
  */
-static void afs_done_one_fs_probe(struct afs_net *net, struct afs_server *server)
+static void afs_done_one_fs_probe(struct afs_net *net, struct afs_server *server,
+				  struct afs_endpoint_state *estate)
 {
 	_enter("");
 
-	if (atomic_dec_and_test(&server->probe_outstanding))
-		afs_finished_fs_probe(net, server);
+	if (atomic_dec_and_test(&estate->nr_probing))
+		afs_finished_fs_probe(net, server, estate);
 
 	wake_up_all(&server->probe_wq);
 }
@@ -74,7 +113,7 @@ static void afs_done_one_fs_probe(struct afs_net *net, struct afs_server *server
  */
 static void afs_fs_probe_not_done(struct afs_net *net,
 				  struct afs_server *server,
-				  struct afs_addr_list *alist,
+				  struct afs_endpoint_state *estate,
 				  int index)
 {
 	_enter("");
@@ -82,14 +121,14 @@ static void afs_fs_probe_not_done(struct afs_net *net,
 	trace_afs_io_error(0, -ENOMEM, afs_io_error_fs_probe_fail);
 	spin_lock(&server->probe_lock);
 
-	server->probe.local_failure = true;
-	if (server->probe.error == 0)
-		server->probe.error = -ENOMEM;
+	estate->local_failure = true;
+	if (estate->error == 0)
+		estate->error = -ENOMEM;
 
-	set_bit(index, &alist->probe_failed);
+	set_bit(index, &estate->failed_set);
 
 	spin_unlock(&server->probe_lock);
-	return afs_done_one_fs_probe(net, server);
+	return afs_done_one_fs_probe(net, server, estate);
 }
 
 /*
@@ -98,7 +137,8 @@ static void afs_fs_probe_not_done(struct afs_net *net,
  */
 void afs_fileserver_probe_result(struct afs_call *call)
 {
-	struct afs_addr_list *alist = call->probe_alist;
+	struct afs_endpoint_state *estate = call->probe;
+	struct afs_addr_list *alist = estate->addresses;
 	struct afs_address *addr = &alist->addrs[call->probe_index];
 	struct afs_server *server = call->server;
 	unsigned int index = call->probe_index;
@@ -113,18 +153,18 @@ void afs_fileserver_probe_result(struct afs_call *call)
 
 	switch (ret) {
 	case 0:
-		server->probe.error = 0;
+		estate->error = 0;
 		goto responded;
 	case -ECONNABORTED:
-		if (!server->probe.responded) {
-			server->probe.abort_code = call->abort_code;
-			server->probe.error = ret;
+		if (!estate->responded) {
+			estate->abort_code = call->abort_code;
+			estate->error = ret;
 		}
 		goto responded;
 	case -ENOMEM:
 	case -ENONET:
-		clear_bit(index, &alist->responded);
-		server->probe.local_failure = true;
+		clear_bit(index, &estate->responsive_set);
+		estate->local_failure = true;
 		trace_afs_io_error(call->debug_id, ret, afs_io_error_fs_probe_fail);
 		goto out;
 	case -ECONNRESET: /* Responded, but call expired. */
@@ -137,28 +177,28 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	case -ETIMEDOUT:
 	case -ETIME:
 	default:
-		clear_bit(index, &alist->responded);
-		set_bit(index, &alist->probe_failed);
-		if (!server->probe.responded &&
-		    (server->probe.error == 0 ||
-		     server->probe.error == -ETIMEDOUT ||
-		     server->probe.error == -ETIME))
-			server->probe.error = ret;
+		clear_bit(index, &estate->responsive_set);
+		set_bit(index, &estate->failed_set);
+		if (!estate->responded &&
+		    (estate->error == 0 ||
+		     estate->error == -ETIMEDOUT ||
+		     estate->error == -ETIME))
+			estate->error = ret;
 		trace_afs_io_error(call->debug_id, ret, afs_io_error_fs_probe_fail);
 		goto out;
 	}
 
 responded:
-	clear_bit(index, &alist->probe_failed);
+	clear_bit(index, &estate->failed_set);
 
 	if (call->service_id == YFS_FS_SERVICE) {
-		server->probe.is_yfs = true;
+		estate->is_yfs = true;
 		set_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
 		server->service_id = call->service_id;
 	} else {
-		server->probe.not_yfs = true;
-		if (!server->probe.is_yfs) {
-			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
+		estate->not_yfs = true;
+		if (!estate->is_yfs) {
+			estate->is_yfs = false;
 			server->service_id = call->service_id;
 		}
 		cap0 = ntohl(call->tmp);
@@ -169,84 +209,90 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	}
 
 	rtt_us = rxrpc_kernel_get_srtt(addr->peer);
-	if (rtt_us < server->probe.rtt) {
-		server->probe.rtt = rtt_us;
+	if (rtt_us < estate->rtt) {
+		estate->rtt = rtt_us;
 		server->rtt = rtt_us;
 		alist->preferred = index;
 	}
 
 	smp_wmb(); /* Set rtt before responded. */
-	server->probe.responded = true;
-	set_bit(index, &alist->responded);
+	estate->responded = true;
+	set_bit(index, &estate->responsive_set);
 	set_bit(AFS_SERVER_FL_RESPONDING, &server->flags);
 out:
 	spin_unlock(&server->probe_lock);
 
-	trace_afs_fs_probe(server, false, alist, index, call->error, call->abort_code, rtt_us);
-	_debug("probe %pU [%u] %pISpc rtt=%d ret=%d",
-	       &server->uuid, index, rxrpc_kernel_remote_addr(alist->addrs[index].peer),
+	trace_afs_fs_probe(server, false, estate, index, call->error, call->abort_code, rtt_us);
+	_debug("probe[%x] %pU [%u] %pISpc rtt=%d ret=%d",
+	       estate->probe_seq, &server->uuid, index,
+	       rxrpc_kernel_remote_addr(alist->addrs[index].peer),
 	       rtt_us, ret);
 
-	return afs_done_one_fs_probe(call->net, server);
+	return afs_done_one_fs_probe(call->net, server, estate);
 }
 
 /*
- * Probe one or all of a fileserver's addresses to find out the best route and
- * to query its capabilities.
+ * Probe all of a fileserver's addresses to find out the best route and to
+ * query its capabilities.
  */
 void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
-			     struct key *key, bool all)
+			     struct afs_addr_list *new_alist, struct key *key)
 {
+	struct afs_endpoint_state *estate, *old;
 	struct afs_addr_list *alist;
-	unsigned int index;
+	unsigned long unprobed;
 
 	_enter("%pU", &server->uuid);
 
-	read_lock(&server->fs_lock);
-	alist = rcu_dereference_protected(server->addresses,
-					  lockdep_is_held(&server->fs_lock));
-	afs_get_addrlist(alist, afs_alist_trace_get_probe);
-	read_unlock(&server->fs_lock);
+	estate = kzalloc(sizeof(*estate), GFP_KERNEL);
+	if (!estate)
+		return;
+
+	refcount_set(&estate->ref, 1);
+	estate->server_id = server->debug_id;
+	estate->rtt = UINT_MAX;
+
+	write_lock(&server->fs_lock);
+
+	old = rcu_dereference_protected(server->endpoint_state,
+					lockdep_is_held(&server->fs_lock));
+	estate->responsive_set = old->responsive_set;
+	estate->addresses = afs_get_addrlist(new_alist ?: old->addresses,
+					     afs_alist_trace_get_estate);
+	alist = estate->addresses;
+	estate->probe_seq = ++server->probe_counter;
+	atomic_set(&estate->nr_probing, alist->nr_addrs);
+
+	rcu_assign_pointer(server->endpoint_state, estate);
+	old->superseded = true;
+	write_unlock(&server->fs_lock);
+
+	trace_afs_estate(estate->server_id, estate->probe_seq, refcount_read(&estate->ref),
+			 afs_estate_trace_alloc_probe);
 
 	afs_get_address_preferences(net, alist);
 
 	server->probed_at = jiffies;
-	atomic_set(&server->probe_outstanding, all ? alist->nr_addrs : 1);
-	memset(&server->probe, 0, sizeof(server->probe));
-	server->probe.rtt = UINT_MAX;
-
-	index = alist->preferred;
-	if (index < 0 || index >= alist->nr_addrs)
-		all = true;
-
-	if (all) {
-		unsigned long unprobed = (1UL << alist->nr_addrs) - 1;
-		unsigned int i;
-		int best_prio;
-
-		while (unprobed) {
-			best_prio = -1;
-			index = 0;
-			for (i = 0; i < alist->nr_addrs; i++) {
-				if (test_bit(i, &unprobed) &&
-				    alist->addrs[i].prio > best_prio) {
-					index = i;
-					best_prio = alist->addrs[i].prio;
-				}
+	unprobed = (1UL << alist->nr_addrs) - 1;
+	while (unprobed) {
+		unsigned int index = 0, i;
+		int best_prio = -1;
+
+		for (i = 0; i < alist->nr_addrs; i++) {
+			if (test_bit(i, &unprobed) &&
+			    alist->addrs[i].prio > best_prio) {
+				index = i;
+				best_prio = alist->addrs[i].prio;
 			}
-			__clear_bit(index, &unprobed);
-
-			trace_afs_fs_probe(server, true, alist, index, 0, 0, 0);
-			if (!afs_fs_get_capabilities(net, server, alist, index, key))
-				afs_fs_probe_not_done(net, server, alist, index);
 		}
-	} else {
-		trace_afs_fs_probe(server, true, alist, index, 0, 0, 0);
-		if (!afs_fs_get_capabilities(net, server, alist, index, key))
-			afs_fs_probe_not_done(net, server, alist, index);
+		__clear_bit(index, &unprobed);
+
+		trace_afs_fs_probe(server, true, estate, index, 0, 0, 0);
+		if (!afs_fs_get_capabilities(net, server, estate, index, key))
+			afs_fs_probe_not_done(net, server, estate, index);
 	}
 
-	afs_put_addrlist(alist, afs_alist_trace_put_probe);
+	afs_put_endpoint_state(old, afs_estate_trace_put_probe);
 }
 
 /*
@@ -254,6 +300,7 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
  */
 int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 {
+	struct afs_endpoint_state *estate;
 	struct wait_queue_entry *waits;
 	struct afs_server *server;
 	unsigned int rtt = UINT_MAX, rtt_s;
@@ -263,15 +310,18 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 	_enter("%u,%lx", slist->nr_servers, untried);
 
 	/* Only wait for servers that have a probe outstanding. */
+	rcu_read_lock();
 	for (i = 0; i < slist->nr_servers; i++) {
 		if (test_bit(i, &untried)) {
 			server = slist->servers[i].server;
-			if (!atomic_read(&server->probe_outstanding))
+			estate = rcu_dereference(server->endpoint_state);
+			if (!atomic_read(&estate->nr_probing))
 				__clear_bit(i, &untried);
-			if (server->probe.responded)
+			if (estate->responded)
 				have_responders = true;
 		}
 	}
+	rcu_read_unlock();
 	if (have_responders || !untried)
 		return 0;
 
@@ -294,9 +344,9 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 		for (i = 0; i < slist->nr_servers; i++) {
 			if (test_bit(i, &untried)) {
 				server = slist->servers[i].server;
-				if (server->probe.responded)
+				if (estate->responded)
 					goto stop;
-				if (atomic_read(&server->probe_outstanding))
+				if (atomic_read(&estate->nr_probing))
 					still_probing = true;
 			}
 		}
@@ -348,7 +398,7 @@ void afs_fs_probe_timer(struct timer_list *timer)
 /*
  * Dispatch a probe to a server.
  */
-static void afs_dispatch_fs_probe(struct afs_net *net, struct afs_server *server, bool all)
+static void afs_dispatch_fs_probe(struct afs_net *net, struct afs_server *server)
 	__releases(&net->fs_lock)
 {
 	struct key *key = NULL;
@@ -361,7 +411,7 @@ static void afs_dispatch_fs_probe(struct afs_net *net, struct afs_server *server
 	afs_get_server(server, afs_server_trace_get_probe);
 	write_sequnlock(&net->fs_lock);
 
-	afs_fs_probe_fileserver(net, server, key, all);
+	afs_fs_probe_fileserver(net, server, NULL, key);
 	afs_put_server(net, server, afs_server_trace_put_probe);
 }
 
@@ -373,7 +423,7 @@ void afs_probe_fileserver(struct afs_net *net, struct afs_server *server)
 {
 	write_seqlock(&net->fs_lock);
 	if (!list_empty(&server->probe_link))
-		return afs_dispatch_fs_probe(net, server, true);
+		return afs_dispatch_fs_probe(net, server);
 	write_sequnlock(&net->fs_lock);
 }
 
@@ -433,7 +483,7 @@ void afs_fs_probe_dispatcher(struct work_struct *work)
 		_debug("probe %pU", &server->uuid);
 
 	if (server && (first_pass || !need_resched())) {
-		afs_dispatch_fs_probe(net, server, server == fast);
+		afs_dispatch_fs_probe(net, server);
 		first_pass = false;
 		goto again;
 	}
@@ -457,12 +507,13 @@ void afs_fs_probe_dispatcher(struct work_struct *work)
 /*
  * Wait for a probe on a particular fileserver to complete for 2s.
  */
-int afs_wait_for_one_fs_probe(struct afs_server *server, bool is_intr)
+int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_state *estate,
+			      bool is_intr)
 {
 	struct wait_queue_entry wait;
 	unsigned long timo = 2 * HZ;
 
-	if (atomic_read(&server->probe_outstanding) == 0)
+	if (atomic_read(&estate->nr_probing) == 0)
 		goto dont_wait;
 
 	init_wait_entry(&wait, 0);
@@ -470,8 +521,8 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, bool is_intr)
 		prepare_to_wait_event(&server->probe_wq, &wait,
 				      is_intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 		if (timo == 0 ||
-		    server->probe.responded ||
-		    atomic_read(&server->probe_outstanding) == 0 ||
+		    estate->responded ||
+		    atomic_read(&estate->nr_probing) == 0 ||
 		    (is_intr && signal_pending(current)))
 			break;
 		timo = schedule_timeout(timo);
@@ -480,7 +531,7 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, bool is_intr)
 	finish_wait(&server->probe_wq, &wait);
 
 dont_wait:
-	if (server->probe.responded)
+	if (estate->responded)
 		return 0;
 	if (is_intr && signal_pending(current))
 		return -ERESTARTSYS;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 4f98b43b0dde..f1f879ba9cf7 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1697,7 +1697,7 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 
 static void afs_fs_get_capabilities_destructor(struct afs_call *call)
 {
-	afs_put_addrlist(call->probe_alist, afs_alist_trace_put_getcaps);
+	afs_put_endpoint_state(call->probe, afs_estate_trace_put_getcaps);
 	afs_flat_call_destructor(call);
 }
 
@@ -1719,7 +1719,7 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
  * ->done() - otherwise we return false to indicate we didn't even try.
  */
 bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
-			     struct afs_addr_list *alist, unsigned int addr_index,
+			     struct afs_endpoint_state *estate, unsigned int addr_index,
 			     struct key *key)
 {
 	struct afs_call *call;
@@ -1733,8 +1733,8 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 
 	call->key	= key;
 	call->server	= afs_use_server(server, afs_server_trace_get_caps);
-	call->peer	= rxrpc_kernel_get_peer(alist->addrs[addr_index].peer);
-	call->probe_alist = afs_get_addrlist(alist, afs_alist_trace_get_getcaps);
+	call->peer	= rxrpc_kernel_get_peer(estate->addresses->addrs[addr_index].peer);
+	call->probe	= afs_get_endpoint_state(estate, afs_estate_trace_get_getcaps);
 	call->probe_index = addr_index;
 	call->service_id = server->service_id;
 	call->upgrade	= true;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 88db04220773..4d42f84a8da4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -33,6 +33,7 @@
 struct pagevec;
 struct afs_call;
 struct afs_vnode;
+struct afs_server_probe;
 
 /*
  * Partial file-locking emulation mode.  (The problem being that AFS3 only
@@ -146,14 +147,13 @@ struct afs_call {
 	};
 	void			*buffer;	/* reply receive buffer */
 	union {
-		struct {
-			struct afs_addr_list	*probe_alist;
-			unsigned char		probe_index;	/* Address in ->probe_alist */
-		};
+		struct afs_endpoint_state *probe;
+		struct afs_addr_list	*vl_probe;
 		struct afs_addr_list	*ret_alist;
 		struct afs_vldb_entry	*ret_vldb;
 		char			*ret_str;
 	};
+	unsigned char		probe_index;	/* Address in ->probe_alist */
 	struct afs_operation	*op;
 	unsigned int		server_index;
 	refcount_t		ref;
@@ -520,6 +520,32 @@ struct afs_vldb_entry {
 	u8			name[AFS_MAXVOLNAME + 1]; /* NUL-padded volume name */
 };
 
+/*
+ * Fileserver endpoint state.  The records the addresses of a fileserver's
+ * endpoints and the state and result of a round of probing on them.  This
+ * allows the rotation algorithm to access those results without them being
+ * erased by a subsequent round of probing.
+ */
+struct afs_endpoint_state {
+	struct rcu_head		rcu;
+	struct afs_addr_list	*addresses;	/* The addresses being probed */
+	unsigned long		responsive_set;	/* Bitset of responsive endpoints */
+	unsigned long		failed_set;	/* Bitset of endpoints we failed to probe */
+	refcount_t		ref;
+	unsigned int		server_id;	/* Debug ID of server */
+	unsigned int		probe_seq;	/* Probe sequence (from server::probe_counter) */
+
+	atomic_t		nr_probing;	/* Number of outstanding probes */
+	unsigned int		rtt;		/* Best RTT in uS (or UINT_MAX) */
+	s32			abort_code;
+	short			error;
+	bool			responded:1;
+	bool			is_yfs:1;
+	bool			not_yfs:1;
+	bool			local_failure:1;
+	bool			superseded:1;	/* Set if has been superseded */
+};
+
 /*
  * Record of fileserver with which we're actively communicating.
  */
@@ -530,7 +556,6 @@ struct afs_server {
 		struct afs_uuid	_uuid;
 	};
 
-	struct afs_addr_list	__rcu *addresses;
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
 	struct rb_node		uuid_rb;	/* Link in net->fs_servers */
 	struct afs_server __rcu	*uuid_next;	/* Next server with same UUID */
@@ -568,19 +593,11 @@ struct afs_server {
 	unsigned		cb_s_break;	/* Break-everything counter. */
 
 	/* Probe state */
+	struct afs_endpoint_state __rcu *endpoint_state; /* Latest endpoint/probe state */
 	unsigned long		probed_at;	/* Time last probe was dispatched (jiffies) */
 	wait_queue_head_t	probe_wq;
-	atomic_t		probe_outstanding;
+	unsigned int		probe_counter;	/* Number of probes issued */
 	spinlock_t		probe_lock;
-	struct {
-		unsigned int	rtt;		/* Best RTT in uS (or UINT_MAX) */
-		u32		abort_code;
-		short		error;
-		bool		responded:1;
-		bool		is_yfs:1;
-		bool		not_yfs:1;
-		bool		local_failure:1;
-	} probe;
 };
 
 /*
@@ -883,7 +900,7 @@ struct afs_operation {
 	/* Fileserver iteration state */
 	struct afs_server_list	*server_list;	/* Current server list (pins ref) */
 	struct afs_server	*server;	/* Server we're using (ref pinned by server_list) */
-	struct afs_addr_list	*alist;		/* Current address list (pins ref) */
+	struct afs_endpoint_state *estate;	/* Current endpoint state (pins ref) */
 	struct afs_call		*call;
 	unsigned long		untried_servers; /* Bitmask of untried servers */
 	unsigned long		addr_tried;	/* Tried addresses */
@@ -1153,7 +1170,7 @@ extern void afs_fs_release_lock(struct afs_operation *);
 int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
 				 struct afs_address *addr, struct key *key);
 bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
-			     struct afs_addr_list *alist, unsigned int addr_index,
+			     struct afs_endpoint_state *estate, unsigned int addr_index,
 			     struct key *key);
 extern void afs_fs_inline_bulk_status(struct afs_operation *);
 
@@ -1190,12 +1207,17 @@ static inline void afs_op_set_fid(struct afs_operation *op, unsigned int n,
 /*
  * fs_probe.c
  */
+struct afs_endpoint_state *afs_get_endpoint_state(struct afs_endpoint_state *estate,
+						  enum afs_estate_trace where);
+void afs_put_endpoint_state(struct afs_endpoint_state *estate, enum afs_estate_trace where);
 extern void afs_fileserver_probe_result(struct afs_call *);
-extern void afs_fs_probe_fileserver(struct afs_net *, struct afs_server *, struct key *, bool);
+void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
+			     struct afs_addr_list *new_addrs, struct key *key);
 extern int afs_wait_for_fs_probes(struct afs_server_list *, unsigned long);
 extern void afs_probe_fileserver(struct afs_net *, struct afs_server *);
 extern void afs_fs_probe_dispatcher(struct work_struct *);
-extern int afs_wait_for_one_fs_probe(struct afs_server *, bool);
+int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_state *estate,
+			      bool is_intr);
 extern void afs_fs_probe_cleanup(struct afs_net *);
 
 /*
@@ -1348,12 +1370,14 @@ extern int afs_protocol_error(struct afs_call *, enum afs_eproto_cause);
 static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *call,
 				    gfp_t gfp)
 {
+	struct afs_addr_list *alist = op->estate->addresses;
+
 	op->call	= call;
 	op->type	= call->type;
 	call->op	= op;
 	call->key	= op->key;
 	call->intr	= !(op->flags & AFS_OPERATION_UNINTR);
-	call->peer	= rxrpc_kernel_get_peer(op->alist->addrs[op->addr_index].peer);
+	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
 	call->service_id = op->server->service_id;
 	afs_make_call(call, gfp);
 }
@@ -1476,7 +1500,7 @@ extern void afs_manage_servers(struct work_struct *);
 extern void afs_servers_timer(struct timer_list *);
 extern void afs_fs_probe_timer(struct timer_list *);
 extern void __net_exit afs_purge_servers(struct afs_net *);
-extern bool afs_check_server_record(struct afs_operation *, struct afs_server *);
+bool afs_check_server_record(struct afs_operation *op, struct afs_server *server, struct key *key);
 
 static inline void afs_inc_servers_outstanding(struct afs_net *net)
 {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 944eb51e75a1..a138022d8e0d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -424,8 +424,9 @@ static const struct seq_operations afs_proc_cell_vlservers_ops = {
  */
 static int afs_proc_servers_show(struct seq_file *m, void *v)
 {
-	struct afs_server *server;
+	struct afs_endpoint_state *estate;
 	struct afs_addr_list *alist;
+	struct afs_server *server;
 	unsigned long failed;
 	int i;
 
@@ -435,7 +436,8 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	}
 
 	server = list_entry(v, struct afs_server, proc_link);
-	alist = rcu_dereference(server->addresses);
+	estate = rcu_dereference(server->endpoint_state);
+	alist = estate->addresses;
 	seq_printf(m, "%pU %3d %3d %s\n",
 		   &server->uuid,
 		   refcount_read(&server->ref),
@@ -443,13 +445,14 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   server->cell->name);
 	seq_printf(m, "  - info: fl=%lx rtt=%u brk=%x\n",
 		   server->flags, server->rtt, server->cb_s_break);
-	seq_printf(m, "  - probe: last=%d out=%d\n",
-		   (int)(jiffies - server->probed_at) / HZ,
-		   atomic_read(&server->probe_outstanding));
-	failed = alist->probe_failed;
-	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx ap=%u\n",
-		   alist->version, alist->responded, alist->probe_failed,
-		   alist->addr_pref_version);
+	seq_printf(m, "  - probe: last=%d\n",
+		   (int)(jiffies - server->probed_at) / HZ);
+	failed = estate->failed_set;
+	seq_printf(m, "  - ESTATE pq=%x np=%u rsp=%lx f=%lx\n",
+		   estate->probe_seq, atomic_read(&estate->nr_probing),
+		   estate->responsive_set, estate->failed_set);
+	seq_printf(m, "  - ALIST v=%u ap=%u\n",
+		   alist->version, alist->addr_pref_version);
 	for (i = 0; i < alist->nr_addrs; i++) {
 		const struct afs_address *addr = &alist->addrs[i];
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 5423ac80f4e0..e8635f60b97d 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -109,10 +109,11 @@ static bool afs_sleep_and_retry(struct afs_operation *op)
  */
 bool afs_select_fileserver(struct afs_operation *op)
 {
-	struct afs_addr_list *alist = op->alist;
+	struct afs_endpoint_state *estate = op->estate;
+	struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct afs_vnode *vnode = op->file[0].vnode;
-	unsigned long set;
+	unsigned long set, failed;
 	unsigned int rtt;
 	s32 abort_code = op->call_abort_code;
 	int error = op->call_error, addr_index, i;
@@ -133,7 +134,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (op->nr_iterations == 0)
 		goto start;
 
-	WRITE_ONCE(alist->addrs[op->addr_index].last_error, error);
+	WRITE_ONCE(estate->addresses->addrs[op->addr_index].last_error, error);
 
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (op->call_error) {
@@ -401,14 +402,14 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 restart_from_beginning:
 	_debug("restart");
-	afs_put_addrlist(alist, afs_alist_trace_put_restart_rotate);
-	alist = op->alist = NULL;
+	afs_put_endpoint_state(estate, afs_estate_trace_put_restart_rotate);
+	estate = op->estate = NULL;
 	op->server = NULL;
 	afs_put_serverlist(op->net, op->server_list);
 	op->server_list = NULL;
 start:
 	_debug("start");
-	ASSERTCMP(alist, ==, NULL);
+	ASSERTCMP(estate, ==, NULL);
 	/* See if we need to do an update of the volume record.  Note that the
 	 * volume may have moved or even have been deleted.
 	 */
@@ -425,7 +426,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 pick_server:
 	_debug("pick [%lx]", op->untried_servers);
-	ASSERTCMP(alist, ==, NULL);
+	ASSERTCMP(estate, ==, NULL);
 
 	error = afs_wait_for_fs_probes(op->server_list, op->untried_servers);
 	if (error < 0) {
@@ -452,9 +453,9 @@ bool afs_select_fileserver(struct afs_operation *op)
 		if (!test_bit(i, &op->untried_servers) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->probe.rtt <= rtt) {
+		if (s->rtt <= rtt) {
 			op->server_index = i;
-			rtt = s->probe.rtt;
+			rtt = s->rtt;
 		}
 	}
 
@@ -469,10 +470,10 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 * check it, create a callback intercept, find its address list and
 	 * probe its capabilities before we use it.
 	 */
-	ASSERTCMP(alist, ==, NULL);
+	ASSERTCMP(estate, ==, NULL);
 	server = op->server_list->servers[op->server_index].server;
 
-	if (!afs_check_server_record(op, server))
+	if (!afs_check_server_record(op, server, op->key))
 		goto failed;
 
 	_debug("USING SERVER: %pU", &server->uuid);
@@ -488,9 +489,9 @@ bool afs_select_fileserver(struct afs_operation *op)
 	}
 
 	read_lock(&server->fs_lock);
-	alist = rcu_dereference_protected(server->addresses,
-					  lockdep_is_held(&server->fs_lock));
-	op->alist = afs_get_addrlist(alist, afs_alist_trace_get_fsrotate_set);
+	estate = rcu_dereference_protected(server->endpoint_state,
+					   lockdep_is_held(&server->fs_lock));
+	op->estate = afs_get_endpoint_state(estate, afs_estate_trace_get_fsrotate_set);
 	read_unlock(&server->fs_lock);
 
 retry_server:
@@ -501,18 +502,20 @@ bool afs_select_fileserver(struct afs_operation *op)
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	set = READ_ONCE(alist->responded);
-	set &= ~(READ_ONCE(alist->probe_failed) | op->addr_tried);
+	set = READ_ONCE(estate->responsive_set);
+	failed = READ_ONCE(estate->failed_set);
+	_debug("iterate ES=%x rs=%lx fs=%lx", estate->probe_seq, set, failed);
+	set &= ~(failed | op->addr_tried);
 	if (!set)
 		goto out_of_addresses;
 
+	alist = estate->addresses;
 	addr_index = READ_ONCE(alist->preferred);
 	if (!test_bit(addr_index, &set))
 		addr_index = __ffs(set);
 
 	op->addr_index = addr_index;
 	set_bit(addr_index, &op->addr_tried);
-	op->alist = alist;
 
 	op->call_responded = false;
 	_debug("address [%u] %u/%u %pISp",
@@ -527,8 +530,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	 */
 	afs_probe_fileserver(op->net, op->server);
 	if (op->flags & AFS_OPERATION_RETRY_SERVER) {
-		error = afs_wait_for_one_fs_probe(
-			op->server, !(op->flags & AFS_OPERATION_UNINTR));
+		error = afs_wait_for_one_fs_probe(op->server, estate,
+						  !(op->flags & AFS_OPERATION_UNINTR));
 		switch (error) {
 		case 0:
 			op->flags &= ~AFS_OPERATION_RETRY_SERVER;
@@ -544,13 +547,14 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 next_server:
 	_debug("next");
-	ASSERT(alist);
+	ASSERT(estate);
+	alist = estate->addresses;
 	if (op->call_responded &&
 	    op->addr_index != READ_ONCE(alist->preferred) &&
 	    test_bit(alist->preferred, &op->addr_tried))
 		WRITE_ONCE(alist->preferred, op->addr_index);
-	afs_put_addrlist(alist, afs_alist_trace_put_next_server);
-	alist = op->alist = NULL;
+	afs_put_endpoint_state(estate, afs_estate_trace_put_next_server);
+	estate = op->estate = NULL;
 	goto pick_server;
 
 no_more_servers:
@@ -560,23 +564,28 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (op->flags & AFS_OPERATION_VBUSY)
 		goto restart_from_beginning;
 
+	rcu_read_lock();
 	for (i = 0; i < op->server_list->nr_servers; i++) {
+		struct afs_endpoint_state *estate;
 		struct afs_server *s = op->server_list->servers[i].server;
 
-		error = READ_ONCE(s->probe.error);
+		estate = rcu_dereference(s->endpoint_state);
+		error = READ_ONCE(estate->error);
 		if (error < 0)
-			afs_op_accumulate_error(op, error, s->probe.abort_code);
+			afs_op_accumulate_error(op, error, estate->abort_code);
 	}
+	rcu_read_unlock();
 
 failed:
 	op->flags |= AFS_OPERATION_STOP;
-	if (alist) {
+	if (estate) {
+		alist = estate->addresses;
 		if (op->call_responded &&
 		    op->addr_index != READ_ONCE(alist->preferred) &&
 		    test_bit(alist->preferred, &op->addr_tried))
 			WRITE_ONCE(alist->preferred, op->addr_index);
-		afs_put_addrlist(alist, afs_alist_trace_put_op_failed);
-		op->alist = NULL;
+		afs_put_endpoint_state(estate, afs_estate_trace_put_op_failed);
+		op->estate = NULL;
 	}
 	_leave(" = f [failed %d]", afs_op_error(op));
 	return false;
@@ -607,27 +616,30 @@ void afs_dump_edestaddrreq(const struct afs_operation *op)
 
 	if (op->server_list) {
 		const struct afs_server_list *sl = op->server_list;
+
 		pr_notice("FC: SL nr=%u pr=%u vnov=%hx\n",
 			  sl->nr_servers, sl->preferred, sl->vnovol_mask);
 		for (i = 0; i < sl->nr_servers; i++) {
 			const struct afs_server *s = sl->servers[i].server;
+			const struct afs_endpoint_state *e =
+				rcu_dereference(s->endpoint_state);
+			const struct afs_addr_list *a = e->addresses;
+
 			pr_notice("FC: server fl=%lx av=%u %pU\n",
 				  s->flags, s->addr_version, &s->uuid);
-			if (s->addresses) {
-				const struct afs_addr_list *a =
-					rcu_dereference(s->addresses);
+			pr_notice("FC:  - pq=%x R=%lx F=%lx\n",
+				  e->probe_seq, e->responsive_set, e->failed_set);
+			if (a) {
 				pr_notice("FC:  - av=%u nr=%u/%u/%u pr=%u\n",
 					  a->version,
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
 					  a->preferred);
-				pr_notice("FC:  - R=%lx F=%lx\n",
-					  a->responded, a->probe_failed);
-				if (a == op->alist)
+				if (a == e->addresses)
 					pr_notice("FC:  - current\n");
 			}
 		}
 	}
 
-	pr_notice("AC: t=%lx ax=%u\n", op->addr_tried, op->addr_index);
+	pr_notice("AC: t=%lx ax=%d\n", op->addr_tried, op->addr_index);
 	rcu_read_unlock();
 }
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 62d453365689..281625c71aff 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -23,6 +23,7 @@ static void __afs_put_server(struct afs_net *, struct afs_server *);
  */
 struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer *peer)
 {
+	const struct afs_endpoint_state *estate;
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
@@ -38,7 +39,8 @@ struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
 		hlist_for_each_entry_rcu(server, &net->fs_addresses6, addr6_link) {
-			alist = rcu_dereference(server->addresses);
+			estate = rcu_dereference(server->endpoint_state);
+			alist = estate->addresses;
 			for (i = 0; i < alist->nr_addrs; i++)
 				if (alist->addrs[i].peer == peer)
 					goto found;
@@ -111,6 +113,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 static struct afs_server *afs_install_server(struct afs_cell *cell,
 					     struct afs_server *candidate)
 {
+	const struct afs_endpoint_state *estate;
 	const struct afs_addr_list *alist;
 	struct afs_server *server, *next;
 	struct afs_net *net = cell->net;
@@ -162,8 +165,9 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 
 added_dup:
 	write_seqlock(&net->fs_addr_lock);
-	alist = rcu_dereference_protected(server->addresses,
-					  lockdep_is_held(&net->fs_addr_lock.lock));
+	estate = rcu_dereference_protected(server->endpoint_state,
+					   lockdep_is_held(&net->fs_addr_lock.lock));
+	alist = estate->addresses;
 
 	/* Secondly, if the server has any IPv4 and/or IPv6 addresses, install
 	 * it in the IPv4 and/or IPv6 reverse-map lists.
@@ -193,6 +197,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 					   const uuid_t *uuid,
 					   struct afs_addr_list *alist)
 {
+	struct afs_endpoint_state *estate;
 	struct afs_server *server;
 	struct afs_net *net = cell->net;
 
@@ -202,10 +207,13 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	if (!server)
 		goto enomem;
 
+	estate = kzalloc(sizeof(struct afs_endpoint_state), GFP_KERNEL);
+	if (!estate)
+		goto enomem_server;
+
 	refcount_set(&server->ref, 1);
 	atomic_set(&server->active, 1);
 	server->debug_id = atomic_inc_return(&afs_server_debug_id);
-	RCU_INIT_POINTER(server->addresses, alist);
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
@@ -217,11 +225,23 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->rtt = UINT_MAX;
 	server->service_id = FS_SERVICE;
 
+	server->probe_counter = 1;
+	server->probed_at = jiffies - LONG_MAX / 2;
+	refcount_set(&estate->ref, 1);
+	estate->addresses = alist;
+	estate->server_id = server->debug_id;
+	estate->probe_seq = 1;
+	rcu_assign_pointer(server->endpoint_state, estate);
+
 	afs_inc_servers_outstanding(net);
 	trace_afs_server(server->debug_id, 1, 1, afs_server_trace_alloc);
+	trace_afs_estate(estate->server_id, estate->probe_seq, refcount_read(&estate->ref),
+			 afs_estate_trace_alloc_server);
 	_leave(" = %p", server);
 	return server;
 
+enomem_server:
+	kfree(server);
 enomem:
 	_leave(" = NULL [nomem]");
 	return NULL;
@@ -289,7 +309,7 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 		 * on the fileserver.  This will make sure the repeat-probing
 		 * service is started.
 		 */
-		afs_fs_probe_fileserver(cell->net, server, key, true);
+		afs_fs_probe_fileserver(cell->net, server, alist, key);
 	}
 
 	return server;
@@ -422,8 +442,8 @@ static void afs_server_rcu(struct rcu_head *rcu)
 
 	trace_afs_server(server->debug_id, refcount_read(&server->ref),
 			 atomic_read(&server->active), afs_server_trace_free);
-	afs_put_addrlist(rcu_access_pointer(server->addresses),
-			 afs_alist_trace_put_server);
+	afs_put_endpoint_state(rcu_access_pointer(server->endpoint_state),
+			       afs_estate_trace_put_server);
 	kfree(server);
 }
 
@@ -435,7 +455,8 @@ static void __afs_put_server(struct afs_net *net, struct afs_server *server)
 
 static void afs_give_up_callbacks(struct afs_net *net, struct afs_server *server)
 {
-	struct afs_addr_list *alist = rcu_access_pointer(server->addresses);
+	struct afs_endpoint_state *estate = rcu_access_pointer(server->endpoint_state);
+	struct afs_addr_list *alist = estate->addresses;
 
 	afs_fs_give_up_all_callbacks(net, server, &alist->addrs[alist->preferred], NULL);
 }
@@ -607,9 +628,12 @@ void afs_purge_servers(struct afs_net *net)
  * Get an update for a server's address list.
  */
 static noinline bool afs_update_server_record(struct afs_operation *op,
-					      struct afs_server *server)
+					      struct afs_server *server,
+					      struct key *key)
 {
-	struct afs_addr_list *alist, *discard;
+	struct afs_endpoint_state *estate;
+	struct afs_addr_list *alist;
+	bool has_addrs;
 
 	_enter("");
 
@@ -619,10 +643,15 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 
 	alist = afs_vl_lookup_addrs(op->volume->cell, op->key, &server->uuid);
 	if (IS_ERR(alist)) {
+		rcu_read_lock();
+		estate = rcu_dereference(server->endpoint_state);
+		has_addrs = estate->addresses;
+		rcu_read_unlock();
+
 		if ((PTR_ERR(alist) == -ERESTARTSYS ||
 		     PTR_ERR(alist) == -EINTR) &&
 		    (op->flags & AFS_OPERATION_UNINTR) &&
-		    server->addresses) {
+		    has_addrs) {
 			_leave(" = t [intr]");
 			return true;
 		}
@@ -631,17 +660,10 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 		return false;
 	}
 
-	discard = alist;
-	if (server->addr_version != alist->version) {
-		write_lock(&server->fs_lock);
-		discard = rcu_dereference_protected(server->addresses,
-						    lockdep_is_held(&server->fs_lock));
-		rcu_assign_pointer(server->addresses, alist);
-		server->addr_version = alist->version;
-		write_unlock(&server->fs_lock);
-	}
+	if (server->addr_version != alist->version)
+		afs_fs_probe_fileserver(op->net, server, alist, key);
 
-	afs_put_addrlist(discard, afs_alist_trace_put_server_update);
+	afs_put_addrlist(alist, afs_alist_trace_put_server_update);
 	_leave(" = t");
 	return true;
 }
@@ -649,7 +671,8 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 /*
  * See if a server's address list needs updating.
  */
-bool afs_check_server_record(struct afs_operation *op, struct afs_server *server)
+bool afs_check_server_record(struct afs_operation *op, struct afs_server *server,
+			     struct key *key)
 {
 	bool success;
 	int ret, retries = 0;
@@ -669,7 +692,7 @@ bool afs_check_server_record(struct afs_operation *op, struct afs_server *server
 update:
 	if (!test_and_set_bit_lock(AFS_SERVER_FL_UPDATING, &server->flags)) {
 		clear_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags);
-		success = afs_update_server_record(op, server);
+		success = afs_update_server_record(op, server, key);
 		clear_bit_unlock(AFS_SERVER_FL_UPDATING, &server->flags);
 		wake_up_bit(&server->flags, AFS_SERVER_FL_UPDATING);
 		_leave(" = %d", success);
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 89cadd9a69e1..43788d0c18e8 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -41,8 +41,8 @@ static int afs_compare_fs_alists(const struct afs_server *server_a,
 	const struct afs_addr_list *la, *lb;
 	int a = 0, b = 0, addr_matches = 0;
 
-	la = rcu_dereference(server_a->addresses);
-	lb = rcu_dereference(server_b->addresses);
+	la = rcu_dereference(server_a->endpoint_state)->addresses;
+	lb = rcu_dereference(server_b->endpoint_state)->addresses;
 
 	while (a < la->nr_addrs && b < lb->nr_addrs) {
 		unsigned long pa = (unsigned long)la->addrs[a].peer;
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index b128dc3d8af7..3d2e0c925460 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -46,7 +46,7 @@ static void afs_done_one_vl_probe(struct afs_vlserver *server, bool wake_up)
  */
 void afs_vlserver_probe_result(struct afs_call *call)
 {
-	struct afs_addr_list *alist = call->probe_alist;
+	struct afs_addr_list *alist = call->vl_probe;
 	struct afs_vlserver *server = call->vlserver;
 	struct afs_address *addr = &alist->addrs[call->probe_index];
 	unsigned int server_index = call->server_index;
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 39a0b7614d05..cef02a265edc 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -371,7 +371,7 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 
 static void afs_destroy_vl_get_capabilities(struct afs_call *call)
 {
-	afs_put_addrlist(call->probe_alist, afs_alist_trace_put_vlgetcaps);
+	afs_put_addrlist(call->vl_probe, afs_alist_trace_put_vlgetcaps);
 	afs_put_vlserver(call->net, call->vlserver);
 	afs_flat_call_destructor(call);
 }
@@ -414,7 +414,7 @@ struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
 	call->vlserver = afs_get_vlserver(server);
 	call->server_index = server_index;
 	call->peer = rxrpc_kernel_get_peer(alist->addrs[addr_index].peer);
-	call->probe_alist = afs_get_addrlist(alist, afs_alist_trace_get_vlgetcaps);
+	call->vl_probe = afs_get_addrlist(alist, afs_alist_trace_get_vlgetcaps);
 	call->probe_index = addr_index;
 	call->service_id = server->service_id;
 	call->upgrade = true;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index f1815b3dafb0..cf2fa4fddd5b 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -204,22 +204,14 @@ enum yfs_cm_operation {
 
 #define afs_alist_traces \
 	EM(afs_alist_trace_alloc,		"ALLOC     ") \
-	EM(afs_alist_trace_get_getcaps,		"GET getcap") \
-	EM(afs_alist_trace_get_fsrotate_set,	"GET fs-rot") \
-	EM(afs_alist_trace_get_probe,		"GET probe ") \
+	EM(afs_alist_trace_get_estate,		"GET estate") \
 	EM(afs_alist_trace_get_vlgetcaps,	"GET vgtcap") \
 	EM(afs_alist_trace_get_vlprobe,		"GET vprobe") \
 	EM(afs_alist_trace_get_vlrotate_set,	"GET vl-rot") \
+	EM(afs_alist_trace_put_estate,		"PUT estate") \
 	EM(afs_alist_trace_put_getaddru,	"PUT GtAdrU") \
-	EM(afs_alist_trace_put_getcaps,		"PUT getcap") \
-	EM(afs_alist_trace_put_next_server,	"PUT nx-srv") \
-	EM(afs_alist_trace_put_op_failed,	"PUT op-fai") \
-	EM(afs_alist_trace_put_operation,	"PUT op    ") \
 	EM(afs_alist_trace_put_parse_empty,	"PUT p-empt") \
 	EM(afs_alist_trace_put_parse_error,	"PUT p-err ") \
-	EM(afs_alist_trace_put_probe,		"PUT probe ") \
-	EM(afs_alist_trace_put_restart_rotate,	"PUT rstrot") \
-	EM(afs_alist_trace_put_server,		"PUT server") \
 	EM(afs_alist_trace_put_server_dup,	"PUT sv-dup") \
 	EM(afs_alist_trace_put_server_oom,	"PUT sv-oom") \
 	EM(afs_alist_trace_put_server_update,	"PUT sv-upd") \
@@ -233,6 +225,20 @@ enum yfs_cm_operation {
 	EM(afs_alist_trace_put_vlserver_old,	"PUT vs-old") \
 	E_(afs_alist_trace_free,		"FREE      ")
 
+#define afs_estate_traces \
+	EM(afs_estate_trace_alloc_probe,	"ALLOC prob") \
+	EM(afs_estate_trace_alloc_server,	"ALLOC srvr") \
+	EM(afs_estate_trace_get_fsrotate_set,	"GET fs-rot") \
+	EM(afs_estate_trace_get_getcaps,	"GET getcap") \
+	EM(afs_estate_trace_put_getcaps,	"PUT getcap") \
+	EM(afs_estate_trace_put_next_server,	"PUT nx-srv") \
+	EM(afs_estate_trace_put_op_failed,	"PUT op-fai") \
+	EM(afs_estate_trace_put_operation,	"PUT op    ") \
+	EM(afs_estate_trace_put_probe,		"PUT probe ") \
+	EM(afs_estate_trace_put_restart_rotate,	"PUT rstrot") \
+	EM(afs_estate_trace_put_server,		"PUT server") \
+	E_(afs_estate_trace_free,		"FREE      ")
+
 #define afs_fs_operations \
 	EM(afs_FS_FetchData,			"FS.FetchData") \
 	EM(afs_FS_FetchStatus,			"FS.FetchStatus") \
@@ -458,6 +464,7 @@ enum afs_cell_trace		{ afs_cell_traces } __mode(byte);
 enum afs_edit_dir_op		{ afs_edit_dir_ops } __mode(byte);
 enum afs_edit_dir_reason	{ afs_edit_dir_reasons } __mode(byte);
 enum afs_eproto_cause		{ afs_eproto_causes } __mode(byte);
+enum afs_estate_trace		{ afs_estate_traces } __mode(byte);
 enum afs_file_error		{ afs_file_errors } __mode(byte);
 enum afs_flock_event		{ afs_flock_events } __mode(byte);
 enum afs_flock_operation	{ afs_flock_operations } __mode(byte);
@@ -486,6 +493,7 @@ yfs_cm_operations;
 afs_edit_dir_ops;
 afs_edit_dir_reasons;
 afs_eproto_causes;
+afs_estate_traces;
 afs_io_errors;
 afs_file_errors;
 afs_flock_types;
@@ -1387,14 +1395,43 @@ TRACE_EVENT(afs_alist,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(afs_estate,
+	    TP_PROTO(unsigned int server_debug_id, unsigned int estate_debug_id,
+		     int ref, enum afs_estate_trace reason),
+
+	    TP_ARGS(server_debug_id, estate_debug_id, ref, reason),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		server)
+		    __field(unsigned int,		estate)
+		    __field(int,			ref)
+		    __field(int,			active)
+		    __field(int,			reason)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->server = server_debug_id;
+		    __entry->estate = estate_debug_id;
+		    __entry->ref = ref;
+		    __entry->reason = reason;
+			   ),
+
+	    TP_printk("ES=%08x[%x] %s r=%d",
+		      __entry->server,
+		      __entry->estate,
+		      __print_symbolic(__entry->reason, afs_estate_traces),
+		      __entry->ref)
+	    );
+
 TRACE_EVENT(afs_fs_probe,
-	    TP_PROTO(struct afs_server *server, bool tx, struct afs_addr_list *alist,
+	    TP_PROTO(struct afs_server *server, bool tx, struct afs_endpoint_state *estate,
 		     unsigned int addr_index, int error, s32 abort_code, unsigned int rtt_us),
 
-	    TP_ARGS(server, tx, alist, addr_index, error, abort_code, rtt_us),
+	    TP_ARGS(server, tx, estate, addr_index, error, abort_code, rtt_us),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		server)
+		    __field(unsigned int,		estate)
 		    __field(bool,			tx)
 		    __field(u16,			addr_index)
 		    __field(short,			error)
@@ -1404,7 +1441,9 @@ TRACE_EVENT(afs_fs_probe,
 			     ),
 
 	    TP_fast_assign(
+		    struct afs_addr_list *alist = estate->addresses;
 		    __entry->server = server->debug_id;
+		    __entry->estate = estate->probe_seq;
 		    __entry->tx = tx;
 		    __entry->addr_index = addr_index;
 		    __entry->error = error;
@@ -1414,9 +1453,9 @@ TRACE_EVENT(afs_fs_probe,
 			   sizeof(__entry->srx));
 			   ),
 
-	    TP_printk("s=%08x %s ax=%u e=%d ac=%d rtt=%d %pISpc",
-		      __entry->server, __entry->tx ? "tx" : "rx", __entry->addr_index,
-		      __entry->error, __entry->abort_code, __entry->rtt_us,
+	    TP_printk("s=%08x %s pq=%x ax=%u e=%d ac=%d rtt=%d %pISpc",
+		      __entry->server, __entry->tx ? "tx" : "rx", __entry->estate,
+		      __entry->addr_index, __entry->error, __entry->abort_code, __entry->rtt_us,
 		      &__entry->srx.transport)
 	    );
 



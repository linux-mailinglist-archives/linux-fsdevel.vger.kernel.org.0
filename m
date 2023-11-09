Return-Path: <linux-fsdevel+bounces-2581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13657E6DCC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B699CB21BB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F023236B1D;
	Thu,  9 Nov 2023 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAjVjdGC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113C358A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A113C39
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlmknsHV6huO4rkFnZ1PiiqgNgGgFMxJtP+wB8puc+g=;
	b=YAjVjdGCTSIQAyk9ihmOpmibNnB5YBO+umgzHwWQ1pJrxk/7RDZoUeGTaQLJ+pm7P5PChM
	R3EUC1MXRJaGNFRt9dk8xvRWG6yHSEnpbtPIANgpw2/3qUHwv7llVkvuXdBHSG9QXfCuC7
	TzPWCl2TObshNFKbwWMsC5fBnoV45hU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-4hJOkfx-OQiHHTun6MThrg-1; Thu,
 09 Nov 2023 10:41:18 -0500
X-MC-Unique: 4hJOkfx-OQiHHTun6MThrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19C5A38012D6;
	Thu,  9 Nov 2023 15:41:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 191781C060B1;
	Thu,  9 Nov 2023 15:41:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 40/41] afs: Fix fileserver rotation
Date: Thu,  9 Nov 2023 15:40:03 +0000
Message-ID: <20231109154004.3317227-41-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Fix the fileserver rotation so that it doesn't use RTT as the basis for
deciding which server and address to use as this doesn't necessarily give a
good indication of the best path.  Instead, use the configurable preference
list in conjunction with whatever probes have succeeded at the time of
looking.

To this end, make the following changes:

 (1) Keep an array of "server states" to track what addresses we've tried
     on each server and move the waitqueue entries there that we'll need
     for probing.

 (2) Each afs_server_state struct is made to pin the corresponding server's
     endpoint state rather than the afs_operation struct carrying a pin on
     the server we're currently looking at.

 (3) Drop the server list preference; we now always rescan the server list.

 (4) afs_wait_for_probes() now uses the server state list to guide it in
     what it waits for (and to provide the waitqueue entries) and returns
     an indication of whether we'd got a response, run out of responsive
     addresses or the endpoint state had been superseded and we need to
     restart the iteration.

 (5) We call afs_get_address_preferences*() occasionally to refresh the
     preference values.

 (6) When picking a server, scan the addresses of the servers for which we
     have as-yet untested communications, looking for the highest priority
     one and use that instead of trying all the addresses for a particular
     server in ascending-RTT order.

Also add a tracepoint to track progress through the rotation algorithm.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c      |   8 +-
 fs/afs/fs_probe.c          | 103 +++++++++--------------
 fs/afs/internal.h          |  23 ++++-
 fs/afs/rotate.c            | 168 +++++++++++++++++++++++++++----------
 fs/afs/server_list.c       |  14 +---
 include/trace/events/afs.h |  80 +++++++++++++++---
 6 files changed, 256 insertions(+), 140 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index c9e85fa94d58..4c2ac403751d 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -230,7 +230,6 @@ void afs_wait_for_operation(struct afs_operation *op)
  */
 int afs_put_operation(struct afs_operation *op)
 {
-	struct afs_endpoint_state *estate = op->estate;
 	struct afs_addr_list *alist;
 	int i, ret = afs_op_error(op);
 
@@ -254,18 +253,17 @@ int afs_put_operation(struct afs_operation *op)
 		kfree(op->more_files);
 	}
 
-	if (estate) {
-		alist = estate->addresses;
+	if (op->estate) {
+		alist = op->estate->addresses;
 		if (alist) {
 			if (op->call_responded &&
 			    op->addr_index != alist->preferred &&
 			    test_bit(alist->preferred, &op->addr_tried))
 				WRITE_ONCE(alist->preferred, op->addr_index);
 		}
-		afs_put_endpoint_state(estate, afs_estate_trace_put_operation);
-		op->estate = NULL;
 	}
 
+	afs_clear_server_states(op);
 	afs_put_serverlist(op->net, op->server_list);
 	afs_put_volume(op->volume, afs_volume_trace_put_put_op);
 	key_put(op->key);
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index c00d38b98a67..580de4adaaf6 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -296,58 +296,48 @@ void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 }
 
 /*
- * Wait for the first as-yet untried fileserver to respond.
+ * Wait for the first as-yet untried fileserver to respond, for the probe state
+ * to be superseded or for all probes to finish.
  */
-int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
+int afs_wait_for_fs_probes(struct afs_operation *op, struct afs_server_state *states, bool intr)
 {
 	struct afs_endpoint_state *estate;
-	struct wait_queue_entry *waits;
-	struct afs_server *server;
-	unsigned int rtt = UINT_MAX, rtt_s;
-	bool have_responders = false;
-	int pref = -1, i;
+	struct afs_server_list *slist = op->server_list;
+	bool still_probing = true;
+	int ret = 0, i;
 
-	_enter("%u,%lx", slist->nr_servers, untried);
+	_enter("%u", slist->nr_servers);
 
-	/* Only wait for servers that have a probe outstanding. */
-	rcu_read_lock();
 	for (i = 0; i < slist->nr_servers; i++) {
-		if (test_bit(i, &untried)) {
-			server = slist->servers[i].server;
-			estate = rcu_dereference(server->endpoint_state);
-			if (!atomic_read(&estate->nr_probing))
-				__clear_bit(i, &untried);
-			if (test_bit(AFS_ESTATE_RESPONDED, &estate->flags))
-				have_responders = true;
-		}
+		estate = states[i].endpoint_state;
+		if (test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags))
+			return 2;
+		if (atomic_read(&estate->nr_probing))
+			still_probing = true;
+		if (estate->responsive_set & states[i].untried_addrs)
+			return 1;
 	}
-	rcu_read_unlock();
-	if (have_responders || !untried)
+	if (!still_probing)
 		return 0;
 
-	waits = kmalloc(array_size(slist->nr_servers, sizeof(*waits)), GFP_KERNEL);
-	if (!waits)
-		return -ENOMEM;
-
-	for (i = 0; i < slist->nr_servers; i++) {
-		if (test_bit(i, &untried)) {
-			server = slist->servers[i].server;
-			init_waitqueue_entry(&waits[i], current);
-			add_wait_queue(&server->probe_wq, &waits[i]);
-		}
-	}
+	for (i = 0; i < slist->nr_servers; i++)
+		add_wait_queue(&slist->servers[i].server->probe_wq, &states[i].probe_waiter);
 
 	for (;;) {
-		bool still_probing = false;
+		still_probing = false;
 
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 		for (i = 0; i < slist->nr_servers; i++) {
-			if (test_bit(i, &untried)) {
-				server = slist->servers[i].server;
-				if (test_bit(AFS_ESTATE_RESPONDED, &estate->flags))
-					goto stop;
-				if (atomic_read(&estate->nr_probing))
-					still_probing = true;
+			estate = states[i].endpoint_state;
+			if (test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags)) {
+				ret = 2;
+				goto stop;
+			}
+			if (atomic_read(&estate->nr_probing))
+				still_probing = true;
+			if (estate->responsive_set & states[i].untried_addrs) {
+				ret = 1;
+				goto stop;
 			}
 		}
 
@@ -359,28 +349,12 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 stop:
 	set_current_state(TASK_RUNNING);
 
-	for (i = 0; i < slist->nr_servers; i++) {
-		if (test_bit(i, &untried)) {
-			server = slist->servers[i].server;
-			rtt_s = READ_ONCE(server->rtt);
-			if (test_bit(AFS_SERVER_FL_RESPONDING, &server->flags) &&
-			    rtt_s < rtt) {
-				pref = i;
-				rtt = rtt_s;
-			}
-
-			remove_wait_queue(&server->probe_wq, &waits[i]);
-		}
-	}
-
-	kfree(waits);
-
-	if (pref == -1 && signal_pending(current))
-		return -ERESTARTSYS;
+	for (i = 0; i < slist->nr_servers; i++)
+		remove_wait_queue(&slist->servers[i].server->probe_wq, &states[i].probe_waiter);
 
-	if (pref >= 0)
-		slist->preferred = pref;
-	return 0;
+	if (!ret && signal_pending(current))
+		ret = -ERESTARTSYS;
+	return ret;
 }
 
 /*
@@ -508,7 +482,7 @@ void afs_fs_probe_dispatcher(struct work_struct *work)
  * Wait for a probe on a particular fileserver to complete for 2s.
  */
 int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_state *estate,
-			      bool is_intr)
+			      unsigned long exclude, bool is_intr)
 {
 	struct wait_queue_entry wait;
 	unsigned long timo = 2 * HZ;
@@ -521,7 +495,8 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_sta
 		prepare_to_wait_event(&server->probe_wq, &wait,
 				      is_intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE);
 		if (timo == 0 ||
-		    test_bit(AFS_ESTATE_RESPONDED, &estate->flags) ||
+		    test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags) ||
+		    (estate->responsive_set & ~exclude) ||
 		    atomic_read(&estate->nr_probing) == 0 ||
 		    (is_intr && signal_pending(current)))
 			break;
@@ -531,7 +506,9 @@ int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_sta
 	finish_wait(&server->probe_wq, &wait);
 
 dont_wait:
-	if (test_bit(AFS_ESTATE_RESPONDED, &estate->flags))
+	if (estate->responsive_set & ~exclude)
+		return 1;
+	if (test_bit(AFS_ESTATE_SUPERSEDED, &estate->flags))
 		return 0;
 	if (is_intr && signal_pending(current))
 		return -ERESTARTSYS;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d9ec8cdca169..d1031241d11b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -610,7 +610,6 @@ struct afs_server_list {
 	refcount_t		usage;
 	bool			attached;	/* T if attached to servers */
 	unsigned char		nr_servers;
-	unsigned char		preferred;	/* Preferred server */
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
 	unsigned int		seq;		/* Set to ->servers_seq when installed */
 	rwlock_t		lock;
@@ -806,6 +805,20 @@ struct afs_vl_cursor {
 	bool			call_responded;	/* T if the current address responded */
 };
 
+/*
+ * Fileserver state tracking for an operation.  An array of these is kept,
+ * indexed by server index.
+ */
+struct afs_server_state {
+	/* Tracking of fileserver probe state.  Other operations may interfere
+	 * by probing a fileserver when accessing other volumes.
+	 */
+	unsigned int		probe_seq;
+	unsigned long		untried_addrs;	/* Addresses we haven't tried yet */
+	struct wait_queue_entry	probe_waiter;
+	struct afs_endpoint_state *endpoint_state; /* Endpoint state being monitored */
+};
+
 /*
  * Fileserver operation methods.
  */
@@ -906,7 +919,8 @@ struct afs_operation {
 	/* Fileserver iteration state */
 	struct afs_server_list	*server_list;	/* Current server list (pins ref) */
 	struct afs_server	*server;	/* Server we're using (ref pinned by server_list) */
-	struct afs_endpoint_state *estate;	/* Current endpoint state (pins ref) */
+	struct afs_endpoint_state *estate;	/* Current endpoint state (doesn't pin ref) */
+	struct afs_server_state	*server_states;	/* States of the servers involved */
 	struct afs_call		*call;
 	unsigned long		untried_servers; /* Bitmask of untried servers */
 	unsigned long		addr_tried;	/* Tried addresses */
@@ -1220,11 +1234,11 @@ void afs_put_endpoint_state(struct afs_endpoint_state *estate, enum afs_estate_t
 extern void afs_fileserver_probe_result(struct afs_call *);
 void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 			     struct afs_addr_list *new_addrs, struct key *key);
-extern int afs_wait_for_fs_probes(struct afs_server_list *, unsigned long);
+int afs_wait_for_fs_probes(struct afs_operation *op, struct afs_server_state *states, bool intr);
 extern void afs_probe_fileserver(struct afs_net *, struct afs_server *);
 extern void afs_fs_probe_dispatcher(struct work_struct *);
 int afs_wait_for_one_fs_probe(struct afs_server *server, struct afs_endpoint_state *estate,
-			      bool is_intr);
+			      unsigned long exclude, bool is_intr);
 extern void afs_fs_probe_cleanup(struct afs_net *);
 
 /*
@@ -1348,6 +1362,7 @@ static inline void afs_put_sysnames(struct afs_sysnames *sysnames) {}
 /*
  * rotate.c
  */
+void afs_clear_server_states(struct afs_operation *op);
 extern bool afs_select_fileserver(struct afs_operation *);
 extern void afs_dump_edestaddrreq(const struct afs_operation *);
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index e0267547f305..3f656dcb0adf 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -15,6 +15,18 @@
 #include "afs_fs.h"
 #include "protocol_uae.h"
 
+void afs_clear_server_states(struct afs_operation *op)
+{
+	unsigned int i;
+
+	if (op->server_states) {
+		for (i = 0; i < op->server_list->nr_servers; i++)
+			afs_put_endpoint_state(op->server_states[i].endpoint_state,
+					       afs_estate_trace_put_server_state);
+		kfree(op->server_states);
+	}
+}
+
 /*
  * Begin iteration through a server list, starting with the vnode's last used
  * server if possible, or the last recorded good server if not.
@@ -26,14 +38,41 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 	void *cb_server;
 	int i;
 
+	trace_afs_rotate(op, afs_rotate_trace_start, 0);
+
 	read_lock(&op->volume->servers_lock);
 	op->server_list = afs_get_serverlist(
 		rcu_dereference_protected(op->volume->servers,
 					  lockdep_is_held(&op->volume->servers_lock)));
 	read_unlock(&op->volume->servers_lock);
 
+	op->server_states = kcalloc(op->server_list->nr_servers, sizeof(op->server_states[0]),
+				    GFP_KERNEL);
+	if (!op->server_states) {
+		afs_op_nomem(op);
+		trace_afs_rotate(op, afs_rotate_trace_nomem, 0);
+		return false;
+	}
+
+	rcu_read_lock();
+	for (i = 0; i < op->server_list->nr_servers; i++) {
+		struct afs_endpoint_state *estate;
+		struct afs_server_state *s = &op->server_states[i];
+
+		server = op->server_list->servers[i].server;
+		estate = rcu_dereference(server->endpoint_state);
+		s->endpoint_state = afs_get_endpoint_state(estate,
+							   afs_estate_trace_get_server_state);
+		s->probe_seq = estate->probe_seq;
+		s->untried_addrs = (1UL << estate->addresses->nr_addrs) - 1;
+		init_waitqueue_entry(&s->probe_waiter, current);
+		afs_get_address_preferences(op->net, estate->addresses);
+	}
+	rcu_read_unlock();
+
+
 	op->untried_servers = (1UL << op->server_list->nr_servers) - 1;
-	op->server_index = READ_ONCE(op->server_list->preferred);
+	op->server_index = -1;
 
 	cb_server = vnode->cb_server;
 	if (cb_server) {
@@ -52,6 +91,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 		 */
 		if (op->flags & AFS_OPERATION_CUR_ONLY) {
 			afs_op_set_error(op, -ESTALE);
+			trace_afs_rotate(op, afs_rotate_trace_stale_lock, 0);
 			return false;
 		}
 
@@ -109,14 +149,13 @@ static bool afs_sleep_and_retry(struct afs_operation *op)
  */
 bool afs_select_fileserver(struct afs_operation *op)
 {
-	struct afs_endpoint_state *estate = op->estate;
 	struct afs_addr_list *alist;
 	struct afs_server *server;
 	struct afs_vnode *vnode = op->file[0].vnode;
 	unsigned long set, failed;
-	unsigned int rtt;
 	s32 abort_code = op->call_abort_code;
-	int error = op->call_error, addr_index, i;
+	int best_prio = 0;
+	int error = op->call_error, addr_index, i, j;
 
 	op->nr_iterations++;
 
@@ -127,6 +166,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	       error, abort_code);
 
 	if (op->flags & AFS_OPERATION_STOP) {
+		trace_afs_rotate(op, afs_rotate_trace_stopped, 0);
 		_leave(" = f [stopped]");
 		return false;
 	}
@@ -134,7 +174,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (op->nr_iterations == 0)
 		goto start;
 
-	WRITE_ONCE(estate->addresses->addrs[op->addr_index].last_error, error);
+	WRITE_ONCE(op->estate->addresses->addrs[op->addr_index].last_error, error);
+	trace_afs_rotate(op, afs_rotate_trace_iter, op->call_error);
 
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (op->call_error) {
@@ -145,6 +186,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		/* Success or local failure.  Stop. */
 		afs_op_set_error(op, error);
 		op->flags |= AFS_OPERATION_STOP;
+		trace_afs_rotate(op, afs_rotate_trace_stop, error);
 		_leave(" = f [okay/local %d]", error);
 		return false;
 
@@ -157,6 +199,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		 * errors instead.  IBM AFS and OpenAFS fileservers, however, do leak
 		 * these abort codes.
 		 */
+		trace_afs_rotate(op, afs_rotate_trace_aborted, abort_code);
 		op->cumul_error.responded = true;
 		switch (abort_code) {
 		case VNOVOL:
@@ -399,19 +442,22 @@ bool afs_select_fileserver(struct afs_operation *op)
 	}
 
 restart_from_beginning:
+	trace_afs_rotate(op, afs_rotate_trace_restart, 0);
 	_debug("restart");
-	afs_put_endpoint_state(estate, afs_estate_trace_put_restart_rotate);
-	estate = op->estate = NULL;
+	op->estate = NULL;
 	op->server = NULL;
+	afs_clear_server_states(op);
+	op->server_states = NULL;
 	afs_put_serverlist(op->net, op->server_list);
 	op->server_list = NULL;
 start:
 	_debug("start");
-	ASSERTCMP(estate, ==, NULL);
+	ASSERTCMP(op->estate, ==, NULL);
 	/* See if we need to do an update of the volume record.  Note that the
 	 * volume may have moved or even have been deleted.
 	 */
 	error = afs_check_volume_status(op->volume, op);
+	trace_afs_rotate(op, afs_rotate_trace_check_vol_status, error);
 	if (error < 0) {
 		afs_op_set_error(op, error);
 		goto failed;
@@ -424,16 +470,29 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 pick_server:
 	_debug("pick [%lx]", op->untried_servers);
-	ASSERTCMP(estate, ==, NULL);
+	ASSERTCMP(op->estate, ==, NULL);
 
-	error = afs_wait_for_fs_probes(op->server_list, op->untried_servers);
-	if (error < 0) {
+	error = afs_wait_for_fs_probes(op, op->server_states,
+				       !(op->flags & AFS_OPERATION_UNINTR));
+	switch (error) {
+	case 0: /* No untried responsive servers and no outstanding probes */
+		trace_afs_rotate(op, afs_rotate_trace_probe_none, 0);
+		goto no_more_servers;
+	case 1: /* Got a response */
+		trace_afs_rotate(op, afs_rotate_trace_probe_response, 0);
+		break;
+	case 2: /* Probe data superseded */
+		trace_afs_rotate(op, afs_rotate_trace_probe_superseded, 0);
+		goto restart_from_beginning;
+	default:
+		trace_afs_rotate(op, afs_rotate_trace_probe_error, error);
 		afs_op_set_error(op, error);
 		goto failed;
 	}
 
-	/* Pick the untried server with the lowest RTT.  If we have outstanding
-	 * callbacks, we stick with the server we're already using if we can.
+	/* Pick the untried server with the highest priority untried endpoint.
+	 * If we have outstanding callbacks, we stick with the server we're
+	 * already using if we can.
 	 */
 	if (op->server) {
 		_debug("server %u", op->server_index);
@@ -443,32 +502,45 @@ bool afs_select_fileserver(struct afs_operation *op)
 		_debug("no server");
 	}
 
+	rcu_read_lock();
 	op->server_index = -1;
-	rtt = UINT_MAX;
+	best_prio = -1;
 	for (i = 0; i < op->server_list->nr_servers; i++) {
+		struct afs_endpoint_state *es;
+		struct afs_addr_list *sal;
 		struct afs_server *s = op->server_list->servers[i].server;
 
 		if (!test_bit(i, &op->untried_servers) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
-		if (s->rtt <= rtt) {
-			op->server_index = i;
-			rtt = s->rtt;
+		es = op->server_states->endpoint_state;
+		sal = es->addresses;
+
+		afs_get_address_preferences_rcu(op->net, sal);
+		for (j = 0; j < sal->nr_addrs; j++) {
+			if (!sal->addrs[j].peer)
+				continue;
+			if (sal->addrs[j].prio > best_prio) {
+				op->server_index = i;
+				best_prio = sal->addrs[j].prio;
+			}
 		}
 	}
+	rcu_read_unlock();
 
 	if (op->server_index == -1)
 		goto no_more_servers;
 
 selected_server:
-	_debug("use %d", op->server_index);
+	trace_afs_rotate(op, afs_rotate_trace_selected_server, best_prio);
+	_debug("use %d prio %u", op->server_index, best_prio);
 	__clear_bit(op->server_index, &op->untried_servers);
 
 	/* We're starting on a different fileserver from the list.  We need to
 	 * check it, create a callback intercept, find its address list and
 	 * probe its capabilities before we use it.
 	 */
-	ASSERTCMP(estate, ==, NULL);
+	ASSERTCMP(op->estate, ==, NULL);
 	server = op->server_list->servers[op->server_index].server;
 
 	if (!afs_check_server_record(op, server, op->key))
@@ -484,12 +556,6 @@ bool afs_select_fileserver(struct afs_operation *op)
 		vnode->cb_expires_at = AFS_NO_CB_PROMISE;
 	}
 
-	read_lock(&server->fs_lock);
-	estate = rcu_dereference_protected(server->endpoint_state,
-					   lockdep_is_held(&server->fs_lock));
-	op->estate = afs_get_endpoint_state(estate, afs_estate_trace_get_fsrotate_set);
-	read_unlock(&server->fs_lock);
-
 retry_server:
 	op->addr_tried = 0;
 	op->addr_index = -1;
@@ -498,14 +564,23 @@ bool afs_select_fileserver(struct afs_operation *op)
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	set = READ_ONCE(estate->responsive_set);
-	failed = READ_ONCE(estate->failed_set);
-	_debug("iterate ES=%x rs=%lx fs=%lx", estate->probe_seq, set, failed);
+	op->estate = op->server_states[op->server_index].endpoint_state;
+	set = READ_ONCE(op->estate->responsive_set);
+	failed = READ_ONCE(op->estate->failed_set);
+	_debug("iterate ES=%x rs=%lx fs=%lx", op->estate->probe_seq, set, failed);
 	set &= ~(failed | op->addr_tried);
+	trace_afs_rotate(op, afs_rotate_trace_iterate_addr, set);
 	if (!set)
-		goto out_of_addresses;
+		goto wait_for_more_probe_results;
+
+	alist = op->estate->addresses;
+	for (i = 0; i < alist->nr_addrs; i++) {
+		if (alist->addrs[i].prio > best_prio) {
+			addr_index = i;
+			best_prio = alist->addrs[i].prio;
+		}
+	}
 
-	alist = estate->addresses;
 	addr_index = READ_ONCE(alist->preferred);
 	if (!test_bit(addr_index, &set))
 		addr_index = __ffs(set);
@@ -520,17 +595,24 @@ bool afs_select_fileserver(struct afs_operation *op)
 	_leave(" = t");
 	return true;
 
-out_of_addresses:
+wait_for_more_probe_results:
+	error = afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tried,
+					  !(op->flags & AFS_OPERATION_UNINTR));
+	if (!error)
+		goto iterate_address;
+
 	/* We've now had a failure to respond on all of a server's addresses -
 	 * immediately probe them again and consider retrying the server.
 	 */
+	trace_afs_rotate(op, afs_rotate_trace_probe_fileserver, 0);
 	afs_probe_fileserver(op->net, op->server);
 	if (op->flags & AFS_OPERATION_RETRY_SERVER) {
-		error = afs_wait_for_one_fs_probe(op->server, estate,
+		error = afs_wait_for_one_fs_probe(op->server, op->estate, op->addr_tried,
 						  !(op->flags & AFS_OPERATION_UNINTR));
 		switch (error) {
 		case 0:
 			op->flags &= ~AFS_OPERATION_RETRY_SERVER;
+			trace_afs_rotate(op, afs_rotate_trace_retry_server, 0);
 			goto retry_server;
 		case -ERESTARTSYS:
 			afs_op_set_error(op, error);
@@ -542,30 +624,30 @@ bool afs_select_fileserver(struct afs_operation *op)
 	}
 
 next_server:
+	trace_afs_rotate(op, afs_rotate_trace_next_server, 0);
 	_debug("next");
-	ASSERT(estate);
-	alist = estate->addresses;
+	ASSERT(op->estate);
+	alist = op->estate->addresses;
 	if (op->call_responded &&
 	    op->addr_index != READ_ONCE(alist->preferred) &&
 	    test_bit(alist->preferred, &op->addr_tried))
 		WRITE_ONCE(alist->preferred, op->addr_index);
-	afs_put_endpoint_state(estate, afs_estate_trace_put_next_server);
-	estate = op->estate = NULL;
+	op->estate = NULL;
 	goto pick_server;
 
 no_more_servers:
 	/* That's all the servers poked to no good effect.  Try again if some
 	 * of them were busy.
 	 */
+	trace_afs_rotate(op, afs_rotate_trace_no_more_servers, 0);
 	if (op->flags & AFS_OPERATION_VBUSY)
 		goto restart_from_beginning;
 
 	rcu_read_lock();
 	for (i = 0; i < op->server_list->nr_servers; i++) {
 		struct afs_endpoint_state *estate;
-		struct afs_server *s = op->server_list->servers[i].server;
 
-		estate = rcu_dereference(s->endpoint_state);
+		estate = op->server_states->endpoint_state;
 		error = READ_ONCE(estate->error);
 		if (error < 0)
 			afs_op_accumulate_error(op, error, estate->abort_code);
@@ -573,14 +655,14 @@ bool afs_select_fileserver(struct afs_operation *op)
 	rcu_read_unlock();
 
 failed:
+	trace_afs_rotate(op, afs_rotate_trace_failed, 0);
 	op->flags |= AFS_OPERATION_STOP;
-	if (estate) {
-		alist = estate->addresses;
+	if (op->estate) {
+		alist = op->estate->addresses;
 		if (op->call_responded &&
 		    op->addr_index != READ_ONCE(alist->preferred) &&
 		    test_bit(alist->preferred, &op->addr_tried))
 			WRITE_ONCE(alist->preferred, op->addr_index);
-		afs_put_endpoint_state(estate, afs_estate_trace_put_op_failed);
 		op->estate = NULL;
 	}
 	_leave(" = f [failed %d]", afs_op_error(op));
@@ -613,8 +695,8 @@ void afs_dump_edestaddrreq(const struct afs_operation *op)
 	if (op->server_list) {
 		const struct afs_server_list *sl = op->server_list;
 
-		pr_notice("FC: SL nr=%u pr=%u vnov=%hx\n",
-			  sl->nr_servers, sl->preferred, sl->vnovol_mask);
+		pr_notice("FC: SL nr=%u vnov=%hx\n",
+			  sl->nr_servers, sl->vnovol_mask);
 		for (i = 0; i < sl->nr_servers; i++) {
 			const struct afs_server *s = sl->servers[i].server;
 			const struct afs_endpoint_state *e =
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index c2c2b429ade2..c9f146f69adf 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -102,8 +102,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 bool afs_annotate_server_list(struct afs_server_list *new,
 			      struct afs_server_list *old)
 {
-	struct afs_server *cur;
-	int i, j;
+	int i;
 
 	if (old->nr_servers != new->nr_servers)
 		goto changed;
@@ -111,19 +110,8 @@ bool afs_annotate_server_list(struct afs_server_list *new,
 	for (i = 0; i < old->nr_servers; i++)
 		if (old->servers[i].server != new->servers[i].server)
 			goto changed;
-
 	return false;
-
 changed:
-	/* Maintain the same preferred server as before if possible. */
-	cur = old->servers[old->preferred].server;
-	for (j = 0; j < new->nr_servers; j++) {
-		if (new->servers[j].server == cur) {
-			new->preferred = j;
-			break;
-		}
-	}
-
 	return true;
 }
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 3905fd9c957f..804d9e147314 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -230,15 +230,12 @@ enum yfs_cm_operation {
 #define afs_estate_traces \
 	EM(afs_estate_trace_alloc_probe,	"ALLOC prob") \
 	EM(afs_estate_trace_alloc_server,	"ALLOC srvr") \
-	EM(afs_estate_trace_get_fsrotate_set,	"GET fs-rot") \
+	EM(afs_estate_trace_get_server_state,	"GET srv-st") \
 	EM(afs_estate_trace_get_getcaps,	"GET getcap") \
 	EM(afs_estate_trace_put_getcaps,	"PUT getcap") \
-	EM(afs_estate_trace_put_next_server,	"PUT nx-srv") \
-	EM(afs_estate_trace_put_op_failed,	"PUT op-fai") \
-	EM(afs_estate_trace_put_operation,	"PUT op    ") \
 	EM(afs_estate_trace_put_probe,		"PUT probe ") \
-	EM(afs_estate_trace_put_restart_rotate,	"PUT rstrot") \
 	EM(afs_estate_trace_put_server,		"PUT server") \
+	EM(afs_estate_trace_put_server_state,	"PUT srv-st") \
 	E_(afs_estate_trace_free,		"FREE      ")
 
 #define afs_fs_operations \
@@ -447,6 +444,28 @@ enum yfs_cm_operation {
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
 	E_(afs_cb_break_for_vos_release,	"break-vos-release")
 
+#define afs_rotate_traces						\
+	EM(afs_rotate_trace_aborted,		"Abortd")		\
+	EM(afs_rotate_trace_check_vol_status,	"VolStt")		\
+	EM(afs_rotate_trace_failed,		"Failed")		\
+	EM(afs_rotate_trace_iter,		"Iter  ")		\
+	EM(afs_rotate_trace_iterate_addr,	"ItAddr")		\
+	EM(afs_rotate_trace_next_server,	"NextSv")		\
+	EM(afs_rotate_trace_no_more_servers,	"NoMore")		\
+	EM(afs_rotate_trace_nomem,		"Nomem ")		\
+	EM(afs_rotate_trace_probe_error,	"PrbErr")		\
+	EM(afs_rotate_trace_probe_fileserver,	"PrbFsv")		\
+	EM(afs_rotate_trace_probe_none,		"PrbNon")		\
+	EM(afs_rotate_trace_probe_response,	"PrbRsp")		\
+	EM(afs_rotate_trace_probe_superseded,	"PrbSup")		\
+	EM(afs_rotate_trace_restart,		"Rstart")		\
+	EM(afs_rotate_trace_retry_server,	"RtrySv")		\
+	EM(afs_rotate_trace_selected_server,	"SlctSv")		\
+	EM(afs_rotate_trace_stale_lock,		"StlLck")		\
+	EM(afs_rotate_trace_start,		"Start ")		\
+	EM(afs_rotate_trace_stop,		"Stop  ")		\
+	E_(afs_rotate_trace_stopped,		"Stoppd")
+
 /*
  * Generate enums for tracing information.
  */
@@ -470,6 +489,7 @@ enum afs_file_error		{ afs_file_errors } __mode(byte);
 enum afs_flock_event		{ afs_flock_events } __mode(byte);
 enum afs_flock_operation	{ afs_flock_operations } __mode(byte);
 enum afs_io_error		{ afs_io_errors } __mode(byte);
+enum afs_rotate_trace		{ afs_rotate_traces } __mode(byte);
 enum afs_server_trace		{ afs_server_traces } __mode(byte);
 enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
 
@@ -485,21 +505,22 @@ enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
 
 afs_alist_traces;
 afs_call_traces;
-afs_server_traces;
+afs_cb_break_reasons;
 afs_cell_traces;
-afs_fs_operations;
-afs_vl_operations;
 afs_cm_operations;
-yfs_cm_operations;
 afs_edit_dir_ops;
 afs_edit_dir_reasons;
 afs_eproto_causes;
 afs_estate_traces;
-afs_io_errors;
 afs_file_errors;
-afs_flock_types;
 afs_flock_operations;
-afs_cb_break_reasons;
+afs_flock_types;
+afs_fs_operations;
+afs_io_errors;
+afs_rotate_traces;
+afs_server_traces;
+afs_vl_operations;
+yfs_cm_operations;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -1518,6 +1539,41 @@ TRACE_EVENT(afs_vl_probe,
 		      &__entry->srx.transport)
 	    );
 
+TRACE_EVENT(afs_rotate,
+	    TP_PROTO(struct afs_operation *op, enum afs_rotate_trace reason, unsigned int extra),
+
+	    TP_ARGS(op, reason, extra),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		op)
+		    __field(unsigned int,		flags)
+		    __field(unsigned int,		extra)
+		    __field(unsigned short,		iteration)
+		    __field(short,			server_index)
+		    __field(short,			addr_index)
+		    __field(enum afs_rotate_trace,	reason)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->op = op->debug_id;
+		    __entry->flags = op->flags;
+		    __entry->iteration = op->nr_iterations;
+		    __entry->server_index = op->server_index;
+		    __entry->addr_index = op->addr_index;
+		    __entry->reason = reason;
+		    __entry->extra = extra;
+			   ),
+
+	    TP_printk("OP=%08x it=%02x %s fl=%x sx=%d ax=%d ext=%d",
+		      __entry->op,
+		      __entry->iteration,
+		      __print_symbolic(__entry->reason, afs_rotate_traces),
+		      __entry->flags,
+		      __entry->server_index,
+		      __entry->addr_index,
+		      __entry->extra)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */



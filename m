Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0E21E8AA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgE2WBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:01:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46217 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728526AbgE2WBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XL04Scze2zegkkeqbfdL0/XA8/ZPfRcF0DWVLzioNdo=;
        b=WznyCtFjxX03YHtFO2VqfDPcUFJXKKRjpFZ+sy07EgXi4E1p4wvcaJKzK4uqDVN9DplCAk
        mlUxeYNwG2rX/agM5Wpj1ghaoETAM/kIRliVQ8KNIJa+QODEKfVcvMW2fkBig/s0V63T8B
        H8UMjsn3nqtgJT7XJEEOzTHER0qhwtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-_Mvd-JYPOqiVdytox5ffrg-1; Fri, 29 May 2020 18:00:59 -0400
X-MC-Unique: _Mvd-JYPOqiVdytox5ffrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAAD71005510;
        Fri, 29 May 2020 22:00:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60D665D9D7;
        Fri, 29 May 2020 22:00:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/27] afs: Actively poll fileservers to maintain NAT or
 firewall openings
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Dave Botsch <botsch@cnf.cornell.edu>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:56 +0100
Message-ID: <159078965654.679399.12489766646979427079.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an AFS client accesses a file, it receives a limited-duration callback
promise that the server will notify it if another client changes a file.
This callback duration can be a few hours in length.

If a client mounts a volume and then an application prevents it from being
unmounted, say by chdir'ing into it, but then does nothing for some time,
the rxrpc_peer record will expire and rxrpc-level keepalive will cease.

If there is NAT or a firewall between the client and the server, the route
back for the server may close after a comparatively short duration, meaning
that attempts by the server to notify the client may then bounce.

The client, however, may (so far as it knows) still have a valid unexpired
promise and will then rely on its cached data and will not see changes made
on the server by a third party until it incidentally rechecks the status or
the promise needs renewal.

To deal with this, the client needs to regularly probe the server.  This
has two effects: firstly, it keeps a route open back for the server, and
secondly, it causes the server to disgorge any notifications that got
queued up because they couldn't be sent.

Fix this by adding a mechanism to emit regular probes.

Two levels of probing are made available: Under normal circumstances the
'slow' queue will be used for a fileserver - this just probes the preferred
address once every 5 mins or so; however, if server fails to respond to any
probes, the server will shift to the 'fast' queue from which all its
interfaces will be probed every 30s.  When it finally responds, the record
will switch back to the slow queue.

Further notes:

 (1) Probing is now no longer driven from the fileserver rotation
     algorithm.

 (2) Probes are dispatched to all interfaces on a fileserver when that an
     afs_server object is set up to record it.

 (3) The afs_server object is removed from the probe queues when we start
     to probe it.  afs_is_probing_server() returns true if it's not listed
     - ie. it's undergoing probing.

 (4) The afs_server object is added back on to the probe queue when the
     final outstanding probe completes, but the probed_at time is set when
     we're about to launch a probe so that it's not dependent on the probe
     duration.

 (5) The timer and the work item added for this must be handed a count on
     net->servers_outstanding, which they hand on or release.  This makes
     sure that network namespace cleanup waits for them.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Reported-by: Dave Botsch <botsch@cnf.cornell.edu>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |    2 
 fs/afs/fs_probe.c          |  277 +++++++++++++++++++++++++++++++++-----------
 fs/afs/fsclient.c          |   21 ++-
 fs/afs/internal.h          |   41 +++++--
 fs/afs/main.c              |    5 +
 fs/afs/rotate.c            |    7 -
 fs/afs/server.c            |   19 +--
 fs/afs/volume.c            |   24 ++--
 include/trace/events/afs.h |    4 +
 9 files changed, 281 insertions(+), 119 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 7dcbca3bf828..7ae88958051f 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -157,7 +157,7 @@ static int afs_record_cm_probe(struct afs_call *call, struct afs_server *server)
 	_enter("");
 
 	if (test_bit(AFS_SERVER_FL_HAVE_EPOCH, &server->flags) &&
-	    !test_bit(AFS_SERVER_FL_PROBING, &server->flags)) {
+	    !afs_is_probing_server(server)) {
 		if (server->cm_epoch == call->epoch)
 			return 0;
 
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index d37d78eb84bd..442b5e7944ff 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* AFS fileserver probing
  *
- * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2018, 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  */
 
@@ -11,14 +11,83 @@
 #include "internal.h"
 #include "protocol_yfs.h"
 
-static bool afs_fs_probe_done(struct afs_server *server)
+static unsigned int afs_fs_probe_fast_poll_interval = 30 * HZ;
+static unsigned int afs_fs_probe_slow_poll_interval = 5 * 60 * HZ;
+
+/*
+ * Start the probe polling timer.  We have to supply it with an inc on the
+ * outstanding server count.
+ */
+static void afs_schedule_fs_probe(struct afs_net *net,
+				  struct afs_server *server, bool fast)
+{
+	unsigned long atj;
+
+	if (!net->live)
+		return;
+
+	atj = server->probed_at;
+	atj += fast ? afs_fs_probe_fast_poll_interval : afs_fs_probe_slow_poll_interval;
+
+	afs_inc_servers_outstanding(net);
+	if (timer_reduce(&net->fs_probe_timer, atj))
+		afs_dec_servers_outstanding(net);
+}
+
+/*
+ * Handle the completion of a set of probes.
+ */
+static void afs_finished_fs_probe(struct afs_net *net, struct afs_server *server)
+{
+	bool responded = server->probe.responded;
+
+	write_seqlock(&net->fs_lock);
+	if (responded)
+		list_add_tail(&server->probe_link, &net->fs_probe_slow);
+	else
+		list_add_tail(&server->probe_link, &net->fs_probe_fast);
+	write_sequnlock(&net->fs_lock);
+
+	afs_schedule_fs_probe(net, server, !responded);
+}
+
+/*
+ * Handle the completion of a probe.
+ */
+static void afs_done_one_fs_probe(struct afs_net *net, struct afs_server *server)
+{
+	_enter("");
+
+	if (atomic_dec_and_test(&server->probe_outstanding))
+		afs_finished_fs_probe(net, server);
+
+	wake_up_all(&server->probe_wq);
+}
+
+/*
+ * Handle inability to send a probe due to ENOMEM when trying to allocate a
+ * call struct.
+ */
+static void afs_fs_probe_not_done(struct afs_net *net,
+				  struct afs_server *server,
+				  struct afs_addr_cursor *ac)
 {
-	if (!atomic_dec_and_test(&server->probe_outstanding))
-		return false;
+	struct afs_addr_list *alist = ac->alist;
+	unsigned int index = ac->index;
+
+	_enter("");
 
-	clear_bit_unlock(AFS_SERVER_FL_PROBING, &server->flags);
-	wake_up_bit(&server->flags, AFS_SERVER_FL_PROBING);
-	return true;
+	trace_afs_io_error(0, -ENOMEM, afs_io_error_fs_probe_fail);
+	spin_lock(&server->probe_lock);
+
+	server->probe.local_failure = true;
+	if (server->probe.error == 0)
+		server->probe.error = -ENOMEM;
+
+	set_bit(index, &alist->failed);
+
+	spin_unlock(&server->probe_lock);
+	return afs_done_one_fs_probe(net, server);
 }
 
 /*
@@ -29,10 +98,8 @@ void afs_fileserver_probe_result(struct afs_call *call)
 {
 	struct afs_addr_list *alist = call->alist;
 	struct afs_server *server = call->server;
-	unsigned int server_index = call->server_index;
 	unsigned int index = call->addr_ix;
 	unsigned int rtt_us = 0;
-	bool have_result = false;
 	int ret = call->error;
 
 	_enter("%pU,%u", &server->uuid, index);
@@ -51,8 +118,9 @@ void afs_fileserver_probe_result(struct afs_call *call)
 		goto responded;
 	case -ENOMEM:
 	case -ENONET:
+		clear_bit(index, &alist->responded);
 		server->probe.local_failure = true;
-		afs_io_error(call, afs_io_error_fs_probe_fail);
+		trace_afs_io_error(call->debug_id, ret, afs_io_error_fs_probe_fail);
 		goto out;
 	case -ECONNRESET: /* Responded, but call expired. */
 	case -ERFKILL:
@@ -71,12 +139,11 @@ void afs_fileserver_probe_result(struct afs_call *call)
 		     server->probe.error == -ETIMEDOUT ||
 		     server->probe.error == -ETIME))
 			server->probe.error = ret;
-		afs_io_error(call, afs_io_error_fs_probe_fail);
+		trace_afs_io_error(call->debug_id, ret, afs_io_error_fs_probe_fail);
 		goto out;
 	}
 
 responded:
-	set_bit(index, &alist->responded);
 	clear_bit(index, &alist->failed);
 
 	if (call->service_id == YFS_FS_SERVICE) {
@@ -95,38 +162,31 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	if (rtt_us < server->probe.rtt) {
 		server->probe.rtt = rtt_us;
 		alist->preferred = index;
-		have_result = true;
 	}
 
 	smp_wmb(); /* Set rtt before responded. */
 	server->probe.responded = true;
-	set_bit(AFS_SERVER_FL_PROBED, &server->flags);
+	set_bit(index, &alist->responded);
 out:
 	spin_unlock(&server->probe_lock);
 
-	_debug("probe [%u][%u] %pISpc rtt=%u ret=%d",
-	       server_index, index, &alist->addrs[index].transport, rtt_us, ret);
+	_debug("probe %pU [%u] %pISpc rtt=%u ret=%d",
+	       &server->uuid, index, &alist->addrs[index].transport,
+	       rtt_us, ret);
 
-	have_result |= afs_fs_probe_done(server);
-	if (have_result)
-		wake_up_all(&server->probe_wq);
+	return afs_done_one_fs_probe(call->net, server);
 }
 
 /*
- * Probe all of a fileserver's addresses to find out the best route and to
- * query its capabilities.
+ * Probe one or all of a fileserver's addresses to find out the best route and
+ * to query its capabilities.
  */
-static int afs_do_probe_fileserver(struct afs_net *net,
-				   struct afs_server *server,
-				   struct key *key,
-				   unsigned int server_index,
-				   struct afs_error *_e)
+void afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
+			     struct key *key, bool all)
 {
 	struct afs_addr_cursor ac = {
 		.index = 0,
 	};
-	struct afs_call *call;
-	bool in_progress = false;
 
 	_enter("%pU", &server->uuid);
 
@@ -136,50 +196,25 @@ static int afs_do_probe_fileserver(struct afs_net *net,
 	afs_get_addrlist(ac.alist);
 	read_unlock(&server->fs_lock);
 
-	atomic_set(&server->probe_outstanding, ac.alist->nr_addrs);
+	server->probed_at = jiffies;
+	atomic_set(&server->probe_outstanding, all ? ac.alist->nr_addrs : 1);
 	memset(&server->probe, 0, sizeof(server->probe));
 	server->probe.rtt = UINT_MAX;
 
-	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
-		call = afs_fs_get_capabilities(net, server, &ac, key, server_index);
-		if (!IS_ERR(call)) {
-			afs_put_call(call);
-			in_progress = true;
-		} else {
-			afs_prioritise_error(_e, PTR_ERR(call), ac.abort_code);
-		}
-	}
-
-	if (!in_progress)
-		afs_fs_probe_done(server);
-	afs_put_addrlist(ac.alist);
-	return in_progress;
-}
+	ac.index = ac.alist->preferred;
+	if (ac.index < 0 || ac.index >= ac.alist->nr_addrs)
+		all = true;
 
-/*
- * Send off probes to all unprobed servers.
- */
-int afs_probe_fileservers(struct afs_net *net, struct key *key,
-			  struct afs_server_list *list)
-{
-	struct afs_server *server;
-	struct afs_error e;
-	bool in_progress = false;
-	int i;
-
-	e.error = 0;
-	e.responded = false;
-	for (i = 0; i < list->nr_servers; i++) {
-		server = list->servers[i].server;
-		if (test_bit(AFS_SERVER_FL_PROBED, &server->flags))
-			continue;
-
-		if (!test_and_set_bit_lock(AFS_SERVER_FL_PROBING, &server->flags) &&
-		    afs_do_probe_fileserver(net, server, key, i, &e))
-			in_progress = true;
+	if (all) {
+		for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++)
+			if (!afs_fs_get_capabilities(net, server, &ac, key))
+				afs_fs_probe_not_done(net, server, &ac);
+	} else {
+		if (!afs_fs_get_capabilities(net, server, &ac, key))
+			afs_fs_probe_not_done(net, server, &ac);
 	}
 
-	return in_progress ? 0 : e.error;
+	afs_put_addrlist(ac.alist);
 }
 
 /*
@@ -199,7 +234,7 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 	for (i = 0; i < slist->nr_servers; i++) {
 		if (test_bit(i, &untried)) {
 			server = slist->servers[i].server;
-			if (!test_bit(AFS_SERVER_FL_PROBING, &server->flags))
+			if (!atomic_read(&server->probe_outstanding))
 				__clear_bit(i, &untried);
 			if (server->probe.responded)
 				have_responders = true;
@@ -229,7 +264,7 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 				server = slist->servers[i].server;
 				if (server->probe.responded)
 					goto stop;
-				if (test_bit(AFS_SERVER_FL_PROBING, &server->flags))
+				if (atomic_read(&server->probe_outstanding))
 					still_probing = true;
 			}
 		}
@@ -264,3 +299,109 @@ int afs_wait_for_fs_probes(struct afs_server_list *slist, unsigned long untried)
 		slist->preferred = pref;
 	return 0;
 }
+
+/*
+ * Probe timer.  We have an increment on fs_outstanding that we need to pass
+ * along to the work item.
+ */
+void afs_fs_probe_timer(struct timer_list *timer)
+{
+	struct afs_net *net = container_of(timer, struct afs_net, fs_probe_timer);
+
+	if (!queue_work(afs_wq, &net->fs_prober))
+		afs_dec_servers_outstanding(net);
+}
+
+/*
+ * Dispatch a probe to a server.
+ */
+static void afs_dispatch_fs_probe(struct afs_net *net, struct afs_server *server, bool all)
+	__releases(&net->fs_lock)
+{
+	struct key *key = NULL;
+
+	/* We remove it from the queues here - it will be added back to
+	 * one of the queues on the completion of the probe.
+	 */
+	list_del_init(&server->probe_link);
+
+	afs_get_server(server, afs_server_trace_get_probe);
+	write_sequnlock(&net->fs_lock);
+
+	afs_fs_probe_fileserver(net, server, key, all);
+	afs_put_server(net, server, afs_server_trace_put_probe);
+}
+
+/*
+ * Probe dispatcher to regularly dispatch probes to keep NAT alive.
+ */
+void afs_fs_probe_dispatcher(struct work_struct *work)
+{
+	struct afs_net *net = container_of(work, struct afs_net, fs_prober);
+	struct afs_server *fast, *slow, *server;
+	unsigned long nowj, timer_at, poll_at;
+	bool first_pass = true, set_timer = false;
+
+	if (!net->live)
+		return;
+
+	_enter("");
+
+	if (list_empty(&net->fs_probe_fast) && list_empty(&net->fs_probe_slow)) {
+		_leave(" [none]");
+		return;
+	}
+
+again:
+	write_seqlock(&net->fs_lock);
+
+	fast = slow = server = NULL;
+	nowj = jiffies;
+	timer_at = nowj + MAX_JIFFY_OFFSET;
+
+	if (!list_empty(&net->fs_probe_fast)) {
+		fast = list_first_entry(&net->fs_probe_fast, struct afs_server, probe_link);
+		poll_at = fast->probed_at + afs_fs_probe_fast_poll_interval;
+		if (time_before(nowj, poll_at)) {
+			timer_at = poll_at;
+			set_timer = true;
+			fast = NULL;
+		}
+	}
+
+	if (!list_empty(&net->fs_probe_slow)) {
+		slow = list_first_entry(&net->fs_probe_slow, struct afs_server, probe_link);
+		poll_at = slow->probed_at + afs_fs_probe_slow_poll_interval;
+		if (time_before(nowj, poll_at)) {
+			if (time_before(poll_at, timer_at))
+			    timer_at = poll_at;
+			set_timer = true;
+			slow = NULL;
+		}
+	}
+
+	server = fast ?: slow;
+	if (server)
+		_debug("probe %pU", &server->uuid);
+
+	if (server && (first_pass || !need_resched())) {
+		afs_dispatch_fs_probe(net, server, server == fast);
+		first_pass = false;
+		goto again;
+	}
+
+	write_sequnlock(&net->fs_lock);
+
+	if (server) {
+		if (!queue_work(afs_wq, &net->fs_prober))
+			afs_dec_servers_outstanding(net);
+		_leave(" [requeue]");
+	} else if (set_timer) {
+		if (timer_reduce(&net->fs_probe_timer, timer_at))
+			afs_dec_servers_outstanding(net);
+		_leave(" [timer]");
+	} else {
+		afs_dec_servers_outstanding(net);
+		_leave(" [quiesce]");
+	}
+}
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 3854d16e14b1..401de063996c 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1905,14 +1905,13 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
 };
 
 /*
- * Probe a fileserver for the capabilities that it supports.  This can
- * return up to 196 words.
- */
-struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
-					 struct afs_server *server,
-					 struct afs_addr_cursor *ac,
-					 struct key *key,
-					 unsigned int server_index)
+ * Probe a fileserver for the capabilities that it supports.  This RPC can
+ * reply with up to 196 words.  The operation is asynchronous and if we managed
+ * to allocate a call, true is returned the result is delivered through the
+ * ->done() - otherwise we return false to indicate we didn't even try.
+ */
+bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
+			     struct afs_addr_cursor *ac, struct key *key)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -1921,11 +1920,10 @@ struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
 
 	call = afs_alloc_flat_call(net, &afs_RXFSGetCapabilities, 1 * 4, 16 * 4);
 	if (!call)
-		return ERR_PTR(-ENOMEM);
+		return false;
 
 	call->key = key;
 	call->server = afs_use_server(server, afs_server_trace_get_caps);
-	call->server_index = server_index;
 	call->upgrade = true;
 	call->async = true;
 	call->max_lifespan = AFS_PROBE_MAX_LIFESPAN;
@@ -1936,7 +1934,8 @@ struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
 
 	trace_afs_make_fs_call(call, NULL);
 	afs_make_call(ac, call, GFP_NOFS);
-	return call;
+	afs_put_call(call);
+	return true;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index cb70e1c234cc..61320a632e15 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -90,7 +90,6 @@ struct afs_addr_list {
 	unsigned char		nr_ipv4;	/* Number of IPv4 addresses */
 	enum dns_record_source	source:8;
 	enum dns_lookup_status	status:8;
-	unsigned long		probed;		/* Mask of servers that have been probed */
 	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
 	struct sockaddr_rxrpc	addrs[];
@@ -299,9 +298,10 @@ struct afs_net {
 	 * cell, but in practice, people create aliases and subsets and there's
 	 * no easy way to distinguish them.
 	 */
-	seqlock_t		fs_lock;	/* For fs_servers */
+	seqlock_t		fs_lock;	/* For fs_servers, fs_probe_*, fs_proc */
 	struct rb_root		fs_servers;	/* afs_server (by server UUID or address) */
-	struct list_head	fs_updates;	/* afs_server (by update_at) */
+	struct list_head	fs_probe_fast;	/* List of afs_server to probe at 30s intervals */
+	struct list_head	fs_probe_slow;	/* List of afs_server to probe at 5m intervals */
 	struct hlist_head	fs_proc;	/* procfs servers list */
 
 	struct hlist_head	fs_addresses4;	/* afs_server (by lowest IPv4 addr) */
@@ -310,6 +310,9 @@ struct afs_net {
 
 	struct work_struct	fs_manager;
 	struct timer_list	fs_timer;
+
+	struct work_struct	fs_prober;
+	struct timer_list	fs_probe_timer;
 	atomic_t		servers_outstanding;
 
 	/* File locking renewal management */
@@ -493,7 +496,8 @@ struct afs_server {
 	};
 
 	struct afs_addr_list	__rcu *addresses;
-	struct rb_node		uuid_rb;	/* Link in net->servers */
+	struct rb_node		uuid_rb;	/* Link in net->fs_servers */
+	struct list_head	probe_link;	/* Link in net->fs_probe_list */
 	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
@@ -504,8 +508,6 @@ struct afs_server {
 #define AFS_SERVER_FL_NOT_FOUND	2		/* VL server says no such server */
 #define AFS_SERVER_FL_VL_FAIL	3		/* Failed to access VL server */
 #define AFS_SERVER_FL_UPDATING	4
-#define AFS_SERVER_FL_PROBED	5		/* The fileserver has been probed */
-#define AFS_SERVER_FL_PROBING	6		/* Fileserver is being probed */
 #define AFS_SERVER_FL_NO_IBULK	7		/* Fileserver doesn't support FS.InlineBulkStatus */
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
 #define AFS_SERVER_FL_IS_YFS	9		/* Server is YFS not AFS */
@@ -527,6 +529,7 @@ struct afs_server {
 	rwlock_t		cb_break_lock;	/* Volume finding lock */
 
 	/* Probe state */
+	unsigned long		probed_at;	/* Time last probe was dispatched (jiffies) */
 	wait_queue_head_t	probe_wq;
 	atomic_t		probe_outstanding;
 	spinlock_t		probe_lock;
@@ -956,7 +959,6 @@ extern int afs_flock(struct file *, int, struct file_lock *);
  */
 extern int afs_fs_fetch_file_status(struct afs_fs_cursor *, struct afs_status_cb *,
 				    struct afs_volsync *);
-extern int afs_fs_give_up_callbacks(struct afs_net *, struct afs_server *);
 extern int afs_fs_fetch_data(struct afs_fs_cursor *, struct afs_status_cb *, struct afs_read *);
 extern int afs_fs_create(struct afs_fs_cursor *, const char *, umode_t,
 			 struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
@@ -978,9 +980,8 @@ extern int afs_fs_extend_lock(struct afs_fs_cursor *, struct afs_status_cb *);
 extern int afs_fs_release_lock(struct afs_fs_cursor *, struct afs_status_cb *);
 extern int afs_fs_give_up_all_callbacks(struct afs_net *, struct afs_server *,
 					struct afs_addr_cursor *, struct key *);
-extern struct afs_call *afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
-						struct afs_addr_cursor *, struct key *,
-						unsigned int);
+extern bool afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
+				    struct afs_addr_cursor *, struct key *);
 extern int afs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
 				     struct afs_fid *, struct afs_status_cb *,
 				     unsigned int, struct afs_volsync *);
@@ -1001,8 +1002,9 @@ extern int afs_fs_store_acl(struct afs_fs_cursor *, const struct afs_acl *,
  * fs_probe.c
  */
 extern void afs_fileserver_probe_result(struct afs_call *);
-extern int afs_probe_fileservers(struct afs_net *, struct key *, struct afs_server_list *);
+extern void afs_fs_probe_fileserver(struct afs_net *, struct afs_server *, struct key *, bool);
 extern int afs_wait_for_fs_probes(struct afs_server_list *, unsigned long);
+extern void afs_fs_probe_dispatcher(struct work_struct *);
 
 /*
  * inode.c
@@ -1251,9 +1253,26 @@ extern void afs_unuse_server_notime(struct afs_net *, struct afs_server *, enum
 extern void afs_put_server(struct afs_net *, struct afs_server *, enum afs_server_trace);
 extern void afs_manage_servers(struct work_struct *);
 extern void afs_servers_timer(struct timer_list *);
+extern void afs_fs_probe_timer(struct timer_list *);
 extern void __net_exit afs_purge_servers(struct afs_net *);
 extern bool afs_check_server_record(struct afs_fs_cursor *, struct afs_server *);
 
+static inline void afs_inc_servers_outstanding(struct afs_net *net)
+{
+	atomic_inc(&net->servers_outstanding);
+}
+
+static inline void afs_dec_servers_outstanding(struct afs_net *net)
+{
+	if (atomic_dec_and_test(&net->servers_outstanding))
+		wake_up_var(&net->servers_outstanding);
+}
+
+static inline bool afs_is_probing_server(struct afs_server *server)
+{
+	return list_empty(&server->probe_link);
+}
+
 /*
  * server_list.c
  */
diff --git a/fs/afs/main.c b/fs/afs/main.c
index c9c45d7078bd..56b52f8dbf15 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -87,7 +87,8 @@ static int __net_init afs_net_init(struct net *net_ns)
 
 	seqlock_init(&net->fs_lock);
 	net->fs_servers = RB_ROOT;
-	INIT_LIST_HEAD(&net->fs_updates);
+	INIT_LIST_HEAD(&net->fs_probe_fast);
+	INIT_LIST_HEAD(&net->fs_probe_slow);
 	INIT_HLIST_HEAD(&net->fs_proc);
 
 	INIT_HLIST_HEAD(&net->fs_addresses4);
@@ -96,6 +97,8 @@ static int __net_init afs_net_init(struct net *net_ns)
 
 	INIT_WORK(&net->fs_manager, afs_manage_servers);
 	timer_setup(&net->fs_timer, afs_servers_timer, 0);
+	INIT_WORK(&net->fs_prober, afs_fs_probe_dispatcher);
+	timer_setup(&net->fs_probe_timer, afs_fs_probe_timer, 0);
 
 	ret = -ENOMEM;
 	sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 2a3305e42b14..46b68da89faa 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -349,9 +349,6 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 		goto failed;
 
 	_debug("__ VOL %llx __", vnode->volume->vid);
-	error = afs_probe_fileservers(afs_v2net(vnode), fc->key, fc->server_list);
-	if (error < 0)
-		goto failed_set_error;
 
 pick_server:
 	_debug("pick [%lx]", fc->untried);
@@ -596,8 +593,8 @@ static void afs_dump_edestaddrreq(const struct afs_fs_cursor *fc)
 					  a->version,
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
 					  a->preferred);
-				pr_notice("FC:  - pr=%lx R=%lx F=%lx\n",
-					  a->probed, a->responded, a->failed);
+				pr_notice("FC:  - R=%lx F=%lx\n",
+					  a->responded, a->failed);
 				if (a == fc->ac.alist)
 					pr_notice("FC:  - current\n");
 			}
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 4969a681f8f5..3f707b5ecb62 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -14,17 +14,6 @@
 static unsigned afs_server_gc_delay = 10;	/* Server record timeout in seconds */
 static atomic_t afs_server_debug_id;
 
-static void afs_inc_servers_outstanding(struct afs_net *net)
-{
-	atomic_inc(&net->servers_outstanding);
-}
-
-static void afs_dec_servers_outstanding(struct afs_net *net)
-{
-	if (atomic_dec_and_test(&net->servers_outstanding))
-		wake_up_var(&net->servers_outstanding);
-}
-
 static struct afs_server *afs_maybe_use_server(struct afs_server *,
 					       enum afs_server_trace);
 static void __afs_put_server(struct afs_net *, struct afs_server *);
@@ -226,6 +215,7 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	INIT_HLIST_HEAD(&server->cb_volumes);
 	rwlock_init(&server->cb_break_lock);
 	init_waitqueue_head(&server->probe_wq);
+	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);
 
 	afs_inc_servers_outstanding(net);
@@ -295,6 +285,12 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 	if (server != candidate) {
 		afs_put_addrlist(alist);
 		kfree(candidate);
+	} else {
+		/* Immediately dispatch an asynchronous probe to each interface
+		 * on the fileserver.  This will make sure the repeat-probing
+		 * service is started.
+		 */
+		afs_fs_probe_fileserver(cell->net, server, key, true);
 	}
 
 	return server;
@@ -464,6 +460,7 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 			trace_afs_server(server, atomic_read(&server->ref),
 					 active, afs_server_trace_gc);
 			rb_erase(&server->uuid_rb, &net->fs_servers);
+			list_del(&server->probe_link);
 			hlist_del_rcu(&server->proc_link);
 			if (!hlist_unhashed(&server->addr4_link))
 				hlist_del_rcu(&server->addr4_link);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 4310336b9bb8..249000195f8a 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -266,7 +266,6 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	}
 
 	volume->update_at = ktime_get_real_seconds() + afs_volume_record_life;
-	clear_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
 	write_unlock(&volume->servers_lock);
 	ret = 0;
 
@@ -283,23 +282,25 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
  */
 int afs_check_volume_status(struct afs_volume *volume, struct afs_fs_cursor *fc)
 {
-	time64_t now = ktime_get_real_seconds();
 	int ret, retries = 0;
 
 	_enter("");
 
-	if (volume->update_at <= now)
-		set_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
-
 retry:
-	if (!test_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags) &&
-	    !test_bit(AFS_VOLUME_WAIT, &volume->flags)) {
-		_leave(" = 0");
-		return 0;
-	}
-
+	if (test_bit(AFS_VOLUME_WAIT, &volume->flags))
+		goto wait;
+	if (volume->update_at <= ktime_get_real_seconds() ||
+	    test_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags))
+		goto update;
+	_leave(" = 0");
+	return 0;
+
+update:
 	if (!test_and_set_bit_lock(AFS_VOLUME_UPDATING, &volume->flags)) {
+		clear_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
 		ret = afs_update_volume_status(volume, fc->key);
+		if (ret < 0)
+			set_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
 		clear_bit_unlock(AFS_VOLUME_WAIT, &volume->flags);
 		clear_bit_unlock(AFS_VOLUME_UPDATING, &volume->flags);
 		wake_up_bit(&volume->flags, AFS_VOLUME_WAIT);
@@ -307,6 +308,7 @@ int afs_check_volume_status(struct afs_volume *volume, struct afs_fs_cursor *fc)
 		return ret;
 	}
 
+wait:
 	if (!test_bit(AFS_VOLUME_WAIT, &volume->flags)) {
 		_leave(" = 0 [no wait]");
 		return 0;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index f9691f69b2d6..19a07fbf35df 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -38,10 +38,12 @@ enum afs_server_trace {
 	afs_server_trace_get_caps,
 	afs_server_trace_get_install,
 	afs_server_trace_get_new_cbi,
+	afs_server_trace_get_probe,
 	afs_server_trace_give_up_cb,
 	afs_server_trace_put_call,
 	afs_server_trace_put_cbi,
 	afs_server_trace_put_find_rsq,
+	afs_server_trace_put_probe,
 	afs_server_trace_put_slist,
 	afs_server_trace_put_slist_isort,
 	afs_server_trace_put_uuid_rsq,
@@ -247,10 +249,12 @@ enum afs_cb_break_reason {
 	EM(afs_server_trace_get_caps,		"GET caps ") \
 	EM(afs_server_trace_get_install,	"GET inst ") \
 	EM(afs_server_trace_get_new_cbi,	"GET cbi  ") \
+	EM(afs_server_trace_get_probe,		"GET probe") \
 	EM(afs_server_trace_give_up_cb,		"giveup-cb") \
 	EM(afs_server_trace_put_call,		"PUT call ") \
 	EM(afs_server_trace_put_cbi,		"PUT cbi  ") \
 	EM(afs_server_trace_put_find_rsq,	"PUT f-rsq") \
+	EM(afs_server_trace_put_probe,		"PUT probe") \
 	EM(afs_server_trace_put_slist,		"PUT slist") \
 	EM(afs_server_trace_put_slist_isort,	"PUT isort") \
 	EM(afs_server_trace_put_uuid_rsq,	"PUT u-req") \



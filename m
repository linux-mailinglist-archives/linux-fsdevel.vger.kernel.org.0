Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991D51E8A9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgE2WBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:01:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728505AbgE2WA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ7uUOjK0xafnhlnC3GwMbyzMonAmFbz226fuMzsXt0=;
        b=K1Sci9NH2UxJAgcnQ/CTUO4I6Z+rop0rCRIx5QQjma/cNCSwvVVaywy+3X0UTBW9xchkZl
        tlYaytArH7NPJDr1JWrPc8lHWtQKUJBZX7zRstPrySp0hM5Bx3sSD+rBK/ujcbFAUH9p7q
        AuggSOLCp+XL9ZNPiiLqv27BF9hsNKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-0EwdEI3vPvGDJGySAaY2nw-1; Fri, 29 May 2020 18:00:52 -0400
X-MC-Unique: 0EwdEI3vPvGDJGySAaY2nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5216A8018AB;
        Fri, 29 May 2020 22:00:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477D910013D4;
        Fri, 29 May 2020 22:00:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/27] afs: Split the usage count on struct afs_server
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:00:49 +0100
Message-ID: <159078964952.679399.17573939960907171398.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the usage count on the afs_server struct to have an active count that
registers who's actually using it separately from the reference count on
the object.

This allows a future patch to dispatch polling probes without advancing the
"unuse" time into the future each time we emit a probe, which would
otherwise prevent unused server records from expiring.

Included in this:

 (1) The latter part of afs_destroy_server() in which the RCU destruction
     of afs_server objects is invoked and the outstanding server count is
     decremented is split out into __afs_put_server().

 (2) afs_put_server() now calls __afs_put_server() rather then setting the
     management timer.

 (3) The calls begun by afs_fs_give_up_all_callbacks() and
     afs_fs_get_capabilities() can now take a ref on the server record, so
     afs_destroy_server() can just drop its ref and needn't wait for the
     completion of these calls.  They'll put the ref when they're done.

 (4) Because of (3), afs_fs_probe_done() no longer needs to wake up
     afs_destroy_server() with server->probe_outstanding.

 (5) afs_gc_servers can be simplified.  It only needs to check if
     server->active is 0 rather than playing games with the refcount.

 (6) afs_manage_servers() can propose a server for gc if usage == 0 rather
     than if ref == 1.  The gc is effected by (5).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |    4 +
 fs/afs/fs_probe.c          |    1 
 fs/afs/fsclient.c          |    5 +
 fs/afs/internal.h          |    8 ++
 fs/afs/proc.c              |    9 +--
 fs/afs/rxrpc.c             |    2 -
 fs/afs/server.c            |  151 +++++++++++++++++++++++++++++---------------
 fs/afs/server_list.c       |    4 +
 include/trace/events/afs.h |   18 +++--
 9 files changed, 131 insertions(+), 71 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 380ad5ace7cf..7dcbca3bf828 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -268,7 +268,9 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
 	 * to maintain cache coherency.
 	 */
 	if (call->server) {
-		trace_afs_server(call->server, atomic_read(&call->server->usage),
+		trace_afs_server(call->server,
+				 atomic_read(&call->server->ref),
+				 atomic_read(&call->server->active),
 				 afs_server_trace_callback);
 		afs_break_callbacks(call->server, call->count, call->request);
 	}
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 37d1bba57b00..d37d78eb84bd 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -16,7 +16,6 @@ static bool afs_fs_probe_done(struct afs_server *server)
 	if (!atomic_dec_and_test(&server->probe_outstanding))
 		return false;
 
-	wake_up_var(&server->probe_outstanding);
 	clear_bit_unlock(AFS_SERVER_FL_PROBING, &server->flags);
 	wake_up_bit(&server->flags, AFS_SERVER_FL_PROBING);
 	return true;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d2b3798c1932..3854d16e14b1 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1842,7 +1842,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 	bp = call->request;
 	*bp++ = htonl(FSGIVEUPALLCALLBACKS);
 
-	/* Can't take a ref on server */
+	call->server = afs_use_server(server, afs_server_trace_give_up_cb);
 	afs_make_call(ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, ac);
 }
@@ -1924,7 +1924,7 @@ struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
 		return ERR_PTR(-ENOMEM);
 
 	call->key = key;
-	call->server = afs_get_server(server, afs_server_trace_get_caps);
+	call->server = afs_use_server(server, afs_server_trace_get_caps);
 	call->server_index = server_index;
 	call->upgrade = true;
 	call->async = true;
@@ -1934,7 +1934,6 @@ struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
 	bp = call->request;
 	*bp++ = htonl(FSGETCAPABILITIES);
 
-	/* Can't take a ref on server */
 	trace_afs_make_fs_call(call, NULL);
 	afs_make_call(ac, call, GFP_NOFS);
 	return call;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ee17c868ad2c..cb70e1c234cc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -498,7 +498,7 @@ struct afs_server {
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
-	time64_t		put_time;	/* Time at which last put */
+	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_NOT_READY	1		/* The record is not ready for use */
 #define AFS_SERVER_FL_NOT_FOUND	2		/* VL server says no such server */
@@ -512,7 +512,8 @@ struct afs_server {
 #define AFS_SERVER_FL_NO_RM2	10		/* Fileserver doesn't support YFS.RemoveFile2 */
 #define AFS_SERVER_FL_HAVE_EPOCH 11		/* ->epoch is valid */
 #define AFS_SERVER_FL_NEEDS_UPDATE 12		/* Fileserver address list is out of date */
-	atomic_t		usage;
+	atomic_t		ref;		/* Object refcount */
+	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
 	u32			cm_epoch;	/* Server RxRPC epoch */
 	unsigned int		debug_id;	/* Debugging ID for traces */
@@ -1244,6 +1245,9 @@ extern struct afs_server *afs_find_server(struct afs_net *,
 extern struct afs_server *afs_find_server_by_uuid(struct afs_net *, const uuid_t *);
 extern struct afs_server *afs_lookup_server(struct afs_cell *, struct key *, const uuid_t *, u32);
 extern struct afs_server *afs_get_server(struct afs_server *, enum afs_server_trace);
+extern struct afs_server *afs_use_server(struct afs_server *, enum afs_server_trace);
+extern void afs_unuse_server(struct afs_net *, struct afs_server *, enum afs_server_trace);
+extern void afs_unuse_server_notime(struct afs_net *, struct afs_server *, enum afs_server_trace);
 extern void afs_put_server(struct afs_net *, struct afs_server *, enum afs_server_trace);
 extern void afs_manage_servers(struct work_struct *);
 extern void afs_servers_timer(struct timer_list *);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 468e1713bce1..9bce7898cd7d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -378,19 +378,20 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 	int i;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "UUID                                 USE ADDR\n");
+		seq_puts(m, "UUID                                 REF ACT ADDR\n");
 		return 0;
 	}
 
 	server = list_entry(v, struct afs_server, proc_link);
 	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %pISpc%s\n",
+	seq_printf(m, "%pU %3d %3d %pISpc%s\n",
 		   &server->uuid,
-		   atomic_read(&server->usage),
+		   atomic_read(&server->ref),
+		   atomic_read(&server->active),
 		   &alist->addrs[0].transport,
 		   alist->preferred == 0 ? "*" : "");
 	for (i = 1; i < alist->nr_addrs; i++)
-		seq_printf(m, "                                         %pISpc%s\n",
+		seq_printf(m, "                                             %pISpc%s\n",
 			   &alist->addrs[i].transport,
 			   alist->preferred == i ? "*" : "");
 	return 0;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 1ecc67da6c1a..ab2962fff1fb 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -183,7 +183,7 @@ void afs_put_call(struct afs_call *call)
 		if (call->type->destructor)
 			call->type->destructor(call);
 
-		afs_put_server(call->net, call->server, afs_server_trace_put_call);
+		afs_unuse_server_notime(call->net, call->server, afs_server_trace_put_call);
 		afs_put_cb_interest(call->net, call->cbi);
 		afs_put_addrlist(call->alist);
 		kfree(call->request);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 9e50ccde5d37..4969a681f8f5 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -25,6 +25,10 @@ static void afs_dec_servers_outstanding(struct afs_net *net)
 		wake_up_var(&net->servers_outstanding);
 }
 
+static struct afs_server *afs_maybe_use_server(struct afs_server *,
+					       enum afs_server_trace);
+static void __afs_put_server(struct afs_net *, struct afs_server *);
+
 /*
  * Find a server by one of its addresses.
  */
@@ -40,7 +44,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 
 	do {
 		if (server)
-			afs_put_server(net, server, afs_server_trace_put_find_rsq);
+			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
 		server = NULL;
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
@@ -78,9 +82,9 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		}
 
 		server = NULL;
+		continue;
 	found:
-		if (server && !atomic_inc_not_zero(&server->usage))
-			server = NULL;
+		server = afs_maybe_use_server(server, afs_server_trace_get_by_addr);
 
 	} while (need_seqretry(&net->fs_addr_lock, seq));
 
@@ -91,7 +95,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 }
 
 /*
- * Look up a server by its UUID
+ * Look up a server by its UUID and mark it active.
  */
 struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uuid)
 {
@@ -107,7 +111,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		 * changes.
 		 */
 		if (server)
-			afs_put_server(net, server, afs_server_trace_put_uuid_rsq);
+			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
 		server = NULL;
 
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
@@ -122,7 +126,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 			} else if (diff > 0) {
 				p = p->rb_right;
 			} else {
-				afs_get_server(server, afs_server_trace_get_by_uuid);
+				afs_use_server(server, afs_server_trace_get_by_uuid);
 				break;
 			}
 
@@ -198,7 +202,7 @@ static struct afs_server *afs_install_server(struct afs_net *net,
 }
 
 /*
- * allocate a new server record
+ * Allocate a new server record and mark it active.
  */
 static struct afs_server *afs_alloc_server(struct afs_net *net,
 					   const uuid_t *uuid,
@@ -212,7 +216,8 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	if (!server)
 		goto enomem;
 
-	atomic_set(&server->usage, 1);
+	atomic_set(&server->ref, 1);
+	atomic_set(&server->active, 1);
 	server->debug_id = atomic_inc_return(&afs_server_debug_id);
 	RCU_INIT_POINTER(server->addresses, alist);
 	server->addr_version = alist->version;
@@ -224,7 +229,7 @@ static struct afs_server *afs_alloc_server(struct afs_net *net,
 	spin_lock_init(&server->probe_lock);
 
 	afs_inc_servers_outstanding(net);
-	trace_afs_server(server, 1, afs_server_trace_alloc);
+	trace_afs_server(server, 1, 1, afs_server_trace_alloc);
 	_leave(" = %p", server);
 	return server;
 
@@ -292,7 +297,6 @@ struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 		kfree(candidate);
 	}
 
-	_leave(" = %p{%d}", server, atomic_read(&server->usage));
 	return server;
 }
 
@@ -328,9 +332,38 @@ void afs_servers_timer(struct timer_list *timer)
 struct afs_server *afs_get_server(struct afs_server *server,
 				  enum afs_server_trace reason)
 {
-	unsigned int u = atomic_inc_return(&server->usage);
+	unsigned int u = atomic_inc_return(&server->ref);
+
+	trace_afs_server(server, u, atomic_read(&server->active), reason);
+	return server;
+}
+
+/*
+ * Try to get a reference on a server object.
+ */
+static struct afs_server *afs_maybe_use_server(struct afs_server *server,
+					       enum afs_server_trace reason)
+{
+	unsigned int r = atomic_fetch_add_unless(&server->ref, 1, 0);
+	unsigned int a;
+
+	if (r == 0)
+		return NULL;
+
+	a = atomic_inc_return(&server->active);
+	trace_afs_server(server, r, a, reason);
+	return server;
+}
+
+/*
+ * Get an active count on a server object.
+ */
+struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_trace reason)
+{
+	unsigned int r = atomic_inc_return(&server->ref);
+	unsigned int a = atomic_inc_return(&server->active);
 
-	trace_afs_server(server, u, reason);
+	trace_afs_server(server, r, a, reason);
 	return server;
 }
 
@@ -345,28 +378,56 @@ void afs_put_server(struct afs_net *net, struct afs_server *server,
 	if (!server)
 		return;
 
-	server->put_time = ktime_get_real_seconds();
-
-	usage = atomic_dec_return(&server->usage);
+	usage = atomic_dec_return(&server->ref);
+	trace_afs_server(server, usage, atomic_read(&server->active), reason);
+	if (unlikely(usage == 0))
+		__afs_put_server(net, server);
+}
 
-	trace_afs_server(server, usage, reason);
+/*
+ * Drop an active count on a server object without updating the last-unused
+ * time.
+ */
+void afs_unuse_server_notime(struct afs_net *net, struct afs_server *server,
+			     enum afs_server_trace reason)
+{
+	if (server) {
+		unsigned int active = atomic_dec_return(&server->active);
 
-	if (likely(usage > 0))
-		return;
+		if (active == 0)
+			afs_set_server_timer(net, afs_server_gc_delay);
+		afs_put_server(net, server, reason);
+	}
+}
 
-	afs_set_server_timer(net, afs_server_gc_delay);
+/*
+ * Drop an active count on a server object.
+ */
+void afs_unuse_server(struct afs_net *net, struct afs_server *server,
+		      enum afs_server_trace reason)
+{
+	if (server) {
+		server->unuse_time = ktime_get_real_seconds();
+		afs_unuse_server_notime(net, server, reason);
+	}
 }
 
 static void afs_server_rcu(struct rcu_head *rcu)
 {
 	struct afs_server *server = container_of(rcu, struct afs_server, rcu);
 
-	trace_afs_server(server, atomic_read(&server->usage),
-			 afs_server_trace_free);
+	trace_afs_server(server, atomic_read(&server->ref),
+			 atomic_read(&server->active), afs_server_trace_free);
 	afs_put_addrlist(rcu_access_pointer(server->addresses));
 	kfree(server);
 }
 
+static void __afs_put_server(struct afs_net *net, struct afs_server *server)
+{
+	call_rcu(&server->rcu, afs_server_rcu);
+	afs_dec_servers_outstanding(net);
+}
+
 /*
  * destroy a dead server
  */
@@ -379,19 +440,10 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 		.error	= 0,
 	};
 
-	trace_afs_server(server, atomic_read(&server->usage),
-			 afs_server_trace_give_up_cb);
-
 	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
 		afs_fs_give_up_all_callbacks(net, server, &ac, NULL);
 
-	wait_var_event(&server->probe_outstanding,
-		       atomic_read(&server->probe_outstanding) == 0);
-
-	trace_afs_server(server, atomic_read(&server->usage),
-			 afs_server_trace_destroy);
-	call_rcu(&server->rcu, afs_server_rcu);
-	afs_dec_servers_outstanding(net);
+	afs_put_server(net, server, afs_server_trace_destroy);
 }
 
 /*
@@ -400,31 +452,28 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 {
 	struct afs_server *server;
-	bool deleted;
-	int usage;
+	int active;
 
 	while ((server = gc_list)) {
 		gc_list = server->gc_next;
 
 		write_seqlock(&net->fs_lock);
-		usage = 1;
-		deleted = atomic_try_cmpxchg(&server->usage, &usage, 0);
-		trace_afs_server(server, usage, afs_server_trace_gc);
-		if (deleted) {
+
+		active = atomic_read(&server->active);
+		if (active == 0) {
+			trace_afs_server(server, atomic_read(&server->ref),
+					 active, afs_server_trace_gc);
 			rb_erase(&server->uuid_rb, &net->fs_servers);
 			hlist_del_rcu(&server->proc_link);
-		}
-		write_sequnlock(&net->fs_lock);
-
-		if (deleted) {
-			write_seqlock(&net->fs_addr_lock);
 			if (!hlist_unhashed(&server->addr4_link))
 				hlist_del_rcu(&server->addr4_link);
 			if (!hlist_unhashed(&server->addr6_link))
 				hlist_del_rcu(&server->addr6_link);
-			write_sequnlock(&net->fs_addr_lock);
-			afs_destroy_server(net, server);
 		}
+		write_sequnlock(&net->fs_lock);
+
+		if (active == 0)
+			afs_destroy_server(net, server);
 	}
 }
 
@@ -453,15 +502,14 @@ void afs_manage_servers(struct work_struct *work)
 	for (cursor = rb_first(&net->fs_servers); cursor; cursor = rb_next(cursor)) {
 		struct afs_server *server =
 			rb_entry(cursor, struct afs_server, uuid_rb);
-		int usage = atomic_read(&server->usage);
+		int active = atomic_read(&server->active);
 
-		_debug("manage %pU %u", &server->uuid, usage);
+		_debug("manage %pU %u", &server->uuid, active);
 
-		ASSERTCMP(usage, >=, 1);
-		ASSERTIFCMP(purging, usage, ==, 1);
+		ASSERTIFCMP(purging, active, ==, 0);
 
-		if (usage == 1) {
-			time64_t expire_at = server->put_time;
+		if (active == 0) {
+			time64_t expire_at = server->unuse_time;
 
 			if (!test_bit(AFS_SERVER_FL_VL_FAIL, &server->flags) &&
 			    !test_bit(AFS_SERVER_FL_NOT_FOUND, &server->flags))
@@ -532,7 +580,8 @@ static noinline bool afs_update_server_record(struct afs_fs_cursor *fc, struct a
 
 	_enter("");
 
-	trace_afs_server(server, atomic_read(&server->usage), afs_server_trace_update);
+	trace_afs_server(server, atomic_read(&server->ref), atomic_read(&server->active),
+			 afs_server_trace_update);
 
 	alist = afs_vl_lookup_addrs(fc->vnode->volume->cell, fc->key,
 				    &server->uuid);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index f567732df5cc..b77e50f62459 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -16,8 +16,8 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 	if (slist && refcount_dec_and_test(&slist->usage)) {
 		for (i = 0; i < slist->nr_servers; i++) {
 			afs_put_cb_interest(net, slist->servers[i].cb_interest);
-			afs_put_server(net, slist->servers[i].server,
-				       afs_server_trace_put_slist);
+			afs_unuse_server(net, slist->servers[i].server,
+					 afs_server_trace_put_slist);
 		}
 		kfree(slist);
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index c612cabbc378..f9691f69b2d6 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -33,6 +33,7 @@ enum afs_server_trace {
 	afs_server_trace_destroy,
 	afs_server_trace_free,
 	afs_server_trace_gc,
+	afs_server_trace_get_by_addr,
 	afs_server_trace_get_by_uuid,
 	afs_server_trace_get_caps,
 	afs_server_trace_get_install,
@@ -241,6 +242,7 @@ enum afs_cb_break_reason {
 	EM(afs_server_trace_destroy,		"DESTROY  ") \
 	EM(afs_server_trace_free,		"FREE     ") \
 	EM(afs_server_trace_gc,			"GC       ") \
+	EM(afs_server_trace_get_by_addr,	"GET addr ") \
 	EM(afs_server_trace_get_by_uuid,	"GET uuid ") \
 	EM(afs_server_trace_get_caps,		"GET caps ") \
 	EM(afs_server_trace_get_install,	"GET inst ") \
@@ -1271,26 +1273,30 @@ TRACE_EVENT(afs_cb_miss,
 	    );
 
 TRACE_EVENT(afs_server,
-	    TP_PROTO(struct afs_server *server, int usage, enum afs_server_trace reason),
+	    TP_PROTO(struct afs_server *server, int ref, int active,
+		     enum afs_server_trace reason),
 
-	    TP_ARGS(server, usage, reason),
+	    TP_ARGS(server, ref, active, reason),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		server		)
-		    __field(int,			usage		)
+		    __field(int,			ref		)
+		    __field(int,			active		)
 		    __field(int,			reason		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->server = server->debug_id;
-		    __entry->usage = usage;
+		    __entry->ref = ref;
+		    __entry->active = active;
 		    __entry->reason = reason;
 			   ),
 
-	    TP_printk("s=%08x %s u=%d",
+	    TP_printk("s=%08x %s u=%d a=%d",
 		      __entry->server,
 		      __print_symbolic(__entry->reason, afs_server_traces),
-		      __entry->usage)
+		      __entry->ref,
+		      __entry->active)
 	    );
 
 #endif /* _TRACE_AFS_H */



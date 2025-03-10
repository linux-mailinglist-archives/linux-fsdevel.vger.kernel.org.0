Return-Path: <linux-fsdevel+bounces-43585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F9EA5900D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E040D188CCA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F50229B2A;
	Mon, 10 Mar 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJO0mHc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49D228CB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599777; cv=none; b=f2JSusxRlOv4HguvnHrQgzYtvYzU/q64R5+CVpsMiEpM8eCoB0RjvWOq4iIb0YdNtc95a6y0uZM245ICRaTWYkYjTRHwgLTs931u1I/gpjmAU1DCfVsjYPFWmpDV5wq/i2sSCrHpLlfoIU6j7tzsUStpg89+RwH2H1TyG0C4RQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599777; c=relaxed/simple;
	bh=de5b07SyeJXWBFnz5pkuEolbSF3AtYzsHuthpOZLmwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdagkGEDMfWdHKfIQx0Zzjm4GEyA9Y2wVJDFtvkJeP59rGmoSAXgbDqnqUwUjMh6WR/myRjrHO9MGUoiCsW9WUbB+AsFV7dWI39+U8GelXQZwKHEC28NADWzOViMVHF7fgzB2raUlQBUm+i9OKLvspZhGzX/u9S1bXqWVhOuBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJO0mHc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NE4ZegdWhoJRTRrTystV+TjVp4mmZw8U3KNhjr9Mok=;
	b=XJO0mHc7C+csYKlfTqF35sSztWBNgphnXu6/dZeSF4AoJFdvCDnYLd0eXlx1Pkb5gR7kDu
	ixvl88Rc6KW79SUWr7VwaSHEOE230JRn+C+sFcLVHCMIwNWJb1wLVAmMd39lduXz9jV4P2
	+O98+4QPuAdTFqTK+kIO+74dFUftIyQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-uxutYvR4NM-vs9A0MoeX2Q-1; Mon,
 10 Mar 2025 05:42:52 -0400
X-MC-Unique: uxutYvR4NM-vs9A0MoeX2Q-1
X-Mimecast-MFC-AGG-ID: uxutYvR4NM-vs9A0MoeX2Q_1741599771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C57E91809CA6;
	Mon, 10 Mar 2025 09:42:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 069F83000197;
	Mon, 10 Mar 2025 09:42:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] afs: Fix afs_server ref accounting
Date: Mon, 10 Mar 2025 09:42:03 +0000
Message-ID: <20250310094206.801057-11-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The current way that afs_server refs are accounted and cleaned up sometimes
cause rmmod to hang when it is waiting for cell records to be removed.  The
problem is that the cell cleanup might occasionally happen before the
server cleanup and then there's nothing that causes the cell to
garbage-collect the remaining servers as they become inactive.

Partially fix this by:

 (1) Give each afs_server record its own management timer that rather than
     relying on the cell manager's central timer to drive each individual
     cell's maintenance work item to garbage collect servers.

     This timer is set when afs_unuse_server() reduces a server's activity
     count to zero and will schedule the server's destroyer work item upon
     firing.

 (2) Give each afs_server record its own destroyer work item that removes
     the record from the cell's database, shuts down the timer, cancels any
     pending work for itself, sends an RPC to the server to cancel
     outstanding callbacks.

     This change, in combination with the timer, obviates the need to try
     and coordinate so closely between the cell record and a bunch of other
     server records to try and tear everything down in a coordinated
     fashion.  With this, the cell record is pinned until the server RCU is
     complete and namespace/module removal will wait until all the cell
     records are removed.

 (3) Now that incoming calls are mapped to servers (and thus cells) using
     data attached to an rxrpc_peer, the UUID-to-server mapping tree is
     moved from the namespace to the cell (cell->fs_servers).  This means
     there can no longer be duplicates therein - and that allows the
     mapping tree to be simpler as there doesn't need to be a chain of
     same-UUID servers that are in different cells.

 (4) The lock protecting the UUID mapping tree is switched to an
     rw_semaphore on the cell rather than a seqlock on the namespace as
     it's now only used during mounting in contexts in which we're allowed
     to sleep.

 (5) When it comes time for a cell that is being removed to purge its set
     of servers, it just needs to iterate over them and wake them up.  Once
     a server becomes inactive, its destroyer work item will observe the
     state of the cell and immediately remove that record.

 (6) When a server record is removed, it is marked AFS_SERVER_FL_EXPIRED to
     prevent reattempts at removal.  The record will be dispatched to RCU
     for destruction once its refcount reaches 0.

 (7) The AFS_SERVER_FL_UNCREATED/CREATING flags are used to synchronise
     simultaneous creation attempts.  If one attempt fails, it will abandon
     the attempt and allow another to try again.

     Note that the record can't just be abandoned when dead as it's bound
     into a server list attached to a volume and only subject to
     replacement if the server list obtained for the volume from the VLDB
     changes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-15-dhowells@redhat.com/ # v1
---
 fs/afs/cell.c              |   3 +-
 fs/afs/fsclient.c          |   4 +-
 fs/afs/internal.h          |  54 ++--
 fs/afs/main.c              |  10 +-
 fs/afs/server.c            | 564 ++++++++++++++++---------------------
 fs/afs/server_list.c       |   4 +-
 include/trace/events/afs.h |   7 +-
 7 files changed, 289 insertions(+), 357 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index acbf35b4c9ed..694714d296ba 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -169,7 +169,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	INIT_HLIST_HEAD(&cell->proc_volumes);
 	seqlock_init(&cell->volume_lock);
 	cell->fs_servers = RB_ROOT;
-	seqlock_init(&cell->fs_lock);
+	init_rwsem(&cell->fs_lock);
 	rwlock_init(&cell->vl_servers_lock);
 	cell->flags = (1 << AFS_CELL_FL_CHECK_ALIAS);
 
@@ -838,6 +838,7 @@ static void afs_manage_cell(struct afs_cell *cell)
 	/* The root volume is pinning the cell */
 	afs_put_volume(cell->root_volume, afs_volume_trace_put_cell_root);
 	cell->root_volume = NULL;
+	afs_purge_servers(cell);
 	afs_put_cell(cell, afs_cell_trace_put_destroy);
 }
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 9f46d9aebc33..bc9556991d7c 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1653,7 +1653,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
 	bp = call->request;
 	*bp++ = htonl(FSGIVEUPALLCALLBACKS);
 
-	call->server = afs_use_server(server, afs_server_trace_use_give_up_cb);
+	call->server = afs_use_server(server, false, afs_server_trace_use_give_up_cb);
 	afs_make_call(call, GFP_NOFS);
 	afs_wait_for_call_to_complete(call);
 	ret = call->error;
@@ -1760,7 +1760,7 @@ bool afs_fs_get_capabilities(struct afs_net *net, struct afs_server *server,
 		return false;
 
 	call->key	= key;
-	call->server	= afs_use_server(server, afs_server_trace_use_get_caps);
+	call->server	= afs_use_server(server, false, afs_server_trace_use_get_caps);
 	call->peer	= rxrpc_kernel_get_peer(estate->addresses->addrs[addr_index].peer);
 	call->probe	= afs_get_endpoint_state(estate, afs_estate_trace_get_getcaps);
 	call->probe_index = addr_index;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3321fdafb3c7..1e0ab5e7fc88 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -302,18 +302,11 @@ struct afs_net {
 	 * cell, but in practice, people create aliases and subsets and there's
 	 * no easy way to distinguish them.
 	 */
-	seqlock_t		fs_lock;	/* For fs_servers, fs_probe_*, fs_proc */
-	struct rb_root		fs_servers;	/* afs_server (by server UUID or address) */
+	seqlock_t		fs_lock;	/* For fs_probe_*, fs_proc */
 	struct list_head	fs_probe_fast;	/* List of afs_server to probe at 30s intervals */
 	struct list_head	fs_probe_slow;	/* List of afs_server to probe at 5m intervals */
 	struct hlist_head	fs_proc;	/* procfs servers list */
 
-	struct hlist_head	fs_addresses;	/* afs_server (by lowest IPv6 addr) */
-	seqlock_t		fs_addr_lock;	/* For fs_addresses[46] */
-
-	struct work_struct	fs_manager;
-	struct timer_list	fs_timer;
-
 	struct work_struct	fs_prober;
 	struct timer_list	fs_probe_timer;
 	atomic_t		servers_outstanding;
@@ -409,7 +402,7 @@ struct afs_cell {
 
 	/* Active fileserver interaction state. */
 	struct rb_root		fs_servers;	/* afs_server (by server UUID) */
-	seqlock_t		fs_lock;	/* For fs_servers  */
+	struct rw_semaphore	fs_lock;	/* For fs_servers  */
 
 	/* VL server list. */
 	rwlock_t		vl_servers_lock; /* Lock on vl_servers */
@@ -544,22 +537,22 @@ struct afs_server {
 	};
 
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
-	struct rb_node		uuid_rb;	/* Link in net->fs_servers */
-	struct afs_server __rcu	*uuid_next;	/* Next server with same UUID */
-	struct afs_server	*uuid_prev;	/* Previous server with same UUID */
-	struct list_head	probe_link;	/* Link in net->fs_probe_list */
-	struct hlist_node	addr_link;	/* Link in net->fs_addresses6 */
+	struct rb_node		uuid_rb;	/* Link in cell->fs_servers */
+	struct list_head	probe_link;	/* Link in net->fs_probe_* */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
 	struct list_head	volumes;	/* RCU list of afs_server_entry objects */
-	struct afs_server	*gc_next;	/* Next server in manager's list */
+	struct work_struct	destroyer;	/* Work item to try and destroy a server */
+	struct timer_list	timer;		/* Management timer */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
 #define AFS_SERVER_FL_RESPONDING 0		/* The server is responding */
 #define AFS_SERVER_FL_UPDATING	1
 #define AFS_SERVER_FL_NEEDS_UPDATE 2		/* Fileserver address list is out of date */
-#define AFS_SERVER_FL_NOT_READY	4		/* The record is not ready for use */
-#define AFS_SERVER_FL_NOT_FOUND	5		/* VL server says no such server */
-#define AFS_SERVER_FL_VL_FAIL	6		/* Failed to access VL server */
+#define AFS_SERVER_FL_UNCREATED	3		/* The record needs creating */
+#define AFS_SERVER_FL_CREATING	4		/* The record is being created */
+#define AFS_SERVER_FL_EXPIRED	5		/* The record has expired */
+#define AFS_SERVER_FL_NOT_FOUND	6		/* VL server says no such server */
+#define AFS_SERVER_FL_VL_FAIL	7		/* Failed to access VL server */
 #define AFS_SERVER_FL_MAY_HAVE_CB 8		/* May have callbacks on this fileserver */
 #define AFS_SERVER_FL_IS_YFS	16		/* Server is YFS not AFS */
 #define AFS_SERVER_FL_NO_IBULK	17		/* Fileserver doesn't support FS.InlineBulkStatus */
@@ -569,6 +562,7 @@ struct afs_server {
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
 	u16			service_id;	/* Service ID we're using. */
+	short			create_error;	/* Creation error */
 	unsigned int		rtt;		/* Server's current RTT in uS */
 	unsigned int		debug_id;	/* Debugging ID for traces */
 
@@ -1513,19 +1507,29 @@ extern void __exit afs_clean_up_permit_cache(void);
 extern spinlock_t afs_server_peer_lock;
 
 struct afs_server *afs_find_server(const struct rxrpc_peer *peer);
-extern struct afs_server *afs_find_server_by_uuid(struct afs_net *, const uuid_t *);
 extern struct afs_server *afs_lookup_server(struct afs_cell *, struct key *, const uuid_t *, u32);
 extern struct afs_server *afs_get_server(struct afs_server *, enum afs_server_trace);
-extern struct afs_server *afs_use_server(struct afs_server *, enum afs_server_trace);
-extern void afs_unuse_server(struct afs_net *, struct afs_server *, enum afs_server_trace);
-extern void afs_unuse_server_notime(struct afs_net *, struct afs_server *, enum afs_server_trace);
+struct afs_server *afs_use_server(struct afs_server *server, bool activate,
+				  enum afs_server_trace reason);
+void afs_unuse_server(struct afs_net *net, struct afs_server *server,
+		      enum afs_server_trace reason);
+void afs_unuse_server_notime(struct afs_net *net, struct afs_server *server,
+			     enum afs_server_trace reason);
 extern void afs_put_server(struct afs_net *, struct afs_server *, enum afs_server_trace);
-extern void afs_manage_servers(struct work_struct *);
-extern void afs_servers_timer(struct timer_list *);
+void afs_purge_servers(struct afs_cell *cell);
 extern void afs_fs_probe_timer(struct timer_list *);
-extern void __net_exit afs_purge_servers(struct afs_net *);
+void __net_exit afs_wait_for_servers(struct afs_net *net);
 bool afs_check_server_record(struct afs_operation *op, struct afs_server *server, struct key *key);
 
+static inline void afs_see_server(struct afs_server *server, enum afs_server_trace trace)
+{
+	int r = refcount_read(&server->ref);
+	int a = atomic_read(&server->active);
+
+	trace_afs_server(server->debug_id, r, a, trace);
+
+}
+
 static inline void afs_inc_servers_outstanding(struct afs_net *net)
 {
 	atomic_inc(&net->servers_outstanding);
diff --git a/fs/afs/main.c b/fs/afs/main.c
index a7c7dc268302..bff0363286b0 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -86,16 +86,10 @@ static int __net_init afs_net_init(struct net *net_ns)
 	INIT_HLIST_HEAD(&net->proc_cells);
 
 	seqlock_init(&net->fs_lock);
-	net->fs_servers = RB_ROOT;
 	INIT_LIST_HEAD(&net->fs_probe_fast);
 	INIT_LIST_HEAD(&net->fs_probe_slow);
 	INIT_HLIST_HEAD(&net->fs_proc);
 
-	INIT_HLIST_HEAD(&net->fs_addresses);
-	seqlock_init(&net->fs_addr_lock);
-
-	INIT_WORK(&net->fs_manager, afs_manage_servers);
-	timer_setup(&net->fs_timer, afs_servers_timer, 0);
 	INIT_WORK(&net->fs_prober, afs_fs_probe_dispatcher);
 	timer_setup(&net->fs_probe_timer, afs_fs_probe_timer, 0);
 	atomic_set(&net->servers_outstanding, 1);
@@ -131,7 +125,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	net->live = false;
 	afs_fs_probe_cleanup(net);
 	afs_cell_purge(net);
-	afs_purge_servers(net);
+	afs_wait_for_servers(net);
 error_cell_init:
 	net->live = false;
 	afs_proc_cleanup(net);
@@ -153,7 +147,7 @@ static void __net_exit afs_net_exit(struct net *net_ns)
 	net->live = false;
 	afs_fs_probe_cleanup(net);
 	afs_cell_purge(net);
-	afs_purge_servers(net);
+	afs_wait_for_servers(net);
 	afs_close_socket(net);
 	afs_proc_cleanup(net);
 	afs_put_sysnames(net->sysnames);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 1140773f7aed..487e2134aea4 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -14,9 +14,9 @@
 static unsigned afs_server_gc_delay = 10;	/* Server record timeout in seconds */
 static atomic_t afs_server_debug_id;
 
-static struct afs_server *afs_maybe_use_server(struct afs_server *,
-					       enum afs_server_trace);
 static void __afs_put_server(struct afs_net *, struct afs_server *);
+static void afs_server_timer(struct timer_list *timer);
+static void afs_server_destroyer(struct work_struct *work);
 
 /*
  * Find a server by one of its addresses.
@@ -27,148 +27,91 @@ struct afs_server *afs_find_server(const struct rxrpc_peer *peer)
 
 	if (!server)
 		return NULL;
-	return afs_maybe_use_server(server, afs_server_trace_use_cm_call);
+	return afs_use_server(server, false, afs_server_trace_use_cm_call);
 }
 
 /*
- * Look up a server by its UUID and mark it active.
+ * Look up a server by its UUID and mark it active.  The caller must hold
+ * cell->fs_lock.
  */
-struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uuid)
+static struct afs_server *afs_find_server_by_uuid(struct afs_cell *cell, const uuid_t *uuid)
 {
-	struct afs_server *server = NULL;
+	struct afs_server *server;
 	struct rb_node *p;
-	int diff, seq = 1;
+	int diff;
 
 	_enter("%pU", uuid);
 
-	do {
-		/* Unfortunately, rbtree walking doesn't give reliable results
-		 * under just the RCU read lock, so we have to check for
-		 * changes.
-		 */
-		if (server)
-			afs_unuse_server(net, server, afs_server_trace_unuse_uuid_rsq);
-		server = NULL;
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		read_seqbegin_or_lock(&net->fs_lock, &seq);
-
-		p = net->fs_servers.rb_node;
-		while (p) {
-			server = rb_entry(p, struct afs_server, uuid_rb);
-
-			diff = memcmp(uuid, &server->uuid, sizeof(*uuid));
-			if (diff < 0) {
-				p = p->rb_left;
-			} else if (diff > 0) {
-				p = p->rb_right;
-			} else {
-				afs_use_server(server, afs_server_trace_use_by_uuid);
-				break;
-			}
-
-			server = NULL;
-		}
-	} while (need_seqretry(&net->fs_lock, seq));
+	p = cell->fs_servers.rb_node;
+	while (p) {
+		server = rb_entry(p, struct afs_server, uuid_rb);
 
-	done_seqretry(&net->fs_lock, seq);
+		diff = memcmp(uuid, &server->uuid, sizeof(*uuid));
+		if (diff < 0) {
+			p = p->rb_left;
+		} else if (diff > 0) {
+			p = p->rb_right;
+		} else {
+			if (test_bit(AFS_SERVER_FL_UNCREATED, &server->flags))
+				return NULL; /* Need a write lock */
+			afs_use_server(server, true, afs_server_trace_use_by_uuid);
+			return server;
+		}
+	}
 
-	_leave(" = %p", server);
-	return server;
+	return NULL;
 }
 
 /*
- * Install a server record in the namespace tree.  If there's a clash, we stick
- * it into a list anchored on whichever afs_server struct is actually in the
- * tree.
+ * Install a server record in the cell tree.  The caller must hold an exclusive
+ * lock on cell->fs_lock.
  */
 static struct afs_server *afs_install_server(struct afs_cell *cell,
-					     struct afs_server *candidate)
+					     struct afs_server **candidate)
 {
-	const struct afs_endpoint_state *estate;
-	const struct afs_addr_list *alist;
-	struct afs_server *server, *next;
+	struct afs_server *server;
 	struct afs_net *net = cell->net;
 	struct rb_node **pp, *p;
 	int diff;
 
 	_enter("%p", candidate);
 
-	write_seqlock(&net->fs_lock);
-
 	/* Firstly install the server in the UUID lookup tree */
-	pp = &net->fs_servers.rb_node;
+	pp = &cell->fs_servers.rb_node;
 	p = NULL;
 	while (*pp) {
 		p = *pp;
 		_debug("- consider %p", p);
 		server = rb_entry(p, struct afs_server, uuid_rb);
-		diff = memcmp(&candidate->uuid, &server->uuid, sizeof(uuid_t));
-		if (diff < 0) {
+		diff = memcmp(&(*candidate)->uuid, &server->uuid, sizeof(uuid_t));
+		if (diff < 0)
 			pp = &(*pp)->rb_left;
-		} else if (diff > 0) {
+		else if (diff > 0)
 			pp = &(*pp)->rb_right;
-		} else {
-			if (server->cell == cell)
-				goto exists;
-
-			/* We have the same UUID representing servers in
-			 * different cells.  Append the new server to the list.
-			 */
-			for (;;) {
-				next = rcu_dereference_protected(
-					server->uuid_next,
-					lockdep_is_held(&net->fs_lock.lock));
-				if (!next)
-					break;
-				server = next;
-			}
-			rcu_assign_pointer(server->uuid_next, candidate);
-			candidate->uuid_prev = server;
-			server = candidate;
-			goto added_dup;
-		}
+		else
+			goto exists;
 	}
 
-	server = candidate;
+	server = *candidate;
+	*candidate = NULL;
 	rb_link_node(&server->uuid_rb, p, pp);
-	rb_insert_color(&server->uuid_rb, &net->fs_servers);
+	rb_insert_color(&server->uuid_rb, &cell->fs_servers);
+	write_seqlock(&net->fs_lock);
 	hlist_add_head_rcu(&server->proc_link, &net->fs_proc);
+	write_sequnlock(&net->fs_lock);
 
 	afs_get_cell(cell, afs_cell_trace_get_server);
 
-added_dup:
-	write_seqlock(&net->fs_addr_lock);
-	estate = rcu_dereference_protected(server->endpoint_state,
-					   lockdep_is_held(&net->fs_addr_lock.lock));
-	alist = estate->addresses;
-
-	/* Secondly, if the server has any IPv4 and/or IPv6 addresses, install
-	 * it in the IPv4 and/or IPv6 reverse-map lists.
-	 *
-	 * TODO: For speed we want to use something other than a flat list
-	 * here; even sorting the list in terms of lowest address would help a
-	 * bit, but anything we might want to do gets messy and memory
-	 * intensive.
-	 */
-	if (alist->nr_addrs > 0)
-		hlist_add_head_rcu(&server->addr_link, &net->fs_addresses);
-
-	write_sequnlock(&net->fs_addr_lock);
-
 exists:
-	afs_get_server(server, afs_server_trace_get_install);
-	write_sequnlock(&net->fs_lock);
+	afs_use_server(server, true, afs_server_trace_get_install);
 	return server;
 }
 
 /*
- * Allocate a new server record and mark it active.
+ * Allocate a new server record and mark it as active but uncreated.
  */
-static struct afs_server *afs_alloc_server(struct afs_cell *cell,
-					   const uuid_t *uuid,
-					   struct afs_addr_list *alist)
+static struct afs_server *afs_alloc_server(struct afs_cell *cell, const uuid_t *uuid)
 {
-	struct afs_endpoint_state *estate;
 	struct afs_server *server;
 	struct afs_net *net = cell->net;
 
@@ -176,65 +119,49 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 
 	server = kzalloc(sizeof(struct afs_server), GFP_KERNEL);
 	if (!server)
-		goto enomem;
-
-	estate = kzalloc(sizeof(struct afs_endpoint_state), GFP_KERNEL);
-	if (!estate)
-		goto enomem_server;
+		return NULL;
 
 	refcount_set(&server->ref, 1);
-	atomic_set(&server->active, 1);
+	atomic_set(&server->active, 0);
+	__set_bit(AFS_SERVER_FL_UNCREATED, &server->flags);
 	server->debug_id = atomic_inc_return(&afs_server_debug_id);
-	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
+	INIT_WORK(&server->destroyer, &afs_server_destroyer);
+	timer_setup(&server->timer, afs_server_timer, 0);
 	INIT_LIST_HEAD(&server->volumes);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
+	INIT_HLIST_NODE(&server->proc_link);
 	spin_lock_init(&server->probe_lock);
 	server->cell = cell;
 	server->rtt = UINT_MAX;
 	server->service_id = FS_SERVICE;
-
 	server->probe_counter = 1;
 	server->probed_at = jiffies - LONG_MAX / 2;
-	refcount_set(&estate->ref, 1);
-	estate->addresses = alist;
-	estate->server_id = server->debug_id;
-	estate->probe_seq = 1;
-	rcu_assign_pointer(server->endpoint_state, estate);
 
 	afs_inc_servers_outstanding(net);
-	trace_afs_server(server->debug_id, 1, 1, afs_server_trace_alloc);
-	trace_afs_estate(estate->server_id, estate->probe_seq, refcount_read(&estate->ref),
-			 afs_estate_trace_alloc_server);
 	_leave(" = %p", server);
 	return server;
-
-enomem_server:
-	kfree(server);
-enomem:
-	_leave(" = NULL [nomem]");
-	return NULL;
 }
 
 /*
  * Look up an address record for a server
  */
-static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
-						 struct key *key, const uuid_t *uuid)
+static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_server *server,
+						 struct key *key)
 {
 	struct afs_vl_cursor vc;
 	struct afs_addr_list *alist = NULL;
 	int ret;
 
 	ret = -ERESTARTSYS;
-	if (afs_begin_vlserver_operation(&vc, cell, key)) {
+	if (afs_begin_vlserver_operation(&vc, server->cell, key)) {
 		while (afs_select_vlserver(&vc)) {
 			if (test_bit(AFS_VLSERVER_FL_IS_YFS, &vc.server->flags))
-				alist = afs_yfsvl_get_endpoints(&vc, uuid);
+				alist = afs_yfsvl_get_endpoints(&vc, &server->uuid);
 			else
-				alist = afs_vl_get_addrs_u(&vc, uuid);
+				alist = afs_vl_get_addrs_u(&vc, &server->uuid);
 		}
 
 		ret = afs_end_vlserver_operation(&vc);
@@ -250,67 +177,116 @@ static struct afs_addr_list *afs_vl_lookup_addrs(struct afs_cell *cell,
 struct afs_server *afs_lookup_server(struct afs_cell *cell, struct key *key,
 				     const uuid_t *uuid, u32 addr_version)
 {
-	struct afs_addr_list *alist;
-	struct afs_server *server, *candidate;
+	struct afs_addr_list *alist = NULL;
+	struct afs_server *server, *candidate = NULL;
+	bool creating = false;
+	int ret;
 
 	_enter("%p,%pU", cell->net, uuid);
 
-	server = afs_find_server_by_uuid(cell->net, uuid);
+	down_read(&cell->fs_lock);
+	server = afs_find_server_by_uuid(cell, uuid);
+	/* Won't see servers marked uncreated. */
+	up_read(&cell->fs_lock);
+
 	if (server) {
+		timer_delete_sync(&server->timer);
+		if (test_bit(AFS_SERVER_FL_CREATING, &server->flags))
+			goto wait_for_creation;
 		if (server->addr_version != addr_version)
 			set_bit(AFS_SERVER_FL_NEEDS_UPDATE, &server->flags);
 		return server;
 	}
 
-	alist = afs_vl_lookup_addrs(cell, key, uuid);
-	if (IS_ERR(alist))
-		return ERR_CAST(alist);
-
-	candidate = afs_alloc_server(cell, uuid, alist);
+	candidate = afs_alloc_server(cell, uuid);
 	if (!candidate) {
 		afs_put_addrlist(alist, afs_alist_trace_put_server_oom);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	server = afs_install_server(cell, candidate);
-	if (server != candidate) {
-		afs_put_addrlist(alist, afs_alist_trace_put_server_dup);
+	down_write(&cell->fs_lock);
+	server = afs_install_server(cell, &candidate);
+	if (test_bit(AFS_SERVER_FL_CREATING, &server->flags)) {
+		/* We need to wait for creation to complete. */
+		up_write(&cell->fs_lock);
+		goto wait_for_creation;
+	}
+	if (test_bit(AFS_SERVER_FL_UNCREATED, &server->flags)) {
+		set_bit(AFS_SERVER_FL_CREATING, &server->flags);
+		clear_bit(AFS_SERVER_FL_UNCREATED, &server->flags);
+		creating = true;
+	}
+	up_write(&cell->fs_lock);
+	timer_delete_sync(&server->timer);
+
+	/* If we get to create the server, we look up the addresses and then
+	 * immediately dispatch an asynchronous probe to each interface on the
+	 * fileserver.  This will make sure the repeat-probing service is
+	 * started.
+	 */
+	if (creating) {
+		alist = afs_vl_lookup_addrs(server, key);
+		if (IS_ERR(alist)) {
+			ret = PTR_ERR(alist);
+			goto create_failed;
+		}
+
+		ret = afs_fs_probe_fileserver(cell->net, server, alist, key);
+		if (ret)
+			goto create_failed;
+
+		clear_and_wake_up_bit(AFS_SERVER_FL_CREATING, &server->flags);
+	}
+
+out:
+	afs_put_addrlist(alist, afs_alist_trace_put_server_create);
+	if (candidate) {
+		kfree(rcu_access_pointer(server->endpoint_state));
 		kfree(candidate);
-	} else {
-		/* Immediately dispatch an asynchronous probe to each interface
-		 * on the fileserver.  This will make sure the repeat-probing
-		 * service is started.
-		 */
-		afs_fs_probe_fileserver(cell->net, server, alist, key);
+		afs_dec_servers_outstanding(cell->net);
+	}
+	return server ?: ERR_PTR(ret);
+
+wait_for_creation:
+	afs_see_server(server, afs_server_trace_wait_create);
+	wait_on_bit(&server->flags, AFS_SERVER_FL_CREATING, TASK_UNINTERRUPTIBLE);
+	if (test_bit_acquire(AFS_SERVER_FL_UNCREATED, &server->flags)) {
+		/* Barrier: read flag before error */
+		ret = READ_ONCE(server->create_error);
+		afs_put_server(cell->net, server, afs_server_trace_unuse_create_fail);
+		server = NULL;
+		goto out;
 	}
 
-	return server;
-}
+	ret = 0;
+	goto out;
 
-/*
- * Set the server timer to fire after a given delay, assuming it's not already
- * set for an earlier time.
- */
-static void afs_set_server_timer(struct afs_net *net, time64_t delay)
-{
-	if (net->live) {
-		afs_inc_servers_outstanding(net);
-		if (timer_reduce(&net->fs_timer, jiffies + delay * HZ))
-			afs_dec_servers_outstanding(net);
+create_failed:
+	down_write(&cell->fs_lock);
+
+	WRITE_ONCE(server->create_error, ret);
+	smp_wmb(); /* Barrier: set error before flag. */
+	set_bit(AFS_SERVER_FL_UNCREATED, &server->flags);
+
+	clear_and_wake_up_bit(AFS_SERVER_FL_CREATING, &server->flags);
+
+	if (test_bit(AFS_SERVER_FL_UNCREATED, &server->flags)) {
+		clear_bit(AFS_SERVER_FL_UNCREATED, &server->flags);
+		creating = true;
 	}
+	afs_unuse_server(cell->net, server, afs_server_trace_unuse_create_fail);
+	server = NULL;
+
+	up_write(&cell->fs_lock);
+	goto out;
 }
 
 /*
- * Server management timer.  We have an increment on fs_outstanding that we
- * need to pass along to the work item.
+ * Set/reduce a server's timer.
  */
-void afs_servers_timer(struct timer_list *timer)
+static void afs_set_server_timer(struct afs_server *server, unsigned int delay_secs)
 {
-	struct afs_net *net = container_of(timer, struct afs_net, fs_timer);
-
-	_enter("");
-	if (!queue_work(afs_wq, &net->fs_manager))
-		afs_dec_servers_outstanding(net);
+	mod_timer(&server->timer, jiffies + delay_secs * HZ);
 }
 
 /*
@@ -329,32 +305,20 @@ struct afs_server *afs_get_server(struct afs_server *server,
 }
 
 /*
- * Try to get a reference on a server object.
- */
-static struct afs_server *afs_maybe_use_server(struct afs_server *server,
-					       enum afs_server_trace reason)
-{
-	unsigned int a;
-	int r;
-
-	if (!__refcount_inc_not_zero(&server->ref, &r))
-		return NULL;
-
-	a = atomic_inc_return(&server->active);
-	trace_afs_server(server->debug_id, r + 1, a, reason);
-	return server;
-}
-
-/*
- * Get an active count on a server object.
+ * Get an active count on a server object and maybe remove from the inactive
+ * list.
  */
-struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_trace reason)
+struct afs_server *afs_use_server(struct afs_server *server, bool activate,
+				  enum afs_server_trace reason)
 {
 	unsigned int a;
 	int r;
 
 	__refcount_inc(&server->ref, &r);
 	a = atomic_inc_return(&server->active);
+	if (a == 1 && activate &&
+	    !test_bit(AFS_SERVER_FL_EXPIRED, &server->flags))
+		del_timer(&server->timer);
 
 	trace_afs_server(server->debug_id, r + 1, a, reason);
 	return server;
@@ -387,13 +351,16 @@ void afs_put_server(struct afs_net *net, struct afs_server *server,
 void afs_unuse_server_notime(struct afs_net *net, struct afs_server *server,
 			     enum afs_server_trace reason)
 {
-	if (server) {
-		unsigned int active = atomic_dec_return(&server->active);
+	if (!server)
+		return;
 
-		if (active == 0)
-			afs_set_server_timer(net, afs_server_gc_delay);
-		afs_put_server(net, server, reason);
+	if (atomic_dec_and_test(&server->active)) {
+		if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) ||
+		    READ_ONCE(server->cell->state) >= AFS_CELL_FAILED)
+			schedule_work(&server->destroyer);
 	}
+
+	afs_put_server(net, server, reason);
 }
 
 /*
@@ -402,10 +369,22 @@ void afs_unuse_server_notime(struct afs_net *net, struct afs_server *server,
 void afs_unuse_server(struct afs_net *net, struct afs_server *server,
 		      enum afs_server_trace reason)
 {
-	if (server) {
-		server->unuse_time = ktime_get_real_seconds();
-		afs_unuse_server_notime(net, server, reason);
+	if (!server)
+		return;
+
+	if (atomic_dec_and_test(&server->active)) {
+		if (!test_bit(AFS_SERVER_FL_EXPIRED, &server->flags) &&
+		    READ_ONCE(server->cell->state) < AFS_CELL_FAILED) {
+			time64_t unuse_time = ktime_get_real_seconds();
+
+			server->unuse_time = unuse_time;
+			afs_set_server_timer(server, afs_server_gc_delay);
+		} else {
+			schedule_work(&server->destroyer);
+		}
 	}
+
+	afs_put_server(net, server, reason);
 }
 
 static void afs_server_rcu(struct rcu_head *rcu)
@@ -435,166 +414,119 @@ static void afs_give_up_callbacks(struct afs_net *net, struct afs_server *server
 }
 
 /*
- * destroy a dead server
+ * Check to see if the server record has expired.
  */
-static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
+static bool afs_has_server_expired(const struct afs_server *server)
 {
-	struct afs_endpoint_state *estate;
+	time64_t expires_at;
 
-	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
-		afs_give_up_callbacks(net, server);
+	if (atomic_read(&server->active))
+		return false;
 
-	/* Unbind the rxrpc_peer records from the server. */
-	estate = rcu_access_pointer(server->endpoint_state);
-	if (estate)
-		afs_set_peer_appdata(server, estate->addresses, NULL);
+	if (server->cell->net->live ||
+	    server->cell->state >= AFS_CELL_FAILED) {
+		trace_afs_server(server->debug_id, refcount_read(&server->ref),
+				 0, afs_server_trace_purging);
+		return true;
+	}
 
-	afs_put_server(net, server, afs_server_trace_destroy);
+	expires_at = server->unuse_time;
+	if (!test_bit(AFS_SERVER_FL_VL_FAIL, &server->flags) &&
+	    !test_bit(AFS_SERVER_FL_NOT_FOUND, &server->flags))
+		expires_at += afs_server_gc_delay;
+
+	return ktime_get_real_seconds() > expires_at;
 }
 
 /*
- * Garbage collect any expired servers.
+ * Remove a server record from it's parent cell's database.
  */
-static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
+static bool afs_remove_server_from_cell(struct afs_server *server)
 {
-	struct afs_server *server, *next, *prev;
-	int active;
-
-	while ((server = gc_list)) {
-		gc_list = server->gc_next;
-
-		write_seqlock(&net->fs_lock);
-
-		active = atomic_read(&server->active);
-		if (active == 0) {
-			trace_afs_server(server->debug_id, refcount_read(&server->ref),
-					 active, afs_server_trace_gc);
-			next = rcu_dereference_protected(
-				server->uuid_next, lockdep_is_held(&net->fs_lock.lock));
-			prev = server->uuid_prev;
-			if (!prev) {
-				/* The one at the front is in the tree */
-				if (!next) {
-					rb_erase(&server->uuid_rb, &net->fs_servers);
-				} else {
-					rb_replace_node_rcu(&server->uuid_rb,
-							    &next->uuid_rb,
-							    &net->fs_servers);
-					next->uuid_prev = NULL;
-				}
-			} else {
-				/* This server is not at the front */
-				rcu_assign_pointer(prev->uuid_next, next);
-				if (next)
-					next->uuid_prev = prev;
-			}
-
-			list_del(&server->probe_link);
-			hlist_del_rcu(&server->proc_link);
-			if (!hlist_unhashed(&server->addr_link))
-				hlist_del_rcu(&server->addr_link);
-		}
-		write_sequnlock(&net->fs_lock);
+	struct afs_cell *cell = server->cell;
 
-		if (active == 0)
-			afs_destroy_server(net, server);
+	down_write(&cell->fs_lock);
+
+	if (!afs_has_server_expired(server)) {
+		up_write(&cell->fs_lock);
+		return false;
 	}
+
+	set_bit(AFS_SERVER_FL_EXPIRED, &server->flags);
+	_debug("expire %pU %u", &server->uuid, atomic_read(&server->active));
+	afs_see_server(server, afs_server_trace_see_expired);
+	rb_erase(&server->uuid_rb, &cell->fs_servers);
+	up_write(&cell->fs_lock);
+	return true;
 }
 
-/*
- * Manage the records of servers known to be within a network namespace.  This
- * includes garbage collecting unused servers.
- *
- * Note also that we were given an increment on net->servers_outstanding by
- * whoever queued us that we need to deal with before returning.
- */
-void afs_manage_servers(struct work_struct *work)
+static void afs_server_destroyer(struct work_struct *work)
 {
-	struct afs_net *net = container_of(work, struct afs_net, fs_manager);
-	struct afs_server *gc_list = NULL;
-	struct rb_node *cursor;
-	time64_t now = ktime_get_real_seconds(), next_manage = TIME64_MAX;
-	bool purging = !net->live;
-
-	_enter("");
+	struct afs_endpoint_state *estate;
+	struct afs_server *server = container_of(work, struct afs_server, destroyer);
+	struct afs_net *net = server->cell->net;
 
-	/* Trawl the server list looking for servers that have expired from
-	 * lack of use.
-	 */
-	read_seqlock_excl(&net->fs_lock);
+	afs_see_server(server, afs_server_trace_see_destroyer);
 
-	for (cursor = rb_first(&net->fs_servers); cursor; cursor = rb_next(cursor)) {
-		struct afs_server *server =
-			rb_entry(cursor, struct afs_server, uuid_rb);
-		int active = atomic_read(&server->active);
+	if (test_bit(AFS_SERVER_FL_EXPIRED, &server->flags))
+		return;
 
-		_debug("manage %pU %u", &server->uuid, active);
+	if (!afs_remove_server_from_cell(server))
+		return;
 
-		if (purging) {
-			trace_afs_server(server->debug_id, refcount_read(&server->ref),
-					 active, afs_server_trace_purging);
-			if (active != 0)
-				pr_notice("Can't purge s=%08x\n", server->debug_id);
-		}
+	timer_shutdown_sync(&server->timer);
+	cancel_work(&server->destroyer);
 
-		if (active == 0) {
-			time64_t expire_at = server->unuse_time;
-
-			if (!test_bit(AFS_SERVER_FL_VL_FAIL, &server->flags) &&
-			    !test_bit(AFS_SERVER_FL_NOT_FOUND, &server->flags))
-				expire_at += afs_server_gc_delay;
-			if (purging || expire_at <= now) {
-				server->gc_next = gc_list;
-				gc_list = server;
-			} else if (expire_at < next_manage) {
-				next_manage = expire_at;
-			}
-		}
-	}
+	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
+		afs_give_up_callbacks(net, server);
 
-	read_sequnlock_excl(&net->fs_lock);
+	/* Unbind the rxrpc_peer records from the server. */
+	estate = rcu_access_pointer(server->endpoint_state);
+	if (estate)
+		afs_set_peer_appdata(server, estate->addresses, NULL);
 
-	/* Update the timer on the way out.  We have to pass an increment on
-	 * servers_outstanding in the namespace that we are in to the timer or
-	 * the work scheduler.
-	 */
-	if (!purging && next_manage < TIME64_MAX) {
-		now = ktime_get_real_seconds();
+	write_seqlock(&net->fs_lock);
+	list_del_init(&server->probe_link);
+	if (!hlist_unhashed(&server->proc_link))
+		hlist_del_rcu(&server->proc_link);
+	write_sequnlock(&net->fs_lock);
 
-		if (next_manage - now <= 0) {
-			if (queue_work(afs_wq, &net->fs_manager))
-				afs_inc_servers_outstanding(net);
-		} else {
-			afs_set_server_timer(net, next_manage - now);
-		}
-	}
+	afs_put_server(net, server, afs_server_trace_destroy);
+}
 
-	afs_gc_servers(net, gc_list);
+static void afs_server_timer(struct timer_list *timer)
+{
+	struct afs_server *server = container_of(timer, struct afs_server, timer);
 
-	afs_dec_servers_outstanding(net);
-	_leave(" [%d]", atomic_read(&net->servers_outstanding));
+	afs_see_server(server, afs_server_trace_see_timer);
+	if (!test_bit(AFS_SERVER_FL_EXPIRED, &server->flags))
+		schedule_work(&server->destroyer);
 }
 
-static void afs_queue_server_manager(struct afs_net *net)
+/*
+ * Wake up all the servers in a cell so that they can purge themselves.
+ */
+void afs_purge_servers(struct afs_cell *cell)
 {
-	afs_inc_servers_outstanding(net);
-	if (!queue_work(afs_wq, &net->fs_manager))
-		afs_dec_servers_outstanding(net);
+	struct afs_server *server;
+	struct rb_node *rb;
+
+	down_read(&cell->fs_lock);
+	for (rb = rb_first(&cell->fs_servers); rb; rb = rb_next(rb)) {
+		server = rb_entry(rb, struct afs_server, uuid_rb);
+		afs_see_server(server, afs_server_trace_see_purge);
+		schedule_work(&server->destroyer);
+	}
+	up_read(&cell->fs_lock);
 }
 
 /*
- * Purge list of servers.
+ * Wait for outstanding servers.
  */
-void afs_purge_servers(struct afs_net *net)
+void afs_wait_for_servers(struct afs_net *net)
 {
 	_enter("");
 
-	if (del_timer_sync(&net->fs_timer))
-		afs_dec_servers_outstanding(net);
-
-	afs_queue_server_manager(net);
-
-	_debug("wait");
 	atomic_dec(&net->servers_outstanding);
 	wait_var_event(&net->servers_outstanding,
 		       !atomic_read(&net->servers_outstanding));
@@ -618,7 +550,7 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
 			 atomic_read(&server->active),
 			 afs_server_trace_update);
 
-	alist = afs_vl_lookup_addrs(op->volume->cell, op->key, &server->uuid);
+	alist = afs_vl_lookup_addrs(server, op->key);
 	if (IS_ERR(alist)) {
 		rcu_read_lock();
 		estate = rcu_dereference(server->endpoint_state);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 784236b9b2a9..20d5474837df 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -97,8 +97,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
-				afs_unuse_server(volume->cell->net, server,
-						 afs_server_trace_unuse_slist_isort);
+				afs_unuse_server_notime(volume->cell->net, server,
+							afs_server_trace_unuse_slist_isort);
 				continue;
 			}
 
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 4d798b9e43bf..02f8b2a6977c 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -127,7 +127,6 @@ enum yfs_cm_operation {
 	E_(afs_call_trace_work,			"QUEUE")
 
 #define afs_server_traces \
-	EM(afs_server_trace_alloc,		"ALLOC    ") \
 	EM(afs_server_trace_callback,		"CALLBACK ") \
 	EM(afs_server_trace_destroy,		"DESTROY  ") \
 	EM(afs_server_trace_free,		"FREE     ") \
@@ -137,12 +136,14 @@ enum yfs_cm_operation {
 	EM(afs_server_trace_purging,		"PURGE    ") \
 	EM(afs_server_trace_put_cbi,		"PUT cbi  ") \
 	EM(afs_server_trace_put_probe,		"PUT probe") \
+	EM(afs_server_trace_see_destroyer,	"SEE destr") \
 	EM(afs_server_trace_see_expired,	"SEE expd ") \
+	EM(afs_server_trace_see_purge,		"SEE purge") \
+	EM(afs_server_trace_see_timer,		"SEE timer") \
 	EM(afs_server_trace_unuse_call,		"UNU call ") \
 	EM(afs_server_trace_unuse_create_fail,	"UNU cfail") \
 	EM(afs_server_trace_unuse_slist,	"UNU slist") \
 	EM(afs_server_trace_unuse_slist_isort,	"UNU isort") \
-	EM(afs_server_trace_unuse_uuid_rsq,	"PUT u-req") \
 	EM(afs_server_trace_update,		"UPDATE   ") \
 	EM(afs_server_trace_use_by_uuid,	"USE uuid ") \
 	EM(afs_server_trace_use_cm_call,	"USE cm-cl") \
@@ -229,7 +230,7 @@ enum yfs_cm_operation {
 	EM(afs_alist_trace_put_getaddru,	"PUT GtAdrU") \
 	EM(afs_alist_trace_put_parse_empty,	"PUT p-empt") \
 	EM(afs_alist_trace_put_parse_error,	"PUT p-err ") \
-	EM(afs_alist_trace_put_server_dup,	"PUT sv-dup") \
+	EM(afs_alist_trace_put_server_create,	"PUT sv-crt") \
 	EM(afs_alist_trace_put_server_oom,	"PUT sv-oom") \
 	EM(afs_alist_trace_put_server_update,	"PUT sv-upd") \
 	EM(afs_alist_trace_put_vlgetcaps,	"PUT vgtcap") \



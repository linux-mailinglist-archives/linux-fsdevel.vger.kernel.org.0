Return-Path: <linux-fsdevel+bounces-5889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA38781139E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1555282840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105992EB18;
	Wed, 13 Dec 2023 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGOuX8Ms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E96187
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2GWhe9FZEsJl5IpiJcmjxtT2QQDd4kAj0w10I5PhSo=;
	b=DGOuX8Msx256aqKttnBBkzjAeTMBZmb8fKC56R7GLIpoDbd1WbRr+KB8+EqRaNqmL9BNqH
	cj1cSkUx67En0rKlC03EvtNGg9kg/UI4EC7EulZNifagC+utbjxzUYbRzCPSUKEf4xobZZ
	sWTTBb/DWs+FOdIeP58QoNIDUENCTSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-QHbI7rmhMOqpjfSVUp3aXw-1; Wed, 13 Dec 2023 08:50:59 -0500
X-MC-Unique: QHbI7rmhMOqpjfSVUp3aXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BA0B185A782;
	Wed, 13 Dec 2023 13:50:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5113851E3;
	Wed, 13 Dec 2023 13:50:58 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/40] afs: Apply server breaks to mmap'd files in the call processor
Date: Wed, 13 Dec 2023 13:49:55 +0000
Message-ID: <20231213135003.367397-34-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Apply server breaks to mmap'd files that are being used from that server
from the call processor work function rather than punting it off to a
workqueue.  The work item, afs_server_init_callback(), then bumps each
individual inode off to its own work item introducing a potentially lengthy
delay.  This reduces that delay at the cost of extending the amount of time
we delay replying to the CB.InitCallBack3 notification RPC from the server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/callback.c          | 33 +++++++++++++++++++--------------
 fs/afs/cell.c              |  2 +-
 fs/afs/internal.h          |  4 +---
 fs/afs/server.c            |  2 --
 fs/afs/server_list.c       | 22 +++++++++++-----------
 include/trace/events/afs.h |  2 ++
 6 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 90f9b2a46ff4..f67e88076761 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -33,9 +33,8 @@ void afs_invalidate_mmap_work(struct work_struct *work)
 	unmap_mapping_pages(vnode->netfs.inode.i_mapping, 0, 0, false);
 }
 
-void afs_server_init_callback_work(struct work_struct *work)
+static void afs_server_init_callback(struct afs_server *server)
 {
-	struct afs_server *server = container_of(work, struct afs_server, initcb_work);
 	struct afs_vnode *vnode;
 	struct afs_cell *cell = server->cell;
 
@@ -57,15 +56,19 @@ void afs_server_init_callback_work(struct work_struct *work)
  */
 void afs_init_callback_state(struct afs_server *server)
 {
-	rcu_read_lock();
+	struct afs_cell *cell = server->cell;
+
+	down_read(&cell->vs_lock);
+
 	do {
 		server->cb_s_break++;
 		atomic_inc(&server->cell->fs_s_break);
 		if (!list_empty(&server->cell->fs_open_mmaps))
-			queue_work(system_unbound_wq, &server->initcb_work);
+			afs_server_init_callback(server);
 
 	} while ((server = rcu_dereference(server->uuid_next)));
-	rcu_read_unlock();
+
+	up_read(&cell->vs_lock);
 }
 
 /*
@@ -112,7 +115,7 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 	struct rb_node *p;
 	int seq = 1;
 
-	do {
+	for (;;) {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
@@ -133,7 +136,12 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 			volume = NULL;
 		}
 
-	} while (need_seqretry(&cell->volume_lock, seq));
+		if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
+			break;
+		if (!need_seqretry(&cell->volume_lock, seq))
+			break;
+		seq |= 1; /* Want a lock next time */
+	}
 
 	done_seqretry(&cell->volume_lock, seq);
 	return volume;
@@ -188,12 +196,11 @@ static void afs_break_some_callbacks(struct afs_server *server,
 	afs_volid_t vid = cbb->fid.vid;
 	size_t i;
 
+	rcu_read_lock();
 	volume = afs_lookup_volume_rcu(server->cell, vid);
-
 	/* TODO: Find all matching volumes if we couldn't match the server and
 	 * break them anyway.
 	 */
-
 	for (i = *_count; i > 0; cbb++, i--) {
 		if (cbb->fid.vid == vid) {
 			_debug("- Fid { vl=%08llx n=%llu u=%u }",
@@ -207,6 +214,9 @@ static void afs_break_some_callbacks(struct afs_server *server,
 			*residue++ = *cbb;
 		}
 	}
+
+	rcu_read_unlock();
+	afs_put_volume(volume, afs_volume_trace_put_callback);
 }
 
 /*
@@ -219,11 +229,6 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 
 	ASSERT(server != NULL);
 
-	rcu_read_lock();
-
 	while (count > 0)
 		afs_break_some_callbacks(server, callbacks, &count);
-
-	rcu_read_unlock();
-	return;
 }
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 6b389f2bcd0c..1e5cb0f6ee07 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -161,7 +161,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	refcount_set(&cell->ref, 1);
 	atomic_set(&cell->active, 0);
 	INIT_WORK(&cell->manager, afs_manage_cell_work);
-	spin_lock_init(&cell->vs_lock);
+	init_rwsem(&cell->vs_lock);
 	cell->volumes = RB_ROOT;
 	INIT_HLIST_HEAD(&cell->proc_volumes);
 	seqlock_init(&cell->volume_lock);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 4a3d946b1d2a..5ae4ca999d65 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -414,7 +414,7 @@ struct afs_cell {
 	unsigned int		debug_id;
 
 	/* The volumes belonging to this cell */
-	spinlock_t		vs_lock;	/* Lock for server->volumes */
+	struct rw_semaphore	vs_lock;	/* Lock for server->volumes */
 	struct rb_root		volumes;	/* Tree of volumes on this server */
 	struct hlist_head	proc_volumes;	/* procfs volume list */
 	seqlock_t		volume_lock;	/* For volumes */
@@ -566,7 +566,6 @@ struct afs_server {
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
 	struct list_head	volumes;	/* RCU list of afs_server_entry objects */
-	struct work_struct	initcb_work;	/* Work for CB.InitCallBackState* */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
 	time64_t		unuse_time;	/* Time at which last unused */
 	unsigned long		flags;
@@ -1041,7 +1040,6 @@ void afs_get_address_preferences(struct afs_net *net, struct afs_addr_list *alis
  * callback.c
  */
 extern void afs_invalidate_mmap_work(struct work_struct *);
-extern void afs_server_init_callback_work(struct work_struct *work);
 extern void afs_init_callback_state(struct afs_server *);
 extern void __afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
 extern void afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index db2f66b11b40..e169121f603e 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -218,7 +218,6 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
 	INIT_LIST_HEAD(&server->volumes);
-	INIT_WORK(&server->initcb_work, afs_server_init_callback_work);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);
@@ -470,7 +469,6 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
 	if (test_bit(AFS_SERVER_FL_MAY_HAVE_CB, &server->flags))
 		afs_give_up_callbacks(net, server);
 
-	flush_work(&server->initcb_work);
 	afs_put_server(net, server, afs_server_trace_destroy);
 }
 
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 4d6369477f54..cfd900eb09ed 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -136,7 +136,7 @@ void afs_attach_volume_to_servers(struct afs_volume *volume, struct afs_server_l
 	struct list_head *p;
 	unsigned int i;
 
-	spin_lock(&volume->cell->vs_lock);
+	down_write(&volume->cell->vs_lock);
 
 	for (i = 0; i < slist->nr_servers; i++) {
 		se = &slist->servers[i];
@@ -147,11 +147,11 @@ void afs_attach_volume_to_servers(struct afs_volume *volume, struct afs_server_l
 			if (volume->vid <= pe->volume->vid)
 				break;
 		}
-		list_add_tail_rcu(&se->slink, p);
+		list_add_tail(&se->slink, p);
 	}
 
 	slist->attached = true;
-	spin_unlock(&volume->cell->vs_lock);
+	up_write(&volume->cell->vs_lock);
 }
 
 /*
@@ -164,7 +164,7 @@ void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server
 {
 	unsigned int n = 0, o = 0;
 
-	spin_lock(&volume->cell->vs_lock);
+	down_write(&volume->cell->vs_lock);
 
 	while (n < new->nr_servers || o < old->nr_servers) {
 		struct afs_server_entry *pn = n < new->nr_servers ? &new->servers[n] : NULL;
@@ -174,7 +174,7 @@ void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server
 		int diff;
 
 		if (pn && po && pn->server == po->server) {
-			list_replace_rcu(&po->slink, &pn->slink);
+			list_replace(&po->slink, &pn->slink);
 			n++;
 			o++;
 			continue;
@@ -192,15 +192,15 @@ void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server
 				if (volume->vid <= s->volume->vid)
 					break;
 			}
-			list_add_tail_rcu(&pn->slink, p);
+			list_add_tail(&pn->slink, p);
 			n++;
 		} else {
-			list_del_rcu(&po->slink);
+			list_del(&po->slink);
 			o++;
 		}
 	}
 
-	spin_unlock(&volume->cell->vs_lock);
+	up_write(&volume->cell->vs_lock);
 }
 
 /*
@@ -213,11 +213,11 @@ void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server
 	if (!slist->attached)
 		return;
 
-	spin_lock(&volume->cell->vs_lock);
+	down_write(&volume->cell->vs_lock);
 
 	for (i = 0; i < slist->nr_servers; i++)
-		list_del_rcu(&slist->servers[i].slink);
+		list_del(&slist->servers[i].slink);
 
 	slist->attached = false;
-	spin_unlock(&volume->cell->vs_lock);
+	up_write(&volume->cell->vs_lock);
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index cf2fa4fddd5b..63ab23876be8 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -151,9 +151,11 @@ enum yfs_cm_operation {
 	EM(afs_volume_trace_alloc,		"ALLOC         ") \
 	EM(afs_volume_trace_free,		"FREE          ") \
 	EM(afs_volume_trace_get_alloc_sbi,	"GET sbi-alloc ") \
+	EM(afs_volume_trace_get_callback,	"GET callback  ") \
 	EM(afs_volume_trace_get_cell_insert,	"GET cell-insrt") \
 	EM(afs_volume_trace_get_new_op,		"GET op-new    ") \
 	EM(afs_volume_trace_get_query_alias,	"GET cell-alias") \
+	EM(afs_volume_trace_put_callback,	"PUT callback  ") \
 	EM(afs_volume_trace_put_cell_dup,	"PUT cell-dup  ") \
 	EM(afs_volume_trace_put_cell_root,	"PUT cell-root ") \
 	EM(afs_volume_trace_put_destroy_sbi,	"PUT sbi-destry") \



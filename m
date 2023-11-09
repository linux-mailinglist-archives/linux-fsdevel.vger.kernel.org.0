Return-Path: <linux-fsdevel+bounces-2577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B07E6DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E57CB21AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E56341AC;
	Thu,  9 Nov 2023 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKzen+VH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58632C82
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DD03AB7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ1ztg8XqgkGPytJCAaxTcEbNYz7HP0Vo6mf7bCyHww=;
	b=fKzen+VHckyw9Ca52ZlLlnpPtU1KUlaoKBemis09lGc5x/AsWa5y6nFWUYGx+eJvp9Bmdd
	x9VV5i/EexQEw351ILApmBKEv7/3HKlQjS2rcb5GC+0Q86M43Iq/l5+TXiu4fE9nDcc72j
	igePG1epzo2et3yExaEqxM8Ek59DdVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-yPfoRaPzNsW7_PhfTB5g3g-1; Thu, 09 Nov 2023 10:41:13 -0500
X-MC-Unique: yPfoRaPzNsW7_PhfTB5g3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 172B7811E7D;
	Thu,  9 Nov 2023 15:41:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 35A5A25C1;
	Thu,  9 Nov 2023 15:41:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 37/41] afs: Apply server breaks to mmap'd files in the call processor
Date: Thu,  9 Nov 2023 15:40:00 +0000
Message-ID: <20231109154004.3317227-38-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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
 fs/afs/internal.h          |  6 +++---
 fs/afs/server.c            |  2 --
 fs/afs/server_list.c       | 22 +++++++++++-----------
 fs/afs/volume.c            | 15 +++++++++++++++
 include/trace/events/afs.h |  2 ++
 7 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index a484fa642808..535477f88a4f 100644
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
 	int seq = 0;
 
-	do {
+	for (;;) {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
@@ -132,7 +135,12 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
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
@@ -187,12 +195,11 @@ static void afs_break_some_callbacks(struct afs_server *server,
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
@@ -206,6 +213,9 @@ static void afs_break_some_callbacks(struct afs_server *server,
 			*residue++ = *cbb;
 		}
 	}
+
+	rcu_read_unlock();
+	afs_put_volume(volume, afs_volume_trace_put_callback);
 }
 
 /*
@@ -218,11 +228,6 @@ void afs_break_callbacks(struct afs_server *server, size_t count,
 
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
index 0a4ecfc250bf..73f0a456ab98 100644
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
@@ -1040,7 +1039,6 @@ void afs_get_address_preferences(struct afs_net *net, struct afs_addr_list *alis
  * callback.c
  */
 extern void afs_invalidate_mmap_work(struct work_struct *);
-extern void afs_server_init_callback_work(struct work_struct *work);
 extern void afs_init_callback_state(struct afs_server *);
 extern void __afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
 extern void afs_break_callback(struct afs_vnode *, enum afs_cb_break_reason);
@@ -1619,6 +1617,8 @@ extern struct afs_volume *afs_get_volume(struct afs_volume *, enum afs_volume_tr
 void afs_put_volume(struct afs_volume *volume, enum afs_volume_trace reason);
 extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 
+bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason);
+
 /*
  * write.c
  */
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 811dbda88f9c..c97617366557 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -217,7 +217,6 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
 	INIT_LIST_HEAD(&server->volumes);
-	INIT_WORK(&server->initcb_work, afs_server_init_callback_work);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
 	spin_lock_init(&server->probe_lock);
@@ -469,7 +468,6 @@ static void afs_destroy_server(struct afs_net *net, struct afs_server *server)
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
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 1d3bd14dfa2f..00253032ccca 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -242,6 +242,21 @@ static void afs_destroy_volume(struct work_struct *work)
 	_leave(" [destroyed]");
 }
 
+
+/*
+ * Try to get a reference on a volume record.
+ */
+bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason)
+{
+	int r;
+
+	if (__refcount_inc_not_zero(&volume->ref, &r)) {
+		trace_afs_volume(volume->vid, r + 1, reason);
+		return true;
+	}
+	return false;
+}
+
 /*
  * Get a reference on a volume record.
  */
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



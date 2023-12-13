Return-Path: <linux-fsdevel+bounces-5885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D337C811395
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1572826DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C12E82B;
	Wed, 13 Dec 2023 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jnonr231"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17434181
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=me5zgkH5dFArJGbdvmvfmpSDWioSmQChzjo7Z9vM/Ao=;
	b=Jnonr231JpGzkS5RbDf2eqVOYz355SYN75p1CAFMm6aPiEPbpVul6lYuFtw/V52sj9POul
	nnYt9ZThtD5KedWa50WnKrSQE+Wl99OKaShAwcz67GCtBO6H+l1d9OjvOjK+HxGkuM4e0K
	lfy9qhRIAp+FEfyDGl+WoR0WCrySPn0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-WwpT5-LDNOW-84qphPWsRA-1; Wed,
 13 Dec 2023 08:50:54 -0500
X-MC-Unique: WwpT5-LDNOW-84qphPWsRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86A7E3869143;
	Wed, 13 Dec 2023 13:50:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96F7A51E3;
	Wed, 13 Dec 2023 13:50:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/40] afs: Make it possible to find the volumes that are using a server
Date: Wed, 13 Dec 2023 13:49:52 +0000
Message-ID: <20231213135003.367397-31-dhowells@redhat.com>
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

Make it possible to find the afs_volume structs that are using an
afs_server struct to aid in breaking volume callbacks.

The way this is done is that each afs_volume already has an array of
afs_server_entry records that point to the servers where that volume might
be found.  An afs_volume backpointer and a list node is added to each entry
and each entry is then added to an RCU-traversable list on the afs_server
to which it points.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c        |   1 +
 fs/afs/internal.h    |  23 +++++----
 fs/afs/server.c      |   1 +
 fs/afs/server_list.c | 112 +++++++++++++++++++++++++++++++++++++++----
 fs/afs/vl_alias.c    |   2 +-
 fs/afs/volume.c      |  36 ++++++++------
 6 files changed, 143 insertions(+), 32 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 988c2ac7cece..69716fc0ee36 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -161,6 +161,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	refcount_set(&cell->ref, 1);
 	atomic_set(&cell->active, 0);
 	INIT_WORK(&cell->manager, afs_manage_cell_work);
+	spin_lock_init(&cell->vs_lock);
 	cell->volumes = RB_ROOT;
 	INIT_HLIST_HEAD(&cell->proc_volumes);
 	seqlock_init(&cell->volume_lock);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 96c1074fe78d..0b726bd2cf8c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -414,6 +414,7 @@ struct afs_cell {
 	unsigned int		debug_id;
 
 	/* The volumes belonging to this cell */
+	spinlock_t		vs_lock;	/* Lock for server->volumes */
 	struct rb_root		volumes;	/* Tree of volumes on this server */
 	struct hlist_head	proc_volumes;	/* procfs volume list */
 	seqlock_t		volume_lock;	/* For volumes */
@@ -564,6 +565,7 @@ struct afs_server {
 	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
 	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
+	struct list_head	volumes;	/* RCU list of afs_server_entry objects */
 	struct work_struct	initcb_work;	/* Work for CB.InitCallBackState* */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
 	time64_t		unuse_time;	/* Time at which last unused */
@@ -605,12 +607,14 @@ struct afs_server {
  */
 struct afs_server_entry {
 	struct afs_server	*server;
+	struct afs_volume	*volume;
+	struct list_head	slink;		/* Link in server->volumes */
 };
 
 struct afs_server_list {
 	struct rcu_head		rcu;
-	afs_volid_t		vids[AFS_MAXTYPES]; /* Volume IDs */
 	refcount_t		usage;
+	bool			attached;	/* T if attached to servers */
 	unsigned char		nr_servers;
 	unsigned char		preferred;	/* Preferred server */
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
@@ -623,10 +627,9 @@ struct afs_server_list {
  * Live AFS volume management.
  */
 struct afs_volume {
-	union {
-		struct rcu_head	rcu;
-		afs_volid_t	vid;		/* volume ID */
-	};
+	struct rcu_head	rcu;
+	afs_volid_t		vid;		/* The volume ID of this volume */
+	afs_volid_t		vids[AFS_MAXTYPES]; /* All associated volume IDs */
 	refcount_t		ref;
 	time64_t		update_at;	/* Time at which to next update */
 	struct afs_cell		*cell;		/* Cell to which belongs (pins ref) */
@@ -1528,10 +1531,14 @@ static inline struct afs_server_list *afs_get_serverlist(struct afs_server_list
 }
 
 extern void afs_put_serverlist(struct afs_net *, struct afs_server_list *);
-extern struct afs_server_list *afs_alloc_server_list(struct afs_cell *, struct key *,
-						     struct afs_vldb_entry *,
-						     u8);
+struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
+					      struct key *key,
+					      struct afs_vldb_entry *vldb);
 extern bool afs_annotate_server_list(struct afs_server_list *, struct afs_server_list *);
+void afs_attach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *slist);
+void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *slist,
+				    struct afs_server_list *old);
+void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server_list *slist);
 
 /*
  * super.c
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 281625c71aff..db2f66b11b40 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -217,6 +217,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
 	server->addr_version = alist->version;
 	server->uuid = *uuid;
 	rwlock_init(&server->fs_lock);
+	INIT_LIST_HEAD(&server->volumes);
 	INIT_WORK(&server->initcb_work, afs_server_init_callback_work);
 	init_waitqueue_head(&server->probe_wq);
 	INIT_LIST_HEAD(&server->probe_link);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index b59896b1de0a..4d6369477f54 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -24,13 +24,13 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 /*
  * Build a server list from a VLDB record.
  */
-struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
+struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 					      struct key *key,
-					      struct afs_vldb_entry *vldb,
-					      u8 type_mask)
+					      struct afs_vldb_entry *vldb)
 {
 	struct afs_server_list *slist;
 	struct afs_server *server;
+	unsigned int type_mask = 1 << volume->type;
 	int ret = -ENOMEM, nr_servers = 0, i, j;
 
 	for (i = 0; i < vldb->nr_servers; i++)
@@ -44,15 +44,12 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 	refcount_set(&slist->usage, 1);
 	rwlock_init(&slist->lock);
 
-	for (i = 0; i < AFS_MAXTYPES; i++)
-		slist->vids[i] = vldb->vid[i];
-
 	/* Make sure a records exists for each server in the list. */
 	for (i = 0; i < vldb->nr_servers; i++) {
 		if (!(vldb->fs_mask[i] & type_mask))
 			continue;
 
-		server = afs_lookup_server(cell, key, &vldb->fs_server[i],
+		server = afs_lookup_server(volume->cell, key, &vldb->fs_server[i],
 					   vldb->addr_version[i]);
 		if (IS_ERR(server)) {
 			ret = PTR_ERR(server);
@@ -70,7 +67,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
-				afs_put_server(cell->net, server,
+				afs_put_server(volume->cell->net, server,
 					       afs_server_trace_put_slist_isort);
 				continue;
 			}
@@ -81,6 +78,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 		}
 
 		slist->servers[j].server = server;
+		slist->servers[j].volume = volume;
 		slist->nr_servers++;
 	}
 
@@ -92,7 +90,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_cell *cell,
 	return slist;
 
 error_2:
-	afs_put_serverlist(cell->net, slist);
+	afs_put_serverlist(volume->cell->net, slist);
 error:
 	return ERR_PTR(ret);
 }
@@ -127,3 +125,99 @@ bool afs_annotate_server_list(struct afs_server_list *new,
 
 	return true;
 }
+
+/*
+ * Attach a volume to the servers it is going to use.
+ */
+void afs_attach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *slist)
+{
+	struct afs_server_entry *se, *pe;
+	struct afs_server *server;
+	struct list_head *p;
+	unsigned int i;
+
+	spin_lock(&volume->cell->vs_lock);
+
+	for (i = 0; i < slist->nr_servers; i++) {
+		se = &slist->servers[i];
+		server = se->server;
+
+		list_for_each(p, &server->volumes) {
+			pe = list_entry(p, struct afs_server_entry, slink);
+			if (volume->vid <= pe->volume->vid)
+				break;
+		}
+		list_add_tail_rcu(&se->slink, p);
+	}
+
+	slist->attached = true;
+	spin_unlock(&volume->cell->vs_lock);
+}
+
+/*
+ * Reattach a volume to the servers it is going to use when server list is
+ * replaced.  We try to switch the attachment points to avoid rewalking the
+ * lists.
+ */
+void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server_list *new,
+				    struct afs_server_list *old)
+{
+	unsigned int n = 0, o = 0;
+
+	spin_lock(&volume->cell->vs_lock);
+
+	while (n < new->nr_servers || o < old->nr_servers) {
+		struct afs_server_entry *pn = n < new->nr_servers ? &new->servers[n] : NULL;
+		struct afs_server_entry *po = o < old->nr_servers ? &old->servers[o] : NULL;
+		struct afs_server_entry *s;
+		struct list_head *p;
+		int diff;
+
+		if (pn && po && pn->server == po->server) {
+			list_replace_rcu(&po->slink, &pn->slink);
+			n++;
+			o++;
+			continue;
+		}
+
+		if (pn && po)
+			diff = memcmp(&pn->server->uuid, &po->server->uuid,
+				      sizeof(pn->server->uuid));
+		else
+			diff = pn ? -1 : 1;
+
+		if (diff < 0) {
+			list_for_each(p, &pn->server->volumes) {
+				s = list_entry(p, struct afs_server_entry, slink);
+				if (volume->vid <= s->volume->vid)
+					break;
+			}
+			list_add_tail_rcu(&pn->slink, p);
+			n++;
+		} else {
+			list_del_rcu(&po->slink);
+			o++;
+		}
+	}
+
+	spin_unlock(&volume->cell->vs_lock);
+}
+
+/*
+ * Detach a volume from the servers it has been using.
+ */
+void afs_detach_volume_from_servers(struct afs_volume *volume, struct afs_server_list *slist)
+{
+	unsigned int i;
+
+	if (!slist->attached)
+		return;
+
+	spin_lock(&volume->cell->vs_lock);
+
+	for (i = 0; i < slist->nr_servers; i++)
+		list_del_rcu(&slist->servers[i].slink);
+
+	slist->attached = false;
+	spin_unlock(&volume->cell->vs_lock);
+}
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 43788d0c18e8..63e7ed324af9 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -77,7 +77,7 @@ static int afs_compare_volume_slists(const struct afs_volume *vol_a,
 	lb = rcu_dereference(vol_b->servers);
 
 	for (i = 0; i < AFS_MAXTYPES; i++)
-		if (la->vids[i] != lb->vids[i])
+		if (vol_a->vids[i] != vol_b->vids[i])
 			return 0;
 
 	while (a < la->nr_servers && b < lb->nr_servers) {
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 115c081a8e2c..aefb982dee9a 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -72,11 +72,11 @@ static void afs_remove_volume_from_cell(struct afs_volume *volume)
  */
 static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 					   struct afs_vldb_entry *vldb,
-					   unsigned long type_mask)
+					   struct afs_server_list **_slist)
 {
 	struct afs_server_list *slist;
 	struct afs_volume *volume;
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, i;
 
 	volume = kzalloc(sizeof(struct afs_volume), GFP_KERNEL);
 	if (!volume)
@@ -95,13 +95,16 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	rwlock_init(&volume->cb_v_break_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
 
-	slist = afs_alloc_server_list(params->cell, params->key, vldb, type_mask);
+	for (i = 0; i < AFS_MAXTYPES; i++)
+		volume->vids[i] = vldb->vid[i];
+
+	slist = afs_alloc_server_list(volume, params->key, vldb);
 	if (IS_ERR(slist)) {
 		ret = PTR_ERR(slist);
 		goto error_1;
 	}
 
-	refcount_set(&slist->usage, 1);
+	*_slist = slist;
 	rcu_assign_pointer(volume->servers, slist);
 	trace_afs_volume(volume->vid, 1, afs_volume_trace_alloc);
 	return volume;
@@ -117,17 +120,19 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
  * Look up or allocate a volume record.
  */
 static struct afs_volume *afs_lookup_volume(struct afs_fs_context *params,
-					    struct afs_vldb_entry *vldb,
-					    unsigned long type_mask)
+					    struct afs_vldb_entry *vldb)
 {
+	struct afs_server_list *slist;
 	struct afs_volume *candidate, *volume;
 
-	candidate = afs_alloc_volume(params, vldb, type_mask);
+	candidate = afs_alloc_volume(params, vldb, &slist);
 	if (IS_ERR(candidate))
 		return candidate;
 
 	volume = afs_insert_volume_into_cell(params->cell, candidate);
-	if (volume != candidate)
+	if (volume == candidate)
+		afs_attach_volume_to_servers(volume, slist);
+	else
 		afs_put_volume(params->net, candidate, afs_volume_trace_put_cell_dup);
 	return volume;
 }
@@ -208,8 +213,7 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 		goto error;
 	}
 
-	type_mask = 1UL << params->type;
-	volume = afs_lookup_volume(params, vldb, type_mask);
+	volume = afs_lookup_volume(params, vldb);
 
 error:
 	kfree(vldb);
@@ -221,14 +225,17 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
  */
 static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
 {
+	struct afs_server_list *slist = rcu_access_pointer(volume->servers);
+
 	_enter("%p", volume);
 
 #ifdef CONFIG_AFS_FSCACHE
 	ASSERTCMP(volume->cache, ==, NULL);
 #endif
 
+	afs_detach_volume_from_servers(volume, slist);
 	afs_remove_volume_from_cell(volume);
-	afs_put_serverlist(net, rcu_access_pointer(volume->servers));
+	afs_put_serverlist(net, slist);
 	afs_put_cell(volume->cell, afs_cell_trace_put_vol);
 	trace_afs_volume(volume->vid, refcount_read(&volume->ref),
 			 afs_volume_trace_free);
@@ -362,8 +369,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 	}
 
 	/* See if the volume's server list got updated. */
-	new = afs_alloc_server_list(volume->cell, key,
-				    vldb, (1 << volume->type));
+	new = afs_alloc_server_list(volume, key, vldb);
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto error_vldb;
@@ -384,9 +390,11 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 
 	volume->update_at = ktime_get_real_seconds() + afs_volume_record_life;
 	write_unlock(&volume->servers_lock);
-	ret = 0;
 
+	if (discard == old)
+		afs_reattach_volume_to_servers(volume, new, old);
 	afs_put_serverlist(volume->cell->net, discard);
+	ret = 0;
 error_vldb:
 	kfree(vldb);
 error:



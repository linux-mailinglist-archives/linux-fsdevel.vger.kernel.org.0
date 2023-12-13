Return-Path: <linux-fsdevel+bounces-5887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E9811399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4981C21162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98B2EB08;
	Wed, 13 Dec 2023 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Saj3f8KO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C329E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N54RfssiyMrCSUQUUjNs2/hJPSr7YiGFMmK5Pu5ovDQ=;
	b=Saj3f8KOXbR6vdw0W10RCL6yIW2Xtxzi2r9De6sf7lQCa+gWCZ3Byn9Q5cbKbRUJWffZRu
	7GS0Se+fKjh0B9Ui6SzWVLp260DhG80lYMK2Ce29nhBkJtEJPUI1uddGU/WrJ6dEutHUms
	evKrQ1XF/H1NBLLAjkiQaqjW0BxDGDs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-6zP04VebOQuW8m8cO5Ymlg-1; Wed,
 13 Dec 2023 08:50:56 -0500
X-MC-Unique: 6zP04VebOQuW8m8cO5Ymlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 014DE29AC03A;
	Wed, 13 Dec 2023 13:50:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 352591C060B1;
	Wed, 13 Dec 2023 13:50:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/40] afs: Defer volume record destruction to a workqueue
Date: Wed, 13 Dec 2023 13:49:53 +0000
Message-ID: <20231213135003.367397-32-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Defer volume record destruction to a workqueue so that afs_put_volume()
isn't going to run the destruction process in the callback workqueue whilst
the server is holding up other clients whilst waiting for us to reply to a
CB.CallBack notification RPC.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c         |  2 +-
 fs/afs/fs_operation.c |  2 +-
 fs/afs/internal.h     |  3 ++-
 fs/afs/super.c        |  7 +++----
 fs/afs/vl_alias.c     |  6 +++---
 fs/afs/volume.c       | 15 +++++++++------
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 69716fc0ee36..6b389f2bcd0c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -816,7 +816,7 @@ static void afs_manage_cell(struct afs_cell *cell)
 
 final_destruction:
 	/* The root volume is pinning the cell */
-	afs_put_volume(cell->net, cell->root_volume, afs_volume_trace_put_cell_root);
+	afs_put_volume(cell->root_volume, afs_volume_trace_put_cell_root);
 	cell->root_volume = NULL;
 	afs_put_cell(cell, afs_cell_trace_put_destroy);
 }
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 8c6d827f999d..10137681aa7d 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -265,7 +265,7 @@ int afs_put_operation(struct afs_operation *op)
 	}
 
 	afs_put_serverlist(op->net, op->server_list);
-	afs_put_volume(op->net, op->volume, afs_volume_trace_put_put_op);
+	afs_put_volume(op->volume, afs_volume_trace_put_put_op);
 	key_put(op->key);
 	kfree(op);
 	return ret;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0b726bd2cf8c..a50dfb2f8d7d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -636,6 +636,7 @@ struct afs_volume {
 	struct rb_node		cell_node;	/* Link in cell->volumes */
 	struct hlist_node	proc_link;	/* Link in cell->proc_volumes */
 	struct super_block __rcu *sb;		/* Superblock on which inodes reside */
+	struct work_struct	destructor;	/* Deferred destructor */
 	unsigned long		flags;
 #define AFS_VOLUME_NEEDS_UPDATE	0	/* - T if an update needs performing */
 #define AFS_VOLUME_UPDATING	1	/* - T if an update is in progress */
@@ -1613,7 +1614,7 @@ extern int afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
 bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason);
 extern struct afs_volume *afs_get_volume(struct afs_volume *, enum afs_volume_trace);
-extern void afs_put_volume(struct afs_net *, struct afs_volume *, enum afs_volume_trace);
+void afs_put_volume(struct afs_volume *volume, enum afs_volume_trace reason);
 extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 
 /*
diff --git a/fs/afs/super.c b/fs/afs/super.c
index a01a0fb2cdbb..ae2d66a52add 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -381,8 +381,7 @@ static int afs_validate_fc(struct fs_context *fc)
 		ctx->key = key;
 
 		if (ctx->volume) {
-			afs_put_volume(ctx->net, ctx->volume,
-				       afs_volume_trace_put_validate_fc);
+			afs_put_volume(ctx->volume, afs_volume_trace_put_validate_fc);
 			ctx->volume = NULL;
 		}
 
@@ -529,7 +528,7 @@ static void afs_destroy_sbi(struct afs_super_info *as)
 {
 	if (as) {
 		struct afs_net *net = afs_net(as->net_ns);
-		afs_put_volume(net, as->volume, afs_volume_trace_put_destroy_sbi);
+		afs_put_volume(as->volume, afs_volume_trace_put_destroy_sbi);
 		afs_unuse_cell(net, as->cell, afs_cell_trace_unuse_sbi);
 		put_net(as->net_ns);
 		kfree(as);
@@ -615,7 +614,7 @@ static void afs_free_fc(struct fs_context *fc)
 	struct afs_fs_context *ctx = fc->fs_private;
 
 	afs_destroy_sbi(fc->s_fs_info);
-	afs_put_volume(ctx->net, ctx->volume, afs_volume_trace_put_free_fc);
+	afs_put_volume(ctx->volume, afs_volume_trace_put_free_fc);
 	afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_fc);
 	key_put(ctx->key);
 	kfree(ctx);
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index 63e7ed324af9..9f36e14f1c2d 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -156,7 +156,7 @@ static int afs_query_for_alias_one(struct afs_cell *cell, struct key *key,
 	/* And see if it's in the new cell. */
 	volume = afs_sample_volume(cell, key, pvol->name, pvol->name_len);
 	if (IS_ERR(volume)) {
-		afs_put_volume(cell->net, pvol, afs_volume_trace_put_query_alias);
+		afs_put_volume(pvol, afs_volume_trace_put_query_alias);
 		if (PTR_ERR(volume) != -ENOMEDIUM)
 			return PTR_ERR(volume);
 		/* That volume is not in the new cell, so not an alias */
@@ -174,8 +174,8 @@ static int afs_query_for_alias_one(struct afs_cell *cell, struct key *key,
 		rcu_read_unlock();
 	}
 
-	afs_put_volume(cell->net, volume, afs_volume_trace_put_query_alias);
-	afs_put_volume(cell->net, pvol, afs_volume_trace_put_query_alias);
+	afs_put_volume(volume, afs_volume_trace_put_query_alias);
+	afs_put_volume(pvol, afs_volume_trace_put_query_alias);
 	return ret;
 }
 
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index aefb982dee9a..4982fce25057 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -11,6 +11,8 @@
 
 static unsigned __read_mostly afs_volume_record_life = 60 * 60;
 
+static void afs_destroy_volume(struct work_struct *work);
+
 /*
  * Insert a volume into a cell.  If there's an existing volume record, that is
  * returned instead with a ref held.
@@ -91,6 +93,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 
 	refcount_set(&volume->ref, 1);
 	INIT_HLIST_NODE(&volume->proc_link);
+	INIT_WORK(&volume->destructor, afs_destroy_volume);
 	rwlock_init(&volume->servers_lock);
 	rwlock_init(&volume->cb_v_break_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
@@ -133,7 +136,7 @@ static struct afs_volume *afs_lookup_volume(struct afs_fs_context *params,
 	if (volume == candidate)
 		afs_attach_volume_to_servers(volume, slist);
 	else
-		afs_put_volume(params->net, candidate, afs_volume_trace_put_cell_dup);
+		afs_put_volume(candidate, afs_volume_trace_put_cell_dup);
 	return volume;
 }
 
@@ -223,8 +226,9 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 /*
  * Destroy a volume record
  */
-static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
+static void afs_destroy_volume(struct work_struct *work)
 {
+	struct afs_volume *volume = container_of(work, struct afs_volume, destructor);
 	struct afs_server_list *slist = rcu_access_pointer(volume->servers);
 
 	_enter("%p", volume);
@@ -235,7 +239,7 @@ static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
 
 	afs_detach_volume_from_servers(volume, slist);
 	afs_remove_volume_from_cell(volume);
-	afs_put_serverlist(net, slist);
+	afs_put_serverlist(volume->cell->net, slist);
 	afs_put_cell(volume->cell, afs_cell_trace_put_vol);
 	trace_afs_volume(volume->vid, refcount_read(&volume->ref),
 			 afs_volume_trace_free);
@@ -277,8 +281,7 @@ struct afs_volume *afs_get_volume(struct afs_volume *volume,
 /*
  * Drop a reference on a volume record.
  */
-void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
-		    enum afs_volume_trace reason)
+void afs_put_volume(struct afs_volume *volume, enum afs_volume_trace reason)
 {
 	if (volume) {
 		afs_volid_t vid = volume->vid;
@@ -288,7 +291,7 @@ void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
 		zero = __refcount_dec_and_test(&volume->ref, &r);
 		trace_afs_volume(vid, r - 1, reason);
 		if (zero)
-			afs_destroy_volume(net, volume);
+			schedule_work(&volume->destructor);
 	}
 }
 



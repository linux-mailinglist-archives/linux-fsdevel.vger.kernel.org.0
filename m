Return-Path: <linux-fsdevel+bounces-2582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A36E7E6DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7A3B2146D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA037172;
	Thu,  9 Nov 2023 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEl6Z6yo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81723714F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:41:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B61718
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6t8tdE8fU3HgyYVTv6Qhp6ao8beL9M3nm0ZF7eZfRh0=;
	b=hEl6Z6yoO2C025GPu+ksP3Ume2my2PEaXKaBFeX1YaVSxOvDoamrwIpawdMwtZ1iMcCxlW
	oTcRcjLaykF3ydl3+l0E1Um5Og49o1Z3E2W66Y6UCcLmaRS5G/GvDRgB1+W8vHJkIvM5Cp
	LL+pXkaXEBCl1n1lOYx5c+L5ifjeasw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-K9vUEzZFOqiPEEs3GYu1rA-1; Thu, 09 Nov 2023 10:41:26 -0500
X-MC-Unique: K9vUEzZFOqiPEEs3GYu1rA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0923E85A58B;
	Thu,  9 Nov 2023 15:41:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40A1440C6EB9;
	Thu,  9 Nov 2023 15:41:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/41] afs: Defer volume record destruction to a workqueue
Date: Thu,  9 Nov 2023 15:39:58 +0000
Message-ID: <20231109154004.3317227-36-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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
index a085492a7167..22cf782fe924 100644
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
@@ -1611,7 +1612,7 @@ extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern int afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
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
index 25d2b44c7aa6..1d3bd14dfa2f 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -11,6 +11,8 @@
 
 static unsigned __read_mostly afs_volume_record_life = 60 * 60;
 
+static void afs_destroy_volume(struct work_struct *work);
+
 /*
  * Insert a volume into a cell.  If there's an existing volume record, that is
  * returned instead with a ref held.
@@ -85,6 +87,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 
 	refcount_set(&volume->ref, 1);
 	INIT_HLIST_NODE(&volume->proc_link);
+	INIT_WORK(&volume->destructor, afs_destroy_volume);
 	rwlock_init(&volume->servers_lock);
 	rwlock_init(&volume->cb_v_break_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
@@ -127,7 +130,7 @@ static struct afs_volume *afs_lookup_volume(struct afs_fs_context *params,
 	if (volume == candidate)
 		afs_attach_volume_to_servers(volume, slist);
 	else
-		afs_put_volume(params->net, candidate, afs_volume_trace_put_cell_dup);
+		afs_put_volume(candidate, afs_volume_trace_put_cell_dup);
 	return volume;
 }
 
@@ -217,8 +220,9 @@ struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 /*
  * Destroy a volume record
  */
-static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
+static void afs_destroy_volume(struct work_struct *work)
 {
+	struct afs_volume *volume = container_of(work, struct afs_volume, destructor);
 	struct afs_server_list *slist = rcu_access_pointer(volume->servers);
 
 	_enter("%p", volume);
@@ -229,7 +233,7 @@ static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
 
 	afs_detach_volume_from_servers(volume, slist);
 	afs_remove_volume_from_cell(volume);
-	afs_put_serverlist(net, slist);
+	afs_put_serverlist(volume->cell->net, slist);
 	afs_put_cell(volume->cell, afs_cell_trace_put_vol);
 	trace_afs_volume(volume->vid, refcount_read(&volume->ref),
 			 afs_volume_trace_free);
@@ -257,8 +261,7 @@ struct afs_volume *afs_get_volume(struct afs_volume *volume,
 /*
  * Drop a reference on a volume record.
  */
-void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
-		    enum afs_volume_trace reason)
+void afs_put_volume(struct afs_volume *volume, enum afs_volume_trace reason)
 {
 	if (volume) {
 		afs_volid_t vid = volume->vid;
@@ -268,7 +271,7 @@ void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
 		zero = __refcount_dec_and_test(&volume->ref, &r);
 		trace_afs_volume(vid, r - 1, reason);
 		if (zero)
-			afs_destroy_volume(net, volume);
+			schedule_work(&volume->destructor);
 	}
 }
 



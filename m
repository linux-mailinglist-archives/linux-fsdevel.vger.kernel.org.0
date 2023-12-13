Return-Path: <linux-fsdevel+bounces-5894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058B08113A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6143F1F226AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF42E824;
	Wed, 13 Dec 2023 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNUEW0lP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB71716
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdbrznxoeP8yIf0wk1cWrsrMGzm+B2XkO70g6tFDSn8=;
	b=CNUEW0lP7x0ECPfEkltFAQ9P3tfUAQFT6WXqHvd4V2qj2ff1WXWtOg3cZeL8gjj41Y21Gi
	xF4oenDElAM4iUeELLPwmoT7wlkncK0xQcLxEq0l/CNYjiMZPHiGeuE8Nnoz/KRsooEutZ
	p5Rbu8n6npb0zRW6TE0j3oOFjLAEZPQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-EHPgFXP_NImH-2qPIgsFgw-1; Wed,
 13 Dec 2023 08:51:05 -0500
X-MC-Unique: EHPgFXP_NImH-2qPIgsFgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77ACB3C2A1CD;
	Wed, 13 Dec 2023 13:51:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5483CC15968;
	Wed, 13 Dec 2023 13:51:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/40] afs: Overhaul invalidation handling to better support RO volumes
Date: Wed, 13 Dec 2023 13:49:59 +0000
Message-ID: <20231213135003.367397-38-dhowells@redhat.com>
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

Overhaul the third party-induced invalidation handling, making use of the
previously added volume-level event counters (cb_scrub and cb_ro_snapshot)
that are now being parsed out of the VolSync record returned by the
fileserver in many of its replies.

This allows better handling of RO (and Backup) volumes.  Since these are
snapshot of a RW volume that are updated atomically simultantanously across
all servers that host them, they only require a single callback promise for
the entire volume.  The currently upstream code assumes that RO volumes
operate in the same manner as RW volumes, and that each file has its own
individual callback - which means that it does a status fetch for *every*
file in a RO volume, whether or not the volume got "released" (volume
callback breaks can occur for other reasons too, such as the volumeserver
taking ownership of a volume from a fileserver).

To this end, make the following changes:

 (1) Change the meaning of the volume's cb_v_break counter so that it is
     now a hint that we need to issue a status fetch to work out the state
     of a volume.  cb_v_break is incremented by volume break callbacks and
     by server initialisation callbacks.

 (2) Add a second counter, cb_v_check, to the afs_volume struct such that
     if this differs from cb_v_break, we need to do a check.  When the
     check is complete, cb_v_check is advanced to what cb_v_break was at
     the start of the status fetch.

 (3) Move the list of mmap'd vnodes to the volume and trigger removal of
     PTEs that map to files on a volume break rather than on a server
     break.

 (4) When a server reinitialisation callback comes in, use the
     server-to-volume reverse mapping added in a preceding patch to iterate
     over all the volumes using that server and clear the volume callback
     promises for that server and the general volume promise as a whole to
     trigger reanalysis.

 (5) Replace the AFS_VNODE_CB_PROMISED flag with an AFS_NO_CB_PROMISE
     (TIME64_MIN) value in the cb_expires_at field, reducing the number of
     checks we need to make.

 (6) Change afs_check_validity() to quickly see if various event counters
     have been incremented or if the vnode or volume callback promise is
     due to expire/has expired without making any changes to the state.
     That is now left to afs_validate() as this may get more complicated in
     future as we may have to examine server records too.

 (7) Overhaul afs_validate() so that it does a single status fetch if we
     need to check the state of either the vnode or the volume - and do so
     under appropriate locking.  The function does the following steps:

     (A) If the vnode/volume is no longer seen as valid, then we take the
     vnode validation lock and, if the volume promise has expired, the
     volume check lock also.  The latter prevents redundant checks being
     made to find out if a new version of the volume got released.

     (B) If a previous RPC call found that the volsync changed unexpectedly
     or that a RO volume was updated, then we unmap all PTEs pointing to
     the file to stop mmap being used for access.

     (C) If the vnode is still seen to be of uncertain validity, then we
     perform an FS.FetchStatus RPC op to jointly update the volume status
     and the vnode status.  This assessment is done as part of parsing the
     reply:

	If the RO volume creation timestamp advances, cb_ro_snapshot is
	incremented; if either the creation or update timestamps changes in
	an unexpected way, the cb_scrub counter is incremented

	If the Data Version returned doesn't match the copy we have
	locally, then we ask for the pagecache to be zapped.  This takes
	care of handling RO update.

     (D) If cb_scrub differs between volume and vnode, the vnode's
     pagecache is zapped and the vnode's cb_scrub is updated unless the
     file is marked as having been deleted.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/callback.c          | 122 +++++++++------
 fs/afs/cell.c              |   2 -
 fs/afs/dir.c               |   3 +-
 fs/afs/file.c              |  13 +-
 fs/afs/fs_operation.c      |   3 +-
 fs/afs/inode.c             |  21 ++-
 fs/afs/internal.h          |  34 ++---
 fs/afs/proc.c              |   4 +-
 fs/afs/rotate.c            |   8 +-
 fs/afs/server_list.c       |   2 +
 fs/afs/validation.c        | 299 ++++++++++++++++++++++++-------------
 fs/afs/volume.c            |   3 +
 include/trace/events/afs.h |   4 -
 13 files changed, 316 insertions(+), 202 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 8ddc99c9c16b..99b2c8172021 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -33,21 +33,20 @@ void afs_invalidate_mmap_work(struct work_struct *work)
 	unmap_mapping_pages(vnode->netfs.inode.i_mapping, 0, 0, false);
 }
 
-static void afs_server_init_callback(struct afs_server *server)
+static void afs_volume_init_callback(struct afs_volume *volume)
 {
 	struct afs_vnode *vnode;
-	struct afs_cell *cell = server->cell;
 
-	down_read(&cell->fs_open_mmaps_lock);
+	down_read(&volume->open_mmaps_lock);
 
-	list_for_each_entry(vnode, &cell->fs_open_mmaps, cb_mmap_link) {
-		if (vnode->cb_server == server) {
-			clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+	list_for_each_entry(vnode, &volume->open_mmaps, cb_mmap_link) {
+		if (vnode->cb_v_check != atomic_read(&volume->cb_v_break)) {
+			atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
 			queue_work(system_unbound_wq, &vnode->cb_work);
 		}
 	}
 
-	up_read(&cell->fs_open_mmaps_lock);
+	up_read(&volume->open_mmaps_lock);
 }
 
 /*
@@ -56,19 +55,20 @@ static void afs_server_init_callback(struct afs_server *server)
  */
 void afs_init_callback_state(struct afs_server *server)
 {
-	struct afs_cell *cell = server->cell;
+	struct afs_server_entry *se;
 
-	down_read(&cell->vs_lock);
+	down_read(&server->cell->vs_lock);
 
-	do {
-		server->cb_s_break++;
-		atomic_inc(&server->cell->fs_s_break);
-		if (!list_empty(&server->cell->fs_open_mmaps))
-			afs_server_init_callback(server);
-
-	} while ((server = rcu_dereference(server->uuid_next)));
+	list_for_each_entry(se, &server->volumes, slink) {
+		se->cb_expires_at = AFS_NO_CB_PROMISE;
+		se->volume->cb_expires_at = AFS_NO_CB_PROMISE;
+		trace_afs_cb_v_break(se->volume->vid, atomic_read(&se->volume->cb_v_break),
+				     afs_cb_break_for_s_reinit);
+		if (!list_empty(&se->volume->open_mmaps))
+			afs_volume_init_callback(se->volume);
+	}
 
-	up_read(&cell->vs_lock);
+	up_read(&server->cell->vs_lock);
 }
 
 /*
@@ -79,9 +79,9 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 	_enter("");
 
 	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+	if (atomic64_xchg(&vnode->cb_expires_at, AFS_NO_CB_PROMISE) != AFS_NO_CB_PROMISE) {
 		vnode->cb_break++;
-		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
+		vnode->cb_v_check = atomic_read(&vnode->volume->cb_v_break);
 		afs_clear_permits(vnode);
 
 		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
@@ -147,29 +147,51 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 	return volume;
 }
 
+/*
+ * Allow the fileserver to break callbacks at the volume-level.  This is
+ * typically done when, for example, a R/W volume is snapshotted to a R/O
+ * volume (the only way to change an R/O volume).  It may also, however, happen
+ * when a volserver takes control of a volume (offlining it, moving it, etc.).
+ *
+ * Every file in that volume will need to be reevaluated.
+ */
+static void afs_break_volume_callback(struct afs_server *server,
+				      struct afs_volume *volume)
+	__releases(RCU)
+{
+	struct afs_server_list *slist = rcu_dereference(volume->servers);
+	unsigned int i, cb_v_break;
+
+	write_lock(&volume->cb_v_break_lock);
+
+	for (i = 0; i < slist->nr_servers; i++)
+		if (slist->servers[i].server == server)
+			slist->servers[i].cb_expires_at = AFS_NO_CB_PROMISE;
+	volume->cb_expires_at = AFS_NO_CB_PROMISE;
+
+	cb_v_break = atomic_inc_return_release(&volume->cb_v_break);
+	trace_afs_cb_v_break(volume->vid, cb_v_break, afs_cb_break_for_volume_callback);
+
+	write_unlock(&volume->cb_v_break_lock);
+	rcu_read_unlock();
+
+	if (!list_empty(&volume->open_mmaps))
+		afs_volume_init_callback(volume);
+}
+
 /*
  * allow the fileserver to explicitly break one callback
  * - happens when
  *   - the backing file is changed
  *   - a lock is released
  */
-static void afs_break_one_callback(struct afs_volume *volume,
+static void afs_break_one_callback(struct afs_server *server,
+				   struct afs_volume *volume,
 				   struct afs_fid *fid)
 {
 	struct super_block *sb;
 	struct afs_vnode *vnode;
 	struct inode *inode;
-	unsigned int cb_v_break;
-
-	if (fid->vnode == 0 && fid->unique == 0) {
-		/* The callback break applies to an entire volume. */
-		write_lock(&volume->cb_v_break_lock);
-		cb_v_break = atomic_inc_return(&volume->cb_v_break);
-		trace_afs_cb_break(fid, cb_v_break,
-				   afs_cb_break_for_volume_callback, false);
-		write_unlock(&volume->cb_v_break_lock);
-		return;
-	}
 
 	/* See if we can find a matching inode - even an I_NEW inode needs to
 	 * be marked as it can have its callback broken before we finish
@@ -199,24 +221,32 @@ static void afs_break_some_callbacks(struct afs_server *server,
 
 	rcu_read_lock();
 	volume = afs_lookup_volume_rcu(server->cell, vid);
-	/* TODO: Find all matching volumes if we couldn't match the server and
-	 * break them anyway.
-	 */
-	for (i = *_count; i > 0; cbb++, i--) {
-		if (cbb->fid.vid == vid) {
-			_debug("- Fid { vl=%08llx n=%llu u=%u }",
-			       cbb->fid.vid,
-			       cbb->fid.vnode,
-			       cbb->fid.unique);
-			--*_count;
-			if (volume)
-				afs_break_one_callback(volume, &cbb->fid);
-		} else {
-			*residue++ = *cbb;
+	if (cbb->fid.vnode == 0 && cbb->fid.unique == 0) {
+		afs_break_volume_callback(server, volume);
+		*_count -= 1;
+		if (*_count)
+			memmove(cbb, cbb + 1, sizeof(*cbb) * *_count);
+	} else {
+		/* TODO: Find all matching volumes if we couldn't match the server and
+		 * break them anyway.
+		 */
+
+		for (i = *_count; i > 0; cbb++, i--) {
+			if (cbb->fid.vid == vid) {
+				_debug("- Fid { vl=%08llx n=%llu u=%u }",
+				       cbb->fid.vid,
+				       cbb->fid.vnode,
+				       cbb->fid.unique);
+				--*_count;
+				if (volume)
+					afs_break_one_callback(server, volume, &cbb->fid);
+			} else {
+				*residue++ = *cbb;
+			}
 		}
+		rcu_read_unlock();
 	}
 
-	rcu_read_unlock();
 	afs_put_volume(volume, afs_volume_trace_put_callback);
 }
 
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 1e5cb0f6ee07..ed990e2934a0 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -167,8 +167,6 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	seqlock_init(&cell->volume_lock);
 	cell->fs_servers = RB_ROOT;
 	seqlock_init(&cell->fs_lock);
-	INIT_LIST_HEAD(&cell->fs_open_mmaps);
-	init_rwsem(&cell->fs_open_mmaps_lock);
 	rwlock_init(&cell->vl_servers_lock);
 	cell->flags = (1 << AFS_CELL_FL_CHECK_ALIAS);
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index e232f713ece1..ed5bcb5d8895 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1260,6 +1260,7 @@ void afs_check_for_remote_deletion(struct afs_operation *op)
 	switch (afs_op_abort_code(op)) {
 	case VNOVNODE:
 		set_bit(AFS_VNODE_DELETED, &vnode->flags);
+		clear_nlink(&vnode->netfs.inode);
 		afs_break_callback(vnode, afs_cb_break_for_deleted);
 	}
 }
@@ -1375,7 +1376,7 @@ static void afs_dir_remove_subdir(struct dentry *dentry)
 
 		clear_nlink(&vnode->netfs.inode);
 		set_bit(AFS_VNODE_DELETED, &vnode->flags);
-		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+		atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
 		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	}
 }
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8f9b42427569..30914e0d9cb2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -514,13 +514,12 @@ static bool afs_release_folio(struct folio *folio, gfp_t gfp)
 static void afs_add_open_mmap(struct afs_vnode *vnode)
 {
 	if (atomic_inc_return(&vnode->cb_nr_mmap) == 1) {
-		down_write(&vnode->volume->cell->fs_open_mmaps_lock);
+		down_write(&vnode->volume->open_mmaps_lock);
 
 		if (list_empty(&vnode->cb_mmap_link))
-			list_add_tail(&vnode->cb_mmap_link,
-				      &vnode->volume->cell->fs_open_mmaps);
+			list_add_tail(&vnode->cb_mmap_link, &vnode->volume->open_mmaps);
 
-		up_write(&vnode->volume->cell->fs_open_mmaps_lock);
+		up_write(&vnode->volume->open_mmaps_lock);
 	}
 }
 
@@ -529,12 +528,12 @@ static void afs_drop_open_mmap(struct afs_vnode *vnode)
 	if (!atomic_dec_and_test(&vnode->cb_nr_mmap))
 		return;
 
-	down_write(&vnode->volume->cell->fs_open_mmaps_lock);
+	down_write(&vnode->volume->open_mmaps_lock);
 
 	if (atomic_read(&vnode->cb_nr_mmap) == 0)
 		list_del_init(&vnode->cb_mmap_link);
 
-	up_write(&vnode->volume->cell->fs_open_mmaps_lock);
+	up_write(&vnode->volume->open_mmaps_lock);
 	flush_work(&vnode->cb_work);
 }
 
@@ -570,7 +569,7 @@ static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pg
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(vmf->vma->vm_file));
 
-	if (afs_pagecache_valid(vnode))
+	if (afs_check_validity(vnode))
 		return filemap_map_pages(vmf, start_pgoff, end_pgoff);
 	return 0;
 }
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 99d1e649e929..cecc44af6a5f 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -42,7 +42,7 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 	op->pre_volsync.creation = volume->creation_time;
 	op->pre_volsync.update	= volume->update_time;
 	op->debug_id		= atomic_inc_return(&afs_operation_debug_counter);
-	op->nr_iterations = -1;
+	op->nr_iterations	= -1;
 	afs_op_set_error(op, -EDESTADDRREQ);
 
 	_leave(" = [op=%08x]", op->debug_id);
@@ -184,7 +184,6 @@ void afs_wait_for_operation(struct afs_operation *op)
 		op->call_responded = false;
 		op->call_error = 0;
 		op->call_abort_code = 0;
-		op->cb_s_break = op->server->cb_s_break;
 		if (test_bit(AFS_SERVER_FL_IS_YFS, &op->server->flags) &&
 		    op->ops->issue_yfs_rpc)
 			op->ops->issue_yfs_rpc(op);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index df3d37577b5b..4f04f6f33f46 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -85,8 +85,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 
 	write_seqlock(&vnode->cb_lock);
 
-	vnode->cb_v_break = op->cb_v_break;
-	vnode->cb_s_break = op->cb_s_break;
+	vnode->cb_v_check = op->cb_v_break;
 	vnode->status = *status;
 
 	t = status->mtime_client;
@@ -146,11 +145,10 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	if (!vp->scb.have_cb) {
 		/* it's a symlink we just created (the fileserver
 		 * didn't give us a callback) */
-		vnode->cb_expires_at = ktime_get_real_seconds();
+		atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
 	} else {
-		vnode->cb_expires_at = vp->scb.callback.expires_at;
 		vnode->cb_server = op->server;
-		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+		atomic64_set(&vnode->cb_expires_at, vp->scb.callback.expires_at);
 	}
 
 	write_sequnlock(&vnode->cb_lock);
@@ -214,7 +212,8 @@ static void afs_apply_status(struct afs_operation *op,
 	vnode->status = *status;
 
 	if (vp->dv_before + vp->dv_delta != status->data_version) {
-		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags))
+		if (vnode->cb_ro_snapshot == atomic_read(&vnode->volume->cb_ro_snapshot) &&
+		    atomic64_read(&vnode->cb_expires_at) != AFS_NO_CB_PROMISE)
 			pr_warn("kAFS: vnode modified {%llx:%llu} %llx->%llx %s (op=%x)\n",
 				vnode->fid.vid, vnode->fid.vnode,
 				(unsigned long long)vp->dv_before + vp->dv_delta,
@@ -268,9 +267,9 @@ static void afs_apply_callback(struct afs_operation *op,
 	struct afs_vnode *vnode = vp->vnode;
 
 	if (!afs_cb_is_broken(vp->cb_break_before, vnode)) {
-		vnode->cb_expires_at	= cb->expires_at;
-		vnode->cb_server	= op->server;
-		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+		if (op->volume->type == AFSVL_RWVOL)
+			vnode->cb_server = op->server;
+		atomic64_set(&vnode->cb_expires_at, cb->expires_at);
 	}
 }
 
@@ -542,7 +541,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	BUG_ON(!(inode->i_state & I_NEW));
 
 	vnode = AFS_FS_I(inode);
-	vnode->cb_v_break = atomic_read(&as->volume->cb_v_break),
+	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break),
 	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
@@ -587,7 +586,7 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	if (vnode->volume &&
 	    !(query_flags & AT_STATX_DONT_SYNC) &&
-	    !test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+	    atomic64_read(&vnode->cb_expires_at) == AFS_NO_CB_PROMISE) {
 		key = afs_request_key(vnode->volume->cell);
 		if (IS_ERR(key))
 			return PTR_ERR(key);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 4b730cbcf63e..6d0cd886b548 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -422,9 +422,6 @@ struct afs_cell {
 	/* Active fileserver interaction state. */
 	struct rb_root		fs_servers;	/* afs_server (by server UUID) */
 	seqlock_t		fs_lock;	/* For fs_servers  */
-	struct rw_semaphore	fs_open_mmaps_lock;
-	struct list_head	fs_open_mmaps;	/* List of vnodes that are mmapped */
-	atomic_t		fs_s_break;	/* Counter of CB.InitCallBackState messages */
 
 	/* VL server list. */
 	rwlock_t		vl_servers_lock; /* Lock on vl_servers */
@@ -591,9 +588,6 @@ struct afs_server {
 	/* file service access */
 	rwlock_t		fs_lock;	/* access lock */
 
-	/* callback promise management */
-	unsigned		cb_s_break;	/* Break-everything counter. */
-
 	/* Probe state */
 	struct afs_endpoint_state __rcu *endpoint_state; /* Latest endpoint/probe state */
 	unsigned long		probed_at;	/* Time last probe was dispatched (jiffies) */
@@ -615,6 +609,7 @@ struct afs_server_entry {
 	struct afs_server	*server;
 	struct afs_volume	*volume;
 	struct list_head	slink;		/* Link in server->volumes */
+	time64_t		cb_expires_at;	/* Time at which volume-level callback expires */
 	unsigned long		flags;
 #define AFS_SE_EXCLUDED		0		/* Set if server is to be excluded in rotation */
 };
@@ -668,10 +663,15 @@ struct afs_volume {
 	time64_t		update_time;	/* Volume update time (or TIME64_MIN) */
 
 	/* Callback management */
+	struct mutex		cb_check_lock;	/* Lock to control race to check after v_break */
+	time64_t		cb_expires_at;	/* Earliest volume callback expiry time */
 	atomic_t		cb_ro_snapshot;	/* RO volume update-from-snapshot counter */
 	atomic_t		cb_v_break;	/* Volume-break event counter. */
+	atomic_t		cb_v_check;	/* Volume-break has-been-checked counter. */
 	atomic_t		cb_scrub;	/* Scrub-all-data event counter. */
 	rwlock_t		cb_v_break_lock;
+	struct rw_semaphore	open_mmaps_lock;
+	struct list_head	open_mmaps;	/* List of vnodes that are mmapped */
 
 	afs_voltype_t		type;		/* type of volume */
 	char			type_force;	/* force volume type (suppress R/O -> R/W) */
@@ -710,7 +710,6 @@ struct afs_vnode {
 	spinlock_t		wb_lock;	/* lock for wb_keys */
 	spinlock_t		lock;		/* waitqueue/flags lock */
 	unsigned long		flags;
-#define AFS_VNODE_CB_PROMISED	0		/* Set if vnode has a callback promise */
 #define AFS_VNODE_UNSET		1		/* set if vnode attributes not yet set */
 #define AFS_VNODE_DIR_VALID	2		/* Set if dir contents are valid */
 #define AFS_VNODE_ZAP_DATA	3		/* set if vnode's data should be invalidated */
@@ -736,13 +735,14 @@ struct afs_vnode {
 	struct list_head	cb_mmap_link;	/* Link in cell->fs_open_mmaps */
 	void			*cb_server;	/* Server with callback/filelock */
 	atomic_t		cb_nr_mmap;	/* Number of mmaps */
-	unsigned int		cb_fs_s_break;	/* Mass server break counter (cell->fs_s_break) */
-	unsigned int		cb_s_break;	/* Mass break counter on ->server */
-	unsigned int		cb_v_break;	/* Mass break counter on ->volume */
+	unsigned int		cb_ro_snapshot;	/* RO volume release counter on ->volume */
+	unsigned int		cb_scrub;	/* Scrub counter on ->volume */
 	unsigned int		cb_break;	/* Break counter on vnode */
+	unsigned int		cb_v_check;	/* Break check counter on ->volume */
 	seqlock_t		cb_lock;	/* Lock for ->cb_server, ->status, ->cb_*break */
 
-	time64_t		cb_expires_at;	/* time at which callback expires */
+	atomic64_t		cb_expires_at;	/* time at which callback expires */
+#define AFS_NO_CB_PROMISE TIME64_MIN
 };
 
 static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *vnode)
@@ -839,7 +839,7 @@ struct afs_vnode_param {
 	struct afs_fid		fid;		/* Fid to access */
 	struct afs_status_cb	scb;		/* Returned status and callback promise */
 	afs_dataversion_t	dv_before;	/* Data version before the call */
-	unsigned int		cb_break_before; /* cb_break + cb_s_break before the call */
+	unsigned int		cb_break_before; /* cb_break before the call */
 	u8			dv_delta;	/* Expected change in data version */
 	bool			put_vnode:1;	/* T if we have a ref on the vnode */
 	bool			need_io_lock:1;	/* T if we need the I/O lock on this */
@@ -875,7 +875,6 @@ struct afs_operation {
 	unsigned int		debug_id;
 
 	unsigned int		cb_v_break;	/* Volume break counter before op */
-	unsigned int		cb_s_break;	/* Server break counter before op */
 
 	union {
 		struct {
@@ -1066,13 +1065,15 @@ extern void afs_break_callbacks(struct afs_server *, size_t, struct afs_callback
 
 static inline unsigned int afs_calc_vnode_cb_break(struct afs_vnode *vnode)
 {
-	return vnode->cb_break + vnode->cb_v_break;
+	return vnode->cb_break + vnode->cb_ro_snapshot + vnode->cb_scrub;
 }
 
 static inline bool afs_cb_is_broken(unsigned int cb_break,
 				    const struct afs_vnode *vnode)
 {
-	return cb_break != (vnode->cb_break + atomic_read(&vnode->volume->cb_v_break));
+	return cb_break != (vnode->cb_break +
+			    atomic_read(&vnode->volume->cb_ro_snapshot) +
+			    atomic_read(&vnode->volume->cb_scrub));
 }
 
 /*
@@ -1564,9 +1565,8 @@ extern void afs_fs_exit(void);
 /*
  * validation.c
  */
+bool afs_check_validity(const struct afs_vnode *vnode);
 int afs_update_volume_state(struct afs_operation *op);
-bool afs_check_validity(struct afs_vnode *vnode);
-bool afs_pagecache_valid(struct afs_vnode *vnode);
 int afs_validate(struct afs_vnode *vnode, struct key *key);
 
 /*
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index a138022d8e0d..3bd02571f30d 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -443,8 +443,8 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   refcount_read(&server->ref),
 		   atomic_read(&server->active),
 		   server->cell->name);
-	seq_printf(m, "  - info: fl=%lx rtt=%u brk=%x\n",
-		   server->flags, server->rtt, server->cb_s_break);
+	seq_printf(m, "  - info: fl=%lx rtt=%u\n",
+		   server->flags, server->rtt);
 	seq_printf(m, "  - probe: last=%d\n",
 		   (int)(jiffies - server->probed_at) / HZ);
 	failed = estate->failed_set;
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 5c50c9aa1f87..a5222acf0add 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -59,7 +59,7 @@ static bool afs_start_fs_iteration(struct afs_operation *op,
 		write_seqlock(&vnode->cb_lock);
 		ASSERTCMP(cb_server, ==, vnode->cb_server);
 		vnode->cb_server = NULL;
-		if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags))
+		if (atomic64_xchg(&vnode->cb_expires_at, AFS_NO_CB_PROMISE) != AFS_NO_CB_PROMISE)
 			vnode->cb_break++;
 		write_sequnlock(&vnode->cb_lock);
 	}
@@ -484,10 +484,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	op->server = server;
 	if (vnode->cb_server != server) {
 		vnode->cb_server = server;
-		vnode->cb_s_break = server->cb_s_break;
-		vnode->cb_fs_s_break = atomic_read(&server->cell->fs_s_break);
-		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
-		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+		vnode->cb_v_check = atomic_read(&vnode->volume->cb_v_break);
+		atomic64_set(&vnode->cb_expires_at, AFS_NO_CB_PROMISE);
 	}
 
 	read_lock(&server->fs_lock);
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index fb0f4afcb304..ac4a7afff45e 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -110,6 +110,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 		slist->servers[j].server = server;
 		slist->servers[j].volume = volume;
 		slist->servers[j].flags = se_flags;
+		slist->servers[j].cb_expires_at = AFS_NO_CB_PROMISE;
 		slist->nr_servers++;
 	}
 
@@ -210,6 +211,7 @@ void afs_reattach_volume_to_servers(struct afs_volume *volume, struct afs_server
 		int diff;
 
 		if (pn && po && pn->server == po->server) {
+			pn->cb_expires_at = po->cb_expires_at;
 			list_replace(&po->slink, &pn->slink);
 			n++;
 			o++;
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 6aadd5e075e4..13e9a87ac5c6 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -10,6 +10,131 @@
 #include <linux/sched.h>
 #include "internal.h"
 
+/*
+ * Data validation is managed through a number of mechanisms from the server:
+ *
+ *  (1) On first contact with a server (such as if it has just been rebooted),
+ *      the server sends us a CB.InitCallBackState* request.
+ *
+ *  (2) On a RW volume, in response to certain vnode (inode)-accessing RPC
+ *      calls, the server maintains a time-limited per-vnode promise that it
+ *      will send us a CB.CallBack request if a third party alters the vnodes
+ *      accessed.
+ *
+ *      Note that a vnode-level callbacks may also be sent for other reasons,
+ *      such as filelock release.
+ *
+ *  (3) On a RO (or Backup) volume, in response to certain vnode-accessing RPC
+ *      calls, each server maintains a time-limited per-volume promise that it
+ *      will send us a CB.CallBack request if the RO volume is updated to a
+ *      snapshot of the RW volume ("vos release").  This is an atomic event
+ *      that cuts over all instances of the RO volume across multiple servers
+ *      simultaneously.
+ *
+ *	Note that a volume-level callbacks may also be sent for other reasons,
+ *	such as the volumeserver taking over control of the volume from the
+ *	fileserver.
+ *
+ *	Note also that each server maintains an independent time limit on an
+ *	independent callback.
+ *
+ *  (4) Certain RPC calls include a volume information record "VolSync" in
+ *      their reply.  This contains a creation date for the volume that should
+ *      remain unchanged for a RW volume (but will be changed if the volume is
+ *      restored from backup) or will be bumped to the time of snapshotting
+ *      when a RO volume is released.
+ *
+ * In order to track this events, the following are provided:
+ *
+ *	->cb_v_break.  A counter of events that might mean that the contents of
+ *	a volume have been altered since we last checked a vnode.
+ *
+ *	->cb_v_check.  A counter of the number of events that we've sent a
+ *	query to the server for.  Everything's up to date if this equals
+ *	cb_v_break.
+ *
+ *	->cb_scrub.  A counter of the number of regression events for which we
+ *	have to completely wipe the cache.
+ *
+ *	->cb_ro_snapshot.  A counter of the number of times that we've
+ *      recognised that a RO volume has been updated.
+ *
+ *	->cb_break.  A counter of events that might mean that the contents of a
+ *      vnode have been altered.
+ *
+ *	->cb_expires_at.  The time at which the callback promise expires or
+ *      AFS_NO_CB_PROMISE if we have no promise.
+ *
+ * The way we manage things is:
+ *
+ *  (1) When a volume-level CB.CallBack occurs, we increment ->cb_v_break on
+ *      the volume and reset ->cb_expires_at (ie. set AFS_NO_CB_PROMISE) on the
+ *      volume and volume's server record.
+ *
+ *  (2) When a CB.InitCallBackState occurs, we treat this as a volume-level
+ *	callback break on all the volumes that have been using that volume
+ *	(ie. increment ->cb_v_break and reset ->cb_expires_at).
+ *
+ *  (3) When a vnode-level CB.CallBack occurs, we increment ->cb_break on the
+ *	vnode and reset its ->cb_expires_at.  If the vnode is mmapped, we also
+ *	dispatch a work item to unmap all PTEs to the vnode's pagecache to
+ *	force reentry to the filesystem for revalidation.
+ *
+ *  (4) When entering the filesystem, we call afs_validate() to check the
+ *	validity of a vnode.  This first checks to see if ->cb_v_check and
+ *	->cb_v_break match, and if they don't, we lock volume->cb_check_lock
+ *	exclusively and perform an FS.FetchStatus on the vnode.
+ *
+ *	After checking the volume, we check the vnode.  If there's a mismatch
+ *	between the volume counters and the vnode's mirrors of those counters,
+ *	we lock vnode->validate_lock and issue an FS.FetchStatus on the vnode.
+ *
+ *  (5) When the reply from FS.FetchStatus arrives, the VolSync record is
+ *      parsed:
+ *
+ *	(A) If the Creation timestamp has changed on a RW volume or regressed
+ *	    on a RO volume, we try to increment ->cb_scrub; if it advances on a
+ *	    RO volume, we assume "vos release" happened and try to increment
+ *	    ->cb_ro_snapshot.
+ *
+ *      (B) If the Update timestamp has regressed, we try to increment
+ *	    ->cb_scrub.
+ *
+ *      Note that in both of these cases, we only do the increment if we can
+ *      cmpxchg the value of the timestamp from the value we noted before the
+ *      op.  This tries to prevent parallel ops from fighting one another.
+ *
+ *	volume->cb_v_check is then set to ->cb_v_break.
+ *
+ *  (6) The AFSCallBack record included in the FS.FetchStatus reply is also
+ *	parsed and used to set the promise in ->cb_expires_at for the vnode,
+ *	the volume and the volume's server record.
+ *
+ *  (7) If ->cb_scrub is seen to have advanced, we invalidate the pagecache for
+ *      the vnode.
+ */
+
+/*
+ * Check the validity of a vnode/inode and its parent volume.
+ */
+bool afs_check_validity(const struct afs_vnode *vnode)
+{
+	const struct afs_volume *volume = vnode->volume;
+	time64_t deadline = ktime_get_real_seconds() + 10;
+
+	if (atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break) ||
+	    atomic64_read(&vnode->cb_expires_at)  <= deadline ||
+	    volume->cb_expires_at <= deadline ||
+	    vnode->cb_ro_snapshot != atomic_read(&volume->cb_ro_snapshot) ||
+	    vnode->cb_scrub	  != atomic_read(&volume->cb_scrub) ||
+	    test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
+		_debug("inval");
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * See if the server we've just talked to is currently excluded.
  */
@@ -185,11 +310,17 @@ static int afs_update_volume_times(struct afs_operation *op, struct afs_volume *
 }
 
 /*
- * Update the state of a volume.  Returns 1 to redo the operation from the start.
+ * Update the state of a volume, including recording the expiration time of the
+ * callback promise.  Returns 1 to redo the operation from the start.
  */
 int afs_update_volume_state(struct afs_operation *op)
 {
+	struct afs_server_list *slist = op->server_list;
+	struct afs_server_entry *se = &slist->servers[op->server_index];
+	struct afs_callback *cb = &op->file[0].scb.callback;
 	struct afs_volume *volume = op->volume;
+	unsigned int cb_v_break = atomic_read(&volume->cb_v_break);
+	unsigned int cb_v_check = atomic_read(&volume->cb_v_check);
 	int ret;
 
 	_enter("%llx", op->volume->vid);
@@ -202,6 +333,12 @@ int afs_update_volume_state(struct afs_operation *op)
 		}
 	}
 
+	if (op->cb_v_break == cb_v_break) {
+		se->cb_expires_at = cb->expires_at;
+		volume->cb_expires_at = cb->expires_at;
+	}
+	if (cb_v_check < op->cb_v_break)
+		atomic_cmpxchg(&volume->cb_v_check, cb_v_check, op->cb_v_break);
 	return 0;
 }
 
@@ -224,99 +361,6 @@ static void afs_zap_data(struct afs_vnode *vnode)
 		invalidate_inode_pages2(vnode->netfs.inode.i_mapping);
 }
 
-/*
- * Check to see if we have a server currently serving this volume and that it
- * hasn't been reinitialised or dropped from the list.
- */
-static bool afs_check_server_good(struct afs_vnode *vnode)
-{
-	struct afs_server_list *slist;
-	struct afs_server *server;
-	bool good;
-	int i;
-
-	if (vnode->cb_fs_s_break == atomic_read(&vnode->volume->cell->fs_s_break))
-		return true;
-
-	rcu_read_lock();
-
-	slist = rcu_dereference(vnode->volume->servers);
-	for (i = 0; i < slist->nr_servers; i++) {
-		server = slist->servers[i].server;
-		if (server == vnode->cb_server) {
-			good = (vnode->cb_s_break == server->cb_s_break);
-			rcu_read_unlock();
-			return good;
-		}
-	}
-
-	rcu_read_unlock();
-	return false;
-}
-
-/*
- * Check the validity of a vnode/inode.
- */
-bool afs_check_validity(struct afs_vnode *vnode)
-{
-	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
-	time64_t now = ktime_get_real_seconds();
-	unsigned int cb_break;
-	int seq;
-
-	do {
-		seq = read_seqbegin(&vnode->cb_lock);
-		cb_break = vnode->cb_break;
-
-		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-			if (vnode->cb_v_break != atomic_read(&vnode->volume->cb_v_break))
-				need_clear = afs_cb_break_for_v_break;
-			else if (!afs_check_server_good(vnode))
-				need_clear = afs_cb_break_for_s_reinit;
-			else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
-				need_clear = afs_cb_break_for_zap;
-			else if (vnode->cb_expires_at - 10 <= now)
-				need_clear = afs_cb_break_for_lapsed;
-		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-			;
-		} else {
-			need_clear = afs_cb_break_no_promise;
-		}
-
-	} while (read_seqretry(&vnode->cb_lock, seq));
-
-	if (need_clear == afs_cb_break_no_break)
-		return true;
-
-	write_seqlock(&vnode->cb_lock);
-	if (need_clear == afs_cb_break_no_promise)
-		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
-	else if (cb_break == vnode->cb_break)
-		__afs_break_callback(vnode, need_clear);
-	else
-		trace_afs_cb_miss(&vnode->fid, need_clear);
-	write_sequnlock(&vnode->cb_lock);
-	return false;
-}
-
-/*
- * Returns true if the pagecache is still valid.  Does not sleep.
- */
-bool afs_pagecache_valid(struct afs_vnode *vnode)
-{
-	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
-		if (vnode->netfs.inode.i_nlink)
-			clear_nlink(&vnode->netfs.inode);
-		return true;
-	}
-
-	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
-	    afs_check_validity(vnode))
-		return true;
-
-	return false;
-}
-
 /*
  * validate a vnode/inode
  * - there are several things we need to check
@@ -328,23 +372,48 @@ bool afs_pagecache_valid(struct afs_vnode *vnode)
  */
 int afs_validate(struct afs_vnode *vnode, struct key *key)
 {
+	struct afs_volume *volume = vnode->volume;
+	unsigned int cb_ro_snapshot, cb_scrub;
+	time64_t deadline = ktime_get_real_seconds() + 10;
+	bool zap = false, locked_vol = false;
 	int ret;
 
 	_enter("{v={%llx:%llu} fl=%lx},%x",
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
 	       key_serial(key));
 
-	if (afs_pagecache_valid(vnode))
-		goto valid;
+	if (afs_check_validity(vnode))
+		return 0;
+
+	ret = down_write_killable(&vnode->validate_lock);
+	if (ret < 0)
+		goto error;
 
-	down_write(&vnode->validate_lock);
+	/* Validate a volume after the v_break has changed or the volume
+	 * callback expired.  We only want to do this once per volume per
+	 * v_break change.  The actual work will be done when parsing the
+	 * status fetch reply.
+	 */
+	if (volume->cb_expires_at <= deadline ||
+	    atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break)) {
+		ret = mutex_lock_interruptible(&volume->cb_check_lock);
+		if (ret < 0)
+			goto error_unlock;
+		locked_vol = true;
+	}
 
-	/* if the promise has expired, we need to check the server again to get
-	 * a new promise - note that if the (parent) directory's metadata was
-	 * changed then the security may be different and we may no longer have
-	 * access */
-	if (!test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-		_debug("not promised");
+	cb_ro_snapshot = atomic_read(&volume->cb_ro_snapshot);
+	cb_scrub = atomic_read(&volume->cb_scrub);
+	if (vnode->cb_ro_snapshot != cb_ro_snapshot ||
+	    vnode->cb_scrub	  != cb_scrub)
+		unmap_mapping_pages(vnode->netfs.inode.i_mapping, 0, 0, false);
+
+	if (vnode->cb_ro_snapshot != cb_ro_snapshot ||
+	    vnode->cb_scrub	  != cb_scrub ||
+	    volume->cb_expires_at <= deadline ||
+	    atomic_read(&volume->cb_v_check) != atomic_read(&volume->cb_v_break) ||
+	    atomic64_read(&vnode->cb_expires_at) <= deadline
+	    ) {
 		ret = afs_fetch_status(vnode, key, false, NULL);
 		if (ret < 0) {
 			if (ret == -ENOENT) {
@@ -353,9 +422,26 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 			}
 			goto error_unlock;
 		}
+
 		_debug("new promise [fl=%lx]", vnode->flags);
 	}
 
+	/* We can drop the volume lock now as. */
+	if (locked_vol) {
+		mutex_unlock(&volume->cb_check_lock);
+		locked_vol = false;
+	}
+
+	cb_ro_snapshot = atomic_read(&volume->cb_ro_snapshot);
+	cb_scrub = atomic_read(&volume->cb_scrub);
+	_debug("vnode inval %x==%x %x==%x",
+	       vnode->cb_ro_snapshot, cb_ro_snapshot,
+	       vnode->cb_scrub, cb_scrub);
+	if (vnode->cb_scrub != cb_scrub)
+		zap = true;
+	vnode->cb_ro_snapshot = cb_ro_snapshot;
+	vnode->cb_scrub = cb_scrub;
+
 	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 		_debug("file already deleted");
 		ret = -ESTALE;
@@ -364,15 +450,18 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 
 	/* if the vnode's data version number changed then its contents are
 	 * different */
-	if (test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
+	zap |= test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
+	if (zap)
 		afs_zap_data(vnode);
 	up_write(&vnode->validate_lock);
-valid:
 	_leave(" = 0");
 	return 0;
 
 error_unlock:
+	if (locked_vol)
+		mutex_unlock(&volume->cb_check_lock);
 	up_write(&vnode->validate_lock);
+error:
 	_leave(" = %d", ret);
 	return ret;
 }
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 41ab1d3ff3ea..cc207dca1b21 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -98,7 +98,10 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	INIT_WORK(&volume->destructor, afs_destroy_volume);
 	rwlock_init(&volume->servers_lock);
 	mutex_init(&volume->volsync_lock);
+	mutex_init(&volume->cb_check_lock);
 	rwlock_init(&volume->cb_v_break_lock);
+	INIT_LIST_HEAD(&volume->open_mmaps);
+	init_rwsem(&volume->open_mmaps_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
 
 	for (i = 0; i < AFS_MAXTYPES; i++)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index bbe8dcab4b32..2df7d0fd3f21 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -438,18 +438,14 @@ enum yfs_cm_operation {
 
 #define afs_cb_break_reasons						\
 	EM(afs_cb_break_no_break,		"no-break")		\
-	EM(afs_cb_break_no_promise,		"no-promise")		\
 	EM(afs_cb_break_for_callback,		"break-cb")		\
 	EM(afs_cb_break_for_creation_regress,	"creation-regress")	\
 	EM(afs_cb_break_for_deleted,		"break-del")		\
-	EM(afs_cb_break_for_lapsed,		"break-lapsed")		\
 	EM(afs_cb_break_for_s_reinit,		"s-reinit")		\
 	EM(afs_cb_break_for_unlink,		"break-unlink")		\
 	EM(afs_cb_break_for_update_regress,	"update-regress")	\
-	EM(afs_cb_break_for_v_break,		"break-v")		\
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
 	EM(afs_cb_break_for_vos_release,	"break-vos-release")	\
-	EM(afs_cb_break_for_zap,		"break-zap")		\
 	E_(afs_cb_break_volume_excluded,	"vol-excluded")
 
 /*



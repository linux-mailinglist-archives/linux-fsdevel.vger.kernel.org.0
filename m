Return-Path: <linux-fsdevel+bounces-5893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219ED8113A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F271F226A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275312E656;
	Wed, 13 Dec 2023 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OomN+/7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A569A10D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YTTsK/AJL0ANW0loPNDoe7NHrb8y0i3Fu3adda/S2U=;
	b=OomN+/7m51JTtRpv11cA/ffto9tE955X3xoAVdzFyrNkeeXV7mrU+7K81D9eEUYyXseWCe
	D2EuRdn4dnfuMB0eDmvtRMJWQV8UuOFyEFGR7034M6kCYokOCwSgvhSvvi8KOQg8gY8hWP
	i9DQFPVKGD2QF8W88/m3sXu//RtIsNs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-81LEWHC9Ow234AAFtNmmlA-1; Wed,
 13 Dec 2023 08:51:04 -0500
X-MC-Unique: 81LEWHC9Ow234AAFtNmmlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A26D83869143;
	Wed, 13 Dec 2023 13:51:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB51540C6EB9;
	Wed, 13 Dec 2023 13:51:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/40] afs: Parse the VolSync record in the reply of a number of RPC ops
Date: Wed, 13 Dec 2023 13:49:58 +0000
Message-ID: <20231213135003.367397-37-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

A number of fileserver RPC operations return a VolSync record as part of
their reply that gives some information about the state of the volume being
accessed, including:

 (1) A volume Creation timestamp.  For an RW volume, this is the time at
     which the volume was created; if it changes, the RW volume was
     presumably restored from a backup and all cached data should be
     scrubbed as Data Version numbers could regress on the files in the
     volume.

     For an RO volume, this is the time it was last snapshotted from the RW
     volume.  It is expected to advance each time this happens; if it
     regresses, cached data should be scrubbed.

 (2) A volume Update timestamp (Auristor only).  For an RW volume, this is
     updated any time any change is made to a volume or its contents.  If
     it regresses, all cached data must be scrubbed.

     For an RO volume, this is a copy of the RW volume's Update timestamp
     at the point of snapshotting.  It can be used as a version number when
     checking to see if a callback on a RO volume was due to a snapshot.
     If it regresses, all cached data must be scrubbed.

but this is currently not made use of by the in-kernel afs filesystem.

Make the afs filesystem use this by:

 (1) Add an update time field to the afs_volsync struct and use a value of
     TIME64_MIN in both that and the creation time to indicate that they
     are unset.

 (2) Add creation and update time fields to the afs_volume struct and use
     this to track the two timestamps.

 (3) Add a volsync_lock mutex to the afs_volume struct to control
     modification access for when we detect a change in these values.

 (3) Add a 'pre-op volsync' struct to the afs_operation struct to record
     the state of the volume tracking before the op.

 (4) Add a new counter, cb_scrub, to the afs_volume struct to count events
     that require all data to be scrubbed.  A copy is placed in the
     afs_vnode struct (inode) and if they no longer match, a scrub takes
     place.

 (5) When the result of an operation is being parsed, parse the VolSync
     data too, if it is provided.  Note that the two timestamps are handled
     separately, since they don't work in quite the same way.

     - If the afs_volume tracking is unset, just set it and do nothing
       else.

     - If the result timestamps are the same as the ones in afs_volume, do
       nothing.

     - If the timestamps regress, increment cb_scrub if not already done
       so.

     - If the creation timestamp on a RW volume changes, increment cb_scrub
       if not already done so.

     - If the creation timestamp on a RO volume advances, update the server
       list and see if the current server has been excluded, if so reissue
       the op.  Once over half of the replication sites have been updated,
       increment cb_ro_snapshot to indicate updates may be required and
       switch over to excluding unupdated replication sites.

     - If the creation timestamp on a Backup volume advances, just
       increment cb_ro_snapshot to trigger updates.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/afs.h               |   3 +-
 fs/afs/callback.c          |   7 +-
 fs/afs/fs_operation.c      |  14 +--
 fs/afs/fsclient.c          |   5 +-
 fs/afs/inode.c             |   2 +-
 fs/afs/internal.h          |  16 ++-
 fs/afs/rotate.c            |   4 +-
 fs/afs/validation.c        | 199 ++++++++++++++++++++++++++++++++++++-
 fs/afs/volume.c            |   3 +
 fs/afs/yfsclient.c         |   5 +-
 include/trace/events/afs.h |  30 +++++-
 11 files changed, 268 insertions(+), 20 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index 81815724db6c..b488072aee87 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -165,7 +165,8 @@ struct afs_status_cb {
  * AFS volume synchronisation information
  */
 struct afs_volsync {
-	time64_t		creation;	/* volume creation time */
+	time64_t		creation;	/* Volume creation time (or TIME64_MIN) */
+	time64_t		update;		/* Volume update time (or TIME64_MIN) */
 };
 
 /*
diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index f67e88076761..8ddc99c9c16b 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -81,7 +81,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		vnode->cb_break++;
-		vnode->cb_v_break = vnode->volume->cb_v_break;
+		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
 		afs_clear_permits(vnode);
 
 		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
@@ -159,12 +159,13 @@ static void afs_break_one_callback(struct afs_volume *volume,
 	struct super_block *sb;
 	struct afs_vnode *vnode;
 	struct inode *inode;
+	unsigned int cb_v_break;
 
 	if (fid->vnode == 0 && fid->unique == 0) {
 		/* The callback break applies to an entire volume. */
 		write_lock(&volume->cb_v_break_lock);
-		volume->cb_v_break++;
-		trace_afs_cb_break(fid, volume->cb_v_break,
+		cb_v_break = atomic_inc_return(&volume->cb_v_break);
+		trace_afs_cb_break(fid, cb_v_break,
 				   afs_cb_break_for_volume_callback, false);
 		write_unlock(&volume->cb_v_break_lock);
 		return;
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 10137681aa7d..99d1e649e929 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -35,11 +35,13 @@ struct afs_operation *afs_alloc_operation(struct key *key, struct afs_volume *vo
 		key_get(key);
 	}
 
-	op->key		= key;
-	op->volume	= afs_get_volume(volume, afs_volume_trace_get_new_op);
-	op->net		= volume->cell->net;
-	op->cb_v_break	= volume->cb_v_break;
-	op->debug_id	= atomic_inc_return(&afs_operation_debug_counter);
+	op->key			= key;
+	op->volume		= afs_get_volume(volume, afs_volume_trace_get_new_op);
+	op->net			= volume->cell->net;
+	op->cb_v_break		= atomic_read(&volume->cb_v_break);
+	op->pre_volsync.creation = volume->creation_time;
+	op->pre_volsync.update	= volume->update_time;
+	op->debug_id		= atomic_inc_return(&afs_operation_debug_counter);
 	op->nr_iterations = -1;
 	afs_op_set_error(op, -EDESTADDRREQ);
 
@@ -147,7 +149,7 @@ bool afs_begin_vnode_operation(struct afs_operation *op)
 
 	afs_prepare_vnode(op, &op->file[0], 0);
 	afs_prepare_vnode(op, &op->file[1], 1);
-	op->cb_v_break = op->volume->cb_v_break;
+	op->cb_v_break = atomic_read(&op->volume->cb_v_break);
 	_leave(" = true");
 	return true;
 }
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index f1f879ba9cf7..80f7d9e796e3 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1870,7 +1870,10 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		xdr_decode_AFSVolSync(&bp, &op->volsync);
+		/* Unfortunately, prior to OpenAFS-1.6, volsync here is filled
+		 * with rubbish.
+		 */
+		xdr_decode_AFSVolSync(&bp, NULL);
 
 		call->unmarshall++;
 		fallthrough;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 102e7c37d33c..df3d37577b5b 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -542,7 +542,7 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	BUG_ON(!(inode->i_state & I_NEW));
 
 	vnode = AFS_FS_I(inode);
-	vnode->cb_v_break = as->volume->cb_v_break,
+	vnode->cb_v_break = atomic_read(&as->volume->cb_v_break),
 	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3d90415c2527..4b730cbcf63e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -662,7 +662,15 @@ struct afs_volume {
 	rwlock_t		servers_lock;	/* Lock for ->servers */
 	unsigned int		servers_seq;	/* Incremented each time ->servers changes */
 
-	unsigned		cb_v_break;	/* Break-everything counter. */
+	/* RO release tracking */
+	struct mutex		volsync_lock;	/* Time/state evaluation lock */
+	time64_t		creation_time;	/* Volume creation time (or TIME64_MIN) */
+	time64_t		update_time;	/* Volume update time (or TIME64_MIN) */
+
+	/* Callback management */
+	atomic_t		cb_ro_snapshot;	/* RO volume update-from-snapshot counter */
+	atomic_t		cb_v_break;	/* Volume-break event counter. */
+	atomic_t		cb_scrub;	/* Scrub-all-data event counter. */
 	rwlock_t		cb_v_break_lock;
 
 	afs_voltype_t		type;		/* type of volume */
@@ -856,7 +864,8 @@ struct afs_operation {
 	struct afs_volume	*volume;	/* Volume being accessed */
 	struct afs_vnode_param	file[2];
 	struct afs_vnode_param	*more_files;
-	struct afs_volsync	volsync;
+	struct afs_volsync	pre_volsync;	/* Volsync before op */
+	struct afs_volsync	volsync;	/* Volsync returned by op */
 	struct dentry		*dentry;	/* Dentry to be altered */
 	struct dentry		*dentry_2;	/* Second dentry to be altered */
 	struct timespec64	mtime;		/* Modification time to record */
@@ -1063,7 +1072,7 @@ static inline unsigned int afs_calc_vnode_cb_break(struct afs_vnode *vnode)
 static inline bool afs_cb_is_broken(unsigned int cb_break,
 				    const struct afs_vnode *vnode)
 {
-	return cb_break != (vnode->cb_break + vnode->volume->cb_v_break);
+	return cb_break != (vnode->cb_break + atomic_read(&vnode->volume->cb_v_break));
 }
 
 /*
@@ -1555,6 +1564,7 @@ extern void afs_fs_exit(void);
 /*
  * validation.c
  */
+int afs_update_volume_state(struct afs_operation *op);
 bool afs_check_validity(struct afs_vnode *vnode);
 bool afs_pagecache_valid(struct afs_vnode *vnode);
 int afs_validate(struct afs_vnode *vnode, struct key *key);
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 3ab85a907a1d..5c50c9aa1f87 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -486,7 +486,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 		vnode->cb_server = server;
 		vnode->cb_s_break = server->cb_s_break;
 		vnode->cb_fs_s_break = atomic_read(&server->cell->fs_s_break);
-		vnode->cb_v_break = vnode->volume->cb_v_break;
+		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
 		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 	}
 
@@ -519,6 +519,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	op->addr_index = addr_index;
 	set_bit(addr_index, &op->addr_tried);
 
+	op->volsync.creation = TIME64_MIN;
+	op->volsync.update = TIME64_MIN;
 	op->call_responded = false;
 	_debug("address [%u] %u/%u %pISp",
 	       op->server_index, addr_index, alist->nr_addrs,
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 18ba2c5e8ead..6aadd5e075e4 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -10,6 +10,201 @@
 #include <linux/sched.h>
 #include "internal.h"
 
+/*
+ * See if the server we've just talked to is currently excluded.
+ */
+static bool __afs_is_server_excluded(struct afs_operation *op, struct afs_volume *volume)
+{
+	const struct afs_server_entry *se;
+	const struct afs_server_list *slist;
+	bool is_excluded = true;
+	int i;
+
+	rcu_read_lock();
+
+	slist = rcu_dereference(volume->servers);
+	for (i = 0; i < slist->nr_servers; i++) {
+		se = &slist->servers[i];
+		if (op->server == se->server) {
+			is_excluded = test_bit(AFS_SE_EXCLUDED, &se->flags);
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return is_excluded;
+}
+
+/*
+ * Update the volume's server list when the creation time changes and see if
+ * the server we've just talked to is currently excluded.
+ */
+static int afs_is_server_excluded(struct afs_operation *op, struct afs_volume *volume)
+{
+	int ret;
+
+	if (__afs_is_server_excluded(op, volume))
+		return 1;
+
+	set_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
+	ret = afs_check_volume_status(op->volume, op);
+	if (ret < 0)
+		return ret;
+
+	return __afs_is_server_excluded(op, volume);
+}
+
+/*
+ * Handle a change to the volume creation time in the VolSync record.
+ */
+static int afs_update_volume_creation_time(struct afs_operation *op, struct afs_volume *volume)
+{
+	unsigned int snap;
+	time64_t cur = volume->creation_time;
+	time64_t old = op->pre_volsync.creation;
+	time64_t new = op->volsync.creation;
+	int ret;
+
+	_enter("%llx,%llx,%llx->%llx", volume->vid, cur, old, new);
+
+	if (cur == TIME64_MIN) {
+		volume->creation_time = new;
+		return 0;
+	}
+
+	if (new == cur)
+		return 0;
+
+	/* Try to advance the creation timestamp from what we had before the
+	 * operation to what we got back from the server.  This should
+	 * hopefully ensure that in a race between multiple operations only one
+	 * of them will do this.
+	 */
+	if (cur != old)
+		return 0;
+
+	/* If the creation time changes in an unexpected way, we need to scrub
+	 * our caches.  For a RW vol, this will only change if the volume is
+	 * restored from a backup; for a RO/Backup vol, this will advance when
+	 * the volume is updated to a new snapshot (eg. "vos release").
+	 */
+	if (volume->type == AFSVL_RWVOL)
+		goto regressed;
+	if (volume->type == AFSVL_BACKVOL) {
+		if (new < old)
+			goto regressed;
+		goto advance;
+	}
+
+	/* We have an RO volume, we need to query the VL server and look at the
+	 * server flags to see if RW->RO replication is in progress.
+	 */
+	ret = afs_is_server_excluded(op, volume);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		snap = atomic_read(&volume->cb_ro_snapshot);
+		trace_afs_cb_v_break(volume->vid, snap, afs_cb_break_volume_excluded);
+		return ret;
+	}
+
+advance:
+	snap = atomic_inc_return(&volume->cb_ro_snapshot);
+	trace_afs_cb_v_break(volume->vid, snap, afs_cb_break_for_vos_release);
+	volume->creation_time = new;
+	return 0;
+
+regressed:
+	atomic_inc(&volume->cb_scrub);
+	trace_afs_cb_v_break(volume->vid, 0, afs_cb_break_for_creation_regress);
+	volume->creation_time = new;
+	return 0;
+}
+
+/*
+ * Handle a change to the volume update time in the VolSync record.
+ */
+static void afs_update_volume_update_time(struct afs_operation *op, struct afs_volume *volume)
+{
+	enum afs_cb_break_reason reason = afs_cb_break_no_break;
+	time64_t cur = volume->update_time;
+	time64_t old = op->pre_volsync.update;
+	time64_t new = op->volsync.update;
+
+	_enter("%llx,%llx,%llx->%llx", volume->vid, cur, old, new);
+
+	if (cur == TIME64_MIN) {
+		volume->update_time = new;
+		return;
+	}
+
+	if (new == cur)
+		return;
+
+	/* If the volume update time changes in an unexpected way, we need to
+	 * scrub our caches.  For a RW vol, this will advance on every
+	 * modification op; for a RO/Backup vol, this will advance when the
+	 * volume is updated to a new snapshot (eg. "vos release").
+	 */
+	if (new < old)
+		reason = afs_cb_break_for_update_regress;
+
+	/* Try to advance the update timestamp from what we had before the
+	 * operation to what we got back from the server.  This should
+	 * hopefully ensure that in a race between multiple operations only one
+	 * of them will do this.
+	 */
+	if (cur == old) {
+		if (reason == afs_cb_break_for_update_regress) {
+			atomic_inc(&volume->cb_scrub);
+			trace_afs_cb_v_break(volume->vid, 0, reason);
+		}
+		volume->update_time = new;
+	}
+}
+
+static int afs_update_volume_times(struct afs_operation *op, struct afs_volume *volume)
+{
+	int ret = 0;
+
+	if (likely(op->volsync.creation == volume->creation_time &&
+		   op->volsync.update == volume->update_time))
+		return 0;
+
+	mutex_lock(&volume->volsync_lock);
+	if (op->volsync.creation != volume->creation_time) {
+		ret = afs_update_volume_creation_time(op, volume);
+		if (ret < 0)
+			goto out;
+	}
+	if (op->volsync.update != volume->update_time)
+		afs_update_volume_update_time(op, volume);
+out:
+	mutex_unlock(&volume->volsync_lock);
+	return ret;
+}
+
+/*
+ * Update the state of a volume.  Returns 1 to redo the operation from the start.
+ */
+int afs_update_volume_state(struct afs_operation *op)
+{
+	struct afs_volume *volume = op->volume;
+	int ret;
+
+	_enter("%llx", op->volume->vid);
+
+	if (op->volsync.creation != TIME64_MIN || op->volsync.update != TIME64_MIN) {
+		ret = afs_update_volume_times(op, volume);
+		if (ret != 0) {
+			_leave(" = %d", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * mark the data attached to an inode as obsolete due to a write on the server
  * - might also want to ditch all the outstanding writes and dirty pages
@@ -74,7 +269,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 		cb_break = vnode->cb_break;
 
 		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
-			if (vnode->cb_v_break != vnode->volume->cb_v_break)
+			if (vnode->cb_v_break != atomic_read(&vnode->volume->cb_v_break))
 				need_clear = afs_cb_break_for_v_break;
 			else if (!afs_check_server_good(vnode))
 				need_clear = afs_cb_break_for_s_reinit;
@@ -95,7 +290,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 
 	write_seqlock(&vnode->cb_lock);
 	if (need_clear == afs_cb_break_no_promise)
-		vnode->cb_v_break = vnode->volume->cb_v_break;
+		vnode->cb_v_break = atomic_read(&vnode->volume->cb_v_break);
 	else if (cb_break == vnode->cb_break)
 		__afs_break_callback(vnode, need_clear);
 	else
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 4982fce25057..41ab1d3ff3ea 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -90,11 +90,14 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 	volume->type		= params->type;
 	volume->type_force	= params->force;
 	volume->name_len	= vldb->name_len;
+	volume->creation_time	= TIME64_MIN;
+	volume->update_time	= TIME64_MIN;
 
 	refcount_set(&volume->ref, 1);
 	INIT_HLIST_NODE(&volume->proc_link);
 	INIT_WORK(&volume->destructor, afs_destroy_volume);
 	rwlock_init(&volume->servers_lock);
+	mutex_init(&volume->volsync_lock);
 	rwlock_init(&volume->cb_v_break_lock);
 	memcpy(volume->name, vldb->name, vldb->name_len + 1);
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 11571cca86c1..2d6943f05ea5 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -245,12 +245,15 @@ static void xdr_decode_YFSVolSync(const __be32 **_bp,
 				  struct afs_volsync *volsync)
 {
 	struct yfs_xdr_YFSVolSync *x = (void *)*_bp;
-	u64 creation;
+	u64 creation, update;
 
 	if (volsync) {
 		creation = xdr_to_u64(x->vol_creation_date);
 		do_div(creation, 10 * 1000 * 1000);
 		volsync->creation = creation;
+		update = xdr_to_u64(x->vol_update_date);
+		do_div(update, 10 * 1000 * 1000);
+		volsync->update = update;
 	}
 
 	*_bp += xdr_size(x);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 63ab23876be8..bbe8dcab4b32 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -440,13 +440,17 @@ enum yfs_cm_operation {
 	EM(afs_cb_break_no_break,		"no-break")		\
 	EM(afs_cb_break_no_promise,		"no-promise")		\
 	EM(afs_cb_break_for_callback,		"break-cb")		\
+	EM(afs_cb_break_for_creation_regress,	"creation-regress")	\
 	EM(afs_cb_break_for_deleted,		"break-del")		\
 	EM(afs_cb_break_for_lapsed,		"break-lapsed")		\
 	EM(afs_cb_break_for_s_reinit,		"s-reinit")		\
 	EM(afs_cb_break_for_unlink,		"break-unlink")		\
+	EM(afs_cb_break_for_update_regress,	"update-regress")	\
 	EM(afs_cb_break_for_v_break,		"break-v")		\
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
-	E_(afs_cb_break_for_zap,		"break-zap")
+	EM(afs_cb_break_for_vos_release,	"break-vos-release")	\
+	EM(afs_cb_break_for_zap,		"break-zap")		\
+	E_(afs_cb_break_volume_excluded,	"vol-excluded")
 
 /*
  * Generate enums for tracing information.
@@ -1249,6 +1253,30 @@ TRACE_EVENT(afs_get_tree,
 		      __entry->cell, __entry->volume, __entry->vid)
 	    );
 
+TRACE_EVENT(afs_cb_v_break,
+	    TP_PROTO(afs_volid_t vid, unsigned int cb_v_break,
+		     enum afs_cb_break_reason reason),
+
+	    TP_ARGS(vid, cb_v_break, reason),
+
+	    TP_STRUCT__entry(
+		    __field(afs_volid_t,		vid)
+		    __field(unsigned int,		cb_v_break)
+		    __field(enum afs_cb_break_reason,	reason)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vid	= vid;
+		    __entry->cb_v_break	= cb_v_break;
+		    __entry->reason	= reason;
+			   ),
+
+	    TP_printk("%llx vb=%x %s",
+		      __entry->vid,
+		      __entry->cb_v_break,
+		      __print_symbolic(__entry->reason, afs_cb_break_reasons))
+	    );
+
 TRACE_EVENT(afs_cb_break,
 	    TP_PROTO(struct afs_fid *fid, unsigned int cb_break,
 		     enum afs_cb_break_reason reason, bool skipped),



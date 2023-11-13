Return-Path: <linux-fsdevel+bounces-2795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AA07EA0BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBFB1C20928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6A321A17;
	Mon, 13 Nov 2023 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUqOlS+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB0208AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 15:58:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C0410EC
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699891094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHCmFoypa2kVhT1S4U7DdPP9lkZiv+u3flT6Y9kyqx0=;
	b=CUqOlS+wI+A9rromq0j8Vtf/Mo68pXOcgRzl0nPyzyfXJxw/4x7FrpK0dQHT3MWCeRA0gv
	LafDZCGtVVIphJn3U5yf1NGZQM46LZdIUlmpUL+lqgWbWDHqZxROr4YKZYECZvHvC+idbC
	HWJRB9g5hi7S6vWjZjORiGttg+v9JN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-D8-UlHItMBWGKDSLMRZfVg-1; Mon, 13 Nov 2023 10:58:10 -0500
X-MC-Unique: D8-UlHItMBWGKDSLMRZfVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B5C2185A781;
	Mon, 13 Nov 2023 15:58:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74ED61121306;
	Mon, 13 Nov 2023 15:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45c0918e-5948-408e-a928-f764f3b1a42b@auristor.com>
References: <45c0918e-5948-408e-a928-f764f3b1a42b@auristor.com> <20231109154004.3317227-1-dhowells@redhat.com> <20231109154004.3317227-40-dhowells@redhat.com>
To: Jeffrey E Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH 42/41] afs: Fix the handling of RO volumes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3627312.1699891088.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2023 15:58:08 +0000
Message-ID: <3627313.1699891088@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Jeffrey E Altman <jaltman@auristor.com> wrote:

> The atomic visibility of a volume cloning operation is limited to indivi=
dual
> volume locations.  It is untrue that a "vos release" updates all RO volu=
me
> locations simultaneously.

[This need folding down into the preceding patches]

Fix the handling of RO volumes which aren't actually updated all at once,
but are rather updated in stages.

Switch from using the old servers to the new servers when at least half th=
e
servers are marked as new replication sites (VLSF_NEWREPSITE).

If an operation gets a reply from a server that indicates that an RO volum=
e
is of a more recent snapshot, we regenerate the server list and that
excludes whichever bunch of servers we don't want to look at.  If the
server we got the reply from is now excluded, we reissue the operation,
which will cause the rotation algorithm to start agian.

Whilst it thinks that RO replication is in progress, it rechecks the VLDB
record every 2s.  The problem is that as we don't then maintain a callback
on an excluded server, we won't get a notification of completion of the
replication process and will maintain the exclusion until the normal VLDB
recheck happens after an hour.

To simplify things, the volume creation and update times are set to
TIME64_MIN when not valid rather than using a separate flag, and a mutex i=
s
used to serialise attempts to modify them.

David
---
 fs/afs/afs.h               |    7 -
 fs/afs/dir.c               |    4 -
 fs/afs/fs_operation.c      |    5 -
 fs/afs/fsclient.c          |    4 -
 fs/afs/inode.c             |    5 -
 fs/afs/internal.h          |   17 +++-
 fs/afs/rotate.c            |   22 +++++-
 fs/afs/server_list.c       |   52 ++++++++++++--
 fs/afs/validation.c        |  164 +++++++++++++++++++++++++++++++++++----=
------
 fs/afs/vlclient.c          |   19 -----
 fs/afs/volume.c            |   10 ++
 fs/afs/yfsclient.c         |    1 =

 include/trace/events/afs.h |    3 =

 13 files changed, 230 insertions(+), 83 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index a6328a9ec9b0..b488072aee87 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -165,11 +165,8 @@ struct afs_status_cb {
  * AFS volume synchronisation information
  */
 struct afs_volsync {
-	unsigned int		mask;		/* Bitmask of supplied fields */
-#define AFS_VOLSYNC_CREATION	0x01
-#define AFS_VOLSYNC_UPDATE	0x02
-	time64_t		creation;	/* volume creation time */
-	time64_t		update;		/* Volume update time */
+	time64_t		creation;	/* Volume creation time (or TIME64_MIN) */
+	time64_t		update;		/* Volume update time (or TIME64_MIN) */
 };
 =

 /*
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 190d1ff42e60..7ea5803c05da 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -807,8 +807,8 @@ static struct inode *afs_do_lookup(struct inode *dir, =
struct dentry *dentry,
 		cookie->fids[i].vid =3D dvnode->fid.vid;
 	cookie->ctx.actor =3D afs_lookup_filldir;
 	cookie->name =3D dentry->d_name;
-	cookie->nr_fids =3D 2; /* slot 0 is saved for the fid we actually want
-			      * and slot 1 for the directory */
+	cookie->nr_fids =3D 2; /* slot 1 is saved for the fid we actually want
+			      * and slot 0 for the directory */
 =

 	if (!afs_server_supports_ibulk(dvnode))
 		cookie->one_only =3D true;
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index e0f5920a5aef..3546b087e791 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -39,9 +39,8 @@ struct afs_operation *afs_alloc_operation(struct key *ke=
y, struct afs_volume *vo
 	op->volume		=3D afs_get_volume(volume, afs_volume_trace_get_new_op);
 	op->net			=3D volume->cell->net;
 	op->cb_v_break		=3D atomic_read(&volume->cb_v_break);
-	op->pre_volsync.mask	=3D READ_ONCE(volume->volsync_mask);
-	op->pre_volsync.creation =3D atomic64_read(&volume->creation_time);
-	op->pre_volsync.update	=3D atomic64_read(&volume->update_time);
+	op->pre_volsync.creation =3D volume->creation_time;
+	op->pre_volsync.update	=3D volume->update_time;
 	op->debug_id		=3D atomic_inc_return(&afs_operation_debug_counter);
 	op->nr_iterations	=3D -1;
 	afs_op_set_error(op, -EDESTADDRREQ);
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 1bd1614688f7..80f7d9e796e3 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -165,10 +165,8 @@ static void xdr_decode_AFSVolSync(const __be32 **_bp,
 	bp++; /* spare6 */
 	*_bp =3D bp;
 =

-	if (volsync) {
+	if (volsync)
 		volsync->creation =3D creation;
-		volsync->mask |=3D AFS_VOLSYNC_CREATION;
-	}
 }
 =

 /*
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 04c335fab1a5..0fe1c63c9af5 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -212,7 +212,8 @@ static void afs_apply_status(struct afs_operation *op,
 	vnode->status =3D *status;
 =

 	if (vp->dv_before + vp->dv_delta !=3D status->data_version) {
-		if (vnode->cb_expires_at !=3D AFS_NO_CB_PROMISE)
+		if (vnode->cb_ro_snapshot =3D=3D atomic_read(&vnode->volume->cb_ro_snap=
shot) &&
+		    vnode->cb_expires_at !=3D AFS_NO_CB_PROMISE)
 			pr_warn("kAFS: vnode modified {%llx:%llu} %llx->%llx %s (op=3D%x)\n",
 				vnode->fid.vid, vnode->fid.vnode,
 				(unsigned long long)vp->dv_before + vp->dv_delta,
@@ -327,8 +328,6 @@ static void afs_fetch_status_success(struct afs_operat=
ion *op)
 	struct afs_vnode *vnode =3D vp->vnode;
 	int ret;
 =

-	afs_update_volume_state(op, vp);
-
 	if (vnode->netfs.inode.i_state & I_NEW) {
 		ret =3D afs_inode_init_from_status(op, vp, vnode);
 		afs_op_set_error(op, ret);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 43e438697baa..0c41601324fc 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -512,6 +512,7 @@ struct afs_vldb_entry {
 #define AFS_VOL_VTM_RW	0x01 /* R/W version of the volume is available (on=
 this server) */
 #define AFS_VOL_VTM_RO	0x02 /* R/O version of the volume is available (on=
 this server) */
 #define AFS_VOL_VTM_BAK	0x04 /* backup version of the volume is available=
 (on this server) */
+	u8			vlsf_flags[AFS_NMAXNSERVERS];
 	short			error;
 	u8			nr_servers;	/* Number of server records */
 	u8			name_len;
@@ -595,6 +596,12 @@ struct afs_server {
 	spinlock_t		probe_lock;
 };
 =

+enum afs_ro_replicating {
+	AFS_RO_NOT_REPLICATING,			/* Not doing replication */
+	AFS_RO_REPLICATING_USE_OLD,		/* Replicating; use old version */
+	AFS_RO_REPLICATING_USE_NEW,		/* Replicating; switch to new version */
+} __mode(byte);
+
 /*
  * Replaceable volume server list.
  */
@@ -606,12 +613,14 @@ struct afs_server_entry {
 	unsigned long		flags;
 #define AFS_SE_VOLUME_OFFLINE	0		/* Set if volume offline notice given */
 #define AFS_SE_VOLUME_BUSY	1		/* Set if volume busy notice given */
+#define AFS_SE_EXCLUDED		2		/* Set if server is to be excluded in rotatio=
n */
 };
 =

 struct afs_server_list {
 	struct rcu_head		rcu;
 	refcount_t		usage;
 	bool			attached;	/* T if attached to servers */
+	enum afs_ro_replicating	ro_replicating;	/* RW->RO update (probably) in p=
rogress */
 	unsigned char		nr_servers;
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
 	unsigned int		seq;		/* Set to ->servers_seq when installed */
@@ -647,9 +656,9 @@ struct afs_volume {
 	unsigned int		servers_seq;	/* Incremented each time ->servers changes */
 =

 	/* RO release tracking */
-	unsigned int		volsync_mask;	/* Mask of what values we have obtained */
-	atomic64_t		creation_time;	/* Volume creation time (time64_t) */
-	atomic64_t		update_time;	/* Volume update time (time64_t) */
+	struct mutex		volsync_lock;	/* Time/state evaluation lock */
+	time64_t		creation_time;	/* Volume creation time (or TIME64_MIN) */
+	time64_t		update_time;	/* Volume update time (or TIME64_MIN) */
 =

 	/* Callback management */
 	struct mutex		cb_check_lock;	/* Lock to control race to check after v_br=
eak */
@@ -1571,7 +1580,7 @@ extern void afs_fs_exit(void);
  * validation.c
  */
 bool afs_check_validity(const struct afs_vnode *vnode);
-void afs_update_volume_state(struct afs_operation *op, struct afs_vnode_p=
aram *vp);
+int afs_update_volume_state(struct afs_operation *op);
 int afs_validate(struct afs_vnode *vnode, struct key *key);
 =

 /*
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 099e0d1caa67..79c736eeca29 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -187,6 +187,22 @@ bool afs_select_fileserver(struct afs_operation *op)
 		clear_bit(AFS_SE_VOLUME_BUSY,
 			  &op->server_list->servers[op->server_index].flags);
 		op->cumul_error.responded =3D true;
+
+		/* We succeeded, but we may need to check the VLDB and redo the
+		 * op from another server if we're looking at a set of RO
+		 * volumes where some of the servers have not yet been brought
+		 * up to date to avoid regressing the data.  We only switch to
+		 * the new version once >=3D50% of the servers are updated.
+		 */
+		error =3D afs_update_volume_state(op);
+		if (error !=3D 0) {
+			if (error =3D=3D 1) {
+				afs_sleep_and_retry(op);
+				goto restart_from_beginning;
+			}
+			afs_op_set_error(op, error);
+			goto failed;
+		}
 		fallthrough;
 	default:
 		/* Success or local failure.  Stop. */
@@ -517,10 +533,12 @@ bool afs_select_fileserver(struct afs_operation *op)
 	best_prio =3D -1;
 	for (i =3D 0; i < op->server_list->nr_servers; i++) {
 		struct afs_endpoint_state *es;
+		struct afs_server_entry *se =3D &op->server_list->servers[i];
 		struct afs_addr_list *sal;
-		struct afs_server *s =3D op->server_list->servers[i].server;
+		struct afs_server *s =3D se->server;
 =

 		if (!test_bit(i, &op->untried_servers) ||
+		    test_bit(AFS_SE_EXCLUDED, &se->flags) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
 		es =3D op->server_states->endpoint_state;
@@ -598,6 +616,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	op->addr_index =3D addr_index;
 	set_bit(addr_index, &op->addr_tried);
 =

+	op->volsync.creation =3D TIME64_MIN;
+	op->volsync.update =3D TIME64_MIN;
 	op->call_responded =3D false;
 	_debug("address [%u] %u/%u %pISp",
 	       op->server_index, addr_index, alist->nr_addrs,
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index c9f146f69adf..5d45ff95946c 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -31,23 +31,55 @@ struct afs_server_list *afs_alloc_server_list(struct a=
fs_volume *volume,
 	struct afs_server_list *slist;
 	struct afs_server *server;
 	unsigned int type_mask =3D 1 << volume->type;
-	int ret =3D -ENOMEM, nr_servers =3D 0, i, j;
-
-	for (i =3D 0; i < vldb->nr_servers; i++)
-		if (vldb->fs_mask[i] & type_mask)
-			nr_servers++;
+	bool use_newrepsites =3D false;
+	int ret =3D -ENOMEM, nr_servers =3D 0, newrep =3D 0, i, j;
+	u32 tmp;
+
+	/* Work out if we're going to restrict to NEWREPSITE-marked servers or
+	 * not.  If at least one site is marked as NEWREPSITE, then it's likely
+	 * that "vos release" is busy updating RO sites.  We cut over from one
+	 * to the other when >=3D50% of the sites have been updated.  Sites that
+	 * are in the process of being updated are marked DONTUSE.
+	 */
+	for (i =3D 0; i < vldb->nr_servers; i++) {
+		if (!(vldb->fs_mask[i] & type_mask))
+			continue;
+		nr_servers++;
+		if (vldb->vlsf_flags[i] & AFS_VLSF_DONTUSE)
+			continue;
+		if (vldb->vlsf_flags[i] & AFS_VLSF_NEWREPSITE)
+			newrep++;
+	}
 =

 	slist =3D kzalloc(struct_size(slist, servers, nr_servers), GFP_KERNEL);
 	if (!slist)
 		goto error;
 =

+	if (newrep) {
+		if (newrep < nr_servers / 2) {
+			kdebug("USE-OLD");
+			slist->ro_replicating =3D AFS_RO_REPLICATING_USE_OLD;
+		} else {
+			kdebug("USE-NEW");
+			slist->ro_replicating =3D AFS_RO_REPLICATING_USE_NEW;
+			use_newrepsites =3D true;
+		}
+	}
+
 	refcount_set(&slist->usage, 1);
 	rwlock_init(&slist->lock);
 =

 	/* Make sure a records exists for each server in the list. */
 	for (i =3D 0; i < vldb->nr_servers; i++) {
+		unsigned long se_flags =3D 0;
+		bool newrepsite =3D tmp & AFS_VLSF_NEWREPSITE;
+
 		if (!(vldb->fs_mask[i] & type_mask))
 			continue;
+		if (tmp & AFS_VLSF_DONTUSE)
+			__set_bit(AFS_SE_EXCLUDED, &se_flags);
+		if (newrep && (newrepsite ^ use_newrepsites))
+			__set_bit(AFS_SE_EXCLUDED, &se_flags);
 =

 		server =3D afs_lookup_server(volume->cell, key, &vldb->fs_server[i],
 					   vldb->addr_version[i]);
@@ -79,6 +111,7 @@ struct afs_server_list *afs_alloc_server_list(struct af=
s_volume *volume,
 =

 		slist->servers[j].server =3D server;
 		slist->servers[j].volume =3D volume;
+		slist->servers[j].flags =3D se_flags;
 		slist->servers[j].cb_expires_at =3D AFS_NO_CB_PROMISE;
 		slist->nr_servers++;
 	}
@@ -102,14 +135,19 @@ struct afs_server_list *afs_alloc_server_list(struct=
 afs_volume *volume,
 bool afs_annotate_server_list(struct afs_server_list *new,
 			      struct afs_server_list *old)
 {
+	unsigned long mask =3D 1UL << AFS_SE_EXCLUDED;
 	int i;
 =

-	if (old->nr_servers !=3D new->nr_servers)
+	if (old->nr_servers !=3D new->nr_servers ||
+	    old->ro_replicating !=3D new->ro_replicating)
 		goto changed;
 =

-	for (i =3D 0; i < old->nr_servers; i++)
+	for (i =3D 0; i < old->nr_servers; i++) {
 		if (old->servers[i].server !=3D new->servers[i].server)
 			goto changed;
+		if ((old->servers[i].flags & mask) !=3D (new->servers[i].flags & mask))
+			goto changed;
+	}
 	return false;
 changed:
 	return true;
diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index 3802790fe4de..f8e24439727a 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -135,49 +135,115 @@ bool afs_check_validity(const struct afs_vnode *vno=
de)
 	return true;
 }
 =

+/*
+ * See if the server we've just talked to is currently excluded.
+ */
+static bool __afs_is_server_excluded(struct afs_operation *op, struct afs=
_volume *volume)
+{
+	const struct afs_server_entry *se;
+	const struct afs_server_list *slist;
+	bool is_excluded =3D true;
+	int i;
+
+	rcu_read_lock();
+
+	slist =3D rcu_dereference(volume->servers);
+	for (i =3D 0; i < slist->nr_servers; i++) {
+		se =3D &slist->servers[i];
+		if (op->server =3D=3D se->server) {
+			is_excluded =3D test_bit(AFS_SE_EXCLUDED, &se->flags);
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return is_excluded;
+}
+
+/*
+ * Update the volume's server list when the creation time changes and see=
 if
+ * the server we've just talked to is currently excluded.
+ */
+static int afs_is_server_excluded(struct afs_operation *op, struct afs_vo=
lume *volume)
+{
+	int ret;
+
+	if (__afs_is_server_excluded(op, volume))
+		return 1;
+
+	set_bit(AFS_VOLUME_NEEDS_UPDATE, &volume->flags);
+	ret =3D afs_check_volume_status(op->volume, op);
+	if (ret < 0)
+		return ret;
+
+	return __afs_is_server_excluded(op, volume);
+}
+
 /*
  * Handle a change to the volume creation time in the VolSync record.
  */
-static void afs_update_volume_creation_time(struct afs_operation *op, str=
uct afs_volume *volume)
+static int afs_update_volume_creation_time(struct afs_operation *op, stru=
ct afs_volume *volume)
 {
-	enum afs_cb_break_reason reason =3D afs_cb_break_for_vos_release;
 	unsigned int snap;
-	time64_t cur =3D atomic64_read(&volume->creation_time);
+	time64_t cur =3D volume->creation_time;
 	time64_t old =3D op->pre_volsync.creation;
 	time64_t new =3D op->volsync.creation;
+	int ret;
 =

 	_enter("%llx,%llx,%llx->%llx", volume->vid, cur, old, new);
 =

-	if (!(op->volsync.mask & AFS_VOLSYNC_CREATION) ||
-	    !(volume->volsync_mask & AFS_VOLSYNC_CREATION)) {
-		atomic64_set(&volume->creation_time, new);
-		volume->volsync_mask |=3D AFS_VOLSYNC_CREATION;
-		return;
+	if (cur =3D=3D TIME64_MIN) {
+		volume->creation_time =3D new;
+		return 0;
 	}
 =

-	if (likely(new =3D=3D cur))
-		return;
+	if (new =3D=3D cur)
+		return 0;
+
+	/* Try to advance the creation timestamp from what we had before the
+	 * operation to what we got back from the server.  This should
+	 * hopefully ensure that in a race between multiple operations only one
+	 * of them will do this.
+	 */
+	if (cur !=3D old)
+		return 0;
 =

 	/* If the creation time changes in an unexpected way, we need to scrub
 	 * our caches.  For a RW vol, this will only change if the volume is
 	 * restored from a backup; for a RO/Backup vol, this will advance when
 	 * the volume is updated to a new snapshot (eg. "vos release").
 	 */
-	if (volume->type =3D=3D AFSVL_RWVOL || new < old)
-		reason =3D afs_cb_break_for_creation_regress;
+	if (volume->type =3D=3D AFSVL_RWVOL)
+		goto regressed;
+	if (volume->type =3D=3D AFSVL_BACKVOL) {
+		if (new < old)
+			goto regressed;
+		goto advance;
+	}
 =

-	/* Try to advance the creation timestamp from what we had before the
-	 * operation to what we got back from the server.  This should
-	 * hopefully ensure that in a race between multiple operations only one
-	 * of them will do this.
+	/* We have an RO volume, we need to query the VL server and look at the
+	 * server flags to see if RW->RO replication is in progress.
 	 */
-	if (atomic64_try_cmpxchg(&volume->creation_time, &old, new)) {
-		if (reason =3D=3D afs_cb_break_for_creation_regress)
-			atomic_inc(&volume->cb_scrub);
-		else if (volume->type !=3D AFSVL_RWVOL)
-			snap =3D atomic_inc_return(&volume->cb_ro_snapshot);
-		trace_afs_cb_v_break(volume->vid, snap, reason);
+	ret =3D afs_is_server_excluded(op, volume);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		snap =3D atomic_read(&volume->cb_ro_snapshot);
+		trace_afs_cb_v_break(volume->vid, snap, afs_cb_break_volume_excluded);
+		return ret;
 	}
+
+advance:
+	snap =3D atomic_inc_return(&volume->cb_ro_snapshot);
+	trace_afs_cb_v_break(volume->vid, snap, afs_cb_break_for_vos_release);
+	volume->creation_time =3D new;
+	return 0;
+
+regressed:
+	atomic_inc(&volume->cb_scrub);
+	trace_afs_cb_v_break(volume->vid, 0, afs_cb_break_for_creation_regress);
+	volume->creation_time =3D new;
+	return 0;
 }
 =

 /*
@@ -186,20 +252,18 @@ static void afs_update_volume_creation_time(struct a=
fs_operation *op, struct afs
 static void afs_update_volume_update_time(struct afs_operation *op, struc=
t afs_volume *volume)
 {
 	enum afs_cb_break_reason reason =3D afs_cb_break_no_break;
-	time64_t cur =3D atomic64_read(&volume->update_time);
+	time64_t cur =3D volume->update_time;
 	time64_t old =3D op->pre_volsync.update;
 	time64_t new =3D op->volsync.update;
 =

 	_enter("%llx,%llx,%llx->%llx", volume->vid, cur, old, new);
 =

-	if (!(op->volsync.mask & AFS_VOLSYNC_UPDATE) ||
-	    !(volume->volsync_mask & AFS_VOLSYNC_UPDATE)) {
-		atomic64_set(&volume->update_time, new);
-		volume->volsync_mask |=3D AFS_VOLSYNC_UPDATE;
+	if (cur =3D=3D TIME64_MIN) {
+		volume->update_time =3D new;
 		return;
 	}
 =

-	if (likely(new =3D=3D cur))
+	if (new =3D=3D cur)
 		return;
 =

 	/* If the volume update time changes in an unexpected way, we need to
@@ -215,33 +279,59 @@ static void afs_update_volume_update_time(struct afs=
_operation *op, struct afs_v
 	 * hopefully ensure that in a race between multiple operations only one
 	 * of them will do this.
 	 */
-	if (atomic64_try_cmpxchg(&volume->update_time, &old, new)) {
+	if (cur =3D=3D old) {
 		if (reason =3D=3D afs_cb_break_for_update_regress) {
 			atomic_inc(&volume->cb_scrub);
 			trace_afs_cb_v_break(volume->vid, 0, reason);
 		}
+		volume->update_time =3D new;
+	}
+}
+
+static int afs_update_volume_times(struct afs_operation *op, struct afs_v=
olume *volume)
+{
+	int ret =3D 0;
+
+	if (likely(op->volsync.creation =3D=3D volume->creation_time &&
+		   op->volsync.update =3D=3D volume->update_time))
+		return 0;
+
+	mutex_lock(&volume->volsync_lock);
+	if (op->volsync.creation !=3D volume->creation_time) {
+		ret =3D afs_update_volume_creation_time(op, volume);
+		if (ret < 0)
+			goto out;
 	}
+	if (op->volsync.update !=3D volume->update_time)
+		afs_update_volume_update_time(op, volume);
+out:
+	mutex_unlock(&volume->volsync_lock);
+	return ret;
 }
 =

 /*
  * Update the state of a volume, including recording the expiration time =
of the
- * callback promise.
+ * callback promise.  Returns 1 to redo the operation from the start.
  */
-void afs_update_volume_state(struct afs_operation *op, struct afs_vnode_p=
aram *vp)
+int afs_update_volume_state(struct afs_operation *op)
 {
 	struct afs_server_list *slist =3D op->server_list;
 	struct afs_server_entry *se =3D &slist->servers[op->server_index];
-	struct afs_callback *cb =3D &vp->scb.callback;
+	struct afs_callback *cb =3D &op->file[0].scb.callback;
 	struct afs_volume *volume =3D op->volume;
 	unsigned int cb_v_break =3D atomic_read(&volume->cb_v_break);
 	unsigned int cb_v_check =3D atomic_read(&volume->cb_v_check);
+	int ret;
 =

 	_enter("%llx", op->volume->vid);
 =

-	if (op->volsync.mask & AFS_VOLSYNC_CREATION)
-		afs_update_volume_creation_time(op, volume);
-	if (op->volsync.mask & AFS_VOLSYNC_UPDATE)
-		afs_update_volume_update_time(op, volume);
+	if (op->volsync.creation !=3D TIME64_MIN || op->volsync.update !=3D TIME=
64_MIN) {
+		ret =3D afs_update_volume_times(op, volume);
+		if (ret !=3D 0) {
+			_leave(" =3D %d", ret);
+			return ret;
+		}
+	}
 =

 	if (op->cb_v_break =3D=3D cb_v_break) {
 		se->cb_expires_at =3D cb->expires_at;
@@ -249,6 +339,8 @@ void afs_update_volume_state(struct afs_operation *op,=
 struct afs_vnode_param *v
 	}
 	if (cb_v_check < op->cb_v_break)
 		atomic_cmpxchg(&volume->cb_v_check, cb_v_check, op->cb_v_break);
+	_leave(" =3D %d", ret);
+	return ret;
 }
 =

 /*
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index cef02a265edc..cac75f89b64a 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -18,8 +18,7 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs=
_call *call)
 {
 	struct afs_uvldbentry__xdr *uvldb;
 	struct afs_vldb_entry *entry;
-	bool new_only =3D false;
-	u32 tmp, nr_servers, vlflags;
+	u32 nr_servers, vlflags;
 	int i, ret;
 =

 	_enter("");
@@ -41,27 +40,14 @@ static int afs_deliver_vl_get_entry_by_name_u(struct a=
fs_call *call)
 	entry->name[i] =3D 0;
 	entry->name_len =3D strlen(entry->name);
 =

-	/* If there is a new replication site that we can use, ignore all the
-	 * sites that aren't marked as new.
-	 */
-	for (i =3D 0; i < nr_servers; i++) {
-		tmp =3D ntohl(uvldb->serverFlags[i]);
-		if (!(tmp & AFS_VLSF_DONTUSE) &&
-		    (tmp & AFS_VLSF_NEWREPSITE))
-			new_only =3D true;
-	}
-
 	vlflags =3D ntohl(uvldb->flags);
 	for (i =3D 0; i < nr_servers; i++) {
 		struct afs_uuid__xdr *xdr;
 		struct afs_uuid *uuid;
+		u32 tmp =3D ntohl(uvldb->serverFlags[i]);
 		int j;
 		int n =3D entry->nr_servers;
 =

-		tmp =3D ntohl(uvldb->serverFlags[i]);
-		if (tmp & AFS_VLSF_DONTUSE ||
-		    (new_only && !(tmp & AFS_VLSF_NEWREPSITE)))
-			continue;
 		if (tmp & AFS_VLSF_RWVOL) {
 			entry->fs_mask[n] |=3D AFS_VOL_VTM_RW;
 			if (vlflags & AFS_VLF_BACKEXISTS)
@@ -82,6 +68,7 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs=
_call *call)
 		for (j =3D 0; j < 6; j++)
 			uuid->node[j] =3D (u8)ntohl(xdr->node[j]);
 =

+		entry->vlsf_flags[n] =3D tmp;
 		entry->addr_version[n] =3D ntohl(uvldb->serverUnique[i]);
 		entry->nr_servers++;
 	}
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index aebdeeed450a..fd5478e792da 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -84,11 +84,15 @@ static struct afs_volume *afs_alloc_volume(struct afs_=
fs_context *params,
 	volume->type		=3D params->type;
 	volume->type_force	=3D params->force;
 	volume->name_len	=3D vldb->name_len;
+	volume->creation_time	=3D TIME64_MIN;
+	volume->update_time	=3D TIME64_MIN;
 =

 	refcount_set(&volume->ref, 1);
 	INIT_HLIST_NODE(&volume->proc_link);
 	INIT_WORK(&volume->destructor, afs_destroy_volume);
 	rwlock_init(&volume->servers_lock);
+	mutex_init(&volume->volsync_lock);
+	mutex_init(&volume->cb_check_lock);
 	rwlock_init(&volume->cb_v_break_lock);
 	INIT_LIST_HEAD(&volume->open_mmaps);
 	init_rwsem(&volume->open_mmaps_lock);
@@ -388,7 +392,11 @@ static int afs_update_volume_status(struct afs_volume=
 *volume, struct key *key)
 		discard =3D old;
 	}
 =

-	volume->update_at =3D ktime_get_real_seconds() + afs_volume_record_life;
+	/* Check more often if replication is ongoing. */
+	if (new->ro_replicating)
+		volume->update_at =3D ktime_get_real_seconds() + 2;
+	else
+		volume->update_at =3D ktime_get_real_seconds() + afs_volume_record_life=
;
 	write_unlock(&volume->servers_lock);
 =

 	if (discard =3D=3D old)
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 7c013070ef51..2d6943f05ea5 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -254,7 +254,6 @@ static void xdr_decode_YFSVolSync(const __be32 **_bp,
 		update =3D xdr_to_u64(x->vol_update_date);
 		do_div(update, 10 * 1000 * 1000);
 		volsync->update =3D update;
-		volsync->mask |=3D AFS_VOLSYNC_CREATION | AFS_VOLSYNC_UPDATE;
 	}
 =

 	*_bp +=3D xdr_size(x);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index ac50fa687429..b2e0847eca47 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -442,7 +442,8 @@ enum yfs_cm_operation {
 	EM(afs_cb_break_for_unlink,		"break-unlink")		\
 	EM(afs_cb_break_for_update_regress,	"update-regress")	\
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
-	E_(afs_cb_break_for_vos_release,	"break-vos-release")
+	EM(afs_cb_break_for_vos_release,	"break-vos-release")	\
+	E_(afs_cb_break_volume_excluded,	"vol-excluded")
 =

 #define afs_rotate_traces						\
 	EM(afs_rotate_trace_aborted,		"Abortd")		\



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB89403D22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352299AbhIHP7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352252AbhIHP7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umnOPP3wuPqJ4/IcEu6lL2yfkaooZvqD8mts8Av1pEQ=;
        b=aPlHgm9gqQu/y141zRntiAWTmUa2m4BdnzNr0wfueShFHxeW4tY1baj7P83LgQCXDUVOdY
        smuCHwy7718vl4h9WP7MiNabMS/rUQAYTHyndLsZmVEioR8Okh1rv4HIGBpCHJTgW3BHUG
        mOnNhLWXvKpsRRpM0v7rYcIrhAd0tM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-JhXDpMsAMQCXK07DN7Hr3A-1; Wed, 08 Sep 2021 11:58:19 -0400
X-MC-Unique: JhXDpMsAMQCXK07DN7Hr3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A2184A5E3;
        Wed,  8 Sep 2021 15:58:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A46DD5D9C6;
        Wed,  8 Sep 2021 15:58:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/6] afs: Try to avoid taking RCU read lock when checking
 vnode validity
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, markus.suvanto@gmail.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:58:15 +0100
Message-ID: <163111669583.283156.1397603105683094563.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Try to avoid taking the RCU read lock when checking the validity of a
vnode's callback state.  The only thing it's needed for is to pin the
parent volume's server list whilst we search it to find the record of the
server we're currently using to see if it has been reinitialised (ie. it
sent us a CB.InitCallBackState* RPC).

Do this by the following means:

 (1) Keep an additional per-cell counter (fs_s_break) that's incremented
     each time any of the fileservers in the cell reinitialises.

     Since the new counter can be accessed without RCU from the vnode, we
     can check that first - and only if it differs, get the RCU read lock
     and check the volume's server list.

 (2) Replace afs_get_s_break_rcu() with afs_check_server_good() which now
     indicates whether the callback promise is still expected to be present
     on the server.  This does the checks as described in (1).

 (3) Restructure afs_check_validity() to take account of the change in (2).

     We can also get rid of the valid variable and just use the need_clear
     variable with the addition of the afs_cb_break_no_promise reason.

 (4) afs_check_validity() probably shouldn't be altering vnode->cb_v_break
     and vnode->cb_s_break when it doesn't have cb_lock exclusively locked.

     Move the change to vnode->cb_v_break to __afs_break_callback().

     Delegate the change to vnode->cb_s_break to afs_select_fileserver()
     and set vnode->cb_fs_s_break there also.

 (5) afs_validate() no longer needs to get the RCU read lock around its call
     to afs_check_validity() - and can skip the call entirely if we don't have
     a promise.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/callback.c          |    2 +
 fs/afs/inode.c             |   88 ++++++++++++++++++++++----------------------
 fs/afs/internal.h          |    2 +
 fs/afs/rotate.c            |    1 +
 include/trace/events/afs.h |    8 +++-
 5 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 1dd7543dbf9f..1b4d5809808d 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -60,6 +60,7 @@ void afs_init_callback_state(struct afs_server *server)
 	rcu_read_lock();
 	do {
 		server->cb_s_break++;
+		atomic_inc(&server->cell->fs_s_break);
 		if (!list_empty(&server->cell->fs_open_mmaps))
 			queue_work(system_unbound_wq, &server->initcb_work);
 
@@ -77,6 +78,7 @@ void __afs_break_callback(struct afs_vnode *vnode, enum afs_cb_break_reason reas
 	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		vnode->cb_break++;
+		vnode->cb_v_break = vnode->volume->cb_v_break;
 		afs_clear_permits(vnode);
 
 		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 80b6c8d967d5..126daf9969db 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -587,22 +587,32 @@ static void afs_zap_data(struct afs_vnode *vnode)
 }
 
 /*
- * Get the server reinit counter for a vnode's current server.
+ * Check to see if we have a server currently serving this volume and that it
+ * hasn't been reinitialised or dropped from the list.
  */
-static bool afs_get_s_break_rcu(struct afs_vnode *vnode, unsigned int *_s_break)
+static bool afs_check_server_good(struct afs_vnode *vnode)
 {
-	struct afs_server_list *slist = rcu_dereference(vnode->volume->servers);
+	struct afs_server_list *slist;
 	struct afs_server *server;
+	bool good;
 	int i;
 
+	if (vnode->cb_fs_s_break == atomic_read(&vnode->volume->cell->fs_s_break))
+		return true;
+
+	rcu_read_lock();
+
+	slist = rcu_dereference(vnode->volume->servers);
 	for (i = 0; i < slist->nr_servers; i++) {
 		server = slist->servers[i].server;
 		if (server == vnode->cb_server) {
-			*_s_break = READ_ONCE(server->cb_s_break);
-			return true;
+			good = (vnode->cb_s_break == server->cb_s_break);
+			rcu_read_unlock();
+			return good;
 		}
 	}
 
+	rcu_read_unlock();
 	return false;
 }
 
@@ -611,57 +621,46 @@ static bool afs_get_s_break_rcu(struct afs_vnode *vnode, unsigned int *_s_break)
  */
 bool afs_check_validity(struct afs_vnode *vnode)
 {
-	struct afs_volume *volume = vnode->volume;
 	enum afs_cb_break_reason need_clear = afs_cb_break_no_break;
 	time64_t now = ktime_get_real_seconds();
-	bool valid;
-	unsigned int cb_break, cb_s_break, cb_v_break;
+	unsigned int cb_break;
 	int seq = 0;
 
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
-		cb_v_break = READ_ONCE(volume->cb_v_break);
 		cb_break = vnode->cb_break;
 
-		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
-		    afs_get_s_break_rcu(vnode, &cb_s_break)) {
-			if (vnode->cb_s_break != cb_s_break ||
-			    vnode->cb_v_break != cb_v_break) {
-				vnode->cb_s_break = cb_s_break;
-				vnode->cb_v_break = cb_v_break;
-				need_clear = afs_cb_break_for_vsbreak;
-				valid = false;
-			} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
+		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+			if (vnode->cb_v_break != vnode->volume->cb_v_break)
+				need_clear = afs_cb_break_for_v_break;
+			else if (!afs_check_server_good(vnode))
+				need_clear = afs_cb_break_for_s_reinit;
+			else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
 				need_clear = afs_cb_break_for_zap;
-				valid = false;
-			} else if (vnode->cb_expires_at - 10 <= now) {
+			else if (vnode->cb_expires_at - 10 <= now)
 				need_clear = afs_cb_break_for_lapsed;
-				valid = false;
-			} else {
-				valid = true;
-			}
 		} else if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-			valid = true;
+			;
 		} else {
-			vnode->cb_v_break = cb_v_break;
-			valid = false;
+			need_clear = afs_cb_break_no_promise;
 		}
 
 	} while (need_seqretry(&vnode->cb_lock, seq));
 
 	done_seqretry(&vnode->cb_lock, seq);
 
-	if (need_clear != afs_cb_break_no_break) {
-		write_seqlock(&vnode->cb_lock);
-		if (cb_break == vnode->cb_break)
-			__afs_break_callback(vnode, need_clear);
-		else
-			trace_afs_cb_miss(&vnode->fid, need_clear);
-		write_sequnlock(&vnode->cb_lock);
-		valid = false;
-	}
+	if (need_clear == afs_cb_break_no_break)
+		return true;
 
-	return valid;
+	write_seqlock(&vnode->cb_lock);
+	if (need_clear == afs_cb_break_no_promise)
+		vnode->cb_v_break = vnode->volume->cb_v_break;
+	else if (cb_break == vnode->cb_break)
+		__afs_break_callback(vnode, need_clear);
+	else
+		trace_afs_cb_miss(&vnode->fid, need_clear);
+	write_sequnlock(&vnode->cb_lock);
+	return false;
 }
 
 /*
@@ -675,21 +674,20 @@ bool afs_check_validity(struct afs_vnode *vnode)
  */
 int afs_validate(struct afs_vnode *vnode, struct key *key)
 {
-	bool valid;
 	int ret;
 
 	_enter("{v={%llx:%llu} fl=%lx},%x",
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
 	       key_serial(key));
 
-	rcu_read_lock();
-	valid = afs_check_validity(vnode);
-	rcu_read_unlock();
-
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
-		clear_nlink(&vnode->vfs_inode);
+	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
+		if (vnode->vfs_inode.i_nlink)
+			clear_nlink(&vnode->vfs_inode);
+		goto valid;
+	}
 
-	if (valid)
+	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags) &&
+	    afs_check_validity(vnode))
 		goto valid;
 
 	down_write(&vnode->validate_lock);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0deeb76c67d0..c97618855b46 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -392,6 +392,7 @@ struct afs_cell {
 	seqlock_t		fs_lock;	/* For fs_servers  */
 	struct rw_semaphore	fs_open_mmaps_lock;
 	struct list_head	fs_open_mmaps;	/* List of vnodes that are mmapped */
+	atomic_t		fs_s_break;	/* Counter of CB.InitCallBackState messages */
 
 	/* VL server list. */
 	rwlock_t		vl_servers_lock; /* Lock on vl_servers */
@@ -664,6 +665,7 @@ struct afs_vnode {
 	struct list_head	cb_mmap_link;	/* Link in cell->fs_open_mmaps */
 	void			*cb_server;	/* Server with callback/filelock */
 	atomic_t		cb_nr_mmap;	/* Number of mmaps */
+	unsigned int		cb_fs_s_break;	/* Mass server break counter (cell->fs_s_break) */
 	unsigned int		cb_s_break;	/* Mass break counter on ->server */
 	unsigned int		cb_v_break;	/* Mass break counter on ->volume */
 	unsigned int		cb_break;	/* Break counter on vnode */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index d83f13c44b92..79e1a5f6701b 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -374,6 +374,7 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (vnode->cb_server != server) {
 		vnode->cb_server = server;
 		vnode->cb_s_break = server->cb_s_break;
+		vnode->cb_fs_s_break = atomic_read(&server->cell->fs_s_break);
 		vnode->cb_v_break = vnode->volume->cb_v_break;
 		clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 9f73ed2cf061..bca73e8c8cde 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -306,11 +306,13 @@ enum afs_flock_operation {
 
 enum afs_cb_break_reason {
 	afs_cb_break_no_break,
+	afs_cb_break_no_promise,
 	afs_cb_break_for_callback,
 	afs_cb_break_for_deleted,
 	afs_cb_break_for_lapsed,
+	afs_cb_break_for_s_reinit,
 	afs_cb_break_for_unlink,
-	afs_cb_break_for_vsbreak,
+	afs_cb_break_for_v_break,
 	afs_cb_break_for_volume_callback,
 	afs_cb_break_for_zap,
 };
@@ -602,11 +604,13 @@ enum afs_cb_break_reason {
 
 #define afs_cb_break_reasons						\
 	EM(afs_cb_break_no_break,		"no-break")		\
+	EM(afs_cb_break_no_promise,		"no-promise")		\
 	EM(afs_cb_break_for_callback,		"break-cb")		\
 	EM(afs_cb_break_for_deleted,		"break-del")		\
 	EM(afs_cb_break_for_lapsed,		"break-lapsed")		\
+	EM(afs_cb_break_for_s_reinit,		"s-reinit")		\
 	EM(afs_cb_break_for_unlink,		"break-unlink")		\
-	EM(afs_cb_break_for_vsbreak,		"break-vs")		\
+	EM(afs_cb_break_for_v_break,		"break-v")		\
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
 	E_(afs_cb_break_for_zap,		"break-zap")
 



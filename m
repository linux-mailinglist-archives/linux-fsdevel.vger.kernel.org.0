Return-Path: <linux-fsdevel+bounces-70066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF25C8FB4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39B63AD8A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04D2E1F02;
	Thu, 27 Nov 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNJSpG9R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WVrpb4dk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNJSpG9R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WVrpb4dk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4762EB860
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264675; cv=none; b=LCUWVjaEpp9d5rLfiQlgpLLPH7Whwlv/ARJ9PQbrfBqx/5dHh2NodyL5wRNWf17vXYGixjZ3upr4UsTrCKADJlsVdIa4+PLfeQ9xuHJJJlp0UNCWZCBbXi1FSr2O8tjwIWEmsXxcjAi6z01BpAg0sIOT6ljhN2zUZ7Y/iU5ZkOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264675; c=relaxed/simple;
	bh=vIUAtcsLo24bbQFQcALXofBB1BnQeY6XkvcvDuzovoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmJM2jj4j2XBdsPk1ldTMkkAbzWvEbZ+17kp2Pgk/6vL+d5iqDiWk9AsAuCbowlKSzmS/wZitJD6P6rqkPLPfg47GS4Ew236XtUNZe/RbJiswaf+/uy2I7POfEwlX2kb/V9UUW+MFmEn2pvwyFcHPz1z/l0mzTuguD0d6Ht3WjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNJSpG9R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WVrpb4dk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNJSpG9R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WVrpb4dk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FE343369C;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3u422oz/g3qK/ChnW4gvgosdSUwAe0z94bSHJYVAGc=;
	b=KNJSpG9RfSrtNZnDDDxpgRnSxiUAvA0vFMLGoThld8J1BrAkN8+vBxSgP0lFv3o4n1oTT4
	pvLK6OEp+6SEQTv9uWDNG2cUtQ2vAOJUcPxzYHwB3HXgdHe00iVqr46XDEDcwkWZiQMvdp
	W9MVyYKRMcd8FbjVy+CGdLnVA8UIf5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3u422oz/g3qK/ChnW4gvgosdSUwAe0z94bSHJYVAGc=;
	b=WVrpb4dkv1J6HcTgNhD7HaVwj8iUYc4mFRjOIutdwwydTGnuWiwF1q8P69t8anNXZo3asU
	wd0wl7nuUwKvCrBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3u422oz/g3qK/ChnW4gvgosdSUwAe0z94bSHJYVAGc=;
	b=KNJSpG9RfSrtNZnDDDxpgRnSxiUAvA0vFMLGoThld8J1BrAkN8+vBxSgP0lFv3o4n1oTT4
	pvLK6OEp+6SEQTv9uWDNG2cUtQ2vAOJUcPxzYHwB3HXgdHe00iVqr46XDEDcwkWZiQMvdp
	W9MVyYKRMcd8FbjVy+CGdLnVA8UIf5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3u422oz/g3qK/ChnW4gvgosdSUwAe0z94bSHJYVAGc=;
	b=WVrpb4dkv1J6HcTgNhD7HaVwj8iUYc4mFRjOIutdwwydTGnuWiwF1q8P69t8anNXZo3asU
	wd0wl7nuUwKvCrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A9AB3EA6E;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JaODHbKKKGmWPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50F6EA0CB0; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/13] fsnotify: Stop holding inode references from inode mark connectors
Date: Thu, 27 Nov 2025 18:30:17 +0100
Message-ID: <20251127173012.23500-23-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15120; i=jack@suse.cz; h=from:subject; bh=vIUAtcsLo24bbQFQcALXofBB1BnQeY6XkvcvDuzovoU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqs4nawIOUrUrBfqfzB2V5TUv7KAvQeLXC+3 D1xLDKEZY6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKrAAKCRCcnaoHP2RA 2dOICACQJ9XU/Cp0QWYGW7DuKWCbHgdbsnemxtuXNZ35LAIamJUgv0GpuDZMNiYWfTW3MdGZJCe 9WhSIdcNwzQ5hQUiYx+thjIvctWKLWuB8Uq36R/P8mU6vEwJXNgQyGt3OsVsj/8QTbUjjrmDPUW rKcY4X9pTqEiatlyJu7Vhha/pxlx4RzkJIfET0pVjo9dLRk10lmK0bRTAcWFR0CVruOHPQr67L4 HZe6PtsGxvboJv8shL8CTIhKFYHHyhf6D5L7riV9ep6vtGiR9UnpuTH/DmSrajxGi35IRElXxDl 3unXZIdX1COJBBT9FPFa6xFB2AJ81NxpjkGegqeM3KMhPjDo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Currently inode mark connectors hold reference to inode thus keeping it
pinned in memory. Now that we have infrastructure to keep inode marks in
a separate hash and reconnect them to inode on lookup there's no need
for this pinning anymore. Remove it so that reclaim can evict inodes
with notification marks thus significantly reducing effective memory
footprint of inode notification marks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                       |   2 +-
 fs/notify/fsnotify.c             |  20 +++-
 fs/notify/fsnotify.h             |   5 +
 fs/notify/mark.c                 | 157 +++++++++----------------------
 include/linux/fsnotify.h         |   6 +-
 include/linux/fsnotify_backend.h |   7 +-
 6 files changed, 76 insertions(+), 121 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9f9507eea645..196c727365db 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -369,7 +369,7 @@ void __destroy_inode(struct inode *inode)
 	BUG_ON(inode_has_buffers(inode));
 	inode_detach_wb(inode);
 	security_inode_free(inode);
-	fsnotify_inode_delete(inode);
+	fsnotify_inode_evict(inode);
 	locks_free_lock_context(inode);
 	if (!inode->i_nlink) {
 		WARN_ON(atomic_long_read(&inode->i_sb->s_remove_count) == 0);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 6e4da46c10ad..5ee94a6d9422 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -14,8 +14,13 @@
 #include <linux/fsnotify_backend.h>
 #include "fsnotify.h"
 
+void __fsnotify_inode_evict(struct inode *inode)
+{
+	fsnotify_detach_marks(&inode->i_fsnotify_marks);
+}
+
 /*
- * Clear all of the marks on an inode when it is being evicted from core
+ * Clear all of the marks on an inode when it is being deleted
  */
 void __fsnotify_inode_delete(struct inode *inode)
 {
@@ -60,7 +65,8 @@ static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
 		spin_lock(&conn->lock);
 		/* Connector got detached before we grabbed conn->lock? */
 		if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED) {
-			spin_unlock(&conn->lock);
+			/* drops conn->lock... */
+			__fsnotify_destroy_marks(conn);
 			continue;
 		}
 		inode = conn->obj;
@@ -68,7 +74,15 @@ static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
 		spin_unlock(&conn->lock);
 		rhashtable_walk_stop(&iter);
 		fsnotify_inode(inode, FS_UNMOUNT);
-		fsnotify_destroy_marks(&inode->i_fsnotify_marks);
+		/*
+		 * Now when notifications are sent, we can destroy marks.
+		 * The connector can be detached by now but since we held
+		 * fsnotify_mark_srcu all the time, the connector still has to
+		 * be allocated even though we could be racing with other
+		 * processes trying to destroy it.
+		 */
+		spin_lock(&conn->lock);
+		__fsnotify_destroy_marks(conn);
 		iput(inode);
 		cond_resched();
 		rhashtable_walk_start(&iter);
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index e9160c0e1a70..7e0f89a64516 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -79,8 +79,13 @@ extern struct srcu_struct fsnotify_mark_srcu;
 extern int fsnotify_compare_groups(struct fsnotify_group *a,
 				   struct fsnotify_group *b);
 
+extern void __fsnotify_destroy_marks(struct fsnotify_mark_connector *conn);
 /* Destroy all marks attached to an object via connector */
 extern void fsnotify_destroy_marks(fsnotify_connp_t *connp);
+
+/* Detach marks from object but keep them alive (and connector hashed) */
+extern void fsnotify_detach_marks(fsnotify_connp_t *connp);
+
 /* run the list of all marks associated with inode and destroy them */
 static inline void fsnotify_clear_marks_by_inode(struct inode *inode)
 {
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 8fe7128f4122..c01c38244f30 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -49,9 +49,9 @@
  * refcnt==0. Marks are also protected by fsnotify_mark_srcu.
  *
  * The inode mark can be cleared for a number of different reasons including:
- * - The inode is unlinked for the last time.  (fsnotify_inode_remove)
- * - The inode is being evicted from cache. (fsnotify_inode_delete)
- * - The fs the inode is on is unmounted.  (fsnotify_inode_delete/fsnotify_unmount_inodes)
+ * - The inode is unlinked for the last time.  (__fsnotify_inode_delete)
+ * - The inode is being evicted from cache. (fsnotify_inode_evict)
+ * - The fs the inode is on is unmounted.  (__fsnotify_inode_delete/fsnotify_unmount_inodes)
  * - Something explicitly requests that it be removed.  (fsnotify_destroy_mark)
  * - The fsnotify_group associated with the mark is going away and all such marks
  *   need to be cleaned up. (fsnotify_clear_marks_by_group)
@@ -148,21 +148,6 @@ static void fsnotify_put_sb_watched_objects(struct fsnotify_sb_info *sbinfo)
 	atomic_long_dec(&sbinfo->watched_objects[0]);
 }
 
-static void fsnotify_get_inode_ref(struct inode *inode)
-{
-	ihold(inode);
-	fsnotify_get_sb_watched_objects(fsnotify_sb_info(inode->i_sb));
-}
-
-static void fsnotify_put_inode_ref(struct inode *inode)
-{
-	/* read ->i_sb before the inode can go away */
-	struct super_block *sb = inode->i_sb;
-
-	iput(inode);
-	fsnotify_put_sb_watched_objects(fsnotify_sb_info(sb));
-}
-
 /*
  * Grab or drop watched objects reference depending on whether the connector
  * is attached and has any marks attached.
@@ -205,62 +190,25 @@ static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn)
 	}
 }
 
-/*
- * Grab or drop inode reference for the connector if needed.
- *
- * When it's time to drop the reference, we only clear the HAS_IREF flag and
- * return the inode object. fsnotify_drop_object() will be resonsible for doing
- * iput() outside of spinlocks. This happens when last mark that wanted iref is
- * detached.
- */
-static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
-					  bool want_iref)
-{
-	bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
-	struct inode *inode = NULL;
-
-	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE ||
-	    want_iref == has_iref)
-		return NULL;
-
-	if (want_iref) {
-		/* Pin inode if any mark wants inode refcount held */
-		fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
-		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
-	} else {
-		/* Unpin inode after detach of last mark that wanted iref */
-		inode = fsnotify_conn_inode(conn);
-		conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
-	}
-
-	return inode;
-}
-
-static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
+static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	u32 new_mask = 0;
-	bool want_iref = false;
 	struct fsnotify_mark *mark;
 
 	assert_spin_locked(&conn->lock);
 	/* We can get detached connector here when inode is getting unlinked. */
 	if (!fsnotify_valid_obj_type(conn->type))
-		return NULL;
+		return;
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
 		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
 			continue;
 		new_mask |= fsnotify_calc_mask(mark);
-		if (conn->type == FSNOTIFY_OBJ_TYPE_INODE &&
-		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
-			want_iref = true;
 	}
 	/*
 	 * We use WRITE_ONCE() to prevent silly compiler optimizations from
 	 * confusing readers not holding conn->lock with partial updates.
 	 */
 	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
-
-	return fsnotify_update_iref(conn, want_iref);
 }
 
 static bool fsnotify_conn_watches_children(
@@ -326,41 +274,21 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static void *fsnotify_detach_connector_from_object(
-					struct fsnotify_mark_connector *conn,
-					unsigned int *type)
+static void fsnotify_detach_connector_from_object(
+					struct fsnotify_mark_connector *conn)
 {
 	fsnotify_connp_t *connp = fsnotify_object_connp(conn->obj, conn->type);
 	struct super_block *sb = fsnotify_connector_sb(conn);
-	struct inode *inode = NULL;
 
-	*type = conn->type;
 	if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED)
-		return NULL;
-
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
-		inode = fsnotify_conn_inode(conn);
-		inode->i_fsnotify_mask = 0;
-		fsnotify_unhash_connector(conn);
-
-		/* Unpin inode when detaching from connector */
-		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
-			inode = NULL;
-	} else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
-		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
-	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
-		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
-	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
-		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
-	}
+		return;
 
+	*fsnotify_conn_mask_p(conn) = 0;
 	rcu_assign_pointer(*connp, NULL);
 	/* We make detached connectors point to the superblock */
 	conn->obj = sb;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
 	fsnotify_update_sb_watchers(conn);
-
-	return inode;
 }
 
 static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
@@ -373,17 +301,6 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
 	fsnotify_put_group(group);
 }
 
-/* Drop object reference originally held by a connector */
-static void fsnotify_drop_object(unsigned int type, void *objp)
-{
-	if (!objp)
-		return;
-	/* Currently only inode references are passed to be dropped */
-	if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
-		return;
-	fsnotify_put_inode_ref(objp);
-}
-
 static void fsnotify_free_connector(struct fsnotify_mark_connector *conn)
 {
 	struct fsnotify_sb_info *sbinfo =
@@ -401,8 +318,6 @@ static void fsnotify_free_connector(struct fsnotify_mark_connector *conn)
 void fsnotify_put_mark(struct fsnotify_mark *mark)
 {
 	struct fsnotify_mark_connector *conn = READ_ONCE(mark->connector);
-	void *objp = NULL;
-	unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
 	bool free_conn = false;
 
 	/* Catch marks that were actually never attached to object */
@@ -421,20 +336,18 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 
 	hlist_del_init_rcu(&mark->obj_list);
 	if (hlist_empty(&conn->list)) {
-		objp = fsnotify_detach_connector_from_object(conn, &type);
+		fsnotify_unhash_connector(conn);
+		fsnotify_detach_connector_from_object(conn);
 		free_conn = true;
 	} else {
 		/* Update watched objects after detaching mark */
 		if (conn->type != FSNOTIFY_OBJ_TYPE_DETACHED)
 			fsnotify_update_sb_watchers(conn);
-		objp = __fsnotify_recalc_mask(conn);
-		type = conn->type;
+		__fsnotify_recalc_mask(conn);
 	}
 	WRITE_ONCE(mark->connector, NULL);
 	spin_unlock(&conn->lock);
 
-	fsnotify_drop_object(type, objp);
-
 	if (free_conn)
 		fsnotify_free_connector(conn);
 	/*
@@ -1093,17 +1006,11 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	}
 }
 
-/* Destroy all marks attached to an object via connector */
-void fsnotify_destroy_marks(fsnotify_connp_t *connp)
+void __fsnotify_destroy_marks(struct fsnotify_mark_connector *conn)
+	__releases(conn->lock)
 {
-	struct fsnotify_mark_connector *conn;
 	struct fsnotify_mark *mark, *old_mark = NULL;
-	void *objp;
-	unsigned int type;
 
-	conn = fsnotify_grab_connector(connp);
-	if (!conn)
-		return;
 	/*
 	 * We have to be careful since we can race with e.g.
 	 * fsnotify_clear_marks_by_group() and once we drop the conn->lock, the
@@ -1121,15 +1028,41 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 		spin_lock(&conn->lock);
 	}
 	/*
-	 * Detach list from object now so that we don't pin inode until all
-	 * mark references get dropped. It would lead to strange results such
-	 * as delaying inode deletion or blocking unmount.
+	 * The inode is being deleted but the connector will stay alive until
+	 * all mark references are dropped. Unhash it so that it cannot get
+	 * associated with newly allocated inode with the same identifier.
 	 */
-	objp = fsnotify_detach_connector_from_object(conn, &type);
+	fsnotify_unhash_connector(conn);
+	/*
+	 * Detach list from object now so that the object can get freed before
+	 * all mark references are dropped.
+	 */
+	fsnotify_detach_connector_from_object(conn);
 	spin_unlock(&conn->lock);
 	if (old_mark)
 		fsnotify_put_mark(old_mark);
-	fsnotify_drop_object(type, objp);
+}
+
+/* Destroy all marks attached to an object via connector */
+void fsnotify_destroy_marks(fsnotify_connp_t *connp)
+{
+	struct fsnotify_mark_connector *conn;
+
+	conn = fsnotify_grab_connector(connp);
+	if (conn)
+		__fsnotify_destroy_marks(conn);
+}
+
+/* Detach marks from object but keep them alive (and connector hashed) */
+void fsnotify_detach_marks(fsnotify_connp_t *connp)
+{
+	struct fsnotify_mark_connector *conn;
+
+	conn = fsnotify_grab_connector(connp);
+	if (!conn)
+		return;
+	fsnotify_detach_connector_from_object(conn);
+	spin_unlock(&conn->lock);
 }
 
 /*
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 2f94809cca2a..b3ab48079987 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -289,11 +289,11 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 }
 
 /*
- * fsnotify_inode_delete - and inode is being evicted from cache, clean up is needed
+ * fsnotify_inode_evict - an inode is being evicted from cache, clean up is needed
  */
-static inline void fsnotify_inode_delete(struct inode *inode)
+static inline void fsnotify_inode_evict(struct inode *inode)
 {
-	__fsnotify_inode_delete(inode);
+	__fsnotify_inode_evict(inode);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 267c6587af97..c7ca848f576c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -544,8 +544,7 @@ struct fsnotify_mark_connector {
 	unsigned char type;	/* Type of object [lock] */
 	unsigned char prio;	/* Highest priority group */
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
-#define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
-#define FSNOTIFY_CONN_FLAG_HASHED	0x04
+#define FSNOTIFY_CONN_FLAG_HASHED	0x02
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
@@ -647,6 +646,7 @@ extern int fsnotify(__u32 mask, const void *data, int data_type,
 extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 			   int data_type);
 extern void __fsnotify_inode_delete(struct inode *inode);
+extern void __fsnotify_inode_evict(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
 extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
@@ -952,6 +952,9 @@ static inline int __fsnotify_parent(struct dentry *dentry, __u32 mask,
 static inline void __fsnotify_inode_delete(struct inode *inode)
 {}
 
+static inline void __fsnotify_inode_evict(struct inode *inode)
+{}
+
 static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 {}
 
-- 
2.51.0



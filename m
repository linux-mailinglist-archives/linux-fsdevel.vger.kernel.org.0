Return-Path: <linux-fsdevel+bounces-74505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5344D3B49A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9A4F3044890
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E931D72E;
	Mon, 19 Jan 2026 17:14:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9B1F03D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842852; cv=none; b=Q+A8BKqR5/upe4VgOM5vvSbFpGYwEwdAw3yQZcHjk6vVIexoMaNPkF1icAv6MgWaj1aKXYb2JyHm8PLP0jjKOfD9h9LfUismAcBuBgsu9dcWwkmQqv1NJGL+DMAaAfgizAoJWZ4Qf1IYkf1b25aZqMgK5iNvXR5T2MUUTu8OPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842852; c=relaxed/simple;
	bh=nkzo74mAJaBszmA75ZfQX9ltlr876JMCk24xChenvrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCAQ5EV4L9ptFhib7jW07o5La4jqAK9L43Oi9hz0A5i2C9jUzYgWlR2nQ4lwzPTvksvX8JuypcepJoVPnrCbG6E8lF+bIHFpgIWQNQS7TU2SVuSv+3h7kFpt87Ax0LIbz6Si2+eAkNPEaKLUct9xBsgN9PsGd8+7oqTkwLa90OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D93585BCC4;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDAFE3EA66;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ItILmBmbmmDJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 17:14:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5677DA09E9; Mon, 19 Jan 2026 18:14:08 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] fsnotify: Track inode connectors for a superblock
Date: Mon, 19 Jan 2026 18:13:38 +0100
Message-ID: <20260119171400.12006-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119161505.26187-1-jack@suse.cz>
References: <20260119161505.26187-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8630; i=jack@suse.cz; h=from:subject; bh=nkzo74mAJaBszmA75ZfQX9ltlr876JMCk24xChenvrA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpbmZYUQBiupB5/1m0m96El/7/OLP9N+dn0d0gR syoHDyG5fiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW5mWAAKCRCcnaoHP2RA 2YG+CADfWD0/QmWJ7YdNXWYhafAtiAUqugMRa7H6Lam2hfWCiYHpM86tBUYRxbjk4Lv2ALzLAf4 mJvd3HX5joABzB/haordl0ETRB2J5AvRup3enpVCL8tXe7rYZiqzobQoosN5WLXf+lSlZHRHZ3s nTPlxk6sjG0NcnFXbKUjw8v3CZyOjAcY3B44379Y0r9p9xWYgeuSclovu4lIa19MkuT1V321vdn KsvnnN2QVNhk4/qPaoHgpY4SMdSMTYGz+Eo7wKEMmBAvDajaUhxIMojVdKs4ze0O+N1ncTqwuLO ULwvs4hTt9IAfwIU+rEDLmrSvRbBc4GY4JNyCsmUa0d2hbwP
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: D93585BCC4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Introduce a linked list tracking all inode connectors for a superblock.
We will use this list when the superblock is getting shutdown to
properly clean up all the inode marks instead of relying on scanning all
inodes in the superblock which can get rather slow.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c             |  8 ++-
 fs/notify/fsnotify.h             |  5 +-
 fs/notify/mark.c                 | 97 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  6 +-
 4 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 71bd44e5ab6d..706484fb3bf3 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -112,7 +112,10 @@ void fsnotify_sb_delete(struct super_block *sb)
 
 void fsnotify_sb_free(struct super_block *sb)
 {
-	kfree(sb->s_fsnotify_info);
+	if (sb->s_fsnotify_info) {
+		WARN_ON_ONCE(!list_empty(&sb->s_fsnotify_info->inode_conn_list));
+		kfree(sb->s_fsnotify_info);
+	}
 }
 
 /*
@@ -777,8 +780,7 @@ static __init int fsnotify_init(void)
 	if (ret)
 		panic("initializing fsnotify_mark_srcu");
 
-	fsnotify_mark_connector_cachep = KMEM_CACHE(fsnotify_mark_connector,
-						    SLAB_PANIC);
+	fsnotify_init_connector_caches();
 
 	return 0;
 }
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 5950c7a67f41..4e271875dcad 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -67,6 +67,9 @@ static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *sb)
 	return sbinfo ? &sbinfo->sb_marks : NULL;
 }
 
+struct fsnotify_mark_connector *fsnotify_inode_connector_from_list(
+						struct list_head *head);
+
 /* destroy all events sitting in this groups notification queue */
 extern void fsnotify_flush_notify(struct fsnotify_group *group);
 
@@ -106,6 +109,6 @@ static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
  */
 extern void fsnotify_set_children_dentry_flags(struct inode *inode);
 
-extern struct kmem_cache *fsnotify_mark_connector_cachep;
+void fsnotify_init_connector_caches(void);
 
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 55a03bb05aa1..eb26bb8c5c63 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -79,7 +79,8 @@
 #define FSNOTIFY_REAPER_DELAY	(1)	/* 1 jiffy */
 
 struct srcu_struct fsnotify_mark_srcu;
-struct kmem_cache *fsnotify_mark_connector_cachep;
+static struct kmem_cache *fsnotify_mark_connector_cachep;
+static struct kmem_cache *fsnotify_inode_mark_connector_cachep;
 
 static DEFINE_SPINLOCK(destroy_lock);
 static LIST_HEAD(destroy_list);
@@ -323,10 +324,12 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	while (conn) {
 		free = conn;
 		conn = conn->destroy_next;
-		kmem_cache_free(fsnotify_mark_connector_cachep, free);
+		kfree(free);
 	}
 }
 
+static void fsnotify_untrack_connector(struct fsnotify_mark_connector *conn);
+
 static void *fsnotify_detach_connector_from_object(
 					struct fsnotify_mark_connector *conn,
 					unsigned int *type)
@@ -342,6 +345,7 @@ static void *fsnotify_detach_connector_from_object(
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
+		fsnotify_untrack_connector(conn);
 
 		/* Unpin inode when detaching from connector */
 		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
@@ -644,6 +648,8 @@ static int fsnotify_attach_info_to_sb(struct super_block *sb)
 	if (!sbinfo)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&sbinfo->inode_conn_list);
+	spin_lock_init(&sbinfo->list_lock);
 	/*
 	 * cmpxchg() provides the barrier so that callers of fsnotify_sb_info()
 	 * will observe an initialized structure
@@ -655,20 +661,83 @@ static int fsnotify_attach_info_to_sb(struct super_block *sb)
 	return 0;
 }
 
-static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       void *obj, unsigned int obj_type)
+struct fsnotify_inode_mark_connector {
+	struct fsnotify_mark_connector common;
+	struct list_head conns_list;
+};
+
+struct fsnotify_mark_connector *fsnotify_inode_connector_from_list(
+						struct list_head *head)
 {
-	struct fsnotify_mark_connector *conn;
+	return &list_entry(head, struct fsnotify_inode_mark_connector,
+			  conns_list)->common;
+}
 
-	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
-	if (!conn)
-		return -ENOMEM;
+static void fsnotify_init_connector(struct fsnotify_mark_connector *conn,
+				    void *obj, unsigned int obj_type)
+{
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
 	conn->flags = 0;
 	conn->prio = 0;
 	conn->type = obj_type;
 	conn->obj = obj;
+}
+
+static struct fsnotify_mark_connector *
+fsnotify_alloc_inode_connector(struct inode *inode)
+{
+	struct fsnotify_inode_mark_connector *iconn;
+	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(inode->i_sb);
+
+	iconn = kmem_cache_alloc(fsnotify_inode_mark_connector_cachep,
+				 GFP_KERNEL);
+	if (!iconn)
+		return NULL;
+
+	fsnotify_init_connector(&iconn->common, inode, FSNOTIFY_OBJ_TYPE_INODE);
+	spin_lock(&sbinfo->list_lock);
+	list_add(&iconn->conns_list, &sbinfo->inode_conn_list);
+	spin_unlock(&sbinfo->list_lock);
+	iconn->common.flags |= FSNOTIFY_CONN_FLAG_TRACKED;
+
+	return &iconn->common;
+}
+
+static void fsnotify_untrack_connector(struct fsnotify_mark_connector *conn)
+{
+	struct fsnotify_inode_mark_connector *iconn;
+	struct fsnotify_sb_info *sbinfo;
+
+	if (!(conn->flags & FSNOTIFY_CONN_FLAG_TRACKED))
+		return;
+
+	WARN_ON_ONCE(conn->type != FSNOTIFY_OBJ_TYPE_INODE);
+	iconn = container_of(conn, struct fsnotify_inode_mark_connector, common);
+	sbinfo = fsnotify_sb_info(fsnotify_conn_inode(conn)->i_sb);
+	spin_lock(&sbinfo->list_lock);
+	list_del(&iconn->conns_list);
+	spin_unlock(&sbinfo->list_lock);
+	conn->flags &= ~FSNOTIFY_CONN_FLAG_TRACKED;
+}
+
+static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
+					       void *obj, unsigned int obj_type)
+{
+	struct fsnotify_mark_connector *conn;
+
+	if (obj_type == FSNOTIFY_OBJ_TYPE_INODE) {
+		struct inode *inode = obj;
+
+		conn = fsnotify_alloc_inode_connector(inode);
+	} else {
+		conn = kmem_cache_alloc(fsnotify_mark_connector_cachep,
+					GFP_KERNEL);
+		if (conn)
+			fsnotify_init_connector(conn, obj, obj_type);
+	}
+	if (!conn)
+		return -ENOMEM;
 
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
@@ -676,7 +745,8 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
+		fsnotify_untrack_connector(conn);
+		kfree(conn);
 	}
 	return 0;
 }
@@ -1007,3 +1077,12 @@ void fsnotify_wait_marks_destroyed(void)
 	flush_delayed_work(&reaper_work);
 }
 EXPORT_SYMBOL_GPL(fsnotify_wait_marks_destroyed);
+
+__init void fsnotify_init_connector_caches(void)
+{
+	fsnotify_mark_connector_cachep = KMEM_CACHE(fsnotify_mark_connector,
+						    SLAB_PANIC);
+	fsnotify_inode_mark_connector_cachep = KMEM_CACHE(
+					fsnotify_inode_mark_connector,
+					SLAB_PANIC);
+}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0d954ea7b179..7f2157d06043 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -546,6 +546,7 @@ struct fsnotify_mark_connector {
 	unsigned char prio;	/* Highest priority group */
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
+#define FSNOTIFY_CONN_FLAG_TRACKED	0x04
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
@@ -553,7 +554,7 @@ struct fsnotify_mark_connector {
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
-	struct hlist_head list;
+	struct hlist_head list;	/* List of marks */
 };
 
 /*
@@ -562,6 +563,9 @@ struct fsnotify_mark_connector {
  */
 struct fsnotify_sb_info {
 	struct fsnotify_mark_connector __rcu *sb_marks;
+	/* List of connectors for inode marks */
+	struct list_head inode_conn_list;
+	spinlock_t list_lock;	/* Lock protecting inode_conn_list */
 	/*
 	 * Number of inode/mount/sb objects that are being watched in this sb.
 	 * Note that inodes objects are currently double-accounted.
-- 
2.51.0



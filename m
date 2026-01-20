Return-Path: <linux-fsdevel+bounces-74641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOoWHZxqcGkVXwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:56:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD0C51C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2B888881BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF3C42B73F;
	Tue, 20 Jan 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xkACMso0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aMMlX4em"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833523B531E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915412; cv=none; b=WYVIj3dc6BX1DCAsWdjit/iSQTC/KzMgQ80HfbEbfIgRadKyX+Y9DLLvAOWT57F24dHnQdWRC3qv0mGTf8IcFPmnmzRcp/L6PfLrtuLksc/SUDPUvhR8A+1jjsm2N/V46e227TpzbfcbakfYj5MxowdJ9+XrG9NpLxu5W/tRzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915412; c=relaxed/simple;
	bh=cbhAIE0UKIjYlQgo+AHhDgBIslp7rF/NkCEtUvdOZFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/1dosPa9Nh/44nqkfxR3onncuZiHgByr3hvgwKr0xjdqnn6j2kSZhWw6jEKwptuw9sUyHh8BJY6jVXuizCoYNVgKed2AOXX0sGbBHCdBYCo4IIgusv55Whr5QsIfvJwzdTtw/PDT+VlcRGJH1GM6AV2bDCm8VNXQ9uXFRNWUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xkACMso0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aMMlX4em; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4BDC337DC;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768915401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSrmzPzLUqMo5e0hLwU2cKIr0H9sC1iWjc19pO4ALPs=;
	b=xkACMso0NJoigl8TiqZUpDt/EOUMaSbjGGftEc7X9aKjV+7Q9Kjr6AlN5oleN8ZF4DH3yF
	SjYJAr5QqoqcmzvWfCZuwJppnWKfrL9fi8VI2cMLA7h6YjNZObXs/QEWHzZ+IDZvHY3p4/
	pq8IelRV7xgwI1PkY2PDADIftfWkb9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768915401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KSrmzPzLUqMo5e0hLwU2cKIr0H9sC1iWjc19pO4ALPs=;
	b=aMMlX4emkqFADDhMJJmi2Ge1aFCppH2HHTRYG5ohdH1X4whaTINLwLVd4/IE18w1zoTnF8
	gc+0BB4VnXJumjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B07F83EA66;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7lS1I8mBb2kjHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 13:23:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4372CA07C4; Tue, 20 Jan 2026 14:23:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/3] fsnotify: Track inode connectors for a superblock
Date: Tue, 20 Jan 2026 14:23:09 +0100
Message-ID: <20260120132313.30198-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120131830.21836-1-jack@suse.cz>
References: <20260120131830.21836-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8143; i=jack@suse.cz; h=from:subject; bh=cbhAIE0UKIjYlQgo+AHhDgBIslp7rF/NkCEtUvdOZFw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpb4HCwrmwifuWziROLrxVQXql/49mAh0HQURtS 0k/2CCLtZCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW+BwgAKCRCcnaoHP2RA 2VNRCADAQs4HIFPfNsGeLWEbdy3OofJ0NalyEdRqaL55UuEYo9vwaFqXsTeFGm9LLvx6Xs6gf+a sIsO3Iqbh7m8USpVJGk3fXIQNhkiN5sb82D/0Xh4uutb+HIKGDaCDvC+tFDEpuQZu/cS9j7BxQH ffHaeX29hcziG0r4rMfyyxDxDjmyjXQ0oEFoToLL/pbIElRT+wImj0Bvba4pLQvSD1b+yprj52F g3byQpTeimCU0NY1lJO0sTOvYnorljlItExhsBRnom25LYWLhROlRYmNBT8iC7Wn5jS2nD74LEp YZmw99V1wRKEatd3hvNXVNeLQ6G5x5RWcAjgOrtvfe3GdNAR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74641-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCD0C51C64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a linked list tracking all inode connectors for a superblock.
We will use this list when the superblock is getting shutdown to
properly clean up all the inode marks instead of relying on scanning all
inodes in the superblock which can get rather slow.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c             |  8 ++-
 fs/notify/fsnotify.h             |  5 +-
 fs/notify/mark.c                 | 94 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  5 +-
 4 files changed, 98 insertions(+), 14 deletions(-)

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
index 55a03bb05aa1..bef5c06112f0 100644
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
@@ -655,20 +661,80 @@ static int fsnotify_attach_info_to_sb(struct super_block *sb)
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
+
+	return &iconn->common;
+}
+
+static void fsnotify_untrack_connector(struct fsnotify_mark_connector *conn)
+{
+	struct fsnotify_inode_mark_connector *iconn;
+	struct fsnotify_sb_info *sbinfo;
+
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return;
+
+	iconn = container_of(conn, struct fsnotify_inode_mark_connector, common);
+	sbinfo = fsnotify_sb_info(fsnotify_conn_inode(conn)->i_sb);
+	spin_lock(&sbinfo->list_lock);
+	list_del(&iconn->conns_list);
+	spin_unlock(&sbinfo->list_lock);
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
@@ -676,7 +742,8 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
+		fsnotify_untrack_connector(conn);
+		kfree(conn);
 	}
 	return 0;
 }
@@ -1007,3 +1074,12 @@ void fsnotify_wait_marks_destroyed(void)
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
index 0d954ea7b179..95985400d3d8 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -553,7 +553,7 @@ struct fsnotify_mark_connector {
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
-	struct hlist_head list;
+	struct hlist_head list;	/* List of marks */
 };
 
 /*
@@ -562,6 +562,9 @@ struct fsnotify_mark_connector {
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



Return-Path: <linux-fsdevel+bounces-74863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D+1A2XhcGnCaQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:23:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB00585CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27A2C82E967
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFB4921B5;
	Wed, 21 Jan 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvMuOcaU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SgZ+aF4B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9nqKurn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vWSCrgRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7248C8D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004004; cv=none; b=AjjLJGToYrywkwinOM1DE3i5VfDzgb6OLLwpkZr92Qj+Sf6zr1ykqojBui3EMqnKWidQCqxlKRlPHu3IINeIlg97g1mMCMt8y6rpTutFIuZkw8ZSr8WC/ANHTH+VuFmguFITM+wij6Yx7QAQ9gQUIGJV8ZKkpGEbXgDy0KG/KVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004004; c=relaxed/simple;
	bh=lL497Mx2nyVCC3siph1xWX2A4v4JIbgGP+wIkacFZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmulKZeXZfxPmIZkgqyNiXpITLIuZFrCbNhGQAhBiVnK+7BY3xf3pFaQuk6KMkhZUTQ7oijbbl3CPsyKK3Npv4DfJLxFvvYMs7iJK5MVxIoYPSkxfi6it/DMo5gzwvks3dnFhkMGFI7Nn6LU/TeXi8UxnKLun5L34E31i3TG6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvMuOcaU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SgZ+aF4B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9nqKurn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vWSCrgRT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E436B5BD14;
	Wed, 21 Jan 2026 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxPv38zTHmyIjAqTgbMeoHCZcUPXhtYmTwQtLHSLTic=;
	b=hvMuOcaUxLj6mu5r7NcwBV8IjMGoX8U7FULjMOImuAdmtqr+GkRK3HhE/ZQL4q625fKOmx
	PCiMzVe5YvDHpVYqlWpOS0XefaDQWXnle6318XQA/M5YDESZar4GXaD47LGGIqWDYrtJq3
	ihfySv5GCTtSvafbzGqLp4iLGYAr5u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxPv38zTHmyIjAqTgbMeoHCZcUPXhtYmTwQtLHSLTic=;
	b=SgZ+aF4BDbZRGKAEytEoOokiyygkDBG724JbRPMcQr6IFFgsHT+ZhvchwGJRnmhyuKc8u+
	MGe/N4prvy03vxBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u9nqKurn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vWSCrgRT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxPv38zTHmyIjAqTgbMeoHCZcUPXhtYmTwQtLHSLTic=;
	b=u9nqKurnvH6zVffXh+hoTW/J9AYubS/V7B3Fx8NOMGTV1FVJKN6DQ5wv6LPONxawZuQfjT
	+1I0zOmDHprD/LmuZzjIi4NSGJ7LR+UgvhesnXn0S3N3lZJ8jQF49jfYZSnKKnNSHHaH+z
	vVyrm1WPLlbUYiyJVvGNrK8ds1OOVVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxPv38zTHmyIjAqTgbMeoHCZcUPXhtYmTwQtLHSLTic=;
	b=vWSCrgRTKTNSXPp7iBMrV4vcrRkBq1dkQtC7WCqvMkOFVPzaMEHFdjQzYQrPWw/WMtLjZp
	Wz9DU1wz8TVX50AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D70123EA63;
	Wed, 21 Jan 2026 14:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id irl5NODbcGmOTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 14:00:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F16BA0845; Wed, 21 Jan 2026 14:59:56 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 1/3] fsnotify: Track inode connectors for a superblock
Date: Wed, 21 Jan 2026 14:59:42 +0100
Message-ID: <20260121135948.8448-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121135513.12008-1-jack@suse.cz>
References: <20260121135513.12008-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7600; i=jack@suse.cz; h=from:subject; bh=lL497Mx2nyVCC3siph1xWX2A4v4JIbgGP+wIkacFZxU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpcNvUDkLVrMy/siSJE2EtR8F8ICgCKFulRtVhn /Qf5KWC1FSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaXDb1AAKCRCcnaoHP2RA 2W0/CACdrUB12x/qKj3hu0cUlr4tSwQ3SOHCvcSV9JZIMiVAt6GBnHkU0SjmnHxnqWm8djUrXuQ 1Fzk/kiCBFJXz+M1QDo1V1bHY2oVbPjpKJSn3JuUapMFsgUGNioEcwaKWlioyxJAopRhfCqfUD7 C++jk5/oLcBI3wqdJ7IRcoqgRYTnWk7FICoZvPQ0/IR0JMPjbC7JXJ+4EpJrqSmzzKEJyGIh4qC DNTglybs0fMjFaBW+bczLNPH1+8GqfuCw+tUe7JfJqIdEeG34KFgOUz98n3sJq2nEOT2+6meRu6 nnZcyTrewJL7RT5I9oOFqXAL5VjcNBwwGVxSkQWUWH42KMFF
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
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
	TAGGED_FROM(0.00)[bounces-74863-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5FB00585CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce a linked list tracking all inode connectors for a superblock.
We will use this list when the superblock is getting shutdown to
properly clean up all the inode marks instead of relying on scanning all
inodes in the superblock which can get rather slow.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c             |  8 +--
 fs/notify/fsnotify.h             |  2 +-
 fs/notify/mark.c                 | 89 ++++++++++++++++++++++++++++----
 include/linux/fsnotify_backend.h |  5 +-
 4 files changed, 89 insertions(+), 15 deletions(-)

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
index 5950c7a67f41..6b58d733ceb6 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -106,6 +106,6 @@ static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
  */
 extern void fsnotify_set_children_dentry_flags(struct inode *inode);
 
-extern struct kmem_cache *fsnotify_mark_connector_cachep;
+void fsnotify_init_connector_caches(void);
 
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 55a03bb05aa1..4a525791a2f3 100644
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
@@ -655,20 +661,73 @@ static int fsnotify_attach_info_to_sb(struct super_block *sb)
 	return 0;
 }
 
-static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       void *obj, unsigned int obj_type)
-{
-	struct fsnotify_mark_connector *conn;
+struct fsnotify_inode_mark_connector {
+	struct fsnotify_mark_connector common;
+	struct list_head conns_list;
+};
 
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
@@ -676,7 +735,8 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
+		fsnotify_untrack_connector(conn);
+		kfree(conn);
 	}
 	return 0;
 }
@@ -1007,3 +1067,12 @@ void fsnotify_wait_marks_destroyed(void)
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



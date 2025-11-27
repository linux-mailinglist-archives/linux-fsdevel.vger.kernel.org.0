Return-Path: <linux-fsdevel+bounces-70058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A29C8FB3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61E64ECDC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA62E8897;
	Thu, 27 Nov 2025 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PGoXDmtS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5h/QpKDH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6fPX+Ly";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jsLvVOE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2C283121
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264640; cv=none; b=uwBiO/v2L/QV9roCw2U1h4JyBhBfvTzrijatB7ckQkrsNxG57tt/yunwgo9RBV6PiIrbIM7pQeNiHS0FVBDMt0uIm7NLuGNccL54OFHe0lhowGYHFixRjrq0WYldfVuspxpA9JW+FXtp9aDGOZrndvvAk+WEN6OIpHGH92YnlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264640; c=relaxed/simple;
	bh=P148ikcsBY510OZ+WGRcZZdhVh7tVCODPhherLAEM+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVCBDIG7XsQuC6jJ/vKWqTwpswuUo4D/F5fOu3XeNz8Ab6+EPDxG52ICiOCUiKNKWwe4NwPB4uL0/hbBLjokFWM7l4iaEW1Z5wr47D/R1Xjt9z8uPPCTvZigH35dhPmiMHJtdrG00uue8jOjbEdMC4VPwqaXJg5XkYpKHiDwmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PGoXDmtS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5h/QpKDH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q6fPX+Ly; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jsLvVOE5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFCA95BCCF;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fySWiR0U5Sq4YTU6BIwomIoS04VDPFxYwilxX/+3f+w=;
	b=PGoXDmtS3Bj9pCBf4B4KC9zonur8SZVyIRbbODb5EthkfJYFM6pz+tarFeQ8xQqkLzLEed
	eyDvyLfSgtaxzwi+4qOwBKIz/3G82z3Jw1xhZuFD2H15DaGuNP5cJ5ok0uyU1G1gEEGGG8
	vakWCJNO/zPsy0cegnORZbooVwCm7zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fySWiR0U5Sq4YTU6BIwomIoS04VDPFxYwilxX/+3f+w=;
	b=5h/QpKDHU2M3fZ6KfTEslTOZk5EewsPmC/3/c/hnFvNoyO1UEdyFUeWD2XzfqH8Hbnrpg4
	+NvtkzxM8t79hnBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q6fPX+Ly;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jsLvVOE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fySWiR0U5Sq4YTU6BIwomIoS04VDPFxYwilxX/+3f+w=;
	b=q6fPX+LywE9KKRU6nQMoLG1sdEOozT1ufRBx/iKiH0+77voDmWQrVw/j+cvPa9KAjiffvp
	DrYkRKrrrN5yCDp1lZ+c8aZV68RCqhTYnSZSx6YhSPWlWwkX5eJ9iurWnoeUTHg9XpbS+J
	/Zerf53Kttf0ZaEfngZv+IdJ0StnoBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fySWiR0U5Sq4YTU6BIwomIoS04VDPFxYwilxX/+3f+w=;
	b=jsLvVOE5HluQLFIYGASirB6UkLHr0j5ctQgTDQ3OyYzcAyYl0IJKCrgf0KEUF2OamP9rJB
	tbe7WEYVMvAyvxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B93393EA65;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wA7VLLGKKGl0PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18C72A0C9A; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/13] fsnotify: Introduce inode connector hash
Date: Thu, 27 Nov 2025 18:30:10 +0100
Message-ID: <20251127173012.23500-16-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13466; i=jack@suse.cz; h=from:subject; bh=P148ikcsBY510OZ+WGRcZZdhVh7tVCODPhherLAEM+0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqml+2vz1y/mZ6E3QBZK73BctVi0TUwfsFM+ HHP1K+sPiSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKpgAKCRCcnaoHP2RA 2V+oB/sEbG+jJMK/IA2HbS+HFPRZEuF5m1sTV8CNHVkUwwb+Vm62COXdTuQ595p0Fgd9hAlF5xB c3RABAdtP8HJ/Xe+9tLBxWIBKyfrtS9b9ky5l6oGVCJi2MMSoTzPNApJKBleeQpWzhyio//27Zj oD3WmpWjmYe2d0FjGmwic4y2aINBNjXBkH6Hu5fhYt6kwtwz7VNZ7jvETy8U1I8sCHome8NKx6F vqm8wa61VDD6voqbASNXtHhQmapGDht5rpy4H+K7re44Bxzebjqpzxcsszrazholxnsd1iQZ58W x3UYT278bJgFgDx72MikJreEeLw1OnSyhBYq0nKZulKyIa5Q
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFCA95BCCF

Introduce rhashtable that will contain all inode connectors for a
superblock. As for some filesystems inode number is not enough to
identify inode, provide enough flexibility for such filesystems to
provide their own keys for the hash. Eventually we will use this hash
table to track all inode connectors (and thus marks) for the superblock
and also to track inode marks for inodes that were evicted from memory
(so that inode marks don't have to pin inodes in memory anymore).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c             |  12 ++-
 fs/notify/fsnotify.h             |   4 +-
 fs/notify/mark.c                 | 176 +++++++++++++++++++++++++++----
 include/linux/fs.h               |   3 +
 include/linux/fsnotify.h         |   9 ++
 include/linux/fsnotify_backend.h |   6 +-
 6 files changed, 187 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 079b868552c2..46db712c83ec 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -110,9 +110,16 @@ void fsnotify_sb_delete(struct super_block *sb)
 						  FSNOTIFY_PRIO_PRE_CONTENT));
 }
 
+void fsnotify_free_sb_info(struct fsnotify_sb_info *sbinfo)
+{
+	rhashtable_destroy(&sbinfo->inode_conn_hash);
+	kfree(sbinfo);
+}
+
 void fsnotify_sb_free(struct super_block *sb)
 {
-	kfree(sb->s_fsnotify_info);
+	if (sb->s_fsnotify_info)
+		fsnotify_free_sb_info(sb->s_fsnotify_info);
 }
 
 /*
@@ -770,8 +777,7 @@ static __init int fsnotify_init(void)
 	if (ret)
 		panic("initializing fsnotify_mark_srcu");
 
-	fsnotify_mark_connector_cachep = KMEM_CACHE(fsnotify_mark_connector,
-						    SLAB_PANIC);
+	fsnotify_init_connector_caches();
 
 	return 0;
 }
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 860a07ada7fd..e9160c0e1a70 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -108,6 +108,8 @@ static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
  */
 extern void fsnotify_set_children_dentry_flags(struct inode *inode);
 
-extern struct kmem_cache *fsnotify_mark_connector_cachep;
+void fsnotify_free_sb_info(struct fsnotify_sb_info *sbinfo);
+
+void fsnotify_init_connector_caches(void);
 
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index ecd2c3944051..fd1fe8d37c36 100644
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
@@ -91,6 +92,8 @@ static DECLARE_DELAYED_WORK(reaper_work, fsnotify_mark_destroy_workfn);
 static void fsnotify_connector_destroy_workfn(struct work_struct *work);
 static DECLARE_WORK(connector_reaper_work, fsnotify_connector_destroy_workfn);
 
+static void fsnotify_unhash_connector(struct fsnotify_mark_connector *conn);
+
 void fsnotify_get_mark(struct fsnotify_mark *mark)
 {
 	WARN_ON_ONCE(!refcount_read(&mark->refcnt));
@@ -323,7 +326,7 @@ static void fsnotify_connector_destroy_workfn(struct work_struct *work)
 	while (conn) {
 		free = conn;
 		conn = conn->destroy_next;
-		kmem_cache_free(fsnotify_mark_connector_cachep, free);
+		kfree(free);
 	}
 }
 
@@ -342,6 +345,7 @@ static void *fsnotify_detach_connector_from_object(
 	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = fsnotify_conn_inode(conn);
 		inode->i_fsnotify_mask = 0;
+		fsnotify_unhash_connector(conn);
 
 		/* Unpin inode when detaching from connector */
 		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
@@ -384,6 +388,15 @@ static void fsnotify_drop_object(unsigned int type, void *objp)
 	fsnotify_put_inode_ref(objp);
 }
 
+static void fsnotify_free_connector(struct fsnotify_mark_connector *conn)
+{
+	spin_lock(&destroy_lock);
+	conn->destroy_next = connector_destroy_list;
+	connector_destroy_list = conn;
+	spin_unlock(&destroy_lock);
+	queue_work(system_unbound_wq, &connector_reaper_work);
+}
+
 void fsnotify_put_mark(struct fsnotify_mark *mark)
 {
 	struct fsnotify_mark_connector *conn = READ_ONCE(mark->connector);
@@ -421,13 +434,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 
 	fsnotify_drop_object(type, objp);
 
-	if (free_conn) {
-		spin_lock(&destroy_lock);
-		conn->destroy_next = connector_destroy_list;
-		connector_destroy_list = conn;
-		spin_unlock(&destroy_lock);
-		queue_work(system_unbound_wq, &connector_reaper_work);
-	}
+	if (free_conn)
+		fsnotify_free_connector(conn);
 	/*
 	 * Note that we didn't update flags telling whether inode cares about
 	 * what's happening with children. We update these flags from
@@ -633,22 +641,136 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 	return -1;
 }
 
+/*
+ * Inode connector for filesystems where inode->i_ino uniquely identifies the
+ * inode.
+ */
+struct fsnotify_inode_mark_connector {
+	struct fsnotify_mark_connector common;
+	ino_t ino;
+	struct rhash_head hash_list;
+};
+
+/* Rhashtable parameters for filesystems using fsnotify_inode_mark_connector */
+static const struct rhashtable_params generic_inode_conn_hash_params = {
+	.key_len = sizeof(ino_t),
+	.key_offset = offsetof(struct fsnotify_inode_mark_connector, ino),
+	.head_offset = offsetof(struct fsnotify_inode_mark_connector, hash_list),
+};
+
+static const struct rhashtable_params *
+fsnotify_get_conn_hash_params(const struct super_block *sb)
+{
+	if (sb->s_fsnotify_op)
+		return &sb->s_fsnotify_op->inode_conn_hash_params;
+	return &generic_inode_conn_hash_params;
+}
+
+static struct rhash_head *fsnotify_conn_hash_head(
+		struct fsnotify_mark_connector *conn,
+		const struct rhashtable_params *params)
+{
+	return (void *)conn -
+		offsetof(struct fsnotify_inode_mark_connector, common) +
+		params->head_offset;
+}
+
+static void fsnotify_init_connector(struct fsnotify_mark_connector *conn,
+				    void *obj, unsigned int obj_type)
+{
+	spin_lock_init(&conn->lock);
+	INIT_HLIST_HEAD(&conn->list);
+	conn->flags = 0;
+	conn->prio = 0;
+	conn->type = obj_type;
+	conn->obj = obj;
+}
+
+/*
+ * Initialize generic part of inode connector and insert the connector into
+ * the hash of inode connectors.
+ */
+int fsnotify_init_inode_connector(struct fsnotify_mark_connector *conn,
+				  struct inode *inode)
+{
+	struct fsnotify_sb_info *info = fsnotify_sb_info(inode->i_sb);
+	const struct rhashtable_params *params =
+			fsnotify_get_conn_hash_params(inode->i_sb);
+	int ret;
+
+	fsnotify_init_connector(conn, inode, FSNOTIFY_OBJ_TYPE_INODE);
+	ret = rhashtable_lookup_insert_fast(&info->inode_conn_hash,
+		fsnotify_conn_hash_head(conn, params),
+		*params);
+	if (!ret)
+		conn->flags |= FSNOTIFY_CONN_FLAG_HASHED;
+	return ret;
+}
+EXPORT_SYMBOL(fsnotify_init_inode_connector);
+
+/*
+ * Inode connector allocation function for filesystems using
+ * fsnotify_inode_mark_connector
+ */
+static struct fsnotify_mark_connector *
+fsnotify_alloc_inode_connector(struct inode *inode)
+{
+	struct fsnotify_inode_mark_connector *iconn;
+
+	iconn = kmem_cache_alloc(fsnotify_inode_mark_connector_cachep,
+				GFP_KERNEL);
+	if (!iconn)
+		return NULL;
+	iconn->ino = inode->i_ino;
+	if (fsnotify_init_inode_connector(&iconn->common, inode)) {
+		kfree(iconn);
+		return NULL;
+	}
+
+	return &iconn->common;
+}
+
+static void fsnotify_unhash_connector(struct fsnotify_mark_connector *conn)
+{
+	if (!(conn->flags & FSNOTIFY_CONN_FLAG_HASHED))
+		return;
+
+	struct super_block *sb = fsnotify_connector_sb(conn);
+	struct fsnotify_sb_info *info = fsnotify_sb_info(sb);
+	const struct rhashtable_params *params =
+			fsnotify_get_conn_hash_params(sb);
+
+	WARN_ON_ONCE(conn->type != FSNOTIFY_OBJ_TYPE_INODE &&
+		     conn->type != FSNOTIFY_OBJ_TYPE_DETACHED);
+	WARN_ON_ONCE(rhashtable_remove_fast(&info->inode_conn_hash,
+				fsnotify_conn_hash_head(conn, params),
+				*params));
+	conn->flags &= ~FSNOTIFY_CONN_FLAG_HASHED;
+}
+
 static int fsnotify_attach_info_to_sb(struct super_block *sb)
 {
 	struct fsnotify_sb_info *sbinfo;
+	int err;
 
 	/* sb info is freed on fsnotify_sb_delete() */
 	sbinfo = kzalloc(sizeof(*sbinfo), GFP_KERNEL);
 	if (!sbinfo)
 		return -ENOMEM;
 
+	err = rhashtable_init(&sbinfo->inode_conn_hash,
+			      fsnotify_get_conn_hash_params(sb));
+	if (err) {
+		kfree(sbinfo);
+		return err;
+	}
 	/*
 	 * cmpxchg() provides the barrier so that callers of fsnotify_sb_info()
 	 * will observe an initialized structure
 	 */
 	if (cmpxchg(&sb->s_fsnotify_info, NULL, sbinfo)) {
 		/* Someone else created sbinfo for us */
-		kfree(sbinfo);
+		fsnotify_free_sb_info(sbinfo);
 	}
 	return 0;
 }
@@ -658,15 +780,23 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 {
 	struct fsnotify_mark_connector *conn;
 
-	conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
+	if (obj_type == FSNOTIFY_OBJ_TYPE_INODE) {
+		struct inode *inode = obj;
+		const struct fsnotify_sb_operations *ops =
+						inode->i_sb->s_fsnotify_op;
+
+		if (ops && ops->alloc_inode_connector)
+			conn = ops->alloc_inode_connector(inode);
+		else
+			conn = fsnotify_alloc_inode_connector(inode);
+	} else {
+		conn = kmem_cache_alloc(fsnotify_mark_connector_cachep,
+					GFP_KERNEL);
+		if (conn)
+			fsnotify_init_connector(conn, obj, obj_type);
+	}
 	if (!conn)
 		return -ENOMEM;
-	spin_lock_init(&conn->lock);
-	INIT_HLIST_HEAD(&conn->list);
-	conn->flags = 0;
-	conn->prio = 0;
-	conn->type = obj_type;
-	conn->obj = obj;
 
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
@@ -674,7 +804,8 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	 */
 	if (cmpxchg(connp, NULL, conn)) {
 		/* Someone else created list structure for us */
-		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
+		fsnotify_unhash_connector(conn);
+		fsnotify_free_connector(conn);
 	}
 	return 0;
 }
@@ -1004,3 +1135,12 @@ void fsnotify_wait_marks_destroyed(void)
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..98890bb1592a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1325,6 +1325,8 @@ struct sb_writers {
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
+struct fsnotify_sb_operations;
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -1385,6 +1387,7 @@ struct super_block {
 #ifdef CONFIG_FSNOTIFY
 	u32			s_fsnotify_mask;
 	struct fsnotify_sb_info	*s_fsnotify_info;
+	const struct fsnotify_sb_operations *s_fsnotify_op;
 #endif
 
 	/*
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 28a9cb13fbfa..2f94809cca2a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -17,6 +17,15 @@
 #include <linux/slab.h>
 #include <linux/bug.h>
 
+struct fsnotify_sb_operations {
+	struct fsnotify_mark_connector *(*alloc_inode_connector)(struct inode *inode);
+
+	const struct rhashtable_params inode_conn_hash_params;
+};
+
+int fsnotify_init_inode_connector(struct fsnotify_mark_connector *conn,
+				  struct inode *inode);
+
 /* Are there any inode/mount/sb objects watched with priority prio or above? */
 static inline bool fsnotify_sb_has_priority_watchers(struct super_block *sb,
 						     int prio)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d4034ddaf392..0a163c10b5e2 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -21,6 +21,7 @@
 #include <linux/refcount.h>
 #include <linux/mempool.h>
 #include <linux/sched/mm.h>
+#include <linux/rhashtable.h>
 
 /*
  * IN_* from inotfy.h lines up EXACTLY with FS_*, this is so we can easily
@@ -544,6 +545,7 @@ struct fsnotify_mark_connector {
 	unsigned char prio;	/* Highest priority group */
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
+#define FSNOTIFY_CONN_FLAG_HASHED	0x04
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
@@ -551,7 +553,7 @@ struct fsnotify_mark_connector {
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
-	struct hlist_head list;
+	struct hlist_head list;	/* List of marks */
 };
 
 /*
@@ -560,6 +562,8 @@ struct fsnotify_mark_connector {
  */
 struct fsnotify_sb_info {
 	struct fsnotify_mark_connector __rcu *sb_marks;
+	/* Hash of connectors for inode marks */
+	struct rhashtable inode_conn_hash;
 	/*
 	 * Number of inode/mount/sb objects that are being watched in this sb.
 	 * Note that inodes objects are currently double-accounted.
-- 
2.51.0



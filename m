Return-Path: <linux-fsdevel+bounces-70057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC41C8FB0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D244134A9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78AE2EB868;
	Thu, 27 Nov 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hbGLY8a4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DakSdM6Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWQxQRP3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4R3JUh2f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DB2EC541
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264640; cv=none; b=D4IFloDFuMJxv+X9DgZ8486m4jd5FsF8lkm9g4JGEvRwreyuyazoFu+XsuuEKykOim1mGbzxrigyghOahPsVAEGEuaiKfv0OyfLjNiJz4MVod2BgEmsM+bSgc/0TwVSOUpICIgWAfVgAtfa22Wd86V/eXXpJKPKMsrJT30xst48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264640; c=relaxed/simple;
	bh=NX09b6amrBYEyfICYZWPQ57zOVm6+ZxTbwPjcIprOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r51FErOloi80hOaId6rtF8zw36yO2fwdHSiZaixgK07IT6NLGXB8tn6M1D+iWH0QZKdrX/Ku5e08fq0OJLbn3dJ4Bm99WIcRLvAd9txWpZoaC22m/FQ699UAAa+mY9wZoINMgElnx1jy85kVmr11jSZlKcME0ld1Gs3bQTczSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hbGLY8a4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DakSdM6Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWQxQRP3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4R3JUh2f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D02821A60;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2EEOEtXgxByJnYiPTwQfTxysKqtbusjB1mcWNBSres=;
	b=hbGLY8a42avKAL2CPcNdFhNMtUx///2tH6/KXLWdHpjlz2n2i2WEBo7WIBnEVI3O19E12H
	3kJQ+PX51mJMKM+bQKzWXTg52OcqbByG3eY6OeEqCvSsWwy0O8qw6qy2g/ZEIfdYKoZ3Fu
	0cns9BBVWYvBshqgXx0LO+tyJiLbpk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2EEOEtXgxByJnYiPTwQfTxysKqtbusjB1mcWNBSres=;
	b=DakSdM6ZncgCimbSYL38ZVKKXB0UojwJTpFwWSo8bczzFLcgeOi60uCT13mg4nRzGfXnXW
	71M2hQKwlTvO4aBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AWQxQRP3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4R3JUh2f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2EEOEtXgxByJnYiPTwQfTxysKqtbusjB1mcWNBSres=;
	b=AWQxQRP3tElwSYU9Wh48AyyBpDwV0vr5W5C0d6W98770CzbhtGvUFuE9Y98rqXUMDOq1mq
	/KTRxFIVDQtlrOBsFm03DSzbhCfk/LJ1McYrZaeu12C6B78p0R3FcAp/hr0r46rew5NG5n
	zwRehAO/T1F9fXyu5WFx9gLMjVtBOyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2EEOEtXgxByJnYiPTwQfTxysKqtbusjB1mcWNBSres=;
	b=4R3JUh2frzPfWfeuVpseY1UUatPqNbjWqPLMyAbV0XyGXjoaM4CtCwBDwVLsASIxi7/RfF
	bSeiwSZDXEzfzFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 730AB3EA6C;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rn+WG7KKKGmRPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 483A9A0CAF; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 09/13] fsnotify: Reconnect inode marks to inode on lookup
Date: Thu, 27 Nov 2025 18:30:16 +0100
Message-ID: <20251127173012.23500-22-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=jack@suse.cz; h=from:subject; bh=NX09b6amrBYEyfICYZWPQ57zOVm6+ZxTbwPjcIprOmA=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDI1ulYvb53z3+616obS1CjFG6sW6rTNuSVU3dhuk9cTX n1++zrOTkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBMZPNu9n+WjbsT3ih+bwu3 Md9SJNzmGjK9YtrMT281VTQZpOoCIrymbX40Z8EF09ZSpekNJuanztw93D599/yPJ+9n6k75xWz 1aEse3+E3W1ZxcbBWuPiEJcdsmdMgnX144VbWPq9ssY7/UoKBjdxHV5noW6zVuFiba6NX8tVvSn v4rqJqr/h6G4HAjr8pX58mFu151XOfYfHVJW+80lX0DPxzdM2/9oZK7E+M3XHxeqRHj3HXfx7BV c3sB0R5hTWFvzJm/HCUT5OSM/n1J+t6euy5Xr3/tQ+NoycItwcxfzeI+Rfuxvl1R0lqpMYM5jWZ 5rdYD33ZsX7fau0HJ2UFmgSOq3S3LOWdsdv3UugptR4hAA==
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8D02821A60
X-Rspamd-Action: no action
X-Spam-Flag: NO

When inode is being inserted into inode cache, lookup whether there are
some notification marks for this inode and reconnect them to it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c                       |  1 +
 fs/notify/mark.c                 | 37 ++++++++++++++++++++++++++++++++
 include/linux/fsnotify_backend.h | 13 +++++++++++
 3 files changed, 51 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..9f9507eea645 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1450,6 +1450,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 			spin_unlock(&inode->i_lock);
 			spin_unlock(&inode_hash_lock);
 			inode_sb_list_add(inode);
+			fsnotify_generic_reconnect_inode_marks(inode);
 
 			/* Return the locked inode with I_NEW set, the
 			 * caller is responsible for filling in the contents
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index f6a197c63c1d..8fe7128f4122 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -731,6 +731,43 @@ fsnotify_alloc_inode_connector(struct inode *inode)
 	return &iconn->common;
 }
 
+/*
+ * If there are existing notification marks for the inode, attach them
+ * to it.
+ */
+void fsnotify_reconnect_inode_marks(struct inode *inode, void *key)
+{
+	struct fsnotify_sb_info *info = fsnotify_sb_info(inode->i_sb);
+	const struct rhashtable_params *params =
+			fsnotify_get_conn_hash_params(inode->i_sb);
+	struct fsnotify_inode_mark_connector *iconn;
+	struct fsnotify_mark_connector *conn;
+	int idx;
+
+	if (!info)
+		return;
+
+	idx = srcu_read_lock(&fsnotify_mark_srcu);
+	iconn = rhashtable_lookup_fast(&info->inode_conn_hash, key, *params);
+	if (!iconn)
+		goto out_srcu;
+	conn = &iconn->common;
+	spin_lock(&conn->lock);
+	/* The connector is just undergoing destruction? */
+	if (hlist_empty(&conn->list))
+		goto out_lock;
+	conn->type = FSNOTIFY_OBJ_TYPE_INODE;
+	conn->obj = inode;
+	rcu_assign_pointer(inode->i_fsnotify_marks, conn);
+	__fsnotify_recalc_mask(conn);
+	fsnotify_update_sb_watchers(conn);
+out_lock:
+	spin_unlock(&conn->lock);
+out_srcu:
+	srcu_read_unlock(&fsnotify_mark_srcu, idx);
+}
+EXPORT_SYMBOL(fsnotify_reconnect_inode_marks);
+
 static void fsnotify_unhash_connector(struct fsnotify_mark_connector *conn)
 {
 	if (!(conn->flags & FSNOTIFY_CONN_FLAG_HASHED))
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index bf6796be7561..267c6587af97 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -921,6 +921,13 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
 			 size_t count);
 
+void fsnotify_reconnect_inode_marks(struct inode *inode, void *key);
+/* Reconnection function for filesystems using fsnotify_inode_mark_connector */
+static inline void fsnotify_generic_reconnect_inode_marks(struct inode *inode)
+{
+	fsnotify_reconnect_inode_marks(inode, &inode->i_ino);
+}
+
 #else
 
 static inline int fsnotify_pre_content(const struct path *path,
@@ -971,6 +978,12 @@ static inline void fsnotify_unmount_inodes(struct super_block *sb)
 static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
 {}
 
+static inline void fsnotify_reconnect_inode_marks(struct inode *inode, void *key)
+{}
+
+static inline void fsnotify_generic_reconnect_inode_marks(struct inode *inode)
+{}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.51.0



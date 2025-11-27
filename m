Return-Path: <linux-fsdevel+bounces-70060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37569C8FB43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 647944E8728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A82EC092;
	Thu, 27 Nov 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqUsv4yh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFaOHJCN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dgW3+qQO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8/ZGl2YO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02F3B2A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264647; cv=none; b=YS9ikstSZYEC4cDjtsVwTOVUhaSeGZo8Yws4aDkWtzhbQX7SokENUhEGd4733NV4rL9XtXXTm1Oq8z5UIsE+wkzTXVQworPkJKW/OyCQM6FhjcdbMvQtiHFhFX6SdITgYnFkgqdDVJti3nDtVIpi/Gy+9Fx5lly74h6Mmpglg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264647; c=relaxed/simple;
	bh=my5N7QVxNV/EpmfzuuOZQMZV/STrl1+iD2+/VvyZ7j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iu2tmiuyO9t+KFd14ysP6FSaE5wySueDcwWaTSwgrDYlnCE2HPTmVFq49YJRVgh6W4YGW4TZjn1hbj07a1S4Ggoceq062iogMYLhI6dbJOIxdRCXZcRENWZMY0L3SVQznUGWkh/nPb+BEoMTvYzWSxHyWfwSC76WzQuFcnojdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqUsv4yh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFaOHJCN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dgW3+qQO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8/ZGl2YO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EBCC33682;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+TNyWnJwz/9tOK6seovEIUqY2+01M9smeLtOZ+X6Nc=;
	b=jqUsv4yhA6wl1bxiM9NNG7BnpTPge6/Po5tXy6W97iAcdo9lllXCro3KCPZe60V04QR5xC
	PPZslKLj5YczytQvaKLAnND0B5dwPhI5pTCtllNMPIFG3LksbFSxvFiHfRyf+Fbs6rCQ9Y
	KGl8oMl4Mgly0/8sEfYV4uynY/+Mv0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+TNyWnJwz/9tOK6seovEIUqY2+01M9smeLtOZ+X6Nc=;
	b=sFaOHJCNxdy7tJeSKnAh/jcHkWwoMuqLSCSUwr3Xfq3ci3tTEKqPcAVj7EBYJCiClYZhM7
	vauLEbBUcUY96HDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dgW3+qQO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8/ZGl2YO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+TNyWnJwz/9tOK6seovEIUqY2+01M9smeLtOZ+X6Nc=;
	b=dgW3+qQOkF0gzhWQSV06DkHlk2qOSaIbXuSDqzQsoj1oWLLmpOXz3EkoV5lschSyopg+kS
	omJulc4DXswWLiIVnTArcDMfb2z39Eou4bcgt5JHPWaZNjP/GgstUNZloNgU/yRYH3NkKI
	kONdRzNX+DTRcHEO/KIV99wfdcFJrZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+TNyWnJwz/9tOK6seovEIUqY2+01M9smeLtOZ+X6Nc=;
	b=8/ZGl2YO8Icw64MlShQ87edB2XuGchy7e6b/5fRPl6BHgvpl//tI2A21q4Wo/icUXFGV5S
	oQvCRSWTeOrpxWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A8803EA6A;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FWYLGrKKKGmMPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38A86A0CAD; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 07/13] fsnotify: Use connector hash for destroying inode marks
Date: Thu, 27 Nov 2025 18:30:14 +0100
Message-ID: <20251127173012.23500-20-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4209; i=jack@suse.cz; h=from:subject; bh=my5N7QVxNV/EpmfzuuOZQMZV/STrl1+iD2+/VvyZ7j0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqp+jVIr64rcq8pjN4I1kP/n+68copOQItM+ 9u0GNvyU4OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKqQAKCRCcnaoHP2RA 2e2aB/9iESVbK0zqsVcNuoqte8qb/b/WP3M5XNrxPQxuDGMmXt5kRGrkau5Bj/xJpYM4EAqMiDs zSUcooEzzm+wLRVuVFiINHuhdVUBnaAEJFHYz4yYIUurqkBf9gHQCKbPNXVH/PSCi8aEf7/tqZI isnGqAeUAoYwWyRO3Zq0dJqeFIwGOrP+7jOy7RgYPEOte8sd6JQ7u7Lx3YRUTTELqz52QY7XFSv +vrDwEKosTnqoqETujujKpVkfAHabmGoSHmzjEj4BZ+ignZ7tu8IClUjaTnuYLWKFyVx0XNlFSo nXVT/TzItxnnFZWo9lY6E0k4qhkbVhtTKjDLDZgAT6VOgqia
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
X-Rspamd-Queue-Id: 8EBCC33682

Instead of iterating all inodes belonging to a superblock to find inode
marks and remove them on umount, iterate all inode connectors for the
superblock. This may be substantially faster since there are generally
much less inodes with fsnotify marks than all inodes. It also removes
one use of sb->s_inodes list which we strive to ultimately remove.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 78 ++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f7f1d9ff3e38..6e4da46c10ad 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -34,62 +34,48 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
 }
 
 /**
- * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
- * @sb: superblock being unmounted.
+ * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched inodes.
+ * @sbinfo: fsnotify info for superblock being unmounted.
  *
- * Called during unmount with no locks held, so needs to be safe against
- * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
+ * Walk all inode connectors for the superblock and free all associated marks.
  */
-static void fsnotify_unmount_inodes(struct super_block *sb)
+static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
 {
-	struct inode *inode, *iput_inode = NULL;
+	int idx;
+	struct rhashtable_iter iter;
+	struct fsnotify_mark_connector *conn;
+	struct inode *inode;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
-		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
-			spin_unlock(&inode->i_lock);
+	/*
+	 * We hold srcu over the iteration so that returned connectors stay
+	 * allocated until we can grab them in fsnotify_destroy_conn_marks()
+	 */
+	idx = srcu_read_lock(&fsnotify_mark_srcu);
+	rhashtable_walk_enter(&sbinfo->inode_conn_hash, &iter);
+	rhashtable_walk_start(&iter);
+	while ((conn = rhashtable_walk_next(&iter)) != NULL) {
+		/* Table resized - we don't care... */
+		if (IS_ERR(conn))
 			continue;
-		}
-
-		/*
-		 * If i_count is zero, the inode cannot have any watches and
-		 * doing an __iget/iput with SB_ACTIVE clear would actually
-		 * evict all inodes with zero i_count from icache which is
-		 * unnecessarily violent and may in fact be illegal to do.
-		 * However, we should have been called /after/ evict_inodes
-		 * removed all zero refcount inodes, in any case.  Test to
-		 * be sure.
-		 */
-		if (!atomic_read(&inode->i_count)) {
-			spin_unlock(&inode->i_lock);
+		spin_lock(&conn->lock);
+		/* Connector got detached before we grabbed conn->lock? */
+		if (conn->type == FSNOTIFY_OBJ_TYPE_DETACHED) {
+			spin_unlock(&conn->lock);
 			continue;
 		}
-
+		inode = conn->obj;
 		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(iput_inode);
-
-		/* for each watch, send FS_UNMOUNT and then remove it */
+		spin_unlock(&conn->lock);
+		rhashtable_walk_stop(&iter);
 		fsnotify_inode(inode, FS_UNMOUNT);
-
-		fsnotify_inode_delete(inode);
-
-		iput_inode = inode;
-
+		fsnotify_destroy_marks(&inode->i_fsnotify_marks);
+		iput(inode);
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		rhashtable_walk_start(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	iput(iput_inode);
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	srcu_read_unlock(&fsnotify_mark_srcu, idx);
 }
 
 void fsnotify_sb_delete(struct super_block *sb)
@@ -100,7 +86,7 @@ void fsnotify_sb_delete(struct super_block *sb)
 	if (!sbinfo)
 		return;
 
-	fsnotify_unmount_inodes(sb);
+	fsnotify_unmount_inodes(sbinfo);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(&sbinfo->connector_count,
-- 
2.51.0



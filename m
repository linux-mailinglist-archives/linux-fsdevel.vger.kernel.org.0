Return-Path: <linux-fsdevel+bounces-74862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APsLITmcGk+awAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:45:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEFA5898B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ECC0723C92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121D3002BB;
	Wed, 21 Jan 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xijPHExz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrE/GrGN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xijPHExz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrE/GrGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D57492191
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004004; cv=none; b=dqOM+t1oHCXTw/CNpRrfPOf5pzA6wjXXRgA1Z/AFfrsoBLaArKiTv/m3iXEPbN3+leH+vJ0mjqgmHl8tE5RpzoZl1c8XUf7W9Hv2twgR7Djoh3mRvHGNnWPDaqHsEOp77LWeNq4iQUsMngXU4i9rm/Gi5qMUgI3ngZLxIG1gU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004004; c=relaxed/simple;
	bh=nhlzBDrmJFdlL3AHPH5Cn60bdrmAECeyg0BHHkpdCFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ah1zdFB3nkEu3kcaEzWOEc6h6+tfLoyk88/nrTl7D+mbXiQcL100sImHIi91crq3sIhFGiDKgQ2UgvyOJE83i5mcmpD2MO3K+cKGtpVunWGax7a5SaC/41IH/FkMPq6fiTrIDaco5oy315exu2NC9AB5iQcwLf64nXpGOLtMwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xijPHExz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yrE/GrGN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xijPHExz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yrE/GrGN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 022B33368F;
	Wed, 21 Jan 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FniioizV6wB+fBTYPgMtjyS4wWSVb08EGqaElWzs0vY=;
	b=xijPHExzWSZJrgzsNJm/G9dZMH7sond9yf23WHSrvUQRzP0bFzNYuVwkug0kvjvnBdi2V5
	7K+q2aGmFxxbAquombL2mDCbdoJmHLz0mipc0UgHvX+lVU48ko6xGAKk35+V4ipnEqXvik
	v1Fvmu92122+O+ub0DQbSCEV0So8Rgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FniioizV6wB+fBTYPgMtjyS4wWSVb08EGqaElWzs0vY=;
	b=yrE/GrGNYjiWbzQ/ES67eqRzTqanCD1QnoEUhMH04IIx89ofaNBlUxC2qchFZHJ0fCQ8OK
	amsA6/hjIVta0xAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FniioizV6wB+fBTYPgMtjyS4wWSVb08EGqaElWzs0vY=;
	b=xijPHExzWSZJrgzsNJm/G9dZMH7sond9yf23WHSrvUQRzP0bFzNYuVwkug0kvjvnBdi2V5
	7K+q2aGmFxxbAquombL2mDCbdoJmHLz0mipc0UgHvX+lVU48ko6xGAKk35+V4ipnEqXvik
	v1Fvmu92122+O+ub0DQbSCEV0So8Rgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FniioizV6wB+fBTYPgMtjyS4wWSVb08EGqaElWzs0vY=;
	b=yrE/GrGNYjiWbzQ/ES67eqRzTqanCD1QnoEUhMH04IIx89ofaNBlUxC2qchFZHJ0fCQ8OK
	amsA6/hjIVta0xAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70833EA67;
	Wed, 21 Jan 2026 14:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ouJaOODbcGmVTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 14:00:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7A15A0A27; Wed, 21 Jan 2026 14:59:56 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v3 2/3] fsnotify: Use connector list for destroying inode marks
Date: Wed, 21 Jan 2026 14:59:43 +0100
Message-ID: <20260121135948.8448-5-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121135513.12008-1-jack@suse.cz>
References: <20260121135513.12008-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5476; i=jack@suse.cz; h=from:subject; bh=nhlzBDrmJFdlL3AHPH5Cn60bdrmAECeyg0BHHkpdCFc=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDILbl/VLBIREmTobJj02ZXTPZ35/Mnrb/4+yzazs7XtK uBx/KXQyWjMwsDIwSArpsiyOvKi9rV5Rl1bQzVkYAaxMoFMYeDiFICJ7HJg/+96PyZmzxyrixEM P8oPf127syKMYRs/x9lIk1yjwpqVekw1XvpbYnv26qQZ/PnqxrbyZFCw/femL8KpJ14krdbUPaA t8UJj/kvLS8c6nv93/lrqWaV2VzCztYEh367nrc0iid9sjsfMzlfmnl9oUenSpZz9cW2x4oNt28 Lcnz/lvDGd49Gh//daJaWabH3ezN0WPEns1tROrdV335Rzma620RRb8+giM//0WqNF3jHVxqGGA h8FutPrZc82fnZwtg24zf3uUWHnvtM3mzNNnloaMuXlxIWd4VPZFZIs5Zt7OKAv3D49PnqzolQd Q1o8x6GyBZ93pSwUWf/G59vxn64LJPNiJU56TWOVmf8eAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
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
	TAGGED_FROM(0.00)[bounces-74862-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5CEFA5898B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of iterating all inodes belonging to a superblock to find inode
marks and remove them on umount, iterate all inode connectors for the
superblock. This may be substantially faster since there are generally
much less inodes with fsnotify marks than all inodes. It also removes
one use of sb->s_inodes list which we strive to ultimately remove.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 61 +-------------------------------------------
 fs/notify/fsnotify.h |  3 +++
 fs/notify/mark.c     | 41 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 60 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 706484fb3bf3..9995de1710e5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -33,65 +33,6 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
 	fsnotify_clear_marks_by_mntns(mntns);
 }
 
-/**
- * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
- * @sb: superblock being unmounted.
- *
- * Called during unmount with no locks held, so needs to be safe against
- * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
- */
-static void fsnotify_unmount_inodes(struct super_block *sb)
-{
-	struct inode *inode, *iput_inode = NULL;
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
-		spin_lock(&inode->i_lock);
-		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
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
-		if (!icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(iput_inode);
-
-		/* for each watch, send FS_UNMOUNT and then remove it */
-		fsnotify_inode(inode, FS_UNMOUNT);
-
-		fsnotify_inode_delete(inode);
-
-		iput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	iput(iput_inode);
-}
-
 void fsnotify_sb_delete(struct super_block *sb)
 {
 	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
@@ -100,7 +41,7 @@ void fsnotify_sb_delete(struct super_block *sb)
 	if (!sbinfo)
 		return;
 
-	fsnotify_unmount_inodes(sb);
+	fsnotify_unmount_inodes(sbinfo);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 6b58d733ceb6..58c7bb25e571 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -77,6 +77,9 @@ extern struct srcu_struct fsnotify_mark_srcu;
 extern int fsnotify_compare_groups(struct fsnotify_group *a,
 				   struct fsnotify_group *b);
 
+/* Destroy all inode marks for given superblock */
+void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo);
+
 /* Destroy all marks attached to an object via connector */
 extern void fsnotify_destroy_marks(fsnotify_connp_t *connp);
 /* run the list of all marks associated with inode and destroy them */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4a525791a2f3..1b955000ad5b 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -666,6 +666,47 @@ struct fsnotify_inode_mark_connector {
 	struct list_head conns_list;
 };
 
+/**
+ * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched inodes.
+ * @sbinfo: fsnotify info for superblock being unmounted.
+ *
+ * Walk all inode connectors for the superblock and free all associated marks.
+ */
+void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
+{
+	struct fsnotify_inode_mark_connector *iconn;
+	struct inode *inode;
+
+restart:
+	spin_lock(&sbinfo->list_lock);
+	list_for_each_entry(iconn, &sbinfo->inode_conn_list, conns_list) {
+		/* All connectors on the list are still attached to an inode */
+		inode = iconn->common.obj;
+		/*
+		 * For connectors without FSNOTIFY_CONN_FLAG_HAS_IREF
+		 * (evictable marks) corresponding inode may well have 0
+		 * refcount and can be undergoing eviction. OTOH list_lock
+		 * protects us from the connector getting detached and inode
+		 * freed. So we can poke around the inode safely.
+		 */
+		spin_lock(&inode->i_lock);
+		if (unlikely(
+		    inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(&sbinfo->list_lock);
+		fsnotify_inode(inode, FS_UNMOUNT);
+		fsnotify_clear_marks_by_inode(inode);
+		iput(inode);
+		cond_resched();
+		goto restart;
+	}
+	spin_unlock(&sbinfo->list_lock);
+}
+
 static void fsnotify_init_connector(struct fsnotify_mark_connector *conn,
 				    void *obj, unsigned int obj_type)
 {
-- 
2.51.0



Return-Path: <linux-fsdevel+bounces-74639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE6FA1UgcGlRVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:39:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 732DA4E9B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87DE170B4C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371142B724;
	Tue, 20 Jan 2026 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IUG9t1sK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uui65eAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93742981C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915405; cv=none; b=esbuaSDFqEANHajd5RgI2W+NRb2LIvnQcwFgprligmxWudG0/n9QIz9PaqMSj0Rc4Z2hY47EBC46qXsM1yFLx3n+2isYlPGkxwxNxE+iCxnHH6nEnO4D8CzOHGnTFk7sZV7S+5DHazYegf0vb9uXPI3V2b8ch29cybpfqpsZbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915405; c=relaxed/simple;
	bh=s68GoyhJDMgTkQMT2Gh/aMhFuvY/heLWdZ00rmkXQI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTLvrcQ2/7WmBHT8vgAanGm1W/TkjG89tLBvylBlEGrenVVXh+79w5gOFHSTCYdUO3j4FbZw7+bFNWbPP9umnkyy6qj5OBJyJF0doPZGuinc/a5ieuzuxINhjjm9G6ao5MnNJMlVvlW9iBwbeISOdFhrDNo8GwuVSabtGp/eiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IUG9t1sK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uui65eAw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C32C25BCC9;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768915401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjm8NLu9oJ0bMNDsTqL7cqzCGN9VsvH+HoDZx4UkFgA=;
	b=IUG9t1sKMI7wwbMWINQzfYzmOmXC1Nlqntyx+d8sZK/AAEEE2hOjyB7Qef1UshhhuPK1+3
	4D6EihCx3sStG/Dp/v6S3FWNd5EV6JDdCkbh7LrhLq7ge46Y6q0JP1NmsjXocEjwhw6Eh9
	E7XZ+7DvlCDfWjG3eRAF5O6AfQZzb6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768915401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjm8NLu9oJ0bMNDsTqL7cqzCGN9VsvH+HoDZx4UkFgA=;
	b=uui65eAw3UKXnlPw9LvEol2vmut2Fbte+qs9k4cxzBZfIg0sP7Y+YsuQT18WG0WlIjuk/J
	oyE7sYJFzHF8KCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B07C93EA65;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CllSI8mBb2kiHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 13:23:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4CEAEA0A4A; Tue, 20 Jan 2026 14:23:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/3] fsnotify: Use connector hash for destroying inode marks
Date: Tue, 20 Jan 2026 14:23:10 +0100
Message-ID: <20260120132313.30198-5-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120131830.21836-1-jack@suse.cz>
References: <20260120131830.21836-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782; i=jack@suse.cz; h=from:subject; bh=s68GoyhJDMgTkQMT2Gh/aMhFuvY/heLWdZ00rmkXQI8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpb4HCsUNhHx04v2DKmX54M4AGcnhj6xYhKgx6t xgK128sY/iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW+BwgAKCRCcnaoHP2RA 2ZsOB/99bclk7ZEu4BHDSbkSmPIyhMYqNKT0k+ysuIJay/SGCZFTxm+7qYBn319sgPDV9lYHlaE j8EAqpwTBF6ZJ3G7CyHVRfXa2FsdUiKGp9nMW1wpqEITSo+SSzJ2OyB5HKYqAp0ko6mPD872nAv R5mHAkGNUYTS/gQjoRXSZpy1+Gi3haCHOyoBp4h4ahzeBThb1zsjuUpZCh+JXkno8ZPz16X6el9 IPhk48xif2W60I5NKXDxPFx1RyRJN4s+LWQbmJoih6Iurt0o8+bo1s7A4G6ZI6pulpbthSYDfAm MBHyq79lH+F+UqpdO338/QrcGIbPRiscF9qaeyPlcFEhBh9n
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
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
	TAGGED_FROM(0.00)[bounces-74639-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 732DA4E9B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of iterating all inodes belonging to a superblock to find inode
marks and remove them on umount, iterate all inode connectors for the
superblock. This may be substantially faster since there are generally
much less inodes with fsnotify marks than all inodes. It also removes
one use of sb->s_inodes list which we strive to ultimately remove.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 71 +++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 51 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 706484fb3bf3..a0cf0a6ffe1d 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -34,62 +34,31 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
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
+	struct fsnotify_mark_connector *conn;
+	struct inode *inode;
+
+	spin_lock(&sbinfo->list_lock);
+	while (!list_empty(&sbinfo->inode_conn_list)) {
+		conn = fsnotify_inode_connector_from_list(
+						sbinfo->inode_conn_list.next);
+		/* All connectors on the list are still attached to an inode */
+		inode = conn->obj;
+		ihold(inode);
+		spin_unlock(&sbinfo->list_lock);
 		fsnotify_inode(inode, FS_UNMOUNT);
-
-		fsnotify_inode_delete(inode);
-
-		iput_inode = inode;
-
+		fsnotify_clear_marks_by_inode(inode);
+		iput(inode);
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		spin_lock(&sbinfo->list_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	iput(iput_inode);
+	spin_unlock(&sbinfo->list_lock);
 }
 
 void fsnotify_sb_delete(struct super_block *sb)
@@ -100,7 +69,7 @@ void fsnotify_sb_delete(struct super_block *sb)
 	if (!sbinfo)
 		return;
 
-	fsnotify_unmount_inodes(sb);
+	fsnotify_unmount_inodes(sbinfo);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
-- 
2.51.0



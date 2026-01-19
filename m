Return-Path: <linux-fsdevel+bounces-74507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F34ED3B44B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FB7309F407
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC75031B108;
	Mon, 19 Jan 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qS6K2+Jh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5PxnN34F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qS6K2+Jh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5PxnN34F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF331AAB8
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842865; cv=none; b=BOyV3K2OUXI2mj4K3GIt2UtJ0p1crOy2hvo9/U5voLchAmZaEwjbo3ywcIPusNoKSrZJbUXvL7aC+KGPnJbrRG7rn3s1GrjAacF3SzVGngFnePn90/xDx4nHNGbXQO8CN4kO/Kia+byulRK1rHyky/OS8TEdBYsDVpowTvS5wKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842865; c=relaxed/simple;
	bh=V+C2BJc1DUo9l058DRtzYADAxx/GsYsof1VsrlKaIrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9pagUCQbyn44ygJFZIxm9V0ORkpENZZNTbDkAU2z5epfqHdLs7L2a9rjvZn9KF1L7wg0IJyUULW7IFLJQrsD5oAhdqvCiL1t00VhTsdmVK4RBl06gSRv/ePEpsCQtLGVhD1RLFBrNZsWRsINIJmNfT6CCwUCB+BqJvKGrQGpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qS6K2+Jh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5PxnN34F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qS6K2+Jh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5PxnN34F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBB595BCC5;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768842848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bULdKFYu1A7tauCXtVWNQgSi0+ijIC7lQGMAgO1RPE=;
	b=qS6K2+JhUIlFLxwKKIecVlD9/vSxcMIIOVhusXafFAqkNI3DEY6DEYYhBfTbpvIUxVi6cU
	J76dB4DMLhCsVKV6UOtDEYqj+On1EYJsOcZ5gcaZeYkn+ncuQSlZCS2WLirpoJIx5X5k4x
	mfVnQJikq46niIBG/iGvWRq3pL6WIfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768842848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bULdKFYu1A7tauCXtVWNQgSi0+ijIC7lQGMAgO1RPE=;
	b=5PxnN34FC+2NIwArK2E/1Pas+RqTlbtSa9VZZC78hnmgg6sJmz4r9BDU/Pf/5B2xretPQ0
	26M4xAr1r4ewXEAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768842848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bULdKFYu1A7tauCXtVWNQgSi0+ijIC7lQGMAgO1RPE=;
	b=qS6K2+JhUIlFLxwKKIecVlD9/vSxcMIIOVhusXafFAqkNI3DEY6DEYYhBfTbpvIUxVi6cU
	J76dB4DMLhCsVKV6UOtDEYqj+On1EYJsOcZ5gcaZeYkn+ncuQSlZCS2WLirpoJIx5X5k4x
	mfVnQJikq46niIBG/iGvWRq3pL6WIfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768842848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bULdKFYu1A7tauCXtVWNQgSi0+ijIC7lQGMAgO1RPE=;
	b=5PxnN34FC+2NIwArK2E/1Pas+RqTlbtSa9VZZC78hnmgg6sJmz4r9BDU/Pf/5B2xretPQ0
	26M4xAr1r4ewXEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C00613EA67;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMyNLmBmbmmGJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 17:14:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5EAE3A0A1B; Mon, 19 Jan 2026 18:14:08 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] fsnotify: Use connector hash for destroying inode marks
Date: Mon, 19 Jan 2026 18:13:39 +0100
Message-ID: <20260119171400.12006-5-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119161505.26187-1-jack@suse.cz>
References: <20260119161505.26187-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984; i=jack@suse.cz; h=from:subject; bh=V+C2BJc1DUo9l058DRtzYADAxx/GsYsof1VsrlKaIrc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpbmZZZHSUrWCRpgNswFqwwy5hZAOM8g5XOgXsL KCCWX0cyuSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW5mWQAKCRCcnaoHP2RA 2ZiRCAC40AiO+4zD3afQFVvQw1NoL+uKrhFhmYH/wG3p/WztFliwbq1YVyCUORAQxEGdMjQKrSd SgJMbz0rhciDwJGvdK8AyBza3JMo7jG0CYTwPc0XoF+qJZ66SPT07sHJ9eVvl+CtK5O3kMap9r8 cC5ODezV/37UnzsZmMx1WvM6DbMw9uv10I+KdwYOhOmlSfeEHMPfLOjcb7y9Du8OoY/hxOtrCTf +y8uILjkz9Lt9XUPP539EYIShbiw6xW4mY9uCboNgqmjUmwKNevQQE27WfiEriXYYguu3O044mp o0bgiIbc6WuLDJQZiZ0G2kK6rww657VGwWR1WF0eQKdSLdp2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Instead of iterating all inodes belonging to a superblock to find inode
marks and remove them on umount, iterate all inode connectors for the
superblock. This may be substantially faster since there are generally
much less inodes with fsnotify marks than all inodes. It also removes
one use of sb->s_inodes list which we strive to ultimately remove.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 74 +++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 706484fb3bf3..16a4a537d8c3 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -34,62 +34,38 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
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
+	int idx;
+	struct fsnotify_mark_connector *conn;
+	struct inode *inode;
 
+	/*
+	 * We hold srcu over the iteration so that returned connectors stay
+	 * allocated until we can grab them in fsnotify_destroy_conn_marks()
+	 */
+	idx = srcu_read_lock(&fsnotify_mark_srcu);
+	spin_lock(&sbinfo->list_lock);
+	while (!list_empty(&sbinfo->inode_conn_list)) {
+		conn = fsnotify_inode_connector_from_list(
+						sbinfo->inode_conn_list.next);
+		/* All connectors on the list are still attached to an inode */
+		inode = conn->obj;
 		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(iput_inode);
-
-		/* for each watch, send FS_UNMOUNT and then remove it */
+		spin_unlock(&sbinfo->list_lock);
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
+		spin_lock(&sbinfo->list_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
-
-	iput(iput_inode);
+	spin_unlock(&sbinfo->list_lock);
+	srcu_read_unlock(&fsnotify_mark_srcu, idx);
 }
 
 void fsnotify_sb_delete(struct super_block *sb)
@@ -100,7 +76,7 @@ void fsnotify_sb_delete(struct super_block *sb)
 	if (!sbinfo)
 		return;
 
-	fsnotify_unmount_inodes(sb);
+	fsnotify_unmount_inodes(sbinfo);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
 	wait_var_event(fsnotify_sb_watched_objects(sb),
-- 
2.51.0



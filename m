Return-Path: <linux-fsdevel+bounces-23825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1290933E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E437D1C2111A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE3D180A8E;
	Wed, 17 Jul 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aadgM6uL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5RW7VvCR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mj9XeGWs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+auTatJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145717E911
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225200; cv=none; b=GR6kQ5RuRBz//CqCcdB3q79KolS+y6nnSmHL1Qz/Fn7SrG58hPbLs64x6NwLphyeWh73FCEbIe2+/Psxa6Vlo8wd7+W+JCAAirMv48AGlKL6TNKakyFhj4L42CNPNXelQLW0ClE9LFpNVKFREmL7QEc+D/vmNAVHz8lJ8Q39pcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225200; c=relaxed/simple;
	bh=5ywzoK0/h6evaBEB/xJaEvqUfMtpvpLGQzfLkgqIFYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vAEwX8b2TZ8nC6zqnyGfO03VVoO+k8T/E2zVaoV6LHZTR5L9TzRZhnMivizLhkEM6HqjyASL3m0zH/y64rjhp+f/6iLi8WL221LPLROMNyw0K1x8FzG29nUdU/Z7GRcFTOuEVyOczsb6bq5ZavzxF5oo9iASBVli60NczWBd7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aadgM6uL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5RW7VvCR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mj9XeGWs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+auTatJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D184721A9C;
	Wed, 17 Jul 2024 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721225197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QsldMUwflcAjcP+MSHZVR2ZoKIK4NRLGCovN+sfM9kw=;
	b=aadgM6uLpeB30KUGyfKF0jJWSEhQ1OFw+aVk3bqo9L7JamuH5OqX3v3sxdhGerfube42ce
	dRozcr7nN6LXqHxmOxp7afI0jXVBlm4hWjuXtDVBZ6aFqZGFVUb/DuQs1BTqFKf2eqdTPy
	qMIfz7zPp1cO4QxBWKscsR1AP2apBUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721225197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QsldMUwflcAjcP+MSHZVR2ZoKIK4NRLGCovN+sfM9kw=;
	b=5RW7VvCRN7wEtaAO5jw+D5ViWvnaWUpyK47H0MlLrl/MO+VRPEzP7QZRis+5Y1wjSXo7lQ
	2/TFktfRB9K3IcBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Mj9XeGWs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T+auTatJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721225196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QsldMUwflcAjcP+MSHZVR2ZoKIK4NRLGCovN+sfM9kw=;
	b=Mj9XeGWs0rAx/tCq/iCNQiDt8shLVcruioaOg2XtawmP4UJNX0WFYzdc05/Lb7s6W2J7Zb
	HoGWbxZt0udQwKtwW70KNKF8act8K2e2ZeixAQwWhWomOQ00zIBq1FZDitIBaJLt8wRm23
	ec1xtLmeB+/bZv0vmkKaLv5nTMTfWWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721225196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QsldMUwflcAjcP+MSHZVR2ZoKIK4NRLGCovN+sfM9kw=;
	b=T+auTatJ6BazKldYxpJgTaumHzpaRlp+nTEfepKddQj7t5s7xY8V+gGfP+ISyj1YWHypgw
	ZRFrBAAdH9aEgvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4F7E1368F;
	Wed, 17 Jul 2024 14:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eUrGL+zPl2bLfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 14:06:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64F39A0987; Wed, 17 Jul 2024 16:06:32 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: [PATCH v3] fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()
Date: Wed, 17 Jul 2024 16:06:23 +0200
Message-Id: <20240717140623.27768-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5961; i=jack@suse.cz; h=from:subject; bh=5ywzoK0/h6evaBEB/xJaEvqUfMtpvpLGQzfLkgqIFYk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBml8/emHL5YlvsuqjP+eHQAAwz5dFxxL0CJ0j0/kkY aCK4SL2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZpfP3gAKCRCcnaoHP2RA2RsECA CgUADVOBkNMLEib5etBiZGo+FHmXTsZQ5y7oSSjPWkKdC5uMm6B8RHGV1ATTtpyaKbUOmRN8Dkp30O IdAH2rBmT5KATf4LxcENweU1Fsbxec1hIajLfeSxdtwCiMCPjbcC9mJ1F/X4fZihhAG2Say7a6e7wT pND7P2+T9GFIZZeLbuxERInQcgGkH8Y4c8gLyXDJCwh9LC4wopdXLtvOPvjq/gq/3MrXflQxTrYNVt U+P362jKbqK/BhJYLatYbBy5yeyXxvl5oLLTyssffVcK0KLZYp+JJ9zoc03l1ogvH9wdQfb/JQEdDZ /Pw6i0yyIOUI27FrhmKkDhx3czxBSs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[701037856c25b143f1ad];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,toxicpanda.com,suse.cz,syzkaller.appspotmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Queue-Id: D184721A9C

When __fsnotify_recalc_mask() recomputes the mask on the watched object,
the compiler can "optimize" the code to perform partial updates to the
mask (including zeroing it at the beginning). Thus places checking
the object mask without conn->lock such as fsnotify_object_watched()
could see invalid states of the mask. Make sure the mask update is
performed by one memory store using WRITE_ONCE().

Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c             | 21 ++++++++++++---------
 fs/notify/inotify/inotify_user.c |  2 +-
 fs/notify/mark.c                 |  8 ++++++--
 include/linux/fsnotify_backend.h |  6 ++++--
 4 files changed, 23 insertions(+), 14 deletions(-)

Third time is the charm :) I plan to merge this patch through my tree. Review
is welcome.

Changes since v2:
* Use READ_ONCE to access i_fsnotify_mask in fsnotify_inode_watches_children()

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ff69ae24c4e8..6675c4182dbf 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -172,8 +172,10 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 	BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ~FS_EVENTS_POSS_TO_PARENT);
 
 	/* Did either inode/sb/mount subscribe for events with parent/name? */
-	marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
-	marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
+	marks_mask |= fsnotify_parent_needed_mask(
+				READ_ONCE(inode->i_fsnotify_mask));
+	marks_mask |= fsnotify_parent_needed_mask(
+				READ_ONCE(inode->i_sb->s_fsnotify_mask));
 	marks_mask |= fsnotify_parent_needed_mask(mnt_mask);
 
 	/* Did they subscribe for this event with parent/name info? */
@@ -184,8 +186,8 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 					   __u32 mask)
 {
-	__u32 marks_mask = inode->i_fsnotify_mask | mnt_mask |
-			   inode->i_sb->s_fsnotify_mask;
+	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
+			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
 
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
@@ -202,7 +204,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		      int data_type)
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
-	__u32 mnt_mask = path ? real_mount(path->mnt)->mnt_fsnotify_mask : 0;
+	__u32 mnt_mask = path ?
+		READ_ONCE(real_mount(path->mnt)->mnt_fsnotify_mask) : 0;
 	struct inode *inode = d_inode(dentry);
 	struct dentry *parent;
 	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
@@ -546,13 +549,13 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	    (!inode2 || !inode2->i_fsnotify_marks))
 		return 0;
 
-	marks_mask = sb->s_fsnotify_mask;
+	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
 	if (mnt)
-		marks_mask |= mnt->mnt_fsnotify_mask;
+		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
 	if (inode)
-		marks_mask |= inode->i_fsnotify_mask;
+		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
-		marks_mask |= inode2->i_fsnotify_mask;
+		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
 
 
 	/*
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 4ffc30606e0b..e163a4b79022 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -569,7 +569,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 		/* more bits in old than in new? */
 		int dropped = (old_mask & ~new_mask);
 		/* more bits in this fsn_mark than the inode's mask? */
-		int do_inode = (new_mask & ~inode->i_fsnotify_mask);
+		int do_inode = (new_mask & ~READ_ONCE(inode->i_fsnotify_mask));
 
 		/* update the inode with this new fsn_mark */
 		if (dropped || do_inode)
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c3eefa70633c..4aba49a58edd 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -128,7 +128,7 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	if (WARN_ON(!fsnotify_valid_obj_type(conn->type)))
 		return 0;
 
-	return *fsnotify_conn_mask_p(conn);
+	return READ_ONCE(*fsnotify_conn_mask_p(conn));
 }
 
 static void fsnotify_get_sb_watched_objects(struct super_block *sb)
@@ -245,7 +245,11 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
 			want_iref = true;
 	}
-	*fsnotify_conn_mask_p(conn) = new_mask;
+	/*
+	 * We use WRITE_ONCE() to prevent silly compiler optimizations from
+	 * confusing readers not holding conn->lock with partial updates.
+	 */
+	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
 
 	return fsnotify_update_iref(conn, want_iref);
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 4dd6143db271..06b0c4be428c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -594,12 +594,14 @@ static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
+	__u32 mask = READ_ONCE(inode->i_fsnotify_mask);
+
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	if (!(mask & FS_EVENT_ON_CHILD))
 		return 0;
 	/* this inode might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
 /*
-- 
2.35.3



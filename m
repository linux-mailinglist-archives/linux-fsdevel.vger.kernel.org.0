Return-Path: <linux-fsdevel+bounces-23699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F3931550
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 15:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C51F21B12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDB18C173;
	Mon, 15 Jul 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGHMY85w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4dQAiEoo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGEVaRBQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gi3+YOFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C518732C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048661; cv=none; b=k8JPQsWUwOk+WzEPEBGEwSrOWcK4H1SQ+9dp7iHbzZaRIWOELJcNgZEj/g8A1YVJTjx/TJLB22xQA129hfFBuf6Hks0gCzvTQV2mOFuF0lCqSnpj4L/RBmOScf5TMVbLG0JjLOxlQkbwDeUL7Z01lCjCv2wXw1fNM4zordFcnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048661; c=relaxed/simple;
	bh=WXWk91P1+8cHx1yI6K32MJCVym7+nQtZWZXPoVZYM2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bruhv8m+7C8nSK9N/mw86rqfEQYa/MvcZAONcGImny4VgosB9Kug7DTt+B/85+lyR9nGvDl2Pv2+VUZE2Yo9MxhVohX7B1xLIZqabSWdQdjcl9aG5pqO5xBwQBOWmukGsPEImi5eBj9ogTt/r+gWVTkEb/+L15Wy2K4t1HBpgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGHMY85w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4dQAiEoo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGEVaRBQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gi3+YOFw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D87F8218F0;
	Mon, 15 Jul 2024 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721048658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFahK9UqJJejUiHm5BqRRcQ46MltcY7bfdnO5gTcLuA=;
	b=TGHMY85wZK6Ga6h9AU9GoGaKiOyO/fcK7hcZNPKd0rCUCT86sdWlTIi336ZeleMEJF3QG8
	QVOpxIEvhJSNcKowdFly0AZlOi+tCL7VmhfHYyE2X6WQgkwOJmfqNzdBNujqZMUOBAh0QY
	9dO63Xc1N48VxUtE4s+o/MDQarDmTyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721048658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFahK9UqJJejUiHm5BqRRcQ46MltcY7bfdnO5gTcLuA=;
	b=4dQAiEooycg1ljVDkAOxGnfRCOaEumhW/vMIs9eOzLw5FC2l+oaNDKDH/u9jS28Ej1hg1g
	ibR2t9pcHKkYUgCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JGEVaRBQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gi3+YOFw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721048656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFahK9UqJJejUiHm5BqRRcQ46MltcY7bfdnO5gTcLuA=;
	b=JGEVaRBQv+l5c5yobziv2HHmBlH+/ACUqSWmgX525WDhcJEZbsMO3sYRsZ5mvMUk1rMwAQ
	P4YNWTYMve6iy50POTuFSbgAb9/jBQoQC3z8HRvEWOETErxGis769NFNxVlwYfcZiFUjWh
	c+MwL2GdfvPmjCh1zLBW7KgGyZOPfoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721048656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFahK9UqJJejUiHm5BqRRcQ46MltcY7bfdnO5gTcLuA=;
	b=gi3+YOFwQVzD0VAgxQF4aaiIqTQdRt2FyiwX7zcZmHXQRQyZKWqBd0i9rHumGndOtWTs0+
	8eXm7UxuPurrEPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA4B134AB;
	Mon, 15 Jul 2024 13:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lf0vMlAelWY6TgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jul 2024 13:04:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 82218A0987; Mon, 15 Jul 2024 15:04:16 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: [PATCH v2] fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()
Date: Mon, 15 Jul 2024 15:04:10 +0200
Message-Id: <20240715130410.30475-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941; i=jack@suse.cz; h=from:subject; bh=WXWk91P1+8cHx1yI6K32MJCVym7+nQtZWZXPoVZYM2w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmlR5E8mBXTjcFzPbySymUtcCNWrRxWaxwR5Nivrc3 H95TaGiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZpUeRAAKCRCcnaoHP2RA2a23CA CgX4bpAQzv1fMSOt3ZVEmlMTlet644dZVOr5jxqW2PPR1DtW6WkaxsLLNkCF3CpdnInr0xpebj/Ifx a11T1j0B8xyQr4xINioRsQcgCAFDHuUnQ9qxaIlfIbhHAlWWZSp+y6hJUeDthXL9S2vwZrtzMx2OeY kiUgPHOT3JGQT3yC8ZbWi7I7isQPGMQ2WgMnAxzkJ5zMPMgR93V4+pjlI2i3bnelGCRATWvBmMCuwP eHKEH77EQgW+p+oU2AWSNJ7CtRX/ShBEicKfJnVeQvFwP5ZmLYwOAQ7mcztXXHDCbJLknify23Co81 nvW/wZ60NiLLKbuLC5ge4F8Nw+fDZb
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[701037856c25b143f1ad];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,appspotmail.com:email,suse.cz:email,suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,suse.cz,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Level: 
X-Rspamd-Queue-Id: D87F8218F0

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
 3 files changed, 19 insertions(+), 12 deletions(-)

I plan to merge this patch through my tree.

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
-- 
2.35.3



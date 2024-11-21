Return-Path: <linux-fsdevel+bounces-35414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D846B9D4B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DB6280F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E61D0F4D;
	Thu, 21 Nov 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLTdH5Cj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BpL5f5Po";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLTdH5Cj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BpL5f5Po"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B21CFEC2;
	Thu, 21 Nov 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188148; cv=none; b=IkFJ5vkz/WqHCN3JBS5/xbQkSd+n6vGn/xwX7jYvDwO0A1XB4XQjXgKdJGybIvmfj0v2XHfyL1Ctuuj2X8NsSpNR+nUk0/2h+/Yk74H/z4VWefMIIVhsDgDbI/9v4y4Ro3uhf5sVUfWDe+eaWcRzdjCISRstEmbrQgBgT5UECqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188148; c=relaxed/simple;
	bh=JY532Wrm2Bv9F4Cz8O5aKeumyMRAvGINniui7mnYhME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVwOxJsYAI79no+bG7tbwOSrj9XzIg5pgad1pa7+Rx0umlJFUu2rPW/9KRE5vY70tsJr4Z9lnaokoqmTeDKSF9eiC8YS6GxTD1AJDvDWrObOitpwxkfDbtvB5LuaHgRdCl8kLeQSJN6OeQZPXBHFewQydFdeWRxSpaNb3AJ6wLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLTdH5Cj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BpL5f5Po; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLTdH5Cj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BpL5f5Po; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 361DB1F7F9;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB07Yami3ajewB8RW829tURphzsxA2qRlxADt5yZDjY=;
	b=VLTdH5CjpOfXOlzEqnLNGCjMZFFeKhFVeYrIGWFT6aS5brey5ZxJzhCRMFhjjHc3JcKgK4
	h6w5vr30yrdEZ92bx6El7rh5HxG/a7vyjGc/RHqA8w+PHaF+JKvqlVlIvf8yA5DSZz1Xpf
	LU0coKeEsE2+vXo89yuwnNwEjSaZaok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB07Yami3ajewB8RW829tURphzsxA2qRlxADt5yZDjY=;
	b=BpL5f5Pood9Vc4H7sEKXMbbJoBglmI9S7N7aFfAN/tNLn7Fq/3lZfJsmx1a0T784A9sBQE
	0hZwrU+Iz+ZO+XAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB07Yami3ajewB8RW829tURphzsxA2qRlxADt5yZDjY=;
	b=VLTdH5CjpOfXOlzEqnLNGCjMZFFeKhFVeYrIGWFT6aS5brey5ZxJzhCRMFhjjHc3JcKgK4
	h6w5vr30yrdEZ92bx6El7rh5HxG/a7vyjGc/RHqA8w+PHaF+JKvqlVlIvf8yA5DSZz1Xpf
	LU0coKeEsE2+vXo89yuwnNwEjSaZaok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sB07Yami3ajewB8RW829tURphzsxA2qRlxADt5yZDjY=;
	b=BpL5f5Pood9Vc4H7sEKXMbbJoBglmI9S7N7aFfAN/tNLn7Fq/3lZfJsmx1a0T784A9sBQE
	0hZwrU+Iz+ZO+XAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2199813A23;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F0nXB/AXP2cUfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC6CEA08E0; Thu, 21 Nov 2024 12:22:23 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/19] fsnotify: opt-in for permission events at file open time
Date: Thu, 21 Nov 2024 12:22:01 +0100
Message-Id: <20241121112218.8249-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,msgid.link:url];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

From: Amir Goldstein <amir73il@gmail.com>

Legacy inotify/fanotify listeners can add watches for events on inode,
parent or mount and expect to get events (e.g. FS_MODIFY) on files that
were already open at the time of setting up the watches.

fanotify permission events are typically used by Anti-malware sofware,
that is watching the entire mount and it is not common to have more that
one Anti-malware engine installed on a system.

To reduce the overhead of the fsnotify_file_perm() hooks on every file
access, relax the semantics of the legacy FAN_ACCESS_PERM event to generate
events only if there were *any* permission event listeners on the
filesystem at the time that the file was opened.

The new semantic is implemented by extending the FMODE_NONOTIFY bit into
two FMODE_NONOTIFY_* bits, that are used to store a mode for which of the
events types to report.

This is going to apply to the new fanotify pre-content events in order
to reduce the cost of the new pre-content event vfs hooks.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-fsdevel/CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com
---
 fs/notify/fsnotify.c     | 38 ++++++++++++++++++++++++++++++++++++++
 fs/open.c                |  8 +++++++-
 include/linux/fs.h       | 37 ++++++++++++++++++++++++++++++++-----
 include/linux/fsnotify.h | 39 +++++++++++++++++++++++----------------
 4 files changed, 100 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f976949d2634..569ec356e4ce 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -623,6 +623,44 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 }
 EXPORT_SYMBOL_GPL(fsnotify);
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+/*
+ * At open time we check fsnotify_sb_has_priority_watchers() and set the
+ * FMODE_NONOTIFY_ mode bits accordignly.
+ * Later, fsnotify permission hooks do not check if there are permission event
+ * watches, but that there were permission event watches at open time.
+ */
+void file_set_fsnotify_mode(struct file *file)
+{
+	struct super_block *sb = file->f_path.dentry->d_sb;
+
+	/* Is it a file opened by fanotify? */
+	if (FMODE_FSNOTIFY_NONE(file->f_mode))
+		return;
+
+	/*
+	 * Permission events is a super set of pre-content events, so if there
+	 * are no permission event watchers, there are also no pre-content event
+	 * watchers and this is implied from the single FMODE_NONOTIFY_PERM bit.
+	 */
+	if (likely(!fsnotify_sb_has_priority_watchers(sb,
+						FSNOTIFY_PRIO_CONTENT))) {
+		file->f_mode |= FMODE_NONOTIFY_PERM;
+		return;
+	}
+
+	/*
+	 * If there are permission event watchers but no pre-content event
+	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
+	 */
+	if (likely(!fsnotify_sb_has_priority_watchers(sb,
+						FSNOTIFY_PRIO_PRE_CONTENT))) {
+		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+		return;
+	}
+}
+#endif
+
 static __init int fsnotify_init(void)
 {
 	int ret;
diff --git a/fs/open.c b/fs/open.c
index 480c3798da2a..9b1fa59d52bf 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -918,7 +918,7 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED;
+		f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
 		f->f_op = &empty_fops;
 		return 0;
 	}
@@ -946,6 +946,12 @@ static int do_dentry_open(struct file *f,
 	if (error)
 		goto cleanup_all;
 
+	/*
+	 * Set FMODE_NONOTIFY_* bits according to existing permission watches.
+	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
+	 * change anything.
+	 */
+	file_set_fsnotify_mode(f);
 	error = fsnotify_open_perm(f);
 	if (error)
 		goto cleanup_all;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 24598d707578..6a170c2c5326 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -171,13 +171,20 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 
 #define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
 
-/* FMODE_* bit 24 */
-
 /* File is embedded in backing_file object */
-#define FMODE_BACKING		((__force fmode_t)(1 << 25))
+#define FMODE_BACKING		((__force fmode_t)(1 << 24))
+
+/*
+ * Together with FMODE_NONOTIFY_PERM defines which fsnotify events shouldn't be
+ * generated (see below)
+ */
+#define FMODE_NONOTIFY		((__force fmode_t)(1 << 25))
 
-/* File was opened by fanotify and shouldn't generate fanotify events */
-#define FMODE_NONOTIFY		((__force fmode_t)(1 << 26))
+/*
+ * Together with FMODE_NONOTIFY defines which fsnotify events shouldn't be
+ * generated (see below)
+ */
+#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
 
 /* File is capable of returning -EAGAIN if I/O will block */
 #define FMODE_NOWAIT		((__force fmode_t)(1 << 27))
@@ -188,6 +195,26 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)(1 << 29))
 
+/*
+ * The two FMODE_NONOTIFY* define which fsnotify events should not be generated
+ * for a file. These are the possible values of (f->f_mode &
+ * FMODE_FSNOTIFY_MASK) and their meaning:
+ *
+ * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
+ * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
+ * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
+ */
+#define FMODE_FSNOTIFY_MASK \
+	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
+
+#define FMODE_FSNOTIFY_NONE(mode) \
+	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
+#define FMODE_FSNOTIFY_PERM(mode) \
+	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
+	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
+#define FMODE_FSNOTIFY_HSM(mode) \
+	((mode & FMODE_FSNOTIFY_MASK) == 0)
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..8d1849137a96 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -108,38 +108,35 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
 }
 
-static inline int fsnotify_file(struct file *file, __u32 mask)
+static inline int fsnotify_path(const struct path *path, __u32 mask)
 {
-	const struct path *path;
+	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
+}
 
+static inline int fsnotify_file(struct file *file, __u32 mask)
+{
 	/*
 	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
 	 * generate new events. We also don't want to generate events for
 	 * FMODE_PATH fds (involves open & close events) as they are just
 	 * handle creation / destruction events and not "real" file events.
 	 */
-	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
+	if (FMODE_FSNOTIFY_NONE(file->f_mode))
 		return 0;
 
-	path = &file->f_path;
-	/* Permission events require group prio >= FSNOTIFY_PRIO_CONTENT */
-	if (mask & ALL_FSNOTIFY_PERM_EVENTS &&
-	    !fsnotify_sb_has_priority_watchers(path->dentry->d_sb,
-					       FSNOTIFY_PRIO_CONTENT))
-		return 0;
-
-	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
+	return fsnotify_path(&file->f_path, mask);
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+
+void file_set_fsnotify_mode(struct file *file);
+
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-	__u32 fsnotify_mask = FS_ACCESS_PERM;
-
 	/*
 	 * filesystem may be modified in the context of permission events
 	 * (e.g. by HSM filling a file on access), so sb freeze protection
@@ -150,7 +147,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	if (!(perm_mask & MAY_READ))
 		return 0;
 
-	return fsnotify_file(file, fsnotify_mask);
+	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
+		return 0;
+
+	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
 /*
@@ -168,16 +168,23 @@ static inline int fsnotify_open_perm(struct file *file)
 {
 	int ret;
 
+	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
+		return 0;
+
 	if (file->f_flags & __FMODE_EXEC) {
-		ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
+		ret = fsnotify_path(&file->f_path, FS_OPEN_EXEC_PERM);
 		if (ret)
 			return ret;
 	}
 
-	return fsnotify_file(file, FS_OPEN_PERM);
+	return fsnotify_path(&file->f_path, FS_OPEN_PERM);
 }
 
 #else
+static inline void file_set_fsnotify_mode(struct file *file)
+{
+}
+
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-- 
2.35.3



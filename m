Return-Path: <linux-fsdevel+bounces-7798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EA82B1A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 16:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF03CB217DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD5F4CB34;
	Thu, 11 Jan 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwoy5myp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211FB4C60A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e62979f41so1428885e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704986558; x=1705591358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yslhBUmA1AIC4HrbWSOh6QhmEDWNCGnjydyR+r1ilmQ=;
        b=jwoy5mypNjBmlAS3/6es6Djn13hF4WHgdPylV8nS7iHD8aCc9G9+GZdGfhEaFigC1W
         I3qxXQvw1RDywbivjEL8F3IG7DGAFCHEuqWcRc723lS+VXME+Ni095nE0TpGVe5QNW/C
         jZv187kavNLeaT2JRTaWmENHiRP5NGfe/KCO8dsAYZrfKsVNoRi7eHNsXMfe+Jo+pVon
         MTj+hOFE7PQNdFTFnoiMQ+CWwlry6uDQuc7XV5CYgwS8btOkAcveO/bT/P09REL81kok
         fhqCxvBTU82dlqCohOR7HxVFka8XjWkeqQtueKvkLh8oobX4LP570VJPkPPmPRsG2Syt
         79UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986558; x=1705591358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yslhBUmA1AIC4HrbWSOh6QhmEDWNCGnjydyR+r1ilmQ=;
        b=l3FWtI9Plp4ZtdneNYbnZdyJ5xuXWdHyh9wm6ayCPgDArb3vKDYIdjwYial9ijEZwZ
         YU+TpRyymWDNhMxgaU3O/pfmCHzopJ6Jp9H9ZI4T/9T1h2MnqYRQ5qooyoRIjTdbeySh
         FMlptITXDv/SYLEJP+rF3h1xLnDzJv/5AFkdRw8rrfArIY6XwKB0TCHQGUJTs9+j2Ind
         uEkuFN4xZ+WkulFFY/3Yft7CKt8JYNEVIykxJUV57fRirpJBsLtfZ+Qa0rQI/KawvLHJ
         QQabbEb4fEULe4mmt5kULIlOiyLtcGiGw5R50MpxgfHV/GsoIxq+W1diYD2s6rJ/GJ9Q
         pqJQ==
X-Gm-Message-State: AOJu0YxIw22NhYPpxkeIOGyUcRiArFTC7sKI5ZKZXgmdSptsdksmouHF
	HkFqKkD9Gnhvf3Sb46Ya98k=
X-Google-Smtp-Source: AGHT+IGSdN2m1qfTMybRb6yLClm1KdNeWkgdPLaCHXch6bjkV2r0TAQlb8iOFt8j1MdMtDTU73fWoA==
X-Received: by 2002:a05:600c:4b95:b0:40e:4807:812c with SMTP id e21-20020a05600c4b9500b0040e4807812cmr602146wmp.38.1704986557839;
        Thu, 11 Jan 2024 07:22:37 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d4dc6000000b00336a2566aa2sm1458136wru.61.2024.01.11.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:22:37 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH v2] fsnotify: optimize the case of no content event watchers
Date: Thu, 11 Jan 2024 17:22:33 +0200
Message-Id: <20240111152233.352912-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
optimized the case where there are no fsnotify watchers on any of the
filesystem's objects.

It is quite common for a system to have a single local filesystem and
it is quite common for the system to have some inotify watches on some
config files or directories, so the optimization of no marks at all is
often not in effect.

Content event (i.e. access,modify) watchers on sb/mount more rare, so
optimizing the case of no sb/mount marks with content events can improve
performance for more systems, especially for performance sensitive io
workloads.

Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
events in their mask exist and use that flag to optimize out the call to
__fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

Based on your feedback on v1 [1] that we can generally do better,
here is another variant for optimizing out FS_ACCESS*/FS_MODIFY.

Instead of relying on the assumption that access event watchers are rare,
this is relying on the assumption that content event sb/mount watchers
are rare.

I temprarily used an s_iflags for the POC and it is not being set in a
race free manner. The intention was to use an sb mask flag or sb
connector flag, but doing that from the context of adding a mount mark
requires a bit of prep work.

Let me know what you think.

Jens,

Can you take v2 for a spin with your workloads?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20240109194818.91465-1-amir73il@gmail.com/

Changes since v1:
- Optimize out also FS_MODIFY events
- Use single taint sb flag instead of counter


 fs/notify/mark.c                 | 26 +++++++++++++++-
 include/linux/fs.h               |  1 +
 include/linux/fsnotify.h         | 52 ++++++++++++++++++++++++++------
 include/linux/fsnotify_backend.h | 12 ++++++++
 4 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index d6944ff86ffa..d0e208913881 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -153,9 +153,30 @@ static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
 	return inode;
 }
 
+/*
+ * To avoid the performance penalty of rare case of sb/mount content event
+ * watchers in the hot io path, taint sb if such watchers are added.
+ */
+static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn,
+					u32 old_mask, u32 new_mask)
+{
+	struct super_block *sb = fsnotify_connector_sb(conn);
+	u32 new_watchers = new_mask & ~old_mask & FSNOTIFY_CONTENT_EVENTS;
+
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE || !sb || !new_watchers)
+		return;
+
+	/*
+	 * TODO: We need to take sb conn->lock to set FS_MNT_CONTENT_WATCHED
+	 * in sb->s_fsnotify_mask, but if this is a recalc of mount mark mask,
+	 * it is not sure that we have an sb connector attached yet.
+	 */
+	sb->s_iflags |= SB_I_CONTENT_WATCHED;
+}
+
 static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
-	u32 new_mask = 0;
+	u32 old_mask, new_mask = 0;
 	bool want_iref = false;
 	struct fsnotify_mark *mark;
 
@@ -163,6 +184,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	/* We can get detached connector here when inode is getting unlinked. */
 	if (!fsnotify_valid_obj_type(conn->type))
 		return NULL;
+	old_mask = fsnotify_conn_mask(conn);
 	hlist_for_each_entry(mark, &conn->list, obj_list) {
 		if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
 			continue;
@@ -173,6 +195,8 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	}
 	*fsnotify_conn_mask_p(conn) = new_mask;
 
+	fsnotify_update_sb_watchers(conn, old_mask, new_mask);
+
 	return fsnotify_update_iref(conn, want_iref);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e6ba0cc6f2ee..dac36fe139e1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1173,6 +1173,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
+#define SB_I_CONTENT_WATCHED 0x00002000 /* fsnotify file content monitor */
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 11e6434b8e71..67568ed4b64b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -17,6 +17,12 @@
 #include <linux/slab.h>
 #include <linux/bug.h>
 
+/* Are there any inode/mount/sb objects that are being watched? */
+static inline bool fsnotify_sb_has_watchers(struct super_block *sb)
+{
+	return atomic_long_read(&sb->s_fsnotify_connectors);
+}
+
 /*
  * Notify this @dir inode about a change in a child directory entry.
  * The directory entry may have turned positive or negative or its inode may
@@ -30,7 +36,7 @@ static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
 				struct inode *dir, const struct qstr *name,
 				u32 cookie)
 {
-	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
+	if (!fsnotify_sb_has_watchers(dir->i_sb))
 		return 0;
 
 	return fsnotify(mask, data, data_type, dir, name, NULL, cookie);
@@ -44,7 +50,7 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 
 static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 {
-	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+	if (!fsnotify_sb_has_watchers(inode->i_sb))
 		return;
 
 	if (S_ISDIR(inode->i_mode))
@@ -59,9 +65,6 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 {
 	struct inode *inode = d_inode(dentry);
 
-	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
-		return 0;
-
 	if (S_ISDIR(inode->i_mode)) {
 		mask |= FS_ISDIR;
 
@@ -86,20 +89,51 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
  */
 static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 {
+	if (!fsnotify_sb_has_watchers(dentry->d_sb))
+		return;
+
 	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
 }
 
-static inline int fsnotify_file(struct file *file, __u32 mask)
+static inline int fsnotify_path(const struct path *path, __u32 mask)
 {
-	const struct path *path;
+	struct dentry *dentry = path->dentry;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	if (!fsnotify_sb_has_watchers(dentry->d_sb))
 		return 0;
 
-	path = &file->f_path;
+	/* Optimize the likely case of sb/mount/parent not watching content */
+	if (mask & FSNOTIFY_CONTENT_EVENTS &&
+	    likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
+	    likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
+		/*
+		 * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
+		 * events in s_fsnotify_mask is redundant, but it will be needed
+		 * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
+		 * existence of only mount content event watchers.
+		 */
+		__u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
+				   dentry->d_sb->s_fsnotify_mask;
+
+		if (!(mask & marks_mask))
+			return 0;
+	}
+
+	/*
+	 * sb/mount/parent are being watched. Need to call fsnotify_parent()
+	 * to check the event masks of sb/mount/parent/inode marks.
+	 */
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
+static inline int fsnotify_file(struct file *file, __u32 mask)
+{
+	if (file->f_mode & FMODE_NONOTIFY)
+		return 0;
+
+	return fsnotify_path(&file->f_path, mask);
+}
+
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
  */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 7f63be5ca0f1..54e297f9e03e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -66,6 +66,11 @@
 #define FS_RENAME		0x10000000	/* File was renamed */
 #define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
+/*
+ * This flag is set in the object interest mask of sb to indicate that
+ * some mount mark is interested to get content events.
+ */
+#define FS_MNT_CONTENT_WATCHED	0x80000000
 
 #define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
 
@@ -77,6 +82,13 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
+/* Content events can be used to inspect file content */
+#define FSNOTIFY_CONTENT_PERM_EVENTS	(FS_ACCESS_PERM)
+
+/* Content events can be used to monitor file content */
+#define FSNOTIFY_CONTENT_EVENTS		(FS_ACCESS | FS_MODIFY | \
+					 FSNOTIFY_CONTENT_PERM_EVENTS)
+
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
 
-- 
2.34.1



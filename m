Return-Path: <linux-fsdevel+bounces-50631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2881ACE1F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F601891ACC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D611DE3CB;
	Wed,  4 Jun 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R27gMEqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C21D619F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053368; cv=none; b=u2wnTbKtNyYCt08PVzY+p3C8Fph9a30hBj9U/hIawAYbbdbr3Hm04K115rqMusL45YRqFXK2T4d0H7phWloZn+Ey10WH48yOdKRBL4kA3qbu95Q4yTaX+MvtKdi7JQIAdKes6gbqH1vJChnBwJMFFGg4Du+sIo9pegNgHQJgALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053368; c=relaxed/simple;
	bh=He3y1oaOZXV1sUvCD6BocoK5Qh+WOM1g1eoZJnbl8+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8OQtc3+OwPA8781DT3cs8JeHbsdcEX0v7eI+v+nSIDAIlVVw0MnJneBSjzUx3dbQUDF++uBrUehHCDfF0eeAIALmCuoztRi8Noyu5E0e9s6C1h1LZ4vurgy2xntMhHj//TgW0csYPx2hvGJ1bm39hqAC3WU93C5CbjtT/W3ygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R27gMEqn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso44386825e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749053365; x=1749658165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqv/1jILXj4JLXPhCYfpExBcN2HV3sWNSKrondVYhSo=;
        b=R27gMEqnvPu6P64W5gIrJkNAHiJNNzgvvJizRxGJM0A9/nVg1yv/5/p7MOXFNbvusY
         X+8PeanB/KUo+qb8JxD3dXBIFkFmhhzZj5uibY5Fek3fAwe/N4bFNcIIadgxR+oXCQw3
         vus6gQq07QEZakfV5ox232QAJVSeS17RfuifMWruZclxDFrQ2ZdwiOROsw9W84mfKnch
         R29dd1+IeZzZvxZLBL7zm7ViiLOPMAvWyIRgvM5oBHd5b3zbD2sPzDm/EdyLrSqros6w
         0FBIrY4M0JwqwU3oxgev6sUgG0kee1FpDqiiWTXBQBe2o+uK2/4JMwdG668RqR5pk8Xr
         7fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749053365; x=1749658165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqv/1jILXj4JLXPhCYfpExBcN2HV3sWNSKrondVYhSo=;
        b=YLSEvHCr+Rc9kqg5xZ5XFQ/uqIyDgm1uOxe0NIKPanZQNAS1a/ZvJmmU28hNT3sjcV
         JavT6EHGM0EDb/SWgzjI0CZR2VK8j6msKDhhLjv2hV/kTh9MLe35YGGUa6dVNHrk2RgY
         tHB3h7zAvJxbTb7mSyifzYk2/nUGaWsZTT0KCXbGhTndlKVkkCKiHZn5/DXT9aTh+mNN
         YfkleEMVnhOJVBfekEnsgTjGqTHkTrz+Lzssx8Ei2MJeM725F7pP/M/XBcVjR7Pf+clg
         5UU9atP+GX0NlWAIbp/s2Rj+OMG0yL4dSs430TiFIPvdZ1cubSRVcEIKYeMtuWnwiRKA
         5/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLkmz+kALrXFeaxWLUVDgq2BnOG3z1vnIoPs8iEpJpgor3uQ9ACqpZp0+lo7RLgr+raTodRlW1ln3NoGT6@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHfBoc2zESXhnGyRdZZ98NDlWsPkeouHTRW5oq4hDz4toezL5
	QiVU0j7Xj4Ogr2mARh4gDKNT1z5GFFD693auTAHhmNTgBI1sa5MBZw0RMI6RV3eg
X-Gm-Gg: ASbGncuarxzMj5+RcyBOrPuvICdKyGJHZhYK3HmkJ7oCHtUjSujo5A77fOIvU3gXNJ+
	aPUE4ZHNzpjxMyXUSJVfJ8ujkC3/ZEstav2p9B4UdrnM6A2h/Mh5QprMbgr4ICZRHVLfuqTozQn
	Bt5WfBF7lLWGUljncUdfkOV4pg+0RV1WzOrKhsCger5Ee6ItMO7LUA8BAME8y5I0YBNkpU3CrkR
	LUUu9R+UL+FYtki5YWrCct51YOjEyM/pQDlRQzpuTaCuK/weENB+oOLLHGInybvRLHK56rObpKj
	5/tc8CpIClZFb4xO6GBbtxVf3vjUp1WY59t55UZ2SgNNh6OGWf0PrVtdo8Q2lm1zH5uvhRgwoCr
	hM+/Pk5KtUrReIa8EIUq+1WhlL2AgLih9+IAx8JgoJPA/D+vJ
X-Google-Smtp-Source: AGHT+IENgY1KB6eqDdvSEohG11M503Nbx1GnjI93eFSi+QVerqehwafFaVqUwOHDokDYpQK3RA+Cjw==
X-Received: by 2002:a05:600c:8b23:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-451f0b99db5mr39908255e9.0.1749053364665;
        Wed, 04 Jun 2025 09:09:24 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a1678sm22304306f8f.99.2025.06.04.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:09:24 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] fanotify: introduce FAN_PATH_ACCESS event
Date: Wed,  4 Jun 2025 18:09:18 +0200
Message-Id: <20250604160918.2170961-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604160918.2170961-1-amir73il@gmail.com>
References: <20250604160918.2170961-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exiting FAN_PRE_ACCESS pre-content event on a directory can be used
to populate a directory before ian application is reading its content.

The new FAN_PATH_ACCESS pre-content event adds the ability to populate
a directory before lookup in the directory index.

The hook is called from lookup_slow_notify() when travesing a directory
during path lookup walk.  Because it is only relevant for directories,
the FAN_PATH_ACCESS event is generated regardless of FAN_ONDIR flag
in mark mask.

The permission hook cannot be sent to usersapce while lookup is in
RCU walk, so if dcache entries already exist, it is assumed that
FAN_PATH_ACCESS events are not needed, because an event was already
generated when dcache was populated.

To prevent a deadlock, when a directory access monitoring process uses
the event->fd obtained in a FAN_PATH_ACCESS event to lookup a path,
relative to event->fd, this lookup does not generate recursive
FAN_PATH_ACCESS events

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c                       | 70 ++++++++++++++++++++++++++++----
 fs/notify/fanotify/fanotify.c    |  3 +-
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fanotify.h         |  2 +-
 include/linux/fsnotify.h         | 26 ++++++++++++
 include/linux/fsnotify_backend.h |  4 +-
 include/linux/namei.h            |  3 ++
 include/uapi/linux/fanotify.h    |  2 +
 8 files changed, 101 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..b41fedc0f11f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -657,6 +657,14 @@ struct nameidata {
 #define ND_ROOT_PRESET 1
 #define ND_ROOT_GRABBED 2
 #define ND_JUMPED 4
+#define ND_NONOTIFY 8
+
+static void nd_set_jumped(struct nameidata *nd)
+{
+	nd->state |= ND_JUMPED;
+	/* Maybe crossed sb/mount so need to re-test sb/mount watches */
+	nd->state &= ~ND_NONOTIFY;
+}
 
 static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 {
@@ -1051,7 +1059,7 @@ static int nd_jump_root(struct nameidata *nd)
 		path_get(&nd->path);
 		nd->inode = nd->path.dentry->d_inode;
 	}
-	nd->state |= ND_JUMPED;
+	nd_set_jumped(nd);
 	return 0;
 }
 
@@ -1079,7 +1087,7 @@ int nd_jump_link(const struct path *path)
 	path_put(&nd->path);
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
-	nd->state |= ND_JUMPED;
+	nd_set_jumped(nd);
 	return 0;
 
 err:
@@ -1594,7 +1602,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 			if (mounted) {
 				path->mnt = &mounted->mnt;
 				dentry = path->dentry = mounted->mnt.mnt_root;
-				nd->state |= ND_JUMPED;
+				nd_set_jumped(nd);
 				nd->next_seq = read_seqcount_begin(&dentry->d_seq);
 				flags = dentry->d_flags;
 				// makes sure that non-RCU pathwalk could reach
@@ -1634,7 +1642,7 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 		if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 			ret = -EXDEV;
 		else
-			nd->state |= ND_JUMPED;
+			nd_set_jumped(nd);
 	}
 	if (unlikely(ret)) {
 		dput(path->dentry);
@@ -1836,6 +1844,47 @@ static struct dentry *lookup_slow(const struct qstr *name,
 	return res;
 }
 
+static bool lookup_should_notify(struct nameidata *nd)
+{
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+	/* Was dirfd obtained from fanotify event->fd? */
+	if (unlikely(nd->flags & LOOKUP_NONOTIFY))
+		return false;
+
+	/*
+	 * An open coded version of the fsnotify mask checks in fsnotify()
+	 * optimized to check the sb/mount marks only once per jump.
+	 */
+	if (unlikely(nd->inode->i_fsnotify_mask & FS_PATH_ACCESS))
+		return true;
+
+	if (likely(nd->state & ND_NONOTIFY))
+		return false;
+
+	if (unlikely(nd->inode->i_sb->s_fsnotify_mask & FS_PATH_ACCESS) ||
+	    unlikely(real_mount(nd->path.mnt)->mnt_fsnotify_mask &
+		     FS_PATH_ACCESS))
+		return true;
+
+	/* Avoid testing sb/mount masks again until nd_set_jumped() */
+	nd->state |= ND_NONOTIFY;
+#endif
+	return false;
+}
+
+
+static struct dentry *lookup_slow_notify(struct nameidata *nd)
+{
+	if (lookup_should_notify(nd)) {
+		int err = fsnotify_lookup_perm(&nd->path, nd->inode, &nd->last);
+
+		if (unlikely(err))
+			return ERR_PTR(err);
+	}
+
+	return lookup_slow(&nd->last, nd->path.dentry, nd->flags);
+}
+
 static inline int may_lookup(struct mnt_idmap *idmap,
 			     struct nameidata *restrict nd)
 {
@@ -2135,7 +2184,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
-		dentry = lookup_slow(&nd->last, nd->path.dentry, nd->flags);
+		dentry = lookup_slow_notify(nd);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
@@ -2461,7 +2510,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		switch(lastword) {
 		case LAST_WORD_IS_DOTDOT:
 			nd->last_type = LAST_DOTDOT;
-			nd->state |= ND_JUMPED;
+			nd_set_jumped(nd);
 			break;
 
 		case LAST_WORD_IS_DOT:
@@ -2541,7 +2590,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		nd->seq = nd->next_seq = 0;
 
 	nd->flags = flags;
-	nd->state |= ND_JUMPED;
+	nd_set_jumped(nd);
 
 	nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
 	nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
@@ -2608,6 +2657,13 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		if (*s && unlikely(!d_can_lookup(dentry)))
 			return ERR_PTR(-ENOTDIR);
 
+		/*
+		 * dfd was opened by fanotify and lookup_slow_notify()
+		 * shouldn't generate fanotify events.
+		 */
+		if (FMODE_FSNOTIFY_NONE(fd_file(f)->f_mode))
+			nd->flags |= LOOKUP_NONOTIFY;
+
 		nd->path = fd_file(f)->f_path;
 		if (flags & LOOKUP_RCU) {
 			nd->inode = nd->path.dentry->d_inode;
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7c9a2614e715..df9b10d717d2 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -952,8 +952,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
+	BUILD_BUG_ON(FAN_PATH_ACCESS != FS_PATH_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 25);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index e2b4f17a48bb..004a24036a12 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -745,7 +745,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 27);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 879cff5eccd4..0eaae7a46a33 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -93,7 +93,7 @@
 #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				      FAN_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PATH_ACCESS)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 175149167642..44b8496730a3 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -227,6 +227,25 @@ static inline int fsnotify_open_perm(struct file *file)
 	return fsnotify_path(&file->f_path, FS_OPEN_PERM);
 }
 
+/*
+ * fsnotify_lookup_perm - permission hook before path access
+ */
+static inline int fsnotify_lookup_perm(struct path *path,
+				       struct inode *dir,
+				       const struct qstr *name)
+{
+	if (!(dir->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
+	    !fsnotify_sb_has_priority_watchers(dir->i_sb,
+					       FSNOTIFY_PRIO_PRE_CONTENT))
+		return 0;
+
+	if (WARN_ON_ONCE(!S_ISDIR(dir->i_mode)))
+		return 0;
+
+	return fsnotify(FS_PATH_ACCESS, path, FSNOTIFY_EVENT_PATH,
+			dir, name, NULL, 0);
+}
+
 #else
 static inline void file_set_fsnotify_mode_from_watchers(struct file *file)
 {
@@ -258,6 +277,13 @@ static inline int fsnotify_open_perm(struct file *file)
 {
 	return 0;
 }
+
+static inline int fsnotify_lookup_perm(struct path *path,
+				       struct inode *dir,
+				       const struct qstr *name)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index d4034ddaf392..c9a71cb97f3b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -43,6 +43,7 @@
 #define FS_OPEN_EXEC		0x00001000	/* File was opened for exec */
 
 #define FS_UNMOUNT		0x00002000	/* inode on umount fs */
+
 #define FS_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
 #define FS_ERROR		0x00008000	/* Filesystem Error (fanotify) */
 
@@ -58,6 +59,7 @@
 /* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FS_PATH_ACCESS		0x00200000	/* Pre-path access hook */
 
 #define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FS_MNT_DETACH		0x02000000	/* Mount was detached */
@@ -91,7 +93,7 @@
 #define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
 				      FS_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
+#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS | FS_PATH_ACCESS)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
 				  FSNOTIFY_PRE_CONTENT_EVENTS)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5d085428e471..f084b5493f02 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -49,6 +49,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 /* 3 spare bits for scoping */
 
+/* dirfd was opened by fanotify and lookup shouldn't generate fanotify events */
+#define LOOKUP_NONOTIFY		0x4000000
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at(int, const char __user *, unsigned, struct path *);
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e710967c7c26..190c2258f623 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -28,6 +28,8 @@
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FAN_PATH_ACCESS		0x00200000	/* Pre-path access hook */
+
 #define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
 #define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
 
-- 
2.34.1



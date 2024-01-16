Return-Path: <linux-fsdevel+bounces-8055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF082EDC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DF81F24662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E51B949;
	Tue, 16 Jan 2024 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCuRKJxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E371B940
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e800461baso11555025e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705404774; x=1706009574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEUWwoI02pFJNol55jCa4HBlEHtMkCTqNiEci+hKlJM=;
        b=RCuRKJxRfkr1w5HAM29KNP9MBIl35iY9bLN5A7KE0l5nCI3LB68hFwwpIBDKHxx6Hv
         3gVBQQ2Eg6jegKlUSzHqnG+UC7XNwjzC++jVBvigEoMrsi+lTA4593ol9axz6Lr1GaIT
         GjaV+gInChD07UCXkvXcP54e+n79pRO+Xv7IDA8dZDDv3r3S23iH6hiw4+cF08WLj5aU
         jJrnngDEE2Av4g6/UEpHIVG/Vr7du4XYdZrvq6j0BfQX97/04GpaYLUf+xDsQMXKxPf+
         99ujaxNqUnnkIMPPIIyLW9ZQDfDSSckW2spV/Moft6a5ggQjgtF1QTnWwNzQgT8/4GPU
         9hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705404774; x=1706009574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEUWwoI02pFJNol55jCa4HBlEHtMkCTqNiEci+hKlJM=;
        b=gh4Jx9dFgzHuO0fS83d7QZIs4JZZKT1idsZhizLCSTpmB0UmOYDSD+wbukmYbO8pya
         YUtgKrZmLSZFc76Ua7bD0zHwqmpL4aCMJuxOblRsR/jJ75C67IXaTRRErf0yeLTnFDEF
         SwbtmnVMuJjTqBSrG138YFa93qZAXnAHPyWDO1Hl291bBjqknfHk4XTKgLdLswUylj0H
         s1GeWPl6Datgf/kUAdGwT/i7jfh4ti50qd3CUH7pjz1DFxvBsic3EDS0TOqyzCo8+B0u
         uP+d26i+O1dhtSDP8JhRlnFpXK0wgYKy92bX9rYGESfG4n+Vx4iNnmFVZh49BxmCZLdC
         V3Sg==
X-Gm-Message-State: AOJu0Yx9JBZjPT9YEqEl4FXFjzoksWHMfozAKaKxsyJnRrRUuvOi71z1
	WrwalHIIUgh60nyMs2dEMK4=
X-Google-Smtp-Source: AGHT+IHYCAKEOUAGpIB/BFp5NHiPhnP016wS10amA4jLoZV5GfXMEQVwNwG6dPplqSUGRPgFW/J55w==
X-Received: by 2002:a05:600c:12c8:b0:40e:6cf9:505b with SMTP id v8-20020a05600c12c800b0040e6cf9505bmr1391847wmd.297.1705404773461;
        Tue, 16 Jan 2024 03:32:53 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040d8ff79fd8sm19040675wmb.7.2024.01.16.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:32:53 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] fsnotify: optimize the case of no parent watcher
Date: Tue, 16 Jan 2024 13:32:47 +0200
Message-Id: <20240116113247.758848-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If parent inode is not watching, check for the event in masks of
sb/mount/inode masks early to optimize out most of the code in
__fsnotify_parent() and avoid calling fsnotify().

Jens has reported that this optimization improves BW and IOPS in an
io_uring benchmark by more than 10% and reduces perf reported CPU usage.

before:

+    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
+    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent

after:

+    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent

Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90a6-aad5e6759e0b@kernel.dk/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

Considering that this change looks like a clear win and it actually
the change that you suggested, I cleaned it up a bit and posting for
your consideration.

I've kept the wrappers fsnotify_path() and fsnotify_sb_has_watchers()
although they are not directly related to the optimization, because they
makes the code a bit nicer IMO.

Jens,

I took the liberty to add Reported-and-tested-by to attribute for your
help even though the patch that you tested was slightly different than
this cleaned up version, because logically it should be identical.

Thanks,
Amir.

Changes since v2:
- Add helper fsnotify_object_watched()
- Move the optimization from inlined fsnotify_path() to
  extern __fsnotify_parent()
- Optimize for any event - not only content events
- Drop the SB_I_CONTENT_WATCHED flag

 fs/notify/fsnotify.c     | 28 +++++++++++++++++-----------
 include/linux/fsnotify.h | 22 +++++++++++++++-------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8bfd690e9f10..6582204cca70 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -141,7 +141,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 }
 
 /* Are inode/sb/mount interested in parent and name info with this event? */
-static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
+static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 					__u32 mask)
 {
 	__u32 marks_mask = 0;
@@ -160,13 +160,22 @@ static bool fsnotify_event_needs_parent(struct inode *inode, struct mount *mnt,
 	/* Did either inode/sb/mount subscribe for events with parent/name? */
 	marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
 	marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
-	if (mnt)
-		marks_mask |= fsnotify_parent_needed_mask(mnt->mnt_fsnotify_mask);
+	marks_mask |= fsnotify_parent_needed_mask(mnt_mask);
 
 	/* Did they subscribe for this event with parent/name info? */
 	return mask & marks_mask;
 }
 
+/* Are there any inode/mount/sb objects that are interested in this event? */
+static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
+					   __u32 mask)
+{
+	__u32 marks_mask = inode->i_fsnotify_mask | mnt_mask |
+			   inode->i_sb->s_fsnotify_mask;
+
+	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
+}
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
@@ -179,7 +188,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		      int data_type)
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
-	struct mount *mnt = path ? real_mount(path->mnt) : NULL;
+	__u32 mnt_mask = path ? real_mount(path->mnt)->mnt_fsnotify_mask : 0;
 	struct inode *inode = d_inode(dentry);
 	struct dentry *parent;
 	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
@@ -190,16 +199,13 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 	struct qstr *file_name = NULL;
 	int ret = 0;
 
-	/*
-	 * Do inode/sb/mount care about parent and name info on non-dir?
-	 * Do they care about any event at all?
-	 */
-	if (!inode->i_fsnotify_marks && !inode->i_sb->s_fsnotify_marks &&
-	    (!mnt || !mnt->mnt_fsnotify_marks) && !parent_watched)
+	/* Optimize the likely case of nobody watching this path */
+	if (likely(!parent_watched) &&
+	    likely(!fsnotify_object_watched(inode, mnt_mask, mask)))
 		return 0;
 
 	parent = NULL;
-	parent_needed = fsnotify_event_needs_parent(inode, mnt, mask);
+	parent_needed = fsnotify_event_needs_parent(inode, mnt_mask, mask);
 	if (!parent_watched && !parent_needed)
 		goto notify;
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 8300a5286988..2ddfd7d1eca8 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -17,6 +17,12 @@
 #include <linux/slab.h>
 #include <linux/bug.h>
 
+/* Are there any inode/mount/sb objects that are being watched at all? */
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
@@ -59,7 +65,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 {
 	struct inode *inode = d_inode(dentry);
 
-	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+	if (!fsnotify_sb_has_watchers(inode->i_sb))
 		return 0;
 
 	if (S_ISDIR(inode->i_mode)) {
@@ -89,15 +95,17 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
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
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
 
-	path = &file->f_path;
-	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
+	return fsnotify_path(&file->f_path, mask);
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-- 
2.34.1



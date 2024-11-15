Return-Path: <linux-fsdevel+bounces-34930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DC9CF00B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5072884F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B41D934D;
	Fri, 15 Nov 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="spA1OglA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980A1CF5E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684687; cv=none; b=l1frglem1nOSTPzUW22BOrhdTVExzZFXEUGVRwiVyX/Ye4Z+XsBNE0rmH4S1IxaYsPBnTROQ9SOdSxR/oWc1/hDfI0R+984ScMSuGm5vou6yxBNQvKc+2VmgunavdxUsTHQ8lxJTewUDWUkGKsqG1lAtwoLyQ9D/g+3t2RS5Q38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684687; c=relaxed/simple;
	bh=JByGqE+7zI1PkwzTHs3XXvSyjr5uNafvFWqg8yGYuSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgMigQpzIRcaD0mF/W6Y10q0UHNfycHLmZxUBiFhNS2y6lG6Z11dl15ZjSnTcSGoOFWKhUcCqaIhJ2T/yctf7Yp8o0eqsDAaxH7S3OUBhll3oMvQu8Z8B/tYyfevTy83E3hXQUyw7+lMyGBV1MBZOPJayeIIzTRNEhv1Y6NQywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=spA1OglA; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3cdbc25a0so21871217b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684685; x=1732289485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj8DHbC84OPYXlyGqV3jogaZDMjK7DzZOpBQs/P23MY=;
        b=spA1OglAOwba3VqMXr+8pAXS4f4LNZSslouXRx8nWBn1zcOE/UQ6ueXuIq5ZqUPiOH
         X7lFkeUKaHqJsJtdPWu+qfbL9FohL6PmYSqWsr3yyVmsH0cqNTEbK8K79FlSaTffW61K
         ISLaQXTl0ECB/Rs+7C3H2j8JZQrWhPzCUe9wwo7zHnhP1Cb0aOOc3DhKH8sjlJhNASv+
         876KfM/OdKMJjLkgU9GsKB7G4PPxgDX0S/mcSdJ+yMYUUeBiNrLw0UlfQGWDEYvU2Ly+
         kMJfMQPsRQeW0BxopI0X8N59ae7AC5PO1whTxU7yGUhjeLpd6z05p+YTKKSLuy9Gwes8
         /0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684685; x=1732289485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj8DHbC84OPYXlyGqV3jogaZDMjK7DzZOpBQs/P23MY=;
        b=N4l46izD5vgl0B0SgxtSudkNPAGQXug2K07bYyVTa8B1W5pzd7DuBwIifpF+Rd3T1e
         Kq4u4xsQBht66qiEK2MFjXe2feTjZ7Drya0MMsySR6PqRl3YjYl+4jcsHMEm8iN8NfSr
         9JLWGx/S7Mn3xRCzsKrCELWzNhUqveOPS2OOgkKvWBDERI0VMHsv4kTtYfAo7UIIn7/M
         spKX6OjbqPCwJxgS4kePCC7YmP/j2NtYlxQgoaO4qqZIDCmXDDLhdz6E/qzrOmrPqwDv
         7O85Y9Vqa6UMMdXLM90XpDV09jMpR5099cQnWjMUs0Oe6nMTjY1uJGJ28Wm/OChgo5ck
         dMJA==
X-Forwarded-Encrypted: i=1; AJvYcCWYCL6iq7wkeGNAS+m8kv1MoVOgh0YJDmRNjksZdIh8z8vlrF9+q8npeKRrphHPmFChiwbVxkv+Ss1KXilR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+FBIoteenA/Qjct/nqOvctL3pprAuQw/8/FHcyllxwCqQyKk
	hkQzaZ6ijL+n+LB9g/QEH63Vr3uaIhk3B9VZf0Xi8f/oMe0AkM8OsNZbb/J/ZMM=
X-Google-Smtp-Source: AGHT+IH8WmaESCVDYemYdBxVVvrkUDwhBuFm4p8CVuem1Xk6vUMMQWpt5yAHUnnmjhKyVYoAl9xVug==
X-Received: by 2002:a05:690c:46c4:b0:6ea:ebba:3059 with SMTP id 00721157ae682-6ee558d9384mr37985407b3.0.1731684684910;
        Fri, 15 Nov 2024 07:31:24 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44413490sm7666367b3.95.2024.11.15.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 02/19] fsnotify: opt-in for permission events at file open time
Date: Fri, 15 Nov 2024 10:30:15 -0500
Message-ID: <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/open.c                |  8 ++++-
 include/linux/fs.h       | 35 ++++++++++++++++---
 include/linux/fsnotify.h | 72 +++++++++++++++++++++++++++++++---------
 3 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index c3490286092e..1a9483872e1f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -901,7 +901,7 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED;
+		f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
 		f->f_op = &empty_fops;
 		return 0;
 	}
@@ -929,6 +929,12 @@ static int do_dentry_open(struct file *f,
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
index 23bd058576b1..8e5c783013d2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 
 #define	FMODE_NOREUSE		((__force fmode_t)(1 << 23))
 
-/* FMODE_* bit 24 */
-
 /* File is embedded in backing_file object */
-#define FMODE_BACKING		((__force fmode_t)(1 << 25))
+#define FMODE_BACKING		((__force fmode_t)(1 << 24))
 
-/* File was opened by fanotify and shouldn't generate fanotify events */
-#define FMODE_NONOTIFY		((__force fmode_t)(1 << 26))
+/* File shouldn't generate fanotify pre-content events */
+#define FMODE_NONOTIFY_HSM	((__force fmode_t)(1 << 25))
+
+/* File shouldn't generate fanotify permission events */
+#define FMODE_NONOTIFY_PERM	((__force fmode_t)(1 << 26))
 
 /* File is capable of returning -EAGAIN if I/O will block */
 #define FMODE_NOWAIT		((__force fmode_t)(1 << 27))
@@ -190,6 +191,30 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)(1 << 29))
 
+/*
+ * The two FMODE_NONOTIFY_ bits used together have a special meaning of
+ * not reporting any events at all including non-permission events.
+ * These are the possible values of FMODE_FSNOTIFY(f->f_mode) and their meaning:
+ *
+ * FMODE_NONOTIFY_HSM - suppress only pre-content events.
+ * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
+ * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
+ */
+#define FMODE_FSNOTIFY_MASK \
+	(FMODE_NONOTIFY_HSM | FMODE_NONOTIFY_PERM)
+#define FMODE_NONOTIFY FMODE_FSNOTIFY_MASK
+#define FMODE_FSNOTIFY(mode) \
+	((mode) & FMODE_FSNOTIFY_MASK)
+
+#define FMODE_FSNOTIFY_NONE(mode) \
+	(FMODE_FSNOTIFY(mode) == FMODE_NONOTIFY)
+#define FMODE_FSNOTIFY_NORMAL(mode) \
+	(FMODE_FSNOTIFY(mode) == FMODE_NONOTIFY_PERM)
+#define FMODE_FSNOTIFY_PERM(mode) \
+	(!((mode) & FMODE_NONOTIFY_PERM))
+#define FMODE_FSNOTIFY_HSM(mode) \
+	(FMODE_FSNOTIFY(mode) == 0)
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..54ec97366d7c 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -108,38 +108,68 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
 }
 
+static inline int fsnotify_path(const struct path *path, __u32 mask)
+{
+	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
+}
+
 static inline int fsnotify_file(struct file *file, __u32 mask)
 {
-	const struct path *path;
-
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
+/*
+ * At open time we check fsnotify_sb_has_priority_watchers() and set the
+ * FMODE_NONOTIFY_ mode bits accordignly.
+ * Later, fsnotify permission hooks do not check if there are permission event
+ * watches, but that there were permission event watches at open time.
+ */
+static void file_set_fsnotify_mode(struct file *file)
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
+	 * FMODE_NONOTIFY_HSM bit means there are permission event watchers, but
+	 * no pre-content event watchers.
+	 */
+	if (likely(!fsnotify_sb_has_priority_watchers(sb,
+						FSNOTIFY_PRIO_PRE_CONTENT))) {
+		file->f_mode |= FMODE_NONOTIFY_HSM;
+		return;
+	}
+}
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
@@ -150,7 +180,10 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	if (!(perm_mask & MAY_READ))
 		return 0;
 
-	return fsnotify_file(file, fsnotify_mask);
+	if (likely(file->f_mode & FMODE_NONOTIFY_PERM))
+		return 0;
+
+	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
 /*
@@ -168,16 +201,23 @@ static inline int fsnotify_open_perm(struct file *file)
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
2.43.0



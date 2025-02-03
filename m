Return-Path: <linux-fsdevel+bounces-40681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A95A2669E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDC316595E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A55210F53;
	Mon,  3 Feb 2025 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdhus1Y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E21FF7C2
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621935; cv=none; b=Es4EN3SKJPMDwlDct0jWHr9LlnMFjZMVtb3kim/sKYQnXIpRDUtBG2cD5xgNByHqFJx762CVyaPjJesJmflNYRCFTZkZ6CtsVQxowOT94lJIHiPu9SBYlHRZI9kTCIrXRp+HuwzEnZMIFBW8x/v6RxnO0f2GENcBIlb3Z+kCuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621935; c=relaxed/simple;
	bh=xSSD2tUDNo738USyjqHqi8y5VlyokahQQhmBdLFg4es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OKhxsNjpFKHkhpbyvbpPXiWYJBytTjk1qdkGTciDAJ0qheS8DzsizQ3CvNZFIvdr/0AbvGlKOupMpo9zBQxJKAnfUg7EmRDQTZot1z+DQh12TnCGrtTln3nkVxBFzbisxEnBVz/Nu5WiSXSZbnWcido5Gzfk+/xE+L2Kpt0xzpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdhus1Y9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso9699206a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738621932; x=1739226732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGcdnPMfivw3T5t2Lhe/crDrI/jL06gzbMrHdhzjJRE=;
        b=Wdhus1Y9ICwFoKETIgFY7KkKjpX0sIblnXorp2Fi4P4XZi0lYkxrd67IsEw34OeMXY
         zVZ9eEj8iIraeWosLHLAv59ZUXyz1lW8qMlX9niq3STTNkw9Vtvx66fqX9OHItsJDi7s
         9xYMEHXPlGGJF3kbsNl3KP3YIqHObY0YgJ3MkLUiakkvrmSzSgFma9C3ZTB6wlSKC7XW
         jzDXOarLiOeFJWqKVQktmcrp2271Vzc39rEykjK5PExAB79JJnx1WswFtZSK4vfekIzJ
         6WsVAwS2GBV+n+1Rt/5LPKPHmlxZcJ7sCfhNsbktckTm1xdAIjX/HuPOEfD6YhC3UHKS
         NDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738621932; x=1739226732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGcdnPMfivw3T5t2Lhe/crDrI/jL06gzbMrHdhzjJRE=;
        b=q51C2pcYXv0APv9n5bJiyK6PzsxpI3RRdcU7HZuAk30k1vnxffmMsRcuve5Qr90c9+
         +GH2Q+M+1VxkNGEUJTGgFHWuEdSRtuEvuB5inM1PXp+adSBOVNYcyGDRm5nbjjy/MgnA
         OnxmLTVIEVTyiEdgvZ2sSuBRE9ZFfUTvNlpbz+9AluRQOuU1KqKgczATF1FpDwXwTE8j
         jxdbNMRwVyHk3yBDWgbS3KZeJeKTXeyK9cGf3pkaZjstRrGITEd3COcBRIPxYLo6aOxF
         cLE2ilHseMSAccRL5dnpdkQ87KGP03XLFmmjfn9W6+TMP4mRbBH6FERJFys+YUHWxp7p
         ED3g==
X-Forwarded-Encrypted: i=1; AJvYcCUshbELNxNtfqfZyTwi2SZ/ZKfJ2XExGJJihbyzQdfhHfyeDBV9Ll85M7bN4wNaZqtuXcqoSlGT91s3NmIw@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQakuQnH7GqoEcsB2jbxogjBJ+9PDkw1mXQRx6gu+m1QQf/wI
	MLYBg7fJHlJCncls1HA3vt/W+pzLou8CHBKNEUt5YkrYj4utD65t
X-Gm-Gg: ASbGnctfcd/nO/NbbpJMVvAdEndxE2/FBHZQ4KtCe8Gq8dQRbRAe5M6kPTjQWw5I4Mt
	gih8PBzrl6kwvxGpGKh9ks2swaXD579tB0GOwdZ5adb+Qo2KRlOmj9JDcwlVmtMJFZgaNugzZXk
	NhIMgwV+Novlw+k5hsGEA0kH7WqzM33SIQ1kSV9tBCChVh6OHy4yO36cZoi4Uj+wO/FcQ0wV5Pn
	BrZuFOywoKb5nqQEgZj7o0294VOo8nZ4ojgQ00l11fuD1OVdY1w/JNUJ1TdaGlwu89B99LsntUk
	XDX7gI7xfNvMBTGiW+qd/HKwRnlUyeKWBYXyG9xroZNUZs6hHitTmFtCXmTIsvb5N0Dh+r/rHq7
	ILyFcq87uj7bt
X-Google-Smtp-Source: AGHT+IFs8DO1bLzuoGHimp9/DcKa7QMXgghaPIhlJuVlPrI00IlB+OOHp5y25Eka5dQS06p5ix+h3g==
X-Received: by 2002:a05:6402:2481:b0:5dc:8b8b:3517 with SMTP id 4fb4d7f45d1cf-5dc8b8b38b1mr15466367a12.17.1738621931818;
        Mon, 03 Feb 2025 14:32:11 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724a9c5fsm8339651a12.54.2025.02.03.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:32:11 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fsnotify: use accessor to set FMODE_NONOTIFY_*
Date: Mon,  3 Feb 2025 23:32:03 +0100
Message-Id: <20250203223205.861346-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203223205.861346-1-amir73il@gmail.com>
References: <20250203223205.861346-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FMODE_NONOTIFY_* bits are a 2-bits mode.  Open coding manipulation
of those bits is risky.  Use an accessor file_set_fsnotify_mode() to
set the mode.

Rename file_set_fsnotify_mode() => file_set_fsnotify_mode_from_watchers()
to make way for the simple accessor name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 drivers/tty/pty.c        |  2 +-
 fs/notify/fsnotify.c     | 18 ++++++++++++------
 fs/open.c                |  7 ++++---
 include/linux/fs.h       |  9 ++++++++-
 include/linux/fsnotify.h |  4 ++--
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index df08f13052ff4..8bb1a01fef2a1 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -798,7 +798,7 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 
 	/* We refuse fsnotify events on ptmx, since it's a shared resource */
-	filp->f_mode |= FMODE_NONOTIFY;
+	file_set_fsnotify_mode(filp, FMODE_NONOTIFY);
 
 	retval = tty_alloc_file(filp);
 	if (retval)
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 8ee495a58d0ad..77a1521335a10 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -648,7 +648,7 @@ EXPORT_SYMBOL_GPL(fsnotify);
  * Later, fsnotify permission hooks do not check if there are permission event
  * watches, but that there were permission event watches at open time.
  */
-void file_set_fsnotify_mode(struct file *file)
+void file_set_fsnotify_mode_from_watchers(struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry, *parent;
 	struct super_block *sb = dentry->d_sb;
@@ -665,7 +665,7 @@ void file_set_fsnotify_mode(struct file *file)
 	 */
 	if (likely(!fsnotify_sb_has_priority_watchers(sb,
 						FSNOTIFY_PRIO_CONTENT))) {
-		file->f_mode |= FMODE_NONOTIFY_PERM;
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
 		return;
 	}
 
@@ -676,7 +676,7 @@ void file_set_fsnotify_mode(struct file *file)
 	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
 	    likely(!fsnotify_sb_has_priority_watchers(sb,
 						FSNOTIFY_PRIO_PRE_CONTENT))) {
-		file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
 		return;
 	}
 
@@ -686,19 +686,25 @@ void file_set_fsnotify_mode(struct file *file)
 	 */
 	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
 	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
-				     FSNOTIFY_PRE_CONTENT_EVENTS)))
+				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
+		/* Enable pre-content events */
+		file_set_fsnotify_mode(file, 0);
 		return;
+	}
 
 	/* Is parent watching for pre-content events on this file? */
 	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
 		parent = dget_parent(dentry);
 		p_mask = fsnotify_inode_watches_children(d_inode(parent));
 		dput(parent);
-		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)
+		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
+			/* Enable pre-content events */
+			file_set_fsnotify_mode(file, 0);
 			return;
+		}
 	}
 	/* Nobody watching for pre-content events from this file */
-	file->f_mode |= FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+	file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
 }
 #endif
 
diff --git a/fs/open.c b/fs/open.c
index 932e5a6de63bb..3fcbfff8aede8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -905,7 +905,8 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
+		f->f_mode = FMODE_PATH | FMODE_OPENED;
+		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
 		f->f_op = &empty_fops;
 		return 0;
 	}
@@ -938,7 +939,7 @@ static int do_dentry_open(struct file *f,
 	 * If FMODE_NONOTIFY was already set for an fanotify fd, this doesn't
 	 * change anything.
 	 */
-	file_set_fsnotify_mode(f);
+	file_set_fsnotify_mode_from_watchers(f);
 	error = fsnotify_open_perm(f);
 	if (error)
 		goto cleanup_all;
@@ -1122,7 +1123,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 	if (!IS_ERR(f)) {
 		int error;
 
-		f->f_mode |= FMODE_NONOTIFY;
+		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
 		error = vfs_open(path, f);
 		if (error) {
 			fput(f);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f7..e73d9b998780d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -206,6 +206,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
  * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
  */
+#define FMODE_NONOTIFY_HSM \
+	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
 #define FMODE_FSNOTIFY_MASK \
 	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
 
@@ -222,7 +224,6 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_FSNOTIFY_HSM(mode)	0
 #endif
 
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -3140,6 +3141,12 @@ static inline void exe_file_allow_write_access(struct file *exe_file)
 	allow_write_access(exe_file);
 }
 
+static inline void file_set_fsnotify_mode(struct file *file, fmode_t mode)
+{
+	file->f_mode &= ~FMODE_FSNOTIFY_MASK;
+	file->f_mode |= mode;
+}
+
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 1a9ef8f6784dd..6a33288bd6a1f 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -129,7 +129,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 
-void file_set_fsnotify_mode(struct file *file);
+void file_set_fsnotify_mode_from_watchers(struct file *file);
 
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
@@ -213,7 +213,7 @@ static inline int fsnotify_open_perm(struct file *file)
 }
 
 #else
-static inline void file_set_fsnotify_mode(struct file *file)
+static inline void file_set_fsnotify_mode_from_watchers(struct file *file)
 {
 }
 
-- 
2.34.1



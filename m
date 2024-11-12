Return-Path: <linux-fsdevel+bounces-34503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C99C637A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80862BC4770
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BD3215024;
	Tue, 12 Nov 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="m1J7gQdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0C218332
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434203; cv=none; b=Ejop6dU/rQVTo9zLuFuhQ3ablg29ae/UTCrRyJrusqyJa8xCVGjAB2BMS0JEWiCBC+ZVnTS9e1NREYuBC3td6H7tFZ5sBTR5riZIX8q1RqLt9M3sawsgDEJuNg0WN+u3TJkkFhi6HoiQ0nRmsHW76q+UcY8G9iYuQO7hT/swSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434203; c=relaxed/simple;
	bh=+lplMASGTHN8P1H7PKnzTLs3gf/pli29qBp87Gqi2rs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uee3suLYAQxxVeKfGlC843a+ZEoJsCH1ovUuUfL3oUQi3OmbTeRBDn1k73A9V4xrhN9ow1584h8/JfASdiUV1FWY6UlPULF2F2iFVFTjRSMOlBf56R7kQTKUKs9t5Rvr4qx70pY4utCOD5Qw0ONh7GKP6g2T+XQhHthbcF2/pRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=m1J7gQdQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eb0c2dda3cso24194667b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434201; x=1732039001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR+WXWwndS2FLusUnFYSuykN6wegDmBuVaa7pQ21cd8=;
        b=m1J7gQdQI59ZcFQgCpKOzGYhTiwQf99BGRQ+LpAZ4wOTnwk30KkGf3jgUq8BK+fnPA
         eu4DiVpom9Hl09S/OwgpcUpf+AvEXYJOaUR4/88whgmznPmAwI8GBRskZuiQCQ2pJa5r
         s+n5Y5AuY1z4bLNUBoiUIH5e/qQLIgFuA7daMmuif2/kNaJCPPgkI3uOk2SwwFHCMrf1
         tLZ3khgDe1SNlA2T9mzqzQ5jn0bJGTcvsrZ+RE2HeAgVfnlCqmav29T/nW78MC4EBhwa
         svsHmOaZHWDwUb3lPIEsSQBydu6J4c0p0Nm2DOosy82XkTH7ZAxzAMi5njJPguiy9qZF
         y67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434201; x=1732039001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR+WXWwndS2FLusUnFYSuykN6wegDmBuVaa7pQ21cd8=;
        b=sd4q5pwQEPujjQakprOvZk/DeifVcLQQpVmDbklOAAI2yZmy8DnkG5nusQRyrtWcRJ
         l4WCKwolTTTnCJyMrwr/jXpc00NpLAM2t68ECsFs7jAlRe0rDojpBiqw90bOguUNqPDM
         OixB7SKevHSRMBkUucfqz4to5b+B+zHd4HQX0US64XTpNCzkzEw6hF9Zsp3rXuzITdZb
         jsekiUMB7QrvGUmkbRenJpor5pZGsZ+biHkjmecFuDW8GBVCmImLI8eZUhKKRT3tD3Kb
         lFBiJ95tpYd9zoO4Sx/QcK55QbMjaIvoTp4H2N+ndkVfDF6kZF1kMT9c5+LMN9OH36Ec
         aong==
X-Forwarded-Encrypted: i=1; AJvYcCXIrjQ0wU1P3QXG01f0xqM6gFvTvpCmrpzVJZ1serFGSN7puaBc2c9wuaW4x0Px9P63oDSiN5AzwN2o2G6I@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8Ch9M4u5O5mhNddKcZUmXranNCEKvnTEOAjoyFFNGE3dgRsQ
	/kHNuNQhQYKfyur8dCJxSreQ0GHmbHXYDgB6S8xwUtslUhAK+V4a0ts/mAOzJwc=
X-Google-Smtp-Source: AGHT+IGcFROfyre2Kv1qsuv7MLwuajuAadQn7xHj4Uh/jaGY8cm7A7E77btl+nKFPaxtN+kqNmxpKw==
X-Received: by 2002:a05:690c:6e0a:b0:6e7:e5d6:64cc with SMTP id 00721157ae682-6eadddbd36bmr177209777b3.20.1731434200953;
        Tue, 12 Nov 2024 09:56:40 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f1d2csm26433717b3.42.2024.11.12.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:40 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 08/18] fsnotify: generate pre-content permission event on truncate
Date: Tue, 12 Nov 2024 12:55:23 -0500
Message-ID: <d6648e7f56169468216a3a8155815613de412371.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate FS_PRE_ACCESS event before truncate, without sb_writers held.

Move the security hooks also before sb_start_write() to conform with
other security hooks (e.g. in write, fallocate).

The event will have a range info of the page surrounding the new size
to provide an opportunity to fill the conetnt at the end of file before
truncating to non-page aligned size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/open.c                | 31 +++++++++++++++++++++----------
 include/linux/fsnotify.h | 32 ++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e6911101fe71..e75456cda440 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -81,14 +81,18 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	error = mnt_want_write(path->mnt);
-	if (error)
-		goto out;
-
 	idmap = mnt_idmap(path->mnt);
 	error = inode_permission(idmap, inode, MAY_WRITE);
 	if (error)
-		goto mnt_drop_write_and_out;
+		return error;
+
+	error = fsnotify_truncate_perm(path, length);
+	if (error)
+		return error;
+
+	error = mnt_want_write(path->mnt);
+	if (error)
+		return error;
 
 	error = -EPERM;
 	if (IS_APPEND(inode))
@@ -114,7 +118,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	put_write_access(inode);
 mnt_drop_write_and_out:
 	mnt_drop_write(path->mnt);
-out:
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
@@ -175,11 +179,18 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 	/* Check IS_APPEND on real upper inode */
 	if (IS_APPEND(file_inode(file)))
 		return -EPERM;
-	sb_start_write(inode->i_sb);
+
 	error = security_file_truncate(file);
-	if (!error)
-		error = do_truncate(file_mnt_idmap(file), dentry, length,
-				    ATTR_MTIME | ATTR_CTIME, file);
+	if (error)
+		return error;
+
+	error = fsnotify_truncate_perm(&file->f_path, length);
+	if (error)
+		return error;
+
+	sb_start_write(inode->i_sb);
+	error = do_truncate(file_mnt_idmap(file), dentry, length,
+			    ATTR_MTIME | ATTR_CTIME, file);
 	sb_end_write(inode->i_sb);
 
 	return error;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 2d1c13df112c..f1ef072a3b2f 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -154,17 +154,14 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-static inline int fsnotify_pre_content(const struct file *file,
+static inline int fsnotify_pre_content(const struct path *path,
 				       const loff_t *ppos, size_t count)
 {
-	struct inode *inode = file_inode(file);
+	struct inode *inode = d_inode(path->dentry);
 	struct file_range range;
 	const void *data;
 	int data_type;
 
-	if (!fsnotify_file_watchable(file, FS_PRE_ACCESS))
-		return 0;
-
 	/*
 	 * Pre-content events are only reported for regular files and dirs
 	 * if there are any pre-content event watchers on this sb.
@@ -177,18 +174,17 @@ static inline int fsnotify_pre_content(const struct file *file,
 
 	/* Report page aligned range only when pos is known */
 	if (ppos) {
-		range.path = &file->f_path;
+		range.path = path;
 		range.pos = PAGE_ALIGN_DOWN(*ppos);
 		range.count = PAGE_ALIGN(*ppos + count) - range.pos;
 		data = &range;
 		data_type = FSNOTIFY_EVENT_FILE_RANGE;
 	} else {
-		data = &file->f_path;
+		data = path;
 		data_type = FSNOTIFY_EVENT_PATH;
 	}
 
-	return fsnotify_parent(file->f_path.dentry, FS_PRE_ACCESS,
-			       data, data_type);
+	return fsnotify_parent(path->dentry, FS_PRE_ACCESS, data, data_type);
 }
 
 /*
@@ -206,11 +202,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
+	if (!fsnotify_file_watchable(file, FS_PRE_ACCESS | FS_ACCESS_PERM))
+		return 0;
+
 	/*
 	 * read()/write and other types of access generate pre-content events.
 	 */
 	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS | MAY_OPEN)) {
-		int ret = fsnotify_pre_content(file, ppos, count);
+		int ret = fsnotify_pre_content(&file->f_path, ppos, count);
 
 		if (ret)
 			return ret;
@@ -226,6 +225,14 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return fsnotify_file(file, FS_ACCESS_PERM);
 }
 
+/*
+ * fsnotify_truncate_perm - permission hook before file truncate
+ */
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	return fsnotify_pre_content(path, &length, 0);
+}
+
 /*
  * fsnotify_file_perm - permission hook before file access (unknown range)
  */
@@ -254,6 +261,11 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return 0;
 }
 
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	return 0;
+}
+
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	return 0;
-- 
2.43.0



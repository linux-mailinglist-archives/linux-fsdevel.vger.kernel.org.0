Return-Path: <linux-fsdevel+bounces-34941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E999CF032
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3939B1F28CC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E931EF95B;
	Fri, 15 Nov 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gEgegveC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159F1D5ABF
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684712; cv=none; b=OT8hMdwXP4sBVmg/dQuxNOuoFqNZr7FwO13ANv7y6CJr7IgFO5rpxw3nYY/iCaaWD7VJFKoUZL2HcF3+vBMZA3piOx3WGaKXqoIYZm8z1r/azlJy/cUJ4jvou1b0Bj3d+/PsheFIbl7VOv5UoCioIw9BcnN1+7OBv3nNofJvQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684712; c=relaxed/simple;
	bh=mmiCP5FXX4dhY4TFju9684uZ4Gwy+6bghcevodVCHbw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIfeFz8YtHxMPQ/buJYAqi94mNd3xBDgoww5RS2n7PP4T9E1IiT/+qWkIfwcFemq/WJJ4osqjPywarC9JgBVbDehF1W0JWxfr89I4WH+ZI1cA26HshA3zI+EPmLe6h3zodkwjyOra5tjDm67fzpFbpM8pNXvxG/bp68S0MIKGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gEgegveC; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83abcfb9f37so60832439f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684710; x=1732289510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma7Y5+BFpcWgfxwOepr2mPEvJR7BrAPr6ViHq4rzmZc=;
        b=gEgegveCoTMMo+cZkTn7ilFJrj/mtD71bgnbu5fHQwYfUo6pV7Ss+FFEfgtuprPMGC
         j+/n/WWnXulblkNla3zS7w5iD+f/aH4siIOMz3kTnviiJpal4NetoVnCy0AM700FiahG
         Nlh59G+wvjH/9hwsmlAyaZYnFBjVjvFhWgFsVycl7EOQG9OcZbwMU7gkITR7GX0kqUtZ
         kK1AWpIV5ZlPYCdbireZYFvR8y0VfXXCJfYprpoSaZekIQCk/t7U81SF+xBaUUZrrXox
         qLIqiJ2VgnOAqZ4ROUXA1AYDMCm0Ro5f4ZG4KDL/x+vIUiFEKOEtIPp7nu2U5PWUrXvD
         7nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684710; x=1732289510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma7Y5+BFpcWgfxwOepr2mPEvJR7BrAPr6ViHq4rzmZc=;
        b=ksgcxVKy/gtYmaPqvauW33sqxH0/6L/qcrCI3HbjoSlAMdzzEnDCXKxIN1JhhB7ws/
         TGNJ5v/l0vB+lsxCo/N2C7MjdQt7TatnvxE7KHalgj3PJxtlnEGScAGTA10jDZ1YXp6+
         t/fJhgz/8oRyeQZ3ecfiffPqWyuBSj8Beq0mT0d+fw4QHQQSz/ymEUotKrVYVk1Ef0JX
         MFoHXIZtwbLb7xDPdQ87bMH5lsKU2+s8kGy39JdDJyr1oDaAjddMM4Ow+wdadZu/ScWo
         2eovHth2HKBPLOsSkBD3KkcbNTsoQGy3u2md91OX86ui2jIKC40YbJgVpj8/VOAvQS2r
         Mzdg==
X-Forwarded-Encrypted: i=1; AJvYcCUw7JWC1XpjBPzRFKe64JJ9T4+HBSG2p1Q55xXmJqnJPL5+pAKezYdyx5MyToQTuieXXaR32+jBHfagq1r6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzir/jCL68/nPO8A9WjNSY8uJ1LBOIQETS8XvkKG7hHfMIKi29l
	CngDgiZrpv1ZTr0kjy+ghh9UOXguSr5vAr9VF8zL2b006a2bWWESgMV5IUtnuuPY3gN/vBYcEeH
	X
X-Google-Smtp-Source: AGHT+IH4KF4O/0TeALgb4lQDmEiPTFLtEsIEnnQGgceAZNppg9oa7TyTq0ub2EblRWNTki1B2uNPXQ==
X-Received: by 2002:a05:6902:18ce:b0:e30:e1f3:2a9c with SMTP id 3f1490d57ef6-e3825bdd1fbmr2969338276.0.1731684697839;
        Fri, 15 Nov 2024 07:31:37 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152ab555sm1006714276.12.2024.11.15.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:37 -0800 (PST)
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
Subject: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Fri, 15 Nov 2024 10:30:23 -0500
Message-ID: <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
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

Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.

Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
in the context of the event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first read access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  3 ++-
 fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
 include/linux/fanotify.h           | 14 ++++++++++----
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 2e6ba94ec405..da6c3c1c7edf 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -916,8 +916,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
+	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 456cc3e92c88..5ea447e9e5a8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1640,11 +1640,23 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
 				 (mask & FAN_RENAME) ||
 				 (flags & FAN_MARK_IGNORE);
 
+	/*
+	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
+	 * and they are only supported on regular files and directories.
+	 */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
+			return -EINVAL;
+		if (!is_dir && !d_is_reg(path->dentry))
+			return -EINVAL;
+	}
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1677,7 +1689,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
 	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
 	return 0;
@@ -1778,10 +1790,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		return -EPERM;
 
 	/*
-	 * Permission events require minimum priority FAN_CLASS_CONTENT.
+	 * Permission events are not allowed for FAN_CLASS_NOTIF.
+	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
 	 */
 	if (mask & FANOTIFY_PERM_EVENTS &&
-	    group->priority < FSNOTIFY_PRIO_CONTENT)
+	    group->priority == FSNOTIFY_PRIO_NORMAL)
+		return -EINVAL;
+	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+		 group->priority == FSNOTIFY_PRIO_CONTENT)
 		return -EINVAL;
 
 	if (mask & FAN_FS_ERROR &&
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 89ff45bd6f01..c747af064d2c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -89,6 +89,16 @@
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
 				 FAN_RENAME)
 
+/* Content events can be used to inspect file content */
+#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
+				      FAN_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+
+/* Events that require a permission response from user */
+#define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
+				 FANOTIFY_PRE_CONTENT_EVENTS)
+
 /* Events that can be reported with event->fd */
 #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
 
@@ -104,10 +114,6 @@
 				 FANOTIFY_INODE_EVENTS | \
 				 FANOTIFY_ERROR_EVENTS)
 
-/* Events that require a permission response from user */
-#define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-				 FAN_OPEN_EXEC_PERM)
-
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 79072b6894f2..7596168c80eb 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,8 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
+#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
-- 
2.43.0



Return-Path: <linux-fsdevel+bounces-34282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C09C4689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B0D287444
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49701BD9C0;
	Mon, 11 Nov 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="D0eBahia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1601AB6CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356357; cv=none; b=S/QYUmfMRRsZ9sTfr7Uwb5R+tJSkEtjS14FFInFFUiA45K7dcpbXTC5xIooai87L8PzX0r/l0vdSdP5fbQYS2C8A5B9r9TWTwWPviZgeLHP1LExalH9pgquGVpPpIvfTQm/s99V8ZbRcxz6mu3Q63hT9TXNLGjnRgzJNbJQbzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356357; c=relaxed/simple;
	bh=chNlpW8iwOBtx41TfUvK9qRboNDjBS2Zk4KLK/B4wDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1daBui51DFLNpLHRShIqIqvlOsFtrr7GTFNZhvCD8uGO7IvH9dKgYPz8yG6X67Eky4PNqad5ZwLnvmWvXOdeq1aGAqqPRbt84gTRpnYGk+MWOLdphQl8GGiOvzYSaRlwHyixG3/NFTCyIC+ugIsnwudMN2KrRrME15psMOrRM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=D0eBahia; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4609e784352so34374821cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356354; x=1731961154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqB9yXQqmSu2fdFt06tpBDtWwHudP1dE+kW/6EzrLBA=;
        b=D0eBahiaNze8gynsv3WXmW7FCyBuC25FWljtVFm9aMz9832Rx1lLhwAQPjufViymc6
         4ldQ75YNH/915rkDrSFrvUAmAeIeHlUzJ0XCK/XC0G6apOKvAeVEOeGau240uOrME3Fn
         bPum+q6Tlck1qlGArPHHk5qiFm+DwKDjS8QprlbU7KU+lTxGvjZJqknTLJn/B6Etwsuj
         nAycA1lNIc9AKEmiOTGbRzRjnyHmTXag/iZQisR98x8l7CRgZ+VyuZWDH4CP3VSBc2Gt
         rU8HuxAdMIzstoTrpW0nFpFHVfCMHBhSlBivVR/PznUXOMsqWxLHoLpU5Kr6GGHCJyqg
         LY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356354; x=1731961154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqB9yXQqmSu2fdFt06tpBDtWwHudP1dE+kW/6EzrLBA=;
        b=WzS+gQftXkzzpAjQMEXcYr7YPbqXTw/f4DfqlxOFtBPD7PXFAoLRT+z8iE7nltmS+k
         lD6aL2TXCxLzrWWi8sruDSBhx3qkOfvnlvdOq+ufzOAQNl2BDP5Bef5reeU9W8+Y8wIt
         5GttOekFITUEzHjbNCiM+VsgQBGLE1At0q/PDVE6lZjD9dgvdBbpZm2KgJ7p2bdZRtoc
         HDNDFbXOpfGRr2zWbOVt6sNv+piZjhvqOVZNDIA3U9KqadncVwf4EtpmnlCe5IMm5ZWz
         lMOC3i3iMVParY7ap3ZvZeSFtGGLSCFActbjiWM5GpD8dXbuH4WZWfyFguEZ9XNO5Ahf
         b+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXKOQD4UAYvErpNaSt9ASDlMAyhXoKFbb4ZVfz6llyAW971/BWWzuPIXQ0fXKgo9kfYRqt7f0nbX09Bduwq@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfQ5VmmR9c4ekrIWhX/hOMPYHznHkd9LVTpTTYNpc/f4oMizH
	2B4GLo46dXmEubdvinERi2+b5Z0JZX6FRN0g9mQhJ19SAuwwX0jBzD6XD+wuZ2U=
X-Google-Smtp-Source: AGHT+IFyVEZ8nNhuWSqUTWzgqbTv35BuUsnpAhULP/H0sf68MY9l9ZgPUoCV23Vx6WfGGQrB4k4Iag==
X-Received: by 2002:ac8:5a4b:0:b0:461:7467:e9f1 with SMTP id d75a77b69052e-4634022f337mr184071cf.26.1731356354292;
        Mon, 11 Nov 2024 12:19:14 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df143sm66588861cf.5.2024.11.11.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:13 -0800 (PST)
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
Subject: [PATCH v6 04/17] fsnotify: introduce pre-content permission events
Date: Mon, 11 Nov 2024 15:17:53 -0500
Message-ID: <09566e774319a45108594fe51349c1bb511204f2.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
but it meant for a different use case of filling file content before
access to a file range, so it has slightly different semantics.

Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, so content
scanners could inspect the content filled by pre-content event handler.

Unlike FS_ACCESS_PERM, FS_PRE_ACCESS is also called before a file is
modified by syscalls as write() and fallocate().

FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
pre-content events are only reported for regular files and dirs.

The pre-content events are meant to be used by hierarchical storage
managers that want to fill the content of files on first access.

There are some specific requirements from filesystems that could
be used with pre-content events, so add a flag for fs to opt-in
for pre-content events explicitly before they can be used.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fs.h               |  1 +
 include/linux/fsnotify.h         | 37 ++++++++++++++++++++++++++++----
 include/linux/fsnotify_backend.h | 12 +++++++++--
 security/selinux/hooks.c         |  3 ++-
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 82ae8254c068..0696c1771b2a 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -624,7 +624,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 24);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..1b9f74bda43c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1230,6 +1230,7 @@ extern int send_sigurg(struct file *file);
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
+#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..7c641161b281 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -132,14 +132,29 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+static inline int fsnotify_pre_content(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	/*
+	 * Pre-content events are only reported for regular files and dirs
+	 * if there are any pre-content event watchers on this sb.
+	 */
+	if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
+	    !(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
+	    !fsnotify_sb_has_priority_watchers(inode->i_sb,
+					       FSNOTIFY_PRIO_PRE_CONTENT))
+		return 0;
+
+	return fsnotify_file(file, FS_PRE_ACCESS);
+}
+
 /*
- * fsnotify_file_area_perm - permission hook before access to file range
+ * fsnotify_file_area_perm - permission hook before access of file range
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
-	__u32 fsnotify_mask = FS_ACCESS_PERM;
-
 	/*
 	 * filesystem may be modified in the context of permission events
 	 * (e.g. by HSM filling a file on access), so sb freeze protection
@@ -147,10 +162,24 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
+	/*
+	 * read()/write and other types of access generate pre-content events.
+	 */
+	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)) {
+		int ret = fsnotify_pre_content(file);
+
+		if (ret)
+			return ret;
+	}
+
 	if (!(perm_mask & MAY_READ))
 		return 0;
 
-	return fsnotify_file(file, fsnotify_mask);
+	/*
+	 * read() also generates the legacy FS_ACCESS_PERM event, so content
+	 * scanners can inspect the content filled by pre-content event.
+	 */
+	return fsnotify_file(file, FS_ACCESS_PERM);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 53d5d0e02943..9bda354b5538 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -57,6 +57,8 @@
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 /* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
+#define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -78,8 +80,14 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
-#define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
-				  FS_OPEN_EXEC_PERM)
+/* Content events can be used to inspect file content */
+#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
+				      FS_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
+
+#define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
+				  FSNOTIFY_PRE_CONTENT_EVENTS)
 
 /*
  * This is a list of all events that may get sent to a parent that is watching
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3cac6e..c6f38705c715 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3404,7 +3404,8 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 		perm |= FILE__WATCH_WITH_PERM;
 
 	/* watches on read-like events need the file:watch_reads permission */
-	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
+	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_PRE_ACCESS |
+		    FS_CLOSE_NOWRITE))
 		perm |= FILE__WATCH_READS;
 
 	return path_has_perm(current_cred(), path, perm);
-- 
2.43.0



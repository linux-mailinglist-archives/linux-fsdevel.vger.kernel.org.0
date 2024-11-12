Return-Path: <linux-fsdevel+bounces-34500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7A9C5FA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E0F1F2419B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335E217901;
	Tue, 12 Nov 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KZbnFSMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA32217466
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434198; cv=none; b=fXpYkdlv5F39WTvKETNta0TlKVyzXx25dFpcQtzGwGCG6bZc+zOVplm/ZYKZg3+i4HVss7bNj6yNP6jqkIAbMadxxPC3Tr8tq/dvBgxTtxnYK393Qay8XpY3j2g/EVomvE7mWOfbnNuRxoaBfFbF+xzmUhAVBdjRA2iSfIFfZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434198; c=relaxed/simple;
	bh=KqdRooAgWIiJQIpE4oM2XFeR9nTzjJwjWv3jrWF/TBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+fJrnFmGbxmPhI3VwR7CIz4iBWpWqXHedyfZ55p9uwr6LdToH46NWvc/Bg6L9hOGjRZIR3tIy7/xd5G2g+RYZDeZ7VDC5qRnU6mGoIvIwbxsXuwEcLoPo9/eDSpnL+4ieuxV04ozcch/z+kP2QL/vNfWxr+Va2bOp0h8sgZwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KZbnFSMT; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so5364969276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434196; x=1732038996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLJsKK7R4NzIWRPs6scvSLkW1qqZkqCVN1/0a/AzTQ4=;
        b=KZbnFSMTEJBgZx3FnMbLgTVYsZQH28CFw3qAU1qGyZ3Gv6Y4qxkro7d6iLw7gv0Z3I
         3hhe5+VX19CqSAFxFTq3iE3X5fVQjPHeEf7Jf8kXoeD3dnvAeUGkqXuzSz6LWFaL5Gfe
         W/yJH96yHkNOfkYDfScJMxYTq8rUJeqfln5DklOb+VruiNDZFkqW46FBYMbnr7oyAywB
         n/Fqh9i6qQeLelf8FfKW5w4UFdr7uv2HMqFEi/bKZi2fnJT31JonOWMXtyV70wJ3FVvo
         uIWOpy3pxPiL6yjeyfG9wh4nnVkDC9rwi20bqyol5fNsjQuoC8ULKj5PWRhDQ9VO/6uR
         vcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434196; x=1732038996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLJsKK7R4NzIWRPs6scvSLkW1qqZkqCVN1/0a/AzTQ4=;
        b=CeLhRGpT1vE1HE0Rw+pNt+FmhGm1/vz3LF8fQDm9kqrj8aPkv5i7UwcDDaqSSSMCrh
         JYhBqjkAPl/YpftrjpwySk4u4wz/j2ikAzpkilRnsnvL7+Hyh7fFMUXKxiAar0O/sF+I
         JKRLBBBEiTyT0VvGVOGXSRJuGbLiChd+4z1vV1PiDqM8LUyTszxypKDvTHXGT9P8B35Y
         8BJ4nLDCU1lm+R4oElsq11FgLoMhQEH+xCd2x9jxAkrotE1QCZcRkk9rMqL5GiWTcthQ
         3MoQ5l9O5E/WyUgUkQ3NLnWfP5w5YCD7W2eDXEycZFF9wWmGJ8izCf1rkQ+isS/hTQTI
         pj0g==
X-Forwarded-Encrypted: i=1; AJvYcCUGDISMVL5LEKJp+rq70wsztxI3NAa/BlWeT6hR0uXd1RBHPHeZoa6at7aUVa2Op870ulVYcondD/3YhWXp@vger.kernel.org
X-Gm-Message-State: AOJu0YyU10ZcrLsdN4gahcuqnpFn3KUP+RWX62ws1PPEoQ6xtjocEMvT
	SYU9ObCYR2HO46VnLuwnPF36TWLAT/cM4iPhppIXwIx3FmNs83zj5q3A0XgKMNCSa++K0JqmfNs
	H
X-Google-Smtp-Source: AGHT+IEOgMksI4ZuWIGKlsxQ62qh9QTja1/V58VuHmypKT67lw1RxIlzwCqUPq2uOUJYVFxRqQmgoQ==
X-Received: by 2002:a05:6902:124f:b0:e2b:db9c:5366 with SMTP id 3f1490d57ef6-e337f8ced5cmr17506428276.37.1731434195837;
        Tue, 12 Nov 2024 09:56:35 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1edd7csm2889924276.59.2024.11.12.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:35 -0800 (PST)
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
Subject: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
Date: Tue, 12 Nov 2024 12:55:20 -0500
Message-ID: <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
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
index 316eec309299..cab5a1a16e57 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -626,7 +626,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 24);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9b58e9887e4b..ee0637fcb197 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1232,6 +1232,7 @@ extern int send_sigurg(struct file *file);
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
+#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f0fd3dcae654..0f44cd60ac9a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -154,14 +154,29 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
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
@@ -169,10 +184,24 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
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



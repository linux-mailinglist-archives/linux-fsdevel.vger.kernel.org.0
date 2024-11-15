Return-Path: <linux-fsdevel+bounces-34935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2DE9CF01E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F31F27A32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22F1E3769;
	Fri, 15 Nov 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T3BbY+n+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958281D54D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684697; cv=none; b=MyWMWgPdn+kQkGoS3Jzo5ml+RG/a4t8FflvHqNmb5q+orcWMUpwPn3mDm+JyVj/jUdg7acTfYNrsl8dIkmOh3OH1LH4g/k9ZzcwBa8DkrehVWMDXWmblsXO5AQUTdKvn0t02yoUjpbLedmruf+LpqxBV1vmAYLaBk6anC9vE0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684697; c=relaxed/simple;
	bh=ctuqUXStMMiL6wCBW7aZc8HS3t0BGUFKEOJvAl3AGGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9ukYefz3AdXoRD0kBIlPS+q+46RyLEo7sCDetgI2sKMWxmqN4cZh3LtYa7y4cWWmNyS20s1bwczNPY/lA5V2NluaB68O0pJ67RtFDYT01WoGMiKacEAeLzkUTCquh+3N2pTlG+vCpNdOL+HJVQwX3TS8I90AjHn1nO5dEarNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T3BbY+n+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so902704276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684693; x=1732289493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRzK4Q1A3yuX/T2NQizEcUBNaZlB/P7dkcHbBOaMevU=;
        b=T3BbY+n+jl+xxwNJzLGRuZGg6RiOVOkpOmuIqm9z855f7Z7pvxKgCRUM1Rz77erGKZ
         Ya/m6LSFSAzt/uAXD2qsK8m4hyhQxzHHsS0zFfJ/L1im4m7r1UroF7GPWaPgqmgIZCn4
         KL//bW4THtd6UlHDKNgYqvEUWVKD2i/HF4Suvg6k0bt4i/YuO+pc0Ga7nk491u2MGbbM
         YxOg+v7gD00MQroSs0uJ1FiDO736zmr+s0vVjqYGauvDSy3eC2mmmREsB8AtATK0ZXvw
         ZP8i31YpCbC5tCPwxTyhAwCFVnYV9o4BNuK47TlvlDh1GsqKzDXpN0Ky78E1GqHVPeOH
         7SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684693; x=1732289493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRzK4Q1A3yuX/T2NQizEcUBNaZlB/P7dkcHbBOaMevU=;
        b=KKkbyo3/1wmC8Hgzy9jWg6I+ugcVXMepc2Rg1t+mTDaEUOmZNSFRn8ZZ4LwJakbzLZ
         EJDNIqAui5XuyZeGdoz3hVmlwgFao6Bp8TV+FKwCLVA7Ye0l2SfiwSwkZ3iNLm/XnU4F
         lvUQ34TE7VzNHZCMQq3D0olVVQ/QlBjfaEmVmeCEod0AvGqlrI79PbL2K9eoStS2CAf1
         1gk3mGWMDL2xpAq1zqYUF8uNlB7j4642wfsCxjpLgf0RmeUJckcT+Ch3bJ5wp5vm9RSV
         ayx2hOGeL0sYik0IaP4L+rCnwg3Px6R0RMtVfeX9QKZ4Gz9jewqk6+i1YKjCiM+xGmhE
         yRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+YRo0MjwEfJECz0s2TBcsBfOwvcANAZGdiNyTcpgX6YIod8R2G7VvayZIAbr+2UEmhOROr4X997I0msIZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfo0dEb0Vr/GuLM969ppKP9eLqf9pCcHMOatpnliemyDCQcO1
	hlW0cRmxenKztHS1pTSnqyNx9lv1z6MpOdRtiOaw8BVCMBQ13IW5cenYatx6bVA=
X-Google-Smtp-Source: AGHT+IGyWRJgeIXfM96kmRgZ4BcfzpHMEUIT23gvUh5NA4jhWm1kPkotZW2CvGFTnhHweMUdUT4Lug==
X-Received: by 2002:a05:6902:f84:b0:e2b:b45a:149 with SMTP id 3f1490d57ef6-e382639f2b5mr2742461276.39.1731684693281;
        Fri, 15 Nov 2024 07:31:33 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152d0248sm963707276.23.2024.11.15.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:32 -0800 (PST)
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
Subject: [PATCH v8 07/19] fsnotify: introduce pre-content permission events
Date: Fri, 15 Nov 2024 10:30:20 -0500
Message-ID: <b934c5e3af205abc4e0e4709f6486815937ddfdf.1731684329.git.josef@toxicpanda.com>
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
 include/linux/fsnotify.h         | 39 ++++++++++++++++++++++++++++----
 include/linux/fsnotify_backend.h | 12 ++++++++--
 security/selinux/hooks.c         |  3 ++-
 5 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 33576a848a9f..d128cb7dee62 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -649,7 +649,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 24);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8e5c783013d2..d231f4bc12aa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1256,6 +1256,7 @@ extern int send_sigurg(struct file *file);
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
+#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 54ec97366d7c..994d7a322369 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -134,9 +134,10 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
  * Later, fsnotify permission hooks do not check if there are permission event
  * watches, but that there were permission event watches at open time.
  */
-static void file_set_fsnotify_mode(struct file *file)
+static inline void file_set_fsnotify_mode(struct file *file)
 {
 	struct super_block *sb = file->f_path.dentry->d_sb;
+	struct inode *inode;
 
 	/* Is it a file opened by fanotify? */
 	if (FMODE_FSNOTIFY_NONE(file->f_mode))
@@ -162,6 +163,19 @@ static void file_set_fsnotify_mode(struct file *file)
 		file->f_mode |= FMODE_NONOTIFY_HSM;
 		return;
 	}
+
+	/*
+	 * There are pre-content watchers in the filesystem, but are there
+	 * pre-content watchers on this specific file?
+	 * Pre-content events are only reported for regular files and dirs.
+	 */
+	inode = file_inode(file);
+	if ((!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode)) ||
+	    likely(!fsnotify_file_object_watched(file,
+						FSNOTIFY_PRE_CONTENT_EVENTS))) {
+		file->f_mode |= FMODE_NONOTIFY_HSM;
+		return;
+	}
 }
 
 /*
@@ -177,12 +191,29 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
+	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
+		return 0;
+
+	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
+		return 0;
+
+	/*
+	 * read()/write() and other types of access generate pre-content events.
+	 */
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
+		int ret = fsnotify_path(&file->f_path, FS_PRE_ACCESS);
+
+		if (ret)
+			return ret;
+	}
+
 	if (!(perm_mask & MAY_READ))
 		return 0;
 
-	if (likely(file->f_mode & FMODE_NONOTIFY_PERM))
-		return 0;
-
+	/*
+	 * read() also generates the legacy FS_ACCESS_PERM event, so content
+	 * scanners can inspect the content filled by pre-content event.
+	 */
 	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 2dc30cf637aa..33880de72ef3 100644
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



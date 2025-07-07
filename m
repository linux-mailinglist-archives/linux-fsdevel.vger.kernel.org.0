Return-Path: <linux-fsdevel+bounces-54147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB1AFB9A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89104A27B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400C6220F27;
	Mon,  7 Jul 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5zqO6Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0B21E0BA
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908033; cv=none; b=Czs5HrWQpnpYB1YXF/LhSSaAcXF8OW5NpKgVQrLYNN4E+PC5AaBu/dXNuiQHQRSehbDjY06zNt22QDytunx4mQVcyq3gVMwTNpcK1pNwGuDhjTQFC8F99VHRlqAeQDVX0HITjWYHtfHINIxMSOSrHAaTGoz3NLuVPs8tULyCHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908033; c=relaxed/simple;
	bh=7dzfgQg2JBiFE78BxTAiwyGkiyrRuSD1MBJj1SCwcyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZerRG4hMZ9lFs+LWrd8b1lRrSeaj6GP8/ybICekhG6Yu63+gl2V3TOzHTQe7hq+spbMkOjNxHqvGrMyvrLzN95N/M5XTd31wzTaKcksAnDfrA+AHWhD4EUCcXa0tebzj1WRwmtknNuI3dLk/B4l3chaoFB06N9lXAD6ne1OAiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5zqO6Fo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so5568586a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751908030; x=1752512830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZf9Smz1pxb3AVnyiuhtq9+Tg8jZ3gcbrAnTUdRmFtw=;
        b=C5zqO6FoWNe+laQrWt3PKAWtqAXqlVp0QomaZ5LC2DhAd5Wn2acmhCvLous6N3accr
         Y4xZm1Qy97QcM8Zq8XdjviDW3UmDfpECGFySkOH7fUzbWeCxWcgMlXyBR6Zv4QYAldVx
         ALprd1y8RPtykzN0rjB4Ca1y5mnHE2sUKcbrIPcY2NPchpUvoz6NSufQa8DRFGae5YYY
         3dARVG3L9aOc7Brxg++5MHJ50ZkxKJ8Yu6BDAyZplMJlMSyQYGwxzCtiLBbaBEC4nctq
         dKdtn+MrjEGJmYrJcQmox4689fxPlhCAEyehZzpVPpa6kwhizdZiikb78bL6+ZAlD7A2
         Ofmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908030; x=1752512830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZf9Smz1pxb3AVnyiuhtq9+Tg8jZ3gcbrAnTUdRmFtw=;
        b=JGgZ8JMEcwHLwvAXdvcPQsrRY+xSJXGTtULgimlVQNyFjEl0bEADluJxy/+W+MAwcn
         /SqpYKGYj/K1gceVEA8JlJslbmpr1lHf8qaHvoeRBFKEc87jhE9uyREW/kGcV2zRkIHB
         WNAuif1INAOdmVO0Hr5oWPTo7hSBvBZeZB5cY/Y703raJ8a0sDzCdulsqX18wF8vmpAS
         OjMsaexuYKMX6Df56Jt86BulWpvp617ms4coeNUxwcp01fgPTN8sOWT9Lj1fp/IX4zJP
         +OAGfICErZ21LaQi7TNcnfKHX73zKp5zzMi7k1hcWjqxqAnB+IZpHnRJStQe8NhKcin+
         ooeg==
X-Forwarded-Encrypted: i=1; AJvYcCU+pxjqUiyEuJlPd5+X3mSUn6AON6XTwKSYJgqX7Onv4Wkh/q35inO47EtMzUiRxSqzSAjLOiGOG1lo+ZuT@vger.kernel.org
X-Gm-Message-State: AOJu0YzbofXtxn+zK6/9tRwO/n/vWRJvnmCdPsKTqxghP7IkWc38wXVD
	2eRRkZoWa2ALn/fJjUd6MHGQw4uTFd3op0JuIp8rkIy8V097OYGqIi500YTns9W1
X-Gm-Gg: ASbGncvEvlAY/pSO7jAUvaa26KVGU0Sqp4LvOO8UWBQOk6xBfUX/RPk6b6hp/URYpN+
	Gs0bXOr7ncB8Qf60CL5htmYfrF/AZPvvctiMA/ck4xl87vqI4scDzkHteNNlqgrKvBF70PHG+yu
	Vt3AX/DIQgiFajxiHDUq2l8HtZNSZHHbCiBrdyYGdy+KyAFfEqiK6joS/B+bjXZHkU2ylsCNhtR
	WDFBYTcQkh5V86Wr6AXbNdmIo82edYCZqSGf4P6RQv+bHkQpY7RQMgGkzKex1vfga0OovDeSyBy
	wXEVOGeZkSsAyRnIbKrneWfbdo2tIdeJZQ6QcFFmoWVGaQTPWP+l6TppjX/cvcAnUEWiO8MC85B
	BF5rMFtIIUP+lD34bMwrwR/4/0k2irLZ53hbWgVFefcqOHqPQuIz5
X-Google-Smtp-Source: AGHT+IHDwolZ/p0KFZ8sVJE8Hq9vSA4xMfPBG8kqZDSJ5KDNqs5tT4AUnwCa2iRxf8lIL7PwnQ6Efg==
X-Received: by 2002:aa7:d947:0:b0:60c:7018:de04 with SMTP id 4fb4d7f45d1cf-610461a0c53mr326242a12.10.1751908029797;
        Mon, 07 Jul 2025 10:07:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ff11c3e83sm4251234a12.66.2025.07.07.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:07:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fsnotify: merge file_set_fsnotify_mode_from_watchers() with open perm hook
Date: Mon,  7 Jul 2025 19:07:03 +0200
Message-ID: <20250707170704.303772-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707170704.303772-1-amir73il@gmail.com>
References: <20250707170704.303772-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create helper fsnotify_open_perm_and_set_mode() that moves the
fsnotify_open_perm() hook into file_set_fsnotify_mode_from_watchers().

This will allow some more optimizations.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c          |  2 +-
 fs/notify/fsnotify.c     | 22 +++++++++++++---------
 fs/open.c                |  6 +++---
 include/linux/fsnotify.h |  8 +++-----
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index f09d79a98111..81c72576e548 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -199,7 +199,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	file_ref_init(&f->f_ref, 1);
 	/*
 	 * Disable permission and pre-content events for all files by default.
-	 * They may be enabled later by file_set_fsnotify_mode_from_watchers().
+	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
 	 */
 	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
 	return 0;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index e2b4f17a48bb..de7e7425428b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -656,12 +656,12 @@ EXPORT_SYMBOL_GPL(fsnotify);
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 /*
- * At open time we check fsnotify_sb_has_priority_watchers() and set the
- * FMODE_NONOTIFY_ mode bits accordignly.
+ * At open time we check fsnotify_sb_has_priority_watchers(), call the open perm
+ * hook and set the FMODE_NONOTIFY_ mode bits accordignly.
  * Later, fsnotify permission hooks do not check if there are permission event
  * watches, but that there were permission event watches at open time.
  */
-void file_set_fsnotify_mode_from_watchers(struct file *file)
+int fsnotify_open_perm_and_set_mode(struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry, *parent;
 	struct super_block *sb = dentry->d_sb;
@@ -669,7 +669,7 @@ void file_set_fsnotify_mode_from_watchers(struct file *file)
 
 	/* Is it a file opened by fanotify? */
 	if (FMODE_FSNOTIFY_NONE(file->f_mode))
-		return;
+		return 0;
 
 	/*
 	 * Permission events is a super set of pre-content events, so if there
@@ -679,7 +679,7 @@ void file_set_fsnotify_mode_from_watchers(struct file *file)
 	if (likely(!fsnotify_sb_has_priority_watchers(sb,
 						FSNOTIFY_PRIO_CONTENT))) {
 		file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
-		return;
+		return 0;
 	}
 
 	/*
@@ -689,8 +689,9 @@ void file_set_fsnotify_mode_from_watchers(struct file *file)
 	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
 	    likely(!fsnotify_sb_has_priority_watchers(sb,
 						FSNOTIFY_PRIO_PRE_CONTENT))) {
-		file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
-		return;
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
+				       FMODE_NONOTIFY_PERM);
+		goto open_perm;
 	}
 
 	/*
@@ -702,7 +703,7 @@ void file_set_fsnotify_mode_from_watchers(struct file *file)
 				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
 		/* Enable pre-content events */
 		file_set_fsnotify_mode(file, 0);
-		return;
+		goto open_perm;
 	}
 
 	/* Is parent watching for pre-content events on this file? */
@@ -713,11 +714,14 @@ void file_set_fsnotify_mode_from_watchers(struct file *file)
 		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
 			/* Enable pre-content events */
 			file_set_fsnotify_mode(file, 0);
-			return;
+			goto open_perm;
 		}
 	}
 	/* Nobody watching for pre-content events from this file */
 	file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
+
+open_perm:
+	return fsnotify_open_perm(file);
 }
 #endif
 
diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa..f240b96ce586 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -943,12 +943,12 @@ static int do_dentry_open(struct file *f,
 		goto cleanup_all;
 
 	/*
-	 * Set FMODE_NONOTIFY_* bits according to existing permission watches.
+	 * Call fsnotify open permission hook and set FMODE_NONOTIFY_* bits
+	 * according to existing permission watches.
 	 * If FMODE_NONOTIFY mode was already set for an fanotify fd or for a
 	 * pseudo file, this call will not change the mode.
 	 */
-	file_set_fsnotify_mode_from_watchers(f);
-	error = fsnotify_open_perm(f);
+	error = fsnotify_open_perm_and_set_mode(f);
 	if (error)
 		goto cleanup_all;
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 454d8e466958..8c1fa617d375 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -129,7 +129,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 
-void file_set_fsnotify_mode_from_watchers(struct file *file);
+int fsnotify_open_perm_and_set_mode(struct file *file);
 
 /*
  * fsnotify_file_area_perm - permission hook before access to file range
@@ -215,9 +215,6 @@ static inline int fsnotify_open_perm(struct file *file)
 {
 	int ret;
 
-	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
-		return 0;
-
 	if (file->f_flags & __FMODE_EXEC) {
 		ret = fsnotify_path(&file->f_path, FS_OPEN_EXEC_PERM);
 		if (ret)
@@ -228,8 +225,9 @@ static inline int fsnotify_open_perm(struct file *file)
 }
 
 #else
-static inline void file_set_fsnotify_mode_from_watchers(struct file *file)
+static inline int fsnotify_open_perm_and_set_mode(struct file *file)
 {
+	return 0;
 }
 
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
-- 
2.43.0



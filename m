Return-Path: <linux-fsdevel+bounces-54265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4AEAFCDDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D002418854DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541972DFA37;
	Tue,  8 Jul 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov6ggaU+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D4204583
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985410; cv=none; b=Jc35GTNPVujuvTNgXNTorQODyJdjULEQaIVHq066AJe0pRASsBo1NLXnQZOw0FtqKBoklS2dxq81VWSmKvwJUWElYq9ergb7te5fzytDm0/MCtQC4w1j8iENCLyU15L0SCF6cWNfM8eBFfxmaL5xdOmfeuKckIXpAFnUbN81nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985410; c=relaxed/simple;
	bh=7dzfgQg2JBiFE78BxTAiwyGkiyrRuSD1MBJj1SCwcyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcNx2anlj+03A68vXTxh1KmJf8qPxuCBeuaLN8OVtfqRgkj1CiW9dbWrRoU/+vsBf7u+2GoFzAeNhvsw+nTOg8A/1rlgM0YTcYrFJ1jvZC5ReXUZvVH3yNT5M+ht6fV9XM4binDmNv+LvCok7bKrsQjGA6WAg69Cc4S9Kc3G5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov6ggaU+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ade76b8356cso810985766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jul 2025 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985407; x=1752590207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZf9Smz1pxb3AVnyiuhtq9+Tg8jZ3gcbrAnTUdRmFtw=;
        b=Ov6ggaU+xTckFQBxI0V3hJgEnmtA0YxnpOoiFugn42iePFi8/tixHyEw/7FiXuAUFS
         poIWr9mMyuAP6LBzbwDsklDmhWDkbj6LVJpAnJuH3O/SBgEhB8wOx8XFGYi1f3xoYIl6
         E6sfgOfV2Zg+/BEdpox2wxRMCignP5YnR5woCjRd5BODCitMUQI26c88zXFAeS7K3IMt
         WFKv9l58CKfSRryOroZz6XmPRk456b2fUh+DEPh4SLzCoLe2+G+U+tDDVaUX/KW+EVis
         0/kv2W0Z9G1wFGuxFWb9CCPiXX9zFVBiBzb5hN98SBZ7Aj5cWgMDbaMf5Mp7zSDJEfvt
         fkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985407; x=1752590207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZf9Smz1pxb3AVnyiuhtq9+Tg8jZ3gcbrAnTUdRmFtw=;
        b=dxNKQKilWNZXR0q83LRpAAeZEIrl6KEHErExXE2y1eJelAN29QlyaCGT7WKZolWNaA
         ajNhqlEvsHYEtrLHyjwPsUumApIV6OZWhZgU1peL5LwMoJOv5A2UKX9xJ1m+zZkqyWHu
         26WFKGvLStcyRUKyvn6srGRnf7vT41OTcrk7p0xoxLIztAxEyDIPIpM2/5FGWljCGYcj
         QnUZOKNxSgZYqVRUH7+s33IyMbecWeCnbeb3RPiGre+EA00TNu8IRzrUGpeQyo5KJMmX
         trKwKqFlRdVWvZnYod2htP+bZUcsu8rCSShgQzWjXvTZ07yntbr4FiBXcrtn1zNi/lo9
         YbLA==
X-Forwarded-Encrypted: i=1; AJvYcCWFrQeybdB6trQV2AwAEY/fEBbXawyrSTRhcED2Z20CEAZ/8Col5FTopeBfRNpv5Y2lcM99HNd7w7+xmkT3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+9G63mcSk3mD/4SUMxwcPvQnoGdOIhOo0e5BTuyTXNfJS9dV
	H08BeiEJ+o6meD+4BA3mVRru+d8CDEq8Z38h7mr7UqW0/ine9gDOz7Zn
X-Gm-Gg: ASbGnct6K0CzUBQSyRkZEsNkh8L8GbNmMfLc01lf3dfiOBjHKPH1QYhJQnp0EIrkzUm
	72uSjNNkPECiIJ+anKNoXO8I6wM0/O6KxBTqhdKnO1AWwnkp3EdbC8StAAqY+Fm/TF63oHcYU9z
	BbppH55sTybyEiwzRK+f9WeIyUNMm/WArcE+4od956nzFtpV5dQ/0MhUxlxZYKDDt/HTz88zyLL
	pBtxahmTtUpAGDzMlXNtNFgfDgIfT71ypYCrfM21+80DST5Iux/UCOtKAJ9kOU/33O9UX/ljhhm
	5RtZZjYV5GnkIqRaEF/p2wfk5y33bnbaZ0qez6DXEfZaVz5Keib81CwRyPW55PZ2cw+yygcDbjZ
	4Duxpvlu6kdNUaSAHLoPQ2899DTElwmJUaX71kGTCT4fccLdBrSvM
X-Google-Smtp-Source: AGHT+IGJbE2lXfYcQRnkSRegCJ+rJgg3wK0K0PYqWdMOlpj7a6snA/7ocMF5HXzr5mnoUrm7gdIlGg==
X-Received: by 2002:a17:907:d58f:b0:ad8:9c97:c2da with SMTP id a640c23a62f3a-ae3fbe073d1mr1741953766b.40.1751985406777;
        Tue, 08 Jul 2025 07:36:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696574sm7393068a12.28.2025.07.08.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:36:46 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fsnotify: merge file_set_fsnotify_mode_from_watchers() with open perm hook
Date: Tue,  8 Jul 2025 16:36:40 +0200
Message-ID: <20250708143641.418603-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708143641.418603-1-amir73il@gmail.com>
References: <20250708143641.418603-1-amir73il@gmail.com>
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



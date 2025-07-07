Return-Path: <linux-fsdevel+bounces-54148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2154AFB99A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6CC7ACDE4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DD02E7F3B;
	Mon,  7 Jul 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfPghDMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B0231837
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908034; cv=none; b=fNy19mCSam4RQ75zgiRpHnleKm9V1pkZ8ZvuVyWeGOVF07g4Zgchbmzy4z3MR6NKuOfvzhs1d+4RXXycX/4QHZzb6+vRRNG4b+waZHph68Ie1olcv28ZMsIjdmVVV1LHhFURbNdtVj/4hXK7V6PAJ37hF14fX4xrWz00GnmXb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908034; c=relaxed/simple;
	bh=zUj+h2SUTeaFEIydlQWVoqYqDkOaHHlafKXK6MB3K4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWakL5bf0C5H4RR55cQeCE/4BaGa+FJECUkuir+/7uXfiZeUmKVSwkYUp+tD760YzH1awo/ooPexX9BLveCmaeKlksJaoe/oh8cDj1PxcWAkSCa9VQZpuGiLk1nDCC6m2sDy+n0L6OX2hfFyk+NyiNXWOPF4wtn/LucoA3Sg9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfPghDMb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so5548878a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751908031; x=1752512831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTFK7SGLAemWq9XmiH31oDF2MjOY20yH/9tQz6oiHyE=;
        b=WfPghDMbuFV5mpBe5FtUxc9riqo7Ropb2EMB0eIPxQcxNZv0VnRbtieh6JIbJkDgLw
         uW+tylvJrFB9vMOpt7IDMoYwPStHU1FYJ2XGol5JtaYz4AZubd6PxIkQWMbAsnMWG096
         snD/X9wSAjt+wapR95n3e5RNCZWZLsrrdZ2pgVowdQyDYlzuj0QdqHgPt/g1+sPjW6Tf
         MDXynSKXevS/pEiWzIvhI2oLNcUkmFgS8apwG9ENdoGIv+EfcDZBc2hwaAO9DNoUtLpH
         I8bP2iOXIXjOA3R8vrfQM1jzcuwjDOePgGsoRmq81P069BrLw00W0y5BBV6ITEvFVgEu
         sNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751908031; x=1752512831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTFK7SGLAemWq9XmiH31oDF2MjOY20yH/9tQz6oiHyE=;
        b=ms98ibtQhMdKKr52DpceAg+FDra+1EZSPfD/8XUeBT2OXyPGLxQXsgQldSPCPkpNt9
         4HSOWWBALqHmifmQfZsh1jLzxyEi8FbA/abJLIheDQXjoF3u8VSl5ITwqHAZoSUPVD2C
         wXbDUr/Xugkde7c8EpCstGHFeJgRpEb3sv05Eh2XdpeAmt8d+wljZhHWnj4srJ2GjkK2
         4SJ6Lp0YwM/tFuouwyASQ5oDaNIbhBBomtzBn3Qkevpbgo+F/LMHnvwRxWRw3GE6/VMx
         s71/kCEC3agiGV9mVMUt7yPTj6elrXnMGEsiCfP6GMjhw99SiO5g7YAHUPP5tv0AWIud
         ty0w==
X-Forwarded-Encrypted: i=1; AJvYcCXHj0lzbszlRYwAugbiFBNoxVPsl38P3rsY69YPxjRQoQKMvBmFdDN4cEM0YzCmC+zmtoQEj9mMK+OetJdg@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyjioJeAwFcCuSFjeqohgRkMuLd3o2Eiuk3CzIZRpaG1h6ZHl
	e1HbbxGK2+Fw8pQoVbtjDDeRDlOobDmZq44Qgx2YmuLDgGWtXBhyPJujQApyHFrk
X-Gm-Gg: ASbGnctHUtfBxIFNOXuMmYDNRMKR6aX5P/SU0/3Q0hjWm1S1pJRH4X4PxP60wvTEv56
	9RFb/F2Df0lWjwJmUTS34Lci+mVATwCGV8yHk3rrSg5cILmjEgt0od6eda2MCMQLSv9llcWioU0
	hSYCkoJRYYvnDmA+MJIfu2Tf6felXJ9EgMxBM+0XoJfY6fsg4Sv3ForyPPL1WLqjHnGcsv3OTul
	o6gEFM1ty/BCLUUDlB+7ldmEvefUsIuooL74tE5eBl/BEpzBrVAZ7PF7AsPMR53hz00nqnskNtu
	RyImQ4p/qf+MZo+7H5MCgEVQW0bYF+pYyowuzC8YdBx7eZh1CLf8O4x1RfJJNVewJ4sjCz09pAP
	hvB+kY5EV27gxfWBEgeMwwi0+44bG8Xh5ANr9ykkKt+vj+uE34hbDfFYwdMA+qPk=
X-Google-Smtp-Source: AGHT+IHudF8ZJxaQJTI8B24wXXv244/bS4MjWeUlELLn1jMhNdlME+YAo9UAqJcylYb/dwaIv2kBBQ==
X-Received: by 2002:a05:6402:280a:b0:5fc:4023:1fd2 with SMTP id 4fb4d7f45d1cf-60fd6e47b44mr13137036a12.28.1751908030667;
        Mon, 07 Jul 2025 10:07:10 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60ff11c3e83sm4251234a12.66.2025.07.07.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:07:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases
Date: Mon,  7 Jul 2025 19:07:04 +0200
Message-ID: <20250707170704.303772-3-amir73il@gmail.com>
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

The most unlikely watched permission event is FAN_ACCESS_PERM, because
at the time that it was introduced there were no evictable ignore mark,
so subscribing to FAN_ACCESS_PERM would have incured a very high
overhead.

Yet, when we set the fmode to FMODE_NOTIFY_HSM(), we never skip trying
to send FAN_ACCESS_PERM, which is almost always a waste of cycles.

We got to this logic because of bundling open permisson events and access
permission events in the same category and because FAN_OPEN_PERM is a
commonly used event.

By open coding fsnotify_open_perm() in fsnotify_open_perm_and_set_mode(),
we no longer need to regard FAN_OPEN*_PERM when calculating fmode.

This leaves the case of having pre-content events and not having access
permission events in the object masks a more likely case than the other
way around.

Rework the fmode macros and code so that their meaning now refers only
to hooks on an already open file:

- FMODE_NOTIFY_NONE()	skip all events
- FMODE_NOTIFY_PERM()	send all access permission events
- FMODE_NOTIFY_HSM()	send pre-conent permission events

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c             | 83 +++++++++++++++++++++-----------
 include/linux/fs.h               |  6 +--
 include/linux/fsnotify.h         | 27 +----------
 include/linux/fsnotify_backend.h |  6 ++-
 4 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index de7e7425428b..0c109c50e0cb 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -199,8 +199,8 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 }
 
 /* Are there any inode/mount/sb objects that watch for these events? */
-static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
-					   __u32 mask)
+static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
+					    __u32 mask)
 {
 	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
 			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
@@ -665,7 +665,7 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry, *parent;
 	struct super_block *sb = dentry->d_sb;
-	__u32 mnt_mask, p_mask;
+	__u32 mnt_mask, p_mask = 0;
 
 	/* Is it a file opened by fanotify? */
 	if (FMODE_FSNOTIFY_NONE(file->f_mode))
@@ -683,45 +683,70 @@ int fsnotify_open_perm_and_set_mode(struct file *file)
 	}
 
 	/*
-	 * If there are permission event watchers but no pre-content event
-	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
+	 * OK, there are some permission event watchers. Check if anybody is
+	 * watching for permission events on *this* file.
 	 */
-	if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
-	    likely(!fsnotify_sb_has_priority_watchers(sb,
-						FSNOTIFY_PRIO_PRE_CONTENT))) {
-		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
-				       FMODE_NONOTIFY_PERM);
+	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
+	p_mask = fsnotify_object_watched(d_inode(dentry), mnt_mask,
+					 ALL_FSNOTIFY_PERM_EVENTS);
+	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
+		parent = dget_parent(dentry);
+		p_mask |= fsnotify_inode_watches_children(d_inode(parent));
+		dput(parent);
+	}
+
+	/*
+	 * Without any access permission events, we only need to call the
+	 * open perm hook and no further permission hooks on the open file.
+	 * That is the common case with Anti-Malware protection service.
+	 */
+	if (likely(!(p_mask & FSNOTIFY_ACCESS_PERM_EVENTS))) {
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
 		goto open_perm;
 	}
 
 	/*
-	 * OK, there are some pre-content watchers. Check if anybody is
-	 * watching for pre-content events on *this* file.
+	 * Legacy FAN_ACCESS_PERM events have very high performance overhead,
+	 * so unlikely to be used in the wild. If they are used there will be
+	 * no optimizations at all.
 	 */
-	mnt_mask = READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_mask);
-	if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
-				     FSNOTIFY_PRE_CONTENT_EVENTS))) {
-		/* Enable pre-content events */
+	if (unlikely(p_mask & FS_ACCESS_PERM)) {
+		/* Enable all permission and pre-content events */
 		file_set_fsnotify_mode(file, 0);
 		goto open_perm;
 	}
 
-	/* Is parent watching for pre-content events on this file? */
-	if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
-		parent = dget_parent(dentry);
-		p_mask = fsnotify_inode_watches_children(d_inode(parent));
-		dput(parent);
-		if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
-			/* Enable pre-content events */
-			file_set_fsnotify_mode(file, 0);
-			goto open_perm;
-		}
+	/*
+	 * Pre-content events are only supported on regular files.
+	 * If there are pre-content event watchers and no permission access
+	 * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
+	 * That is the common case with HSM service.
+	 */
+	if (d_is_reg(dentry) && (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
+		file_set_fsnotify_mode(file, FMODE_NONOTIFY |
+					     FMODE_NONOTIFY_PERM);
+		goto open_perm;
 	}
-	/* Nobody watching for pre-content events from this file */
-	file_set_fsnotify_mode(file, FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
+
+	/* Nobody watching permission and pre-content events on this file */
+	file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
 
 open_perm:
-	return fsnotify_open_perm(file);
+	/*
+	 * Send open perm events depending on object masks and regardless of
+	 * FMODE_NONOTIFY_PERM.
+	 */
+	if (file->f_flags & __FMODE_EXEC && p_mask & FS_OPEN_EXEC_PERM) {
+		int ret = fsnotify_path(&file->f_path, FS_OPEN_EXEC_PERM);
+
+		if (ret)
+			return ret;
+	}
+
+	if (p_mask & FS_OPEN_PERM)
+		return fsnotify_path(&file->f_path, FS_OPEN_PERM);
+
+	return 0;
 }
 #endif
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45fe8f833284..1d54d323d9de 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -205,7 +205,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
  *
  * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
  * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
- * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content events.
+ * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - .. (excl. pre-content) events.
  */
 #define FMODE_FSNOTIFY_MASK \
 	(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
@@ -213,10 +213,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_FSNOTIFY_NONE(mode) \
 	((mode & FMODE_FSNOTIFY_MASK) == FMODE_NONOTIFY)
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-#define FMODE_FSNOTIFY_PERM(mode) \
+#define FMODE_FSNOTIFY_HSM(mode) \
 	((mode & FMODE_FSNOTIFY_MASK) == 0 || \
 	 (mode & FMODE_FSNOTIFY_MASK) == (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM))
-#define FMODE_FSNOTIFY_HSM(mode) \
+#define FMODE_FSNOTIFY_PERM(mode) \
 	((mode & FMODE_FSNOTIFY_MASK) == 0)
 #else
 #define FMODE_FSNOTIFY_PERM(mode)	0
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 8c1fa617d375..6be0298701ae 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -147,9 +147,6 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
 		return 0;
 
-	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
-		return 0;
-
 	/*
 	 * read()/write() and other types of access generate pre-content events.
 	 */
@@ -160,7 +157,8 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 			return ret;
 	}
 
-	if (!(perm_mask & MAY_READ))
+	if (!(perm_mask & MAY_READ) ||
+	    likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
 		return 0;
 
 	/*
@@ -208,22 +206,6 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
 }
 
-/*
- * fsnotify_open_perm - permission hook before file open
- */
-static inline int fsnotify_open_perm(struct file *file)
-{
-	int ret;
-
-	if (file->f_flags & __FMODE_EXEC) {
-		ret = fsnotify_path(&file->f_path, FS_OPEN_EXEC_PERM);
-		if (ret)
-			return ret;
-	}
-
-	return fsnotify_path(&file->f_path, FS_OPEN_PERM);
-}
-
 #else
 static inline int fsnotify_open_perm_and_set_mode(struct file *file)
 {
@@ -251,11 +233,6 @@ static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	return 0;
 }
-
-static inline int fsnotify_open_perm(struct file *file)
-{
-	return 0;
-}
 #endif
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 832d94d783d9..557f9b127960 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -87,14 +87,18 @@
 /* Mount namespace events */
 #define FSNOTIFY_MNT_EVENTS (FS_MNT_ATTACH | FS_MNT_DETACH)
 
+#define FSNOTIFY_OPEN_PERM_EVENTS    (FS_OPEN_PERM | FS_OPEN_EXEC_PERM)
 /* Content events can be used to inspect file content */
-#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
+#define FSNOTIFY_CONTENT_PERM_EVENTS (FSNOTIFY_OPEN_PERM_EVENTS | \
 				      FS_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
 #define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
 				  FSNOTIFY_PRE_CONTENT_EVENTS)
+/* Access permission events determine FMODE_NONOTIFY_PERM mode */
+#define FSNOTIFY_ACCESS_PERM_EVENTS (FS_ACCESS_PERM | \
+				     FSNOTIFY_PRE_CONTENT_EVENTS)
 
 /*
  * This is a list of all events that may get sent to a parent that is watching
-- 
2.43.0



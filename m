Return-Path: <linux-fsdevel+bounces-28639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2EE96C870
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7D11F27075
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8621B155A34;
	Wed,  4 Sep 2024 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GmpAbW84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9115575E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481767; cv=none; b=l3D5mT+xAH0G2/dFH662MhxUMENpd2IJ4KQqKaTwZgDxBaSUC0P8hboejuLREvCCwIzueEyWWRZM0Fn9AJGacEFfU8osKtAh4hm0v34CkUwof80CrdlLYVT1Z5hvBe5Sryfj1ajDamhPKni8+Cnq8ds5bh6UzajBAgNWPC5m0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481767; c=relaxed/simple;
	bh=EUC6xHSolCsXCfEGgJe/uC9iBPwO+UdprLu222bnv+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZ3Zkd3FPDRLc9lUsrXL5wXqKDgoGp6CyyVDAybAlSbueQIMISzzSDlobrApLOOF7qboYclAlZZr47cBNx05TtKEL9mn73+yYHzs2XUCixtMb6Tku/bHMWhWf/Ola5usrXv8E3jurCmQR8/bbMudyBwXNcbEvenyUdb39v+jE6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GmpAbW84; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498d7ab8fefso2712166137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481764; x=1726086564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSgX58UYc0emFHK3lK4cO5xgsT7V4KpoEDCer0WZNY4=;
        b=GmpAbW84QKAJFfHE614knUuBLj+/uOnQlQE9BbI4XT+JfGFF4K0x9DJ6UurngPGQwz
         NITRGMtL/df9L804hrlb4nT+K76WCWfp5a2PLMbOBOyTlF9EIqXs9OjkJqOhxrQ1DtIb
         C5n20V4Gxo/f7PdVjrx9DID23g5fKSODv/iZlQem6q1i/qXqUAgEzOV4dDWg5Vr5Zc+8
         NlkchdXMIoygdothzyS4XCbCBvi8sVULapBCunji3igqdGMarxlMjIjDoQQ2h/FdapE8
         t+F1HlCywxAPiOzko6qyeejVoUTF29CgoX5bGNwXtXO/t7y9TBAkDq4sz/DJ8Q4j7tH7
         1hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481764; x=1726086564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSgX58UYc0emFHK3lK4cO5xgsT7V4KpoEDCer0WZNY4=;
        b=bMdAVfJ0evnuqV2oh+9v09qpkXOVlWqUFr4fKZrtzHkuy7YOuhAPJ2f2mv2xh5iMxD
         uzUcqN+o+Pv7QxPql/Cz4JVQY+VjO+YdabYInLtoahdDjrlhIb6klLkIv4d8l+A5puWK
         zlI8FkfMmz+b+eYb2izu+Cg2oDrHybtKbgHT2SI48u2KU4PxRlp3CHrOjPx/Aq5VsLhs
         UEjM7PdFpRkf7JYf3r8HFLQljp3yMd1E4UXPxqFVY9blBaxwgrIdMddp2vbfPGnvgBV+
         x70IU4arz11MbjjGOUA8FJfO7P9bpD8IGT9zi3CyAb+4pS+vwJeMI5MKzvP8Ropyu7Zb
         steA==
X-Forwarded-Encrypted: i=1; AJvYcCWvapMoZg+sukFcY9JNkuXOfMApZCnpVvDU/Ir9IJKFzywllLYNp1fdDihS3c6NAgCwVrdSBfUoHf4kFXBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnTEhpo5vtwSN2mw9ZdRVtVUMcWlYxKwdtU50f3AnYqUtUToxY
	wCP85gpXGutBFwt31ETOoeaIYHg8yy36SDTYEY6ndaLRNcS3SU9PMU3Q7C0RryU=
X-Google-Smtp-Source: AGHT+IGc7mGWNoIW6t0qFMzy1JgoaW/y/pAizbNG4FOmezxVo9UEWHiWN81iBDFZM1s4pxXg42sQVA==
X-Received: by 2002:a05:6102:442b:b0:498:cf81:3a40 with SMTP id ada2fe7eead31-49a7778c1admr18354171137.17.1725481764310;
        Wed, 04 Sep 2024 13:29:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efeb028sm15207185a.84.2024.09.04.13.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 06/18] fanotify: pass optional file access range in pre-content event
Date: Wed,  4 Sep 2024 16:27:56 -0400
Message-ID: <87325af81514d7bd0b2236e14c613b7160651bda.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

We would like to add file range information to pre-content events.

Pass a struct file_range with optional offset and length to event handler
along with pre-content permission event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 10 ++++++++--
 fs/notify/fanotify/fanotify.h    |  2 ++
 include/linux/fsnotify.h         | 17 ++++++++++++++++-
 include/linux/fsnotify_backend.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b163594843f5..4e8dce39fa8f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -549,9 +549,13 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 	return &pevent->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
+static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
+							int data_type,
 							gfp_t gfp)
 {
+	const struct path *path = fsnotify_data_path(data, data_type);
+	const struct file_range *range =
+			    fsnotify_data_file_range(data, data_type);
 	struct fanotify_perm_event *pevent;
 
 	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
@@ -565,6 +569,8 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
+	pevent->ppos = range ? range->ppos : NULL;
+	pevent->count = range ? range->count : 0;
 	path_get(path);
 
 	return &pevent->fae;
@@ -802,7 +808,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	old_memcg = set_active_memcg(group->memcg);
 
 	if (fanotify_is_perm_event(mask)) {
-		event = fanotify_alloc_perm_event(path, gfp);
+		event = fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fanotify_is_error_event(mask)) {
 		event = fanotify_alloc_error_event(group, fsid, data,
 						   data_type, &hash);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index e5ab33cae6a7..93598b7d5952 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -425,6 +425,8 @@ FANOTIFY_PE(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
+	const loff_t *ppos;		/* optional file range info */
+	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index fb3837b8de4c..9d001d328619 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -132,6 +132,21 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+static inline int fsnotify_file_range(struct file *file, __u32 mask,
+				      const loff_t *ppos, size_t count)
+{
+	struct file_range range;
+
+	if (file->f_mode & FMODE_NONOTIFY)
+		return 0;
+
+	range.path = &file->f_path;
+	range.ppos = ppos;
+	range.count = count;
+	return fsnotify_parent(range.path->dentry, mask, &range,
+			       FSNOTIFY_EVENT_FILE_RANGE);
+}
+
 /*
  * fsnotify_file_area_perm - permission hook before access/modify of file range
  */
@@ -175,7 +190,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	else
 		return 0;
 
-	return fsnotify_file(file, fsnotify_mask);
+	return fsnotify_file_range(file, fsnotify_mask, ppos, count);
 }
 
 /*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 200a5e3b1cd4..276320846bfd 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -298,6 +298,7 @@ static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
+	FSNOTIFY_EVENT_FILE_RANGE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
@@ -310,6 +311,17 @@ struct fs_error_report {
 	struct super_block *sb;
 };
 
+struct file_range {
+	const struct path *path;
+	const loff_t *ppos;
+	size_t count;
+};
+
+static inline const struct path *file_range_path(const struct file_range *range)
+{
+	return range->path;
+}
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -319,6 +331,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return d_inode(file_range_path(data)->dentry);
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *)data)->inode;
 	default:
@@ -334,6 +348,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
 		return (struct dentry *)data;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry;
 	default:
 		return NULL;
 	}
@@ -345,6 +361,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
 	switch (data_type) {
 	case FSNOTIFY_EVENT_PATH:
 		return data;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data);
 	default:
 		return NULL;
 	}
@@ -360,6 +378,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 		return ((struct dentry *)data)->d_sb;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry->d_sb;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry->d_sb;
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *) data)->sb;
 	default:
@@ -379,6 +399,18 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 	}
 }
 
+static inline const struct file_range *fsnotify_data_file_range(
+							const void *data,
+							int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return (struct file_range *)data;
+	default:
+		return NULL;
+	}
+}
+
 /*
  * Index to merged marks iterator array that correlates to a type of watch.
  * The type of watched object can be deduced from the iterator type, but not
-- 
2.43.0



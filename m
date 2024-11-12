Return-Path: <linux-fsdevel+bounces-34501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDB9C5FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE940286C50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9B2170B8;
	Tue, 12 Nov 2024 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VEZ6JEl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F42215012
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434200; cv=none; b=XOc+GEHhCWBg6LJCbvl2cw6qGqo20wwGPbJqnh5BvzoJmxT769llQICpVX9cYHS7tSfYrYRsY3z2JyLFRKnYRntHLZcYSgrv4ZLfWDmvPbKMhFxUQj1No/uo3psdnoqfBNuaK4IfrciJLbaCwTlnxHzkQjEMvI04G8VMFiCebvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434200; c=relaxed/simple;
	bh=hCVqg1hYUhJw3sbARLBfUedgysh+nS0Ev5LGrGr4wQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7Cb3reS8lbdAifZN9HMF0Ne9Bwj+ywkPiQGwyn84GyaQ1LhN5AcJMr1nMieze0YtnY8kvtIaRki+NgmJmebcFJkxWrmVPiEpct/+PAW2Wj3bm9GSBmDvXBVIFOgLz7/1AVk8le6BHwV2Rn/HMeZVnyCka+2Mn+xnTdTLBEI4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VEZ6JEl9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5cec98cceso46848447b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434198; x=1732038998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qmzKtSqQfrhv9mwfplhMG+Dc91SaSr6kT90grfFzXE=;
        b=VEZ6JEl9Cu/Isz4seo0E411OBTyTv6TEk4kv3ORCmQlXroCr+ZsB69A/SK/KwaO0EN
         zPCm7TBI4GMvFQkMU4BSgL8o9Hrv4lnqgktZPI5sGjKDYNbv44Dnk1sFXf85v76SnnfD
         lnD1llo+ZFlOQy5Vn96ApASiMjvv6muUdUY7OOKtDTNMsXcSWLbpEI/Sjqbm8N6q8FsI
         LW69MrmsGZx2Hvz1DXN9e+0CydfsIewbFJ1VfbO7fw5tsdWRQtL4oHgcHBnwJdfpI1Hl
         A9FSj6yyrkjL0DhpKPKvTuDW75NETgMdvO7gB1l+vc265C74DKECvnIoqdOFTlc0RfL4
         XLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434198; x=1732038998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qmzKtSqQfrhv9mwfplhMG+Dc91SaSr6kT90grfFzXE=;
        b=ue8Kp2dbcxvA1IgzimOZkOc0D95wl4ko3/QyCUMJJK9VjIGPfi9YZLqEjcsqQvhGtn
         j1c8f4DGLPqCPtWJzx/rPNHyvpyS2rxINBl5fbTkKd5WA8Mx+nEq+/Y1ZsDqrRjJJNoN
         mK6JoiwvRZs6SNLn/9NWflTot1ondS5f3K9X1OiTfyhEPy9YjVWZAQtfmPh1I+g17sJD
         jdRW8gc5sWJsS4Ka4oyRMmOZM8WYmuwn9F7eg0cqqhqY0sZxlVvfVGryX399tUQRgtM5
         OsFA5u4IbTcCw+TmaBdwCf7GthApwzvQmt25sU3nGazCnrGAWToCcxzxZ/LixKB5K718
         ursg==
X-Forwarded-Encrypted: i=1; AJvYcCVVyB3fxVfLO74JfBWhQGR2CBsL+tQhkfxImurYmpI/vkNggv0H6mJhOmXlTRDr6ULlC5goBv/xKXks6LHp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WkhohIqj/f5q+k5IByi8TtFh3mdynmpSgPJ7w62k6OHY2sHo
	zYrwFpnrYZT3Q3DPt9JNOtn5NBHgAT4AJSDUoixA7GIWhjdNrFWdWLbl9jSb0Dg=
X-Google-Smtp-Source: AGHT+IHyY6QTMjull+z1rPYeXNfxhgVBLW70xt2rGV+KFU983vos+ZL89drz2YsnyEbkmVx23Jm32A==
X-Received: by 2002:a05:690c:6885:b0:6ea:7afd:d901 with SMTP id 00721157ae682-6eaddd98734mr177756967b3.18.1731434197704;
        Tue, 12 Nov 2024 09:56:37 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb65a9csm26511117b3.92.2024.11.12.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:37 -0800 (PST)
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
Subject: [PATCH v7 06/18] fsnotify: pass optional file access range in pre-content event
Date: Tue, 12 Nov 2024 12:55:21 -0500
Message-ID: <715ea468f03513b1b1a8e478f7096acc69a227fe.1731433903.git.josef@toxicpanda.com>
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

We would like to add file range information to pre-content events.

Pass a struct file_range with offset and length to event handler
along with pre-content permission event.

The offset and length are aligned to page size, but we may need to
align them to minimum folio size for filesystems with large block size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 11 +++++++++--
 fs/notify/fanotify/fanotify.h    |  2 ++
 include/linux/fsnotify.h         | 28 ++++++++++++++++++++++++----
 include/linux/fsnotify_backend.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 24c7c5df4998..2e6ba94ec405 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -548,9 +548,13 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
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
@@ -564,6 +568,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
+	/* NULL ppos means no range info */
+	pevent->ppos = range ? &range->pos : NULL;
+	pevent->count = range ? range->count : 0;
 	path_get(path);
 
 	return &pevent->fae;
@@ -801,7 +808,7 @@ static struct fanotify_event *fanotify_alloc_event(
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
index 0f44cd60ac9a..7110bc2f5aa7 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -154,9 +154,16 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 #ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
-static inline int fsnotify_pre_content(struct file *file)
+static inline int fsnotify_pre_content(const struct file *file,
+				       const loff_t *ppos, size_t count)
 {
 	struct inode *inode = file_inode(file);
+	struct file_range range;
+	const void *data;
+	int data_type;
+
+	if (!fsnotify_file_watchable(file, FS_PRE_ACCESS))
+		return 0;
 
 	/*
 	 * Pre-content events are only reported for regular files and dirs
@@ -168,7 +175,20 @@ static inline int fsnotify_pre_content(struct file *file)
 					       FSNOTIFY_PRIO_PRE_CONTENT))
 		return 0;
 
-	return fsnotify_file(file, FS_PRE_ACCESS);
+	/* Report page aligned range only when pos is known */
+	if (ppos) {
+		range.path = &file->f_path;
+		range.pos = PAGE_ALIGN_DOWN(*ppos);
+		range.count = PAGE_ALIGN(*ppos + count) - range.pos;
+		data = &range;
+		data_type = FSNOTIFY_EVENT_FILE_RANGE;
+	} else {
+		data = &file->f_path;
+		data_type = FSNOTIFY_EVENT_PATH;
+	}
+
+	return fsnotify_parent(file->f_path.dentry, FS_PRE_ACCESS,
+			       data, data_type);
 }
 
 /*
@@ -188,7 +208,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 * read()/write and other types of access generate pre-content events.
 	 */
 	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)) {
-		int ret = fsnotify_pre_content(file);
+		int ret = fsnotify_pre_content(file, ppos, count);
 
 		if (ret)
 			return ret;
@@ -205,7 +225,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 }
 
 /*
- * fsnotify_file_perm - permission hook before file access
+ * fsnotify_file_perm - permission hook before file access (unknown range)
  */
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9bda354b5538..abd292edb48c 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -294,6 +294,7 @@ static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
+	FSNOTIFY_EVENT_FILE_RANGE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
@@ -306,6 +307,17 @@ struct fs_error_report {
 	struct super_block *sb;
 };
 
+struct file_range {
+	const struct path *path;
+	loff_t pos;
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
@@ -315,6 +327,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return d_inode(file_range_path(data)->dentry);
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *)data)->inode;
 	default:
@@ -330,6 +344,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
 		return (struct dentry *)data;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry;
 	default:
 		return NULL;
 	}
@@ -341,6 +357,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
 	switch (data_type) {
 	case FSNOTIFY_EVENT_PATH:
 		return data;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data);
 	default:
 		return NULL;
 	}
@@ -356,6 +374,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 		return ((struct dentry *)data)->d_sb;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry->d_sb;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry->d_sb;
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *) data)->sb;
 	default:
@@ -375,6 +395,18 @@ static inline struct fs_error_report *fsnotify_data_error_report(
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



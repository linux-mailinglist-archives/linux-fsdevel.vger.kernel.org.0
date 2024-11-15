Return-Path: <linux-fsdevel+bounces-34936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCEF9CF021
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3191F27F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81D1E3DC4;
	Fri, 15 Nov 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="z4KmwIq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BB1D5166
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684698; cv=none; b=l5Zq6G0ktwnO99iH3x+vghrrIVPqycjm/wZYkRDo3dlyRri8wf5qXdTjgX/GK0yV1nZSHwHOxwTG/iJ84xVodQy+hZqb8/lZ8O0SmZJZUzn3MvklUyX0rycLMTo4gOUojenk1YGfsEMvsHzGcjTFDCw3usPyk772PLuTQiNWuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684698; c=relaxed/simple;
	bh=f/yiSuCioIqY8kK579CsLS9yawIIM43Iuar+nxiz9PQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKNHG+IH8Ufyo/DlpkIaEHa7zu1ey/7P4k8UbW5IsMA+0wW4Xw04EwN1yVOTRvWo8wlzj9R2qnrf7Mn5uVBuhWunNolE5odSSRvmPjoErnIetnxM3g1FXToAVJ0v9StcF3OCF+E/J7jSwOR7nO7UFx1Q3tJvUWLhINcmchrmVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=z4KmwIq4; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ee55cfa88cso8330837b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684695; x=1732289495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmDi22ux7vu/mgZp6ZHEvpaDEJU9ywEimHDaeGkRuI8=;
        b=z4KmwIq4hwer5XLF9IL9wmaoth9rNTO3q0tDxRJHEdguDdb2BLBzcrMDsG59pjl2bi
         DK20KemqcWfzz/0hFbYsWPleca8SR9jxidX9oCW8d3H0euQplefnKJfpOiUCwiyvYdu3
         UpAQKXSDA6O6y40KzqZ21zcLzQ0QTkBdQBbv7RSXIHeUWMOshrvpPUhEhdTpPgCk6UT/
         4L5fT+o6fd0R/KMg1f5FgxhklPTcKlGHs/Aje5X1RMvjypGNLzIhvxTEGXNLF4nfDCtz
         f64xXFTJzVQLdApabGelJCP0TqeLvMjC3o9WNZf5Az0S9NB2EreDcGj6H/9gPthbM1nh
         S52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684695; x=1732289495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmDi22ux7vu/mgZp6ZHEvpaDEJU9ywEimHDaeGkRuI8=;
        b=q+N7od1TxJxl6wP9oBthbQ0rrUfcwta5X2NESzhjJxss9t2T3u2bL/jyQh4bRih+Ur
         JbZYtHd00iyw8RScGXnRf0tv/TW3qtcr0qXoCBQv8c+3w+is5lFYHG3QEmgyqQvZHEaN
         F1XR9H/raIvt1D195cxb5xUlDVGO3IVwqaOYYyX8BDNYfptRiQfP6vnDtscRxZNkdBoW
         vuyuc5xWk2VuAJRVzrI4rNx8McZHv3t3qwZhyzAO33nxTiF65E0nTLqygf4Qbo2tWD2C
         YPJxKfbxyxOokiNQbdFvrmWidFxz7iCDKbXCqYfbvEyeyu+vCWj/dsNZu8NJGiL/GgFY
         wYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRNRDb++uWL9JVBdE47wvRgwx8y+Rts3WpJNyz7UPjEVUSDIJgS5R3f18X8I7h50zu1RTkuWa4QKWqH8G9@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGpMkx9ttYhX9Hto/UcV/E5ba0T4W/fz0sHwk2wijUBLsz6FL
	6iyMSy1hnO/LmwQ4VzacDaWCveumYGmVB1ayqOz0zRoMWA923gwMFJ1lEIR3zHs=
X-Google-Smtp-Source: AGHT+IHRArDyJHlTef+3JwzlBCm2e+TOdRS4anVHdo81AyQIdw4zsmIETl6tl9pEKTE/6sFxZRHk4g==
X-Received: by 2002:a05:690c:490e:b0:652:5838:54ef with SMTP id 00721157ae682-6ee55cff0c8mr38839537b3.37.1731684694891;
        Fri, 15 Nov 2024 07:31:34 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4444b907sm7704477b3.121.2024.11.15.07.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:34 -0800 (PST)
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
Subject: [PATCH v8 08/19] fsnotify: pass optional file access range in pre-content event
Date: Fri, 15 Nov 2024 10:30:21 -0500
Message-ID: <88eddee301231d814aede27fb4d5b41ae37c9702.1731684329.git.josef@toxicpanda.com>
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

We would like to add file range information to pre-content events.

Pass a struct file_range with offset and length to event handler
along with pre-content permission event.

The offset and length are aligned to page size, but we may need to
align them to minimum folio size for filesystems with large block size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 11 +++++++--
 fs/notify/fanotify/fanotify.h    |  2 ++
 fs/notify/fsnotify.c             | 18 ++++++++++++++
 include/linux/fsnotify.h         |  4 ++--
 include/linux/fsnotify_backend.h | 40 ++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 4 deletions(-)

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
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index d128cb7dee62..538aacf990ca 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -225,6 +225,24 @@ __u32 fsnotify_file_object_watched(struct file *file, __u32 events_mask)
 }
 EXPORT_SYMBOL_GPL(fsnotify_file_object_watched);
 
+/* Report pre-content event with optional range info */
+int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
+			 size_t count)
+{
+	struct file_range range;
+
+	/* Report page aligned range only when pos is known */
+	if (!ppos)
+		return fsnotify_path(path, FS_PRE_ACCESS);
+
+	range.path = path;
+	range.pos = PAGE_ALIGN_DOWN(*ppos);
+	range.count = PAGE_ALIGN(*ppos + count) - range.pos;
+
+	return fsnotify_parent(path->dentry, FS_PRE_ACCESS, &range,
+			       FSNOTIFY_EVENT_FILE_RANGE);
+}
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 994d7a322369..ce189b4778a5 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -201,7 +201,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 * read()/write() and other types of access generate pre-content events.
 	 */
 	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
-		int ret = fsnotify_path(&file->f_path, FS_PRE_ACCESS);
+		int ret = fsnotify_pre_content(&file->f_path, ppos, count);
 
 		if (ret)
 			return ret;
@@ -218,7 +218,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 }
 
 /*
- * fsnotify_file_perm - permission hook before file access
+ * fsnotify_file_perm - permission hook before file access (unknown range)
  */
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 33880de72ef3..89f351193d8f 100644
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
@@ -865,6 +897,8 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 }
 
 __u32 fsnotify_file_object_watched(struct file *file, __u32 mask);
+int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
+			 size_t count);
 
 #else
 
@@ -873,6 +907,12 @@ static inline __u32 fsnotify_file_object_watched(struct file *file, __u32 mask)
 	return 0;
 }
 
+static inline int fsnotify_pre_content(const struct path *path,
+				       const loff_t *ppos, size_t count)
+{
+	return 0;
+}
+
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
 			   struct inode *dir, const struct qstr *name,
 			   struct inode *inode, u32 cookie)
-- 
2.43.0



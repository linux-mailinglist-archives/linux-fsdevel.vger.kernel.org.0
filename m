Return-Path: <linux-fsdevel+bounces-25998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA39524B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CC283BA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825A1C9ECE;
	Wed, 14 Aug 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zYyn6SrU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29EF1C9DDA
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670774; cv=none; b=jQJlkVJ3KSnd4uJ072qGjj8Qsbmeosm5BECpcTBJAAnqgXwbSlwctw9M9HpbTN+wqOgTCpo/cApflPl80ocD2NuiDh83e9RN381uEq5CuIAQOAwt8RS3cRXp3vrP6NYqeJ9FPlkTex0zCn7EcDH2JqIqnIwZmn0lJo7r8ZjJFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670774; c=relaxed/simple;
	bh=EUC6xHSolCsXCfEGgJe/uC9iBPwO+UdprLu222bnv+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE7sGtqus2R8Mb13hd6iI29hRC8uk8CTuIjc3fggyR8vtv/PrgLR1IjvqAuUZIbXcoa2gYAdQUWj0tRtLSgdIPjBWENBD99dlW+gNYX58CBk06kzBddD8Iw5SPG6Tzs0ydrvnDCJWUB4oem94L6jP+mtbJV1zZNm8EYZgJ9zi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zYyn6SrU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dac7f0b7so23165385a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670771; x=1724275571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSgX58UYc0emFHK3lK4cO5xgsT7V4KpoEDCer0WZNY4=;
        b=zYyn6SrUtko3MgjsBGZwDxVw95Pl/g7WW4OMaLO3HMwt53ipuH4DWP8HytLiEyQ/W/
         ob2DfYilrz+AU3v1dTR43VluuYyg3nogXd8qMBakzQl9JuZIFSlDQidAZJlhaKdhuUtf
         V9qHSHZDYs6a8jP96wHWxMclO015InqaK5CkfgnLeQS/y1lA08DULcEdgDOK5OimDRXw
         PDitTJo+MM02pYfn86XMMQCMYQB95Q8drLkWiUP4wkVSRXsZD82N11AOsqPpG1kibfgO
         dVLkeoygI8WM7EBjVOWuUPOKBttuSNBz3KISoo0Vk3uf/SCTsnVfTXKpaaeWkNtBgTfw
         +L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670771; x=1724275571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSgX58UYc0emFHK3lK4cO5xgsT7V4KpoEDCer0WZNY4=;
        b=cLS2dwdbyVQtXRprsu2EfLxWLGaQrebc2oWeezaFeLEQdQNupgb8AJlwZKFp1m7X00
         2eAJdZO2+uZRDUCh3/dLXKfYTOvCTWkTZ41WitDw3zlAPVAkiGJPu+Z5Id0TffwqGUBN
         /xDhFMDZOyNzzDPrKWL9Z9scBangQoRrHu73R1UAki7PWMzKYCcNqkWaXgTSE0x8BGa7
         W2NKtJ29DEL+5qRjevR7Ajtxv6YPar4+qhXiz9Szpq8DXyhtB3/TeCaoiijWnqVz6kv0
         JmfsGYQ1CZ/dP0UtSneWn+W+9myNybBkgS0NtDshQgTgc1hJ7G8qVCATR/njAv86Kow7
         OF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa+SQxRZ84qrKVodWOEBgzqcvJzDr+RDM886/QoT83HXCpUvDZtIHDwmePrrMgwFvJsbTUY2zI8tLnRKl5TKycd9fu4HScMgLreDxyPg==
X-Gm-Message-State: AOJu0Yw8qyb03LagO8DgEwYf0qTBECoCk/UYvvkAjhDDge5okjDnhL46
	hdzz0trvK34zF1m2UxxCKnVx2Kfznw6KLMBUIezh6KLkJE0Zko2jLudTwBYFrS4=
X-Google-Smtp-Source: AGHT+IHzVqdx5PPzNWH057t0P/FT/P3ME1f3o5KEdS47TJSPsPt6bym6sXk9f4FG53pkQP7Q2xC5YA==
X-Received: by 2002:a05:620a:294d:b0:7a1:d6e4:d83a with SMTP id af79cd13be357-7a4ee3e82d9mr507957885a.69.1723670770577;
        Wed, 14 Aug 2024 14:26:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02f89bsm8812485a.23.2024.08.14.14.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 06/16] fanotify: pass optional file access range in pre-content event
Date: Wed, 14 Aug 2024 17:25:24 -0400
Message-ID: <87325af81514d7bd0b2236e14c613b7160651bda.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
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



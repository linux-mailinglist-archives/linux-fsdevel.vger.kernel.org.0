Return-Path: <linux-fsdevel+bounces-34283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB79C468B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C162877E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DC1BDA87;
	Mon, 11 Nov 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Br2GaQw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A81BD4F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356358; cv=none; b=fKLzTa5BJpJr3L+7ziZzndMvHLxHRJGJP916uO5ZpCThuOqN6N3+sEMHBfL5w+LqlDh/V+AtsVjLNlIrqBx3CszcDzfQos/WJbYUL8JOKAmYo+zbKhzruqdKePOrWwrk9bH/0I3xq7LyP2ouJAquCDqmchzlHLYdcz14YXSZigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356358; c=relaxed/simple;
	bh=q5/g4B2rBSTWJB0ECjWykcuamrrImvqQ3LDdFlghI3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv6gi3uGuYKrdclf9VHGqvxQyPn6ej4v7JYt+JSZFVo1ema+xBwGeuLOPFLdyjmhFEP83ZzJiInBvuHdGcXczRj0EyYMyAYYDljkeEmdXhSjNscWnEYGhtdXE3SbIi+ic1Fv+CwCvgKf2eJyh5PTVw4gyzmS/hzp8+k0QHl1e4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Br2GaQw8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b153047b29so303175485a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356356; x=1731961156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6ag15Q24m9w8QwPLcjiANNOCwpZepXzE8l8EGOvBlA=;
        b=Br2GaQw8waqdInR0OdL1v01YvC/AT9ozAFYE5R0qrRImtTsIikcVxVt0AyfQossGhM
         rMFztzhKoAnNJ6aSBgQ1YKwRyn9yBBs9GlflIQRb3Sei4nAePX6Szx++LA0ZKZraK69Y
         OjsyjXOefWgu2ZDhQY7hkRCShLNXqNpdv6pRnmrc5spVp5mq9+rI0F9TvV5zwJVmdr3x
         Vpco+eKmxlT8jR+L95eK6YTlKMzZy8/MEeIKtbyS89KWAqvOBaBYGCo7F5DVNMeYIZwh
         +sxvUKW02HRZwxwB01K0BKjvhUlHByFn6fMZTCOwDoHOMTM+bDvhX7Uv0FJa7oyc+///
         2xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356356; x=1731961156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6ag15Q24m9w8QwPLcjiANNOCwpZepXzE8l8EGOvBlA=;
        b=mgXQRufryp4g2h+MX1bD0ELzdzsyhX2RCA0PoSYZ9MF+GVkMHz4GQGR6uzed2xLCUj
         P90NECWiJoXLRV1Ij9R0jfzTBvtTUJnwQdGlaW3TcfQkPRyd/hnq6FVsClZGPvE71rNI
         akkAm5Q0dxClGxhvA7oKFulSl5oiHkAnCpR46SB52wTR9FWqbBgONZRz6EZYaWLk/Nwr
         5vpjVMNn2MqPWLj4DuHD47IU4LVczcVDW9oMUhjf2ZxaPNz1B62Vr63a1Y6nFc+ieNpT
         a4RYONj4GFEschar08PkqHjr8JXI3v8IYKZGXabQIP71InwWzGMk/o6DhJV9ExUQZweg
         JReg==
X-Forwarded-Encrypted: i=1; AJvYcCX/BVQuM4mf/6b8SdNXYIkocsdCW0yonli7RKyXCyuCDxDmx9qquyWTEInrt9+MUuzqyJHW4Mq2/R0aC0fb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wtHF2DNzKjqjTwCxmEVXiSmDk+r5daD4IJTeI6ec64JJ28dv
	PEHzV0KcQCqQvd3mmHKEXHpAoqawBDlRuaf+xtt3pHC3ijIbLLYmNUZCcrLTWlg=
X-Google-Smtp-Source: AGHT+IEW2yf22nobd0a01YcQDEMyEsXEK6xdxMmQ1VVAPmH7hZnR8VEcq8csG7mjjoxGe6bC+tsVsw==
X-Received: by 2002:a05:620a:468c:b0:7b1:48d2:f15e with SMTP id af79cd13be357-7b331f3477emr1883416685a.54.1731356355916;
        Mon, 11 Nov 2024 12:19:15 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf7f31sm524088485a.129.2024.11.11.12.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:15 -0800 (PST)
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
Subject: [PATCH v6 05/17] fsnotify: pass optional file access range in pre-content event
Date: Mon, 11 Nov 2024 15:17:54 -0500
Message-ID: <17994e73515dbbad80c1687421dedd3a44f765ae.1731355931.git.josef@toxicpanda.com>
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
index 224bccaab4cc..c1e4ae221093 100644
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
@@ -565,6 +569,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
+	/* NULL ppos means no range info */
+	pevent->ppos = range ? &range->pos : NULL;
+	pevent->count = range ? range->count : 0;
 	path_get(path);
 
 	return &pevent->fae;
@@ -802,7 +809,7 @@ static struct fanotify_event *fanotify_alloc_event(
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
index 7c641161b281..22150e5797c5 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -132,9 +132,16 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
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
+	if (file->f_mode & FMODE_NONOTIFY)
+		return 0;
 
 	/*
 	 * Pre-content events are only reported for regular files and dirs
@@ -146,7 +153,20 @@ static inline int fsnotify_pre_content(struct file *file)
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
@@ -166,7 +186,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 * read()/write and other types of access generate pre-content events.
 	 */
 	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)) {
-		int ret = fsnotify_pre_content(file);
+		int ret = fsnotify_pre_content(file, ppos, count);
 
 		if (ret)
 			return ret;
@@ -183,7 +203,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
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



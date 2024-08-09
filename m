Return-Path: <linux-fsdevel+bounces-25567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445494D69B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CDD283022
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C981667F1;
	Fri,  9 Aug 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xm/6tQQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0F15B57D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229108; cv=none; b=hCq/00ycd6Pd/MBU/dUWxjjXYoYEzHqb7Lp/UoTTR9i+GCU81HL7Q//1T8kuipwEpiXskBSklph1yo4VS2lpl8OlbrqJtTP54J3Ta1iYuwSv6lmSV/Bh/P1xVk5vzmHrJJRJBdJwVvpB74qnus3X1FcDFhDDDYEcWLmAOEOSKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229108; c=relaxed/simple;
	bh=oIFEloV+HJRwW7KKzTETqcSZwuMF6cvmESmc2+RUi2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+dpcAR1+yqHHHL5ALGWamdpd7jljKsRp4Il5RFW0bHN0he7yvxAvE7A60gM3S4Fkv/ZnicnpfJjXETxiBJBjVXtnkwwJW/2wIMa79he7etI3WTlL3ZRoyjxEu3wbIBFAEqvwvibQ/ONB6fNj83l/NPD5S7TVnFdVRWSU97WFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xm/6tQQB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447d6edc6b1so13155441cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229106; x=1723833906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=xm/6tQQBIT7RBpUWaHrfqoHM/7bRessu3XhKS4Gs9vCa8bGxsi2B3vis17/JVdcVsR
         bwEBN+VQc3Yy1tQzawKNVf6zDBz9rQNA0U3xAjpeonY3HITtMWW1biBD1+VKtjnv4cX/
         v3MN4E0K+jE/gb9w4ql4+5MkA3KCggVMlsXDskPpneHCLNoHvk3qU4SKDIr69hOOmx6B
         lsQhJL7olhRQkld8kpq5vW875CIAvEYynX/C1wc0xNYchTQpDzJ/uVZZ4Ch7V9oYlVmx
         9JTmvtFgeUTxkOWg6Xj3UN2Nz10XxPSVqjh1gXeDT+bZzxm5Jj4hVwwh76hBoNyyJ7/m
         7upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229106; x=1723833906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=EXBGvUJE36/8J799TQsDDRu3SnomdHdmGVDCd4NcFrdOxYFQz8iHsQaSqSiBPLbnDV
         5ufkx4Zi5sFEc/DOZIKw9bKwQxXUUHRIiyr0awJQSFz2otP5nJyJ6QmKAybzp8X3RL8c
         QTnR5uQI3MNQXJ3alvZo3I42QGCSl8WHwvGVwd1eqmS89EBNFMv6380pemvov75T1tXP
         gAoKDiKwAiZPIC9V3JAadkMa2nzlrTEBfNUboOCvEU65VUq1zNqhP2X1cK5dwB/eEYZ8
         e/NdAU1zpP7kWKZFrPVgRLuX3QxX8UoK1KxPVnF+d0NVks637TdycIcraVbZMmFbr37U
         U8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW+zMezjctdKl+r32MmOGcI9mBGKzNe7HkiEwjSuXmI4Xiq+yb5nvI4BpdrowCLp0xAyoS2jndG+h+X1el+KxlsH3i2ycjaGO5ybUNkQQ==
X-Gm-Message-State: AOJu0Ywmm6tqFhQazZfeA6u184So+WJzFyiNHxdZgTt/sxY+ov1oQyUq
	OMEaIGG05izyaedVVzuZWEIyU1zemZwIN+FFp33u5AAyXz3GVzzn8+I7jUowHcU=
X-Google-Smtp-Source: AGHT+IG5zQtNW/XpS3+QxRnw3j+AIzLNhodsoGZgh92MwyUW6bcO/0L9pxWR7KNpZnt4tIKD1u7yZg==
X-Received: by 2002:a05:622a:4084:b0:447:f7cf:7022 with SMTP id d75a77b69052e-453126ae6c5mr26804151cf.40.1723229105766;
        Fri, 09 Aug 2024 11:45:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1c3da4sm410271cf.29.2024.08.09.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 10/16] fanotify: add a helper to check for pre content events
Date: Fri,  9 Aug 2024 14:44:18 -0400
Message-ID: <b02993d0e384326194023c76e437c0ea838a5c06.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 12 ++++++++++++
 include/linux/fsnotify_backend.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 1ca4a8da7f29..cbfaa000f815 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -201,6 +201,18 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	__u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
+
+	return fsnotify_object_watched(inode, mnt_mask,
+				       FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+#endif
+
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 276320846bfd..b495a0676dd3 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file);
+#else
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
+
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
@@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.43.0



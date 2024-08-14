Return-Path: <linux-fsdevel+bounces-25995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98CB9524B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8301C21A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3461C824A;
	Wed, 14 Aug 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Uq3xbV2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CD1C8FB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670771; cv=none; b=VctV9EGvd48uELvtIxQ8/lqZez2BZTaiCCyaIK1VPq466OXOJdj6lXve1N6FtjmLzOL9XzSaLRK2okWdTez/dNZhwfPYJinmLpjtwCDe6FrouqHhDLmqqNLDl/oG3k8Y1MLIiVeGuw/pI/iiCFhCqBuJGumr4pm1WCnD7LJcoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670771; c=relaxed/simple;
	bh=205ZgkeQOGfC9lat+UQrPYYg3l/LDds2VjsCRxYzGRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhelaJWObWcRCZFvhuIXA5l72fLN6djRCeyeD85jbe0H4lyZPZso+OHinhCwPWVh5uGaZrJSy5zf5vYxE/uJfhQWMROXq+mToDMOzoC0lQ52t818/YxWmZ/RhP5fVe1XiiHYGKMgCOaOeOGAdd55v2WAgJ/TvRizPW5YLcfvMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Uq3xbV2h; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44ff99fcd42so1843961cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670768; x=1724275568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wY5GQe96iyZHYx9I8f9pL6l7vs2y5u4HNtMRHVuMKgs=;
        b=Uq3xbV2hb6jw1I8O6NtxYaOSnK9/CtYMM+DeUVCcEE2Lg1ZGRmfmNDNaMcboXZ0ZSo
         /I8SBn4sCdJwA8WVja3wb/Km+28OKQs2rvn1bQ5FOfH9qd6gAU1t/uvfL67MVwPtMfxx
         y7uZ52Lrtm9IzAbCrd09wSt/dWiT9n9UaKPiM/kTLHOzeTJd/L8mXsfQwaHmpr1ZtD0I
         e8whAFg6vFn4UojIl64T6O49YtDgCATUmhVecfV6+dbgFKVxw5aaFjLPJeHXGLgTXFcx
         DZ6sHPYlljozDrltG9/XSwN7OFMm+BbvinEJJl8+qxqBuCFJnH4xEJ+HPYQ3VN4td7Au
         K57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670768; x=1724275568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY5GQe96iyZHYx9I8f9pL6l7vs2y5u4HNtMRHVuMKgs=;
        b=o6q6uUUaXfYdt765ucmM7fN+UOa0kbA+Qc+69qWypmEbeE9wNEBBK9GYb1aom1WTk9
         s/T3k3CvNMFPgv6tiYrVEjYGhhxYNufHFSrqsmCwBqezzB4BoqEAYU7dUDHj+CNbnit8
         zKJcp7KLSewv/v2xMm2WH7rOaXPabV8Q0JvbLBRz7uXj+kgYmrADrXgzPGQGA/Zp3zB9
         ofrKvpl51MeKHETaFkwj6cUJ4Kj/k4LPgdQ+fgVx36xuQ+XK7qPOb9frbzcgTwxMLRrm
         H+0hP2S8J4HJJb2TIXjJ6Ga7ilDHAjjTb9gIx1dTpORLbU+0wn6uPKSjSjvh+J5bIlLP
         52jg==
X-Forwarded-Encrypted: i=1; AJvYcCWjW24XB8IxX+x8P0FAAgD0EoTRnfwZ1DZpjr1DDLntX/SK7FdpP7cohFTeCUPop7NF0JM1dlio2aBEdlNq7Ffk+cwC9CHE+8IGQCV/rg==
X-Gm-Message-State: AOJu0YxeZTt+9XSEnqvNvErynF0UZJpNNdVM9YcptL/n0WCtRNzRNNlL
	KZwLs9sv2+Kiqr7nhko1MD7kaBTboJz0w54XTj/2TRmN/voryl/KkarrFgMDrq8=
X-Google-Smtp-Source: AGHT+IFb4WPvIe9b0H0MB5ZFX64Xi4uEtDDjQyEK/diGPUoztnRQsa44qKf+dfrF4BFbTEpCYFi7wg==
X-Received: by 2002:ac8:698e:0:b0:453:5f05:2ba3 with SMTP id d75a77b69052e-4535f052d3fmr26573931cf.8.1723670768575;
        Wed, 14 Aug 2024 14:26:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a07916bsm473631cf.94.2024.08.14.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 04/16] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Wed, 14 Aug 2024 17:25:22 -0400
Message-ID: <19cb8b3b5b93760bc6c6d47a8cbcd277952d7006.1723670362.git.josef@toxicpanda.com>
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

Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.

Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
in the context of the event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first read access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify.c      |  3 ++-
 fs/notify/fanotify/fanotify_user.c | 17 ++++++++++++++---
 include/linux/fanotify.h           | 14 ++++++++++----
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..7dac8e4486df 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -910,8 +910,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
+	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2e2fba8a9d20..c294849e474f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1628,6 +1628,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
 				 (mask & FAN_RENAME) ||
@@ -1665,9 +1666,15 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
 	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
+	/* Pre-content events are only supported on regular files and dirs */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		if (!is_dir && !d_is_reg(path->dentry))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1769,11 +1776,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * Permission events require minimum priority FAN_CLASS_CONTENT.
+	 * Permission events are not allowed for FAN_CLASS_NOTIF.
+	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
 	 */
 	ret = -EINVAL;
 	if (mask & FANOTIFY_PERM_EVENTS &&
-	    group->priority < FSNOTIFY_PRIO_CONTENT)
+	    group->priority == FSNOTIFY_PRIO_NORMAL)
+		goto fput_and_out;
+	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+		 group->priority == FSNOTIFY_PRIO_CONTENT)
 		goto fput_and_out;
 
 	if (mask & FAN_FS_ERROR &&
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 4f1c4f603118..5c811baf44d2 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -88,6 +88,16 @@
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
 				 FAN_RENAME)
 
+/* Content events can be used to inspect file content */
+#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
+				      FAN_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+
+/* Events that require a permission response from user */
+#define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
+				 FANOTIFY_PRE_CONTENT_EVENTS)
+
 /* Events that can be reported with event->fd */
 #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
 
@@ -103,10 +113,6 @@
 				 FANOTIFY_INODE_EVENTS | \
 				 FANOTIFY_ERROR_EVENTS)
 
-/* Events that require a permission response from user */
-#define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-				 FAN_OPEN_EXEC_PERM)
-
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a37de58ca571..bcada21a3a2e 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -26,6 +26,8 @@
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 
+#define FAN_PRE_ACCESS		0x00080000	/* Pre-content access hook */
+
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
-- 
2.43.0



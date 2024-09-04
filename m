Return-Path: <linux-fsdevel+bounces-28637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989196C86A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B5C1F26E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B4155324;
	Wed,  4 Sep 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lfKFC/jU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB91527B1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481763; cv=none; b=lXouh3Urnj1yKOIW4nUWsSldDBMaAwscUPq0HU+ZcQrS9K42+64H9WguiCZXBkBdMpznjF9Ahcrq/M7WLFI22IR5Q1wMuuV8qlKPK0SP3m+GhkDqAZrgRnOxkafgtc92Ehy5LG7SX5+vs/ifIMCKFoKwP3eoamxOywbGjiscFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481763; c=relaxed/simple;
	bh=205ZgkeQOGfC9lat+UQrPYYg3l/LDds2VjsCRxYzGRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lB94eYuqi9L9NTLuk3Y38chZLb9DRtzIVH7gYUhJrLLIcW4s8xQK4LDlgcbRmkgnG6aPmMvIL4fQZ59oEJV2FJM3jdA8TUVmPlHdM7IXTjh1OJlGrKLzhJxYnYDD0GVuQ63/Rk4XWxApw/6B/vw5l7i69gDtQx9piB7aRPoTeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lfKFC/jU; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9786c5ec2so680185a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481761; x=1726086561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wY5GQe96iyZHYx9I8f9pL6l7vs2y5u4HNtMRHVuMKgs=;
        b=lfKFC/jUrrTJNEGAGfnQm5IY4zkD4LojZyGj1C9isIkX135gfPRh0LZgCBMUbqnZH3
         1hkLFS/DYPU6cSaSuKg0huC1j8by3rPoWrnVhHBjkv4c8AswN2HPVUt/zhirxwZbvA+h
         zL2ReZTGs6u6V0OZrKCi5nvVaH7HNviohxlrslbvjHBxJKX7J3l2iz5DT0bC9CjmVUIY
         J0d2xHthAsEBYXa+Vueo4u1F6e+DaC51xfUeVhIUWqVe572h+WHs2BKz0vJ2RGBveNdW
         kkpb44vMvugiO1yS+HFkuw0KNeSl3c5u8P6pAhfZ+yp/0qZm+eM5XSj95MKV2l6d4BPY
         KduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481761; x=1726086561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY5GQe96iyZHYx9I8f9pL6l7vs2y5u4HNtMRHVuMKgs=;
        b=G2oI0wd1ZVQXM+GBeQSyEoNpCMgs/o5+0Vm2eHlDCRy1PS7otydfwHcAGdFt1pvo/P
         xXHjlXNfUhOmYXT3FniYLZeUsh7NQ5Wp2C5ABL0euerdACWjPHdsHH+N1a3HzDgqVbpR
         HV9q9nRL21KKjxfXwv9bqNX4JAJwPKoymEszQdm1e9yEl95cHORnWCO9Ia1rrZ2AwLdd
         32rBqGYPQ2fBtQSBpDx5A5NWqXVUl9961CLKDWJzKHMrGqMghYJKDZWuurKDqZOAuK6E
         +KEXUYYUugT4xc5nCp2ulYnfHHbQ4d5EGPqgJJb8vUwVPkMOpXuqpblfMxSk8Bncednm
         9kHw==
X-Forwarded-Encrypted: i=1; AJvYcCULofKt4PHCEuqkp8WsUDsXe6uTOLx/rFKkxmJlWQYOTCN5zAsNz6tP3gfpDaWZ0kczxD/APtfeMPI34siQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A1m0GfexxGd2wLrX9jJ2Kr2xo6u3IjCIFdPOgi6s4aM0Bc+J
	hzZ+hKoBJ48US4nRoytKi4jxBmhl5zlwxQmoLGJSu7yyUM6436GgPYPutqGDJcI=
X-Google-Smtp-Source: AGHT+IHn2YN4Yn9s+Pe3cKQRQlM1ZQppCBWH1jZTlFjC6uGrUZZrr+lLwvttH1GqC8If9lYaSoNH2g==
X-Received: by 2002:a05:6214:3a89:b0:6c3:626f:2366 with SMTP id 6a1803df08f44-6c3626f243amr168729666d6.34.1725481760916;
        Wed, 04 Sep 2024 13:29:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520315369sm1569046d6.96.2024.09.04.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:20 -0700 (PDT)
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
Subject: [PATCH v5 04/18] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Wed,  4 Sep 2024 16:27:54 -0400
Message-ID: <19cb8b3b5b93760bc6c6d47a8cbcd277952d7006.1725481503.git.josef@toxicpanda.com>
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



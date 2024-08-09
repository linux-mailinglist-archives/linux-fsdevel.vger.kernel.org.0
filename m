Return-Path: <linux-fsdevel+bounces-25561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA394D68F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AD8282F94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1673B160860;
	Fri,  9 Aug 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="s2Dn/fHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2715F40D
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229101; cv=none; b=cFZvxVhz5WBl97LO7d0byzv/QjCH5usNKXgupwMCpcxXv7WtDnz61xW5TINgfVDXBLlk9i4IAEVVGLrTnivrUFt73o/Ni9ev8R8wC9bR4sby1mKS6vBJU0Gh2sVD1fnuAIfPbXvF0sM9rTBYQ/JF9Nd+gMiZtJJhm+pZUCaCwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229101; c=relaxed/simple;
	bh=205ZgkeQOGfC9lat+UQrPYYg3l/LDds2VjsCRxYzGRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlZwqg8Js1/jTdrbN5fRLGPOrcPoekCqKsKj1BGPkGEvEe5lB2hLuSCfi3s/isP9I0ASTNViiFkPR7X8obDo8JgM0o5m2lGYSgi1hVi3u25z0kPR71vSb0vTYg5S7hSPEovI9N5jlJftXK+elPSLz36c3oF015QCxIP7xssLy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=s2Dn/fHG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d7bc07b7so152206785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229098; x=1723833898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wY5GQe96iyZHYx9I8f9pL6l7vs2y5u4HNtMRHVuMKgs=;
        b=s2Dn/fHGrtVAC+3Jotl/iffS2qYri6LPZpmcLKh7qEcJ/sFiSJIuaZjELfaljSs6ja
         ic/hdGS64TzetLZRZ1Z7D3RDg80gbm+uTzdOBG5HL9AKCEUfUGjM64PHlOKw5RcPewol
         0hVGBOYRxWnNtJifqO3nXqDuIp+XbC+aObwQP06AOBKR/RtMiyS+Js+DXzzM98C9zU4Z
         z8cOmjhBnP3VyU1VhnhAdARY1PyPX3dD6aER51p4MZZwoFKUysmVMoYIqZY+et3zR2cA
         yMC0AXQ6Evhy3Lh1lcfbbGL6JXOllxe5/3FRxrGDVSRoBgwQ4t+Iatk2q4zmond85uLd
         B/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229098; x=1723833898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY5GQe96iyZHYx9I8f9pL6l7vs2y5u4HNtMRHVuMKgs=;
        b=Yay+D3izZVnB1ztjXBGpf1Mls/RTvzq4V154MNMQrydl/PZI9rJeXRnNrUXbFJqTZT
         yaej2JlWvH6ZYKaFBk/cE8K9TsbuNthRUPtXSTSM4yZfe/DPi+mijUJ8WZ0GRcdmSEoS
         cR8HU9056ylc0PL+jIvWB2nFl8xnVbryD8FVzz0jK9DMrP7U6nh14K/9FX0QbrRdfFUU
         JRjJ2R3VrOnzqlwEhz2bAPCMFBF0ow6bGEvC5zuEpe/zVm7JOEbHAmHhK7c7tEZpgdaB
         e2YzVoryQS9ojdXZfM3pHJUByowehSjSm4xTnuJ8VbPl7MQZU0WWNVEJusE2B28UJ8Dk
         AQjA==
X-Forwarded-Encrypted: i=1; AJvYcCVGcmJM1uHzQw1AkUG1vEWVZ4fBhEoavLnGLyDDHl1+AxALsgvs2Ofjd9wav1gJ24kYfTln0m7znn0DpPOjwRHI7o1o9tuHV77uigNYfw==
X-Gm-Message-State: AOJu0YwNuATfbusmxaXaawzEFfb0WUwfs4nzHiUvkTterkWTVTEFt/Ny
	vUd3D5rRjE2PKZkujI+T22a17kjZrgadb0/jlb3w+ra5JoSqT2ZzhvdbcCJHsfU=
X-Google-Smtp-Source: AGHT+IHy1Icb/mWbrelWJZVKD9b7WIlNiYz5unrQqQBLrTmD8egF87IWu+cmFIC5OJz3lY5KNi4ybA==
X-Received: by 2002:a05:620a:3704:b0:797:91a7:4f36 with SMTP id af79cd13be357-7a4c18644afmr258060785a.62.1723229098586;
        Fri, 09 Aug 2024 11:44:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d73641sm4329185a.53.2024.08.09.11.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:44:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 04/16] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Fri,  9 Aug 2024 14:44:12 -0400
Message-ID: <19cb8b3b5b93760bc6c6d47a8cbcd277952d7006.1723228772.git.josef@toxicpanda.com>
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



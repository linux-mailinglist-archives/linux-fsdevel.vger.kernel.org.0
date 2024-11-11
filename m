Return-Path: <linux-fsdevel+bounces-34286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A89C4694
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D311F25499
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF71C1F27;
	Mon, 11 Nov 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jYledgT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FA1BD9EB
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356364; cv=none; b=oqLBYdo0BoNPF2Yat+n+G3kf1JvZdtC1hl3lnc7EgL0J2cVrZrzCLV4t+9gFTflHWrsarRhgU/oiB6tocPGelSbeeeQLkIIfIxGDpEyJJoaUZbiszWpcN0keSkeb0+agK3wo/dm239OGpxvIqSnbTI1MTE8jvvYlZkTllVzgolY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356364; c=relaxed/simple;
	bh=kD4ulmGxIpQmCyeh9f4ZPmJ121zBS/vQk1SfQ8U2dVM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQw/LDQOY7IYBdn9vI6NWhJc3h9UjcuhNDWnu3h5CGSaXIVkUuoyloRHPczYz7oBjW87vxbM7rgn6VOVxVGPTZcLnbPMqCM9/S6Jot5NwOsgUKrj+IUj1WQNArExjOwWILs/yRsnsDI92riDyOrmDuQlAmsR61h5mgLBlx+/E8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jYledgT9; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc05007daso2165146eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356362; x=1731961162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIr6hfiIJt6Z0W2/VohDEaflGJcbA2BZOCByAdmo7A4=;
        b=jYledgT9O3ZtEcrDQGenFjbRUib7hLXZpEoosj3W26PZjx1qFark3WDbt6HvN+1M5y
         8d6pyYnyGYcZJa2SjI5W4ztmzXwtrjkYU2qP+ZYjd1j2qvEqwhkBS6IruSrFucSrFMRP
         4kzuHtUGGebGlMJXx7BXXzxnopg4IUibWZ7WWOCW3/FW4js6M1KY1Go5Vceo3uMkK6nR
         bOFvSRROJupEchLdhmfaIEN4HFtXQUx+mu9+WbzTeSV42rPsnEYjCMFz4NXpak8mD2zk
         DVFiNPQSc7Mzhm/TjwcyOSCgmC60IJ4q3lYD3DW3vbOxTvlUAGSnFJDepryF3lJaR+fE
         P1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356362; x=1731961162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIr6hfiIJt6Z0W2/VohDEaflGJcbA2BZOCByAdmo7A4=;
        b=u4I9eMskmOwnltFblxaEMbM2MACjiqLWWT2n/iFGZgK5CPnbS9b9UeziTh/iR6VuZm
         4kWagAq8cxI+inAjm9FGeLos9I8Z9uT2xi9Y6efG4Y9CIYA415vbxRfmLtSnqGV0szrR
         iW76RtSFeeJZ3i22HojsbPcreOz9lwzkePv/B9VZ+eQsFH4CN98ZuiJnWpLnSBtk9B6X
         lJx+Z9XPCEhraJmxDtuwvao1LJ0Vpi5yT+eFuMcAHX3kZcquDkZDoU7ycNWoPygYMmA6
         /LLH6/OtmrqgnCslnfeiReACB2ESYp6U9r0sY2RwTfhRkRRtJBcVQcciiPaIZHDRdKpg
         orpg==
X-Forwarded-Encrypted: i=1; AJvYcCUirPFOKW9baR5FcdcoWQcDAThqbyoDzYyhsalNWS8s0eNvzPoa3/7SIVU8Ez+noW03CKu9EuufD6YRq7Hk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7oduM5EBXVay0EtHw8rPpIQD4sBtOrZeddHyRO6jnFAiyyg1G
	yIXQ7rlab7OFbeDtv+l95jlfP20wvbtEajWjHo+aHYKycrL75LVEhOEubFL863lOyID8nYdEsoz
	o
X-Google-Smtp-Source: AGHT+IG9bGBtdAa/UNjAV/reMXpITXA7+6iabefhDuqPBQRMez+d/kh/izRimXSRfAf9RRVXnEpYWw==
X-Received: by 2002:a05:6358:5d8a:b0:1c2:f482:5c0b with SMTP id e5c5f4694b2df-1c641f66059mr620325055d.24.1731356362041;
        Mon, 11 Nov 2024 12:19:22 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961f4a0fsm63335146d6.41.2024.11.11.12.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:21 -0800 (PST)
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
Subject: [PATCH v6 08/17] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Mon, 11 Nov 2024 15:17:57 -0500
Message-ID: <e990d0aa3eb8489b1f4a67a3616774a6e295c4d4.1731355931.git.josef@toxicpanda.com>
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

Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.

Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
in the context of the event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first read access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  3 ++-
 fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
 include/linux/fanotify.h           | 14 ++++++++++----
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c1e4ae221093..5e05410ddb9f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -917,8 +917,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
+	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0ae4cd87e712..da9cf09565ce 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1639,11 +1639,23 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
 				 (mask & FAN_RENAME) ||
 				 (flags & FAN_MARK_IGNORE);
 
+	/*
+	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
+	 * and they are only supported on regular files and directories.
+	 */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
+			return -EINVAL;
+		if (!is_dir && !d_is_reg(path->dentry))
+			return -EINVAL;
+	}
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1676,7 +1688,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
 	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
 	return 0;
@@ -1780,11 +1792,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
index 89ff45bd6f01..c747af064d2c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -89,6 +89,16 @@
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
 
@@ -104,10 +114,6 @@
 				 FANOTIFY_INODE_EVENTS | \
 				 FANOTIFY_ERROR_EVENTS)
 
-/* Events that require a permission response from user */
-#define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-				 FAN_OPEN_EXEC_PERM)
-
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 79072b6894f2..7596168c80eb 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,8 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
+#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
-- 
2.43.0



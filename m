Return-Path: <linux-fsdevel+bounces-23275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F5929FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5175B1C214DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91874770ED;
	Mon,  8 Jul 2024 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OGCiPkoe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465577581A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433597; cv=none; b=UJwPGMIDAJQlJwcVrqPf8710vXPulUG4V91EW7O+2WWuU0Pqyu5M4lPz+HUCY+4GfDibH0CSH4+7v6cLuDtKUshmoWNu4VSPVFsArO9FBQuRAcj8c6HEMX+tFwphLZRXZnDntMgED6+e60XamhDG69+R8Laouli+jVgLA2vxxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433597; c=relaxed/simple;
	bh=HEeGDhbwnZOacLYf46vwc5wEABZGEKWDdQ4rW5ANr88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=saJRigLh2+UsX0gQp5Mq2Myz70GCR243hnmfKTLCovu/ka4CA5U2e7bLzII4ZvZKFnHaqESKCDfa6Ul+luhFMMMaZriCdTrSOEGIdi0Ld74diSrgYU930/YS5ALdpoSf0LdCfLNkobmSCmfLMegELMHukJ9+DOHBNGpfUxiot9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OGCiPkoe; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d932b342bfso396916b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720433593; x=1721038393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XXKAYmfVFyA7thhyLqvFeZE7qEz3+PJWR4pQ61AWUw=;
        b=OGCiPkoekjCd5ni1KJe+51ayTspB3tGnDgEsabGMQmiRgCJcGxB0C2blxPJewhs8sh
         vCzRNk/C/YagZOrOxlni+44QsU05LbV/vknTFV/5Lm/2yFqidrWCc0RFKRrzUveFDzM4
         mXSLYqYUX1GipBnAgtu+9EJp+LM3Il6jV6N6aQJ8afT6P5lKsPTc0sYLwFF5krjW1Nwh
         ydwBUaBH3QkiDnKtA3UcojpDDxrDrdjZhxFrl+y1PKzK873upQA7FrXyZ0YP98b5t4CP
         jUiulY0KdC+gWxwumbcEf5ls2W/gD5A9/GJNNlGSca4m4wVEFBgatC6Z7T/oiExIevB8
         oFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433593; x=1721038393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XXKAYmfVFyA7thhyLqvFeZE7qEz3+PJWR4pQ61AWUw=;
        b=a/xLl5WL2QcQlyosOkh+ZZxx973mcX0/fHm3J4gr+j0ROayDpJK1tVfVexUCLJcWVO
         CCLeAXx357rvw7wP+W8f2EXQyIp1DieN+9f8Acr/1lRXBq1VRiYt/j1su4G3CjWELMH4
         cHigc3g4kzzWbImCj+k/cUwlc0zR7q+TFzr76eB/FQn7hd01a4JjoSqyLS188NcrtQn1
         a3gZIbgHKoWSEmwTtbaryLkwj5bM7OU00m/P8NKBWhzgshS23FrnOjqbkxyriGCbpd/A
         M4ZzRbklZFz+u4dwrbXfXTJxfOWHK5vAkDiN6/xz4UsANfHI7O8/1NFQeFzOlHImZIKf
         Vj3g==
X-Forwarded-Encrypted: i=1; AJvYcCXma699stdqxo1QBSRH56opx2gvO47RFbVm0LC6vbDpVK1jrFqFCxQQbWUsZcBGhYfEq7yPS/D7AkkRPEJ1Oy4HvGDx5kSK4nIZf9xZIg==
X-Gm-Message-State: AOJu0Yw34NbxiejDvuvD+n3UTN4f2L9MtsHexA3KGqMh7fgrN6/pGhdt
	cB668rto/7Buv+wq8TKnm6EpgEWi3SPYmSdL3Ft9HonHzL+fNJowGvOi1YrReQ==
X-Google-Smtp-Source: AGHT+IE7xxHxLr5inoKXU+i7LdrQmrl5bVJRW4SAjjiIiQkXir4NQfGD8V6du1EKKer2WLBHscQzBg==
X-Received: by 2002:a05:6808:1984:b0:3d2:1b1b:ec1 with SMTP id 5614622812f47-3d914da9b46mr17267596b6e.45.1720433592875;
        Mon, 08 Jul 2024 03:13:12 -0700 (PDT)
Received: from lizhigang-HP-Elite-Tower-880-G9-Desktop-PC.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8df0e3sm14902961a12.36.2024.07.08.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:13:12 -0700 (PDT)
From: lizhigang <lizhigang.1220@bytedance.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lizhigang <lizhigang.1220@bytedance.com>
Subject: [PATCH] inotify: Added pid and uid information in inotify event.
Date: Mon,  8 Jul 2024 18:12:57 +0800
Message-Id: <20240708101257.3367614-1-lizhigang.1220@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inotify event only contains file name information. Sometimes we
also want to know user or process information,such as who created
or deleted a file. This patch adds information such as COMM, PID
and UID to the end of filename, which allowing us to implement
this function without modifying the current Inotify mechanism.

This function is not enabled by default and is enabled through an IOCTL

When enable this function, inotify_event->name will contain comm,
pid and uid information, with the following specific format:

filename____XXX,pid:YYY__uid:ZZZ

Pseudo code to enable this function:
int rc, bytes_to_read, inotify_fd;

inotify_fd = inotify_init();
...
// enable padding uid,pid information
rc = ioctl( inotify_fd, TIOCLINUX, &bytes_to_read);

Log example with this function:
CREATE,ISDIR /home/peter/testdir____mkdir,pid:3626__uid:1000
CREATE /home/peter/test.txt____bash,pid:3582__uid:1000
OPEN /home/peter/test.txt____bash,pid:3582__uid:1000
MODIFY /home/peter/test.txt____bash,pid:3582__uid:1000
CLOSE_WRITE,CLOSE /home/peter/test.txt____bash,pid:3582__uid:1000
OPEN,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
ACCESS,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
ACCESS,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
CLOSE_NOWRITE,CLOSE,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000
DELETE,ISDIR /home/peter/testdir____rm,pid:3640__uid:1000

Signed-off-by: lizhigang <lizhigang.1220@bytedance.com>
---
 fs/notify/inotify/Kconfig            | 24 +++++++++++++++++++++++
 fs/notify/inotify/inotify_fsnotify.c | 29 +++++++++++++++++++++++++++-
 fs/notify/inotify/inotify_user.c     | 11 ++++++++++-
 include/linux/fsnotify_backend.h     |  5 ++++-
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/fs/notify/inotify/Kconfig b/fs/notify/inotify/Kconfig
index 1cc8be25df7e..1b2d6aef5dda 100644
--- a/fs/notify/inotify/Kconfig
+++ b/fs/notify/inotify/Kconfig
@@ -15,3 +15,27 @@ config INOTIFY_USER
 	  For more information, see <file:Documentation/filesystems/inotify.rst>
 
 	  If unsure, say Y.
+
+config INOTIFY_NAME_UID
+	bool "Inotify filename with uid information"
+	default n
+	help
+	  Say Y here to enable inotify file name with uid, pid and comm information.
+	  Added the current context information with file name.
+	  The inotify event only contains file name information. Sometimes we
+	  also want to know user or process information,such as who created
+	  or deleted a file. This patch adds information such as COMM, PID
+	  and UID to the end of filename, which allowing us to implement
+	  this function without modifying the current Inotify mechanism.
+	  This function is not enabled by default and is enabled through an IOCTL
+	  When enable this function, inotify_event->name will contain comm,
+	  pid and uid information, with the following specific format:
+	  filename____XXX,pid:YYY__uid:ZZZ
+	  Pseudo code to enable this function:
+	  int rc, bytes_to_read, inotify_fd;
+	  inotify_fd = inotify_init();
+	  ...
+	  // enable padding uid,pid information
+	  rc = ioctl( inotify_fd, TIOCLINUX, &bytes_to_read);
+
+	  If unsure, say n.
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 993375f0db67..d6d2d11f1e8c 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -23,9 +23,16 @@
 #include <linux/sched.h>
 #include <linux/sched/user.h>
 #include <linux/sched/mm.h>
+#ifdef CONFIG_INOTIFY_NAME_UID
+#include <linux/cred.h>
+#endif
 
 #include "inotify.h"
 
+#ifdef CONFIG_INOTIFY_NAME_UID
+#define UID_INFO_MAX_SIZE   64
+#endif
+
 /*
  * Check if 2 events contain the same information.
  */
@@ -68,9 +75,21 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
+#ifdef CONFIG_INOTIFY_NAME_UID
+	char uid_info[UID_INFO_MAX_SIZE];
+	struct user_struct *user_info;
+#endif
 
 	if (name) {
 		len = name->len;
+#ifdef CONFIG_INOTIFY_NAME_UID
+		if (group->user_flag & USER_FLAG_TASK_INFO) {
+			user_info = current_user();
+			sprintf(uid_info, "____%s,pid:%d__uid:%d",
+				current->comm, current->pid, user_info->uid.val);
+			len += strlen(uid_info);
+		}
+#endif
 		alloc_len += len + 1;
 	}
 
@@ -120,9 +139,17 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
+#ifdef CONFIG_INOTIFY_NAME_UID
+	if (len) {
+		if (group->user_flag & USER_FLAG_TASK_INFO)
+			sprintf(event->name, "%s%s", name->name, uid_info);
+		else
+			strcpy(event->name, name->name);
+	}
+#else
 	if (len)
 		strcpy(event->name, name->name);
-
+#endif
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
 		/* Our event wasn't used in the end. Free it. */
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 4ffc30606e0b..f1538cafdc1d 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -349,6 +349,13 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
 		}
 		break;
 #endif /* CONFIG_CHECKPOINT_RESTORE */
+
+#ifdef CONFIG_INOTIFY_NAME_UID
+	case TIOCLINUX:
+		group->user_flag |=  USER_FLAG_TASK_INFO;
+		ret = 0;
+		break;
+#endif /* CONFIG_INOTIFY_NAME_UID */
 	}
 
 	return ret;
@@ -674,7 +681,9 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 
 	group->max_events = max_events;
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
-
+#ifdef CONFIG_INOTIFY_NAME_UID
+	group->user_flag = 0;
+#endif
 	spin_lock_init(&group->inotify_data.idr_lock);
 	idr_init(&group->inotify_data.idr);
 	group->inotify_data.ucounts = inc_ucount(current_user_ns(),
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 4dd6143db271..d4f57b16f1d3 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -234,7 +234,10 @@ struct fsnotify_group {
 						 * full */
 
 	struct mem_cgroup *memcg;	/* memcg to charge allocations */
-
+#ifdef CONFIG_INOTIFY_NAME_UID
+	#define USER_FLAG_TASK_INFO     1   /* output task infor with filename */
+	unsigned int user_flag;             /* user added control flag */
+#endif
 	/* groups can define private fields here or use the void *private */
 	union {
 		void *private;
-- 
2.25.1



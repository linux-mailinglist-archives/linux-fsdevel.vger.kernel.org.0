Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92EC1612FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgBQNP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38977 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgBQNPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so18447517wme.4;
        Mon, 17 Feb 2020 05:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lz+xcFdtQb9MfwudpkflwlNS1QuyfuZosxO8i55t0/o=;
        b=t9ldRPTVxPsgaaeqI24DkK0+48DTyQS1K/VjBmeqFyXp9H+TzRdS6NBHrNq+yjgm87
         P6O4ZSOeEG/zMh15Inw96qPX/YozRLyH88U1CNIuIPncgI0aWXKGSWqu4RxLAyLBxbr8
         SnjB8WRDDpaoFIHuemRU6Q8cL5cWq4/zC+D0BSAnbvg65Nd4dlbJ1huucyYS8hbwlJfH
         zslSnAdVyhr4J0krABizHf8tDCmI6j5vVyxJv1spiLeEFwxUeolCmT+P5zxCI75YkMeg
         5DIquCPWcWzPL1l6wswYwldz2V/KGSWZv30AqmOdKJ+8Vx4YUzzjVA1b2ok511p6gE+b
         GZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lz+xcFdtQb9MfwudpkflwlNS1QuyfuZosxO8i55t0/o=;
        b=MPUKYgvqkOKbFZflwKigE34cxK01uSbPA0aD5oqweFC7IsgrfimaFZgATZBLduYbgz
         3ql3WwW5BKc9WQ+EaeAR9oh36wzr2ZDWFgp8jnDC//Wrjfr88zaiadg94JTzY2rWeix/
         bxrTDLmBsmxZX/pgJy6dv2CM14D0MZTw4hKeCId4f3jBzNFdf+FnPRGfBjQGlcoOfgS2
         0GGqTllkewyhjbyJoHnwHyJIRKHSzkN0PpZEqQmgCzOpZDPUb5zEiHnDDFAz/zDZgd98
         kRjpoceFG3tTrRB+rjRl+/U70y7AlcCUbI3bAG1ZVmsaRpryFwjuSLeXAR2WqTDKkNUJ
         EDYA==
X-Gm-Message-State: APjAAAW+pahSUUAaYz3FJJ5jwljP2vw9T9lj5z4QJIgrRdOsQxcULSVb
        +5xATtzBNwqvZuDGfNohZGRNo4V+
X-Google-Smtp-Source: APXvYqy02avEyoX3UKEo2nVco1Fo/wUPTOQeHOueRs4qH06fKzqEz+tdkKGERFXQAvun9EhWZA637Q==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr21397524wml.61.1581945319728;
        Mon, 17 Feb 2020 05:15:19 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:19 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 10/16] fanotify: send FAN_DIR_MODIFY event flavor with dir inode and name
Date:   Mon, 17 Feb 2020 15:14:49 +0200
Message-Id: <20200217131455.31107-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dirent events are going to be supported in two flavors:

1. Directory fid info + mask that includes the specific event types
   (e.g. FAN_CREATE) and an optional FAN_ONDIR flag.
2. Directory fid info + name + mask that includes only FAN_DIR_MODIFY.

To request the second event flavor, user needs to set the event type
FAN_DIR_MODIFY in the mark mask.

The first flavor is supported since kernel v5.1 for groups initialized
with flag FAN_REPORT_FID.  It is intended to be used for watching
directories in "batch mode" - the watcher is notified when directory is
changed and re-scans the directory content in response.  This event
flavor is stored more compactly in the event queue, so it is optimal
for workloads with frequent directory changes.

The second event flavor is intended to be used for watching large
directories, where the cost of re-scan of the directory on every change
is considered too high.  The watcher getting the event with the directory
fid and entry name is expected to call fstatat(2) to query the content of
the entry after the change.

Legacy inotify events are reported with name and event mask (e.g. "foo",
FAN_CREATE | FAN_ONDIR).  That can lead users to the conclusion that
there is *currently* an entry "foo" that is a sub-directory, when in fact
"foo" may be negative or non-dir by the time user gets the event.

To make it clear that the current state of the named entry is unknown,
when reporting an event with name info, fanotify obfuscates the specific
event types (e.g. create,delete,rename) and uses a common event type -
FAN_DIR_MODIFY to decribe the change.  This should make it harder for
users to make wrong assumptions and write buggy filesystem monitors.

At this point, name info reporting is not yet implemented, so trying to
set FAN_DIR_MODIFY in mark mask will return -EINVAL.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 7 ++++---
 fs/notify/fsnotify.c             | 2 +-
 include/linux/fsnotify.h         | 6 ++++++
 include/linux/fsnotify_backend.h | 4 +++-
 include/uapi/linux/fanotify.h    | 1 +
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 36903542aa57..1f60823931b7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -194,9 +194,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	test_mask = event_mask & marks_mask & ~marks_ignored_mask;
 
 	/*
-	 * dirent modification events (create/delete/move) do not carry the
-	 * child entry name/inode information. Instead, we report FAN_ONDIR
-	 * for mkdir/rmdir so user can differentiate them from creat/unlink.
+	 * For dirent modification events (create/delete/move) that do not carry
+	 * the child entry name information, we report FAN_ONDIR for mkdir/rmdir
+	 * so user can differentiate them from creat/unlink.
 	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
@@ -399,6 +399,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 	BUILD_BUG_ON(FAN_MOVED_FROM != FS_MOVED_FROM);
 	BUILD_BUG_ON(FAN_CREATE != FS_CREATE);
 	BUILD_BUG_ON(FAN_DELETE != FS_DELETE);
+	BUILD_BUG_ON(FAN_DIR_MODIFY != FS_DIR_MODIFY);
 	BUILD_BUG_ON(FAN_DELETE_SELF != FS_DELETE_SELF);
 	BUILD_BUG_ON(FAN_MOVE_SELF != FS_MOVE_SELF);
 	BUILD_BUG_ON(FAN_EVENT_ON_CHILD != FS_EVENT_ON_CHILD);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 193530f57963..72d332ce8e12 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -383,7 +383,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 7ba40c19bc7e..fb54d9d70552 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -30,6 +30,12 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
 				 const struct qstr *name, u32 cookie)
 {
 	fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
+	/*
+	 * Send another flavor of the event without child inode data and
+	 * without the specific event type (e.g. FS_CREATE|FS_IS_DIR).
+	 * The name is relative to the dir inode the event is reported to.
+	 */
+	fsnotify(dir, FS_DIR_MODIFY, dir, FSNOTIFY_EVENT_INODE, name, 0);
 }
 
 static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index cd106b5c87a4..310c639de04e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -47,6 +47,7 @@
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
+#define FS_DIR_MODIFY		0x00080000	/* Directory entry was modified */
 
 #define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
 /* This inode cares about things that happen to its children.  Always set for
@@ -66,7 +67,8 @@
  * The watching parent may get an FS_ATTRIB|FS_EVENT_ON_CHILD event
  * when a directory entry inside a child subdir changes.
  */
-#define ALL_FSNOTIFY_DIRENT_EVENTS	(FS_CREATE | FS_DELETE | FS_MOVE)
+#define ALL_FSNOTIFY_DIRENT_EVENTS	(FS_CREATE | FS_DELETE | FS_MOVE | \
+					 FS_DIR_MODIFY)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 2a1844edda47..615fa2c87179 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -24,6 +24,7 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+#define FAN_DIR_MODIFY		0x00080000	/* Directory entry was modified */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.17.1


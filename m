Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5718BAAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCSPK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33607 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgCSPK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so3507963wrd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVSVVobZ3NjP89BLt5Dp1KlPOZoxksqI1G3vxFASu/4=;
        b=KKVU0o3M/md4tmP1+HGj2DzLaLB5sQLd/vDRIvtKvVb9WrVGym+jxVWF6bKADrdAEb
         otY/YEOMPGfStWEs3A/V3xK9qerlvE4nP9A10Ve6iKOE6c/9HELBbJbGxVhZyfGaWyxl
         wPK02uvZu3S4fWxQUAU+rITWopbG9Ndpq3lGWJl09LJS1uVfwuVq/ESzZvw025Kn1vqX
         zW8YSZwK/d+MbJxfb+ASHmq94ASouWHapag4jmO0UQid7jJi8nbuooOLFhzDzD1IxN/0
         xzlpvcLlxFVBXsoAz7TufLLU5MO6iNr0iZ/ykWE0jrj7QfK20BbUTYasGs8wPPXXfYhR
         Vf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVSVVobZ3NjP89BLt5Dp1KlPOZoxksqI1G3vxFASu/4=;
        b=nKi5TnZT+qLCIz0ki277CRxYopQRV9zhHS+u+oiwNNharygXQWSEN2EvCwFrzz7aJD
         7TAjBpZvt+uU6IWQVyrv6wTUguXotqc7tZQlYXyR0wppXortmSsWoIl/8+qGMoRbOTmG
         mvkoXb1D41F+BEhaJj6tenfZmKN2FN4FSHxuQgJOMlosQm1ev4so9rttq8iwKTFtRkAd
         a/oTYO/HrAVQVnWxN12ulLtxwiAKrkqPuX14GPmGDNi4Z2SUTJE1rfJ4yN8JByNCv/ug
         SNIOwbyYp+ZCf4erjiklEPQkRlRGf0b9FjpVg7E3i5CKwdcNoUE6KSxIa4rYW8PJHxq7
         na5g==
X-Gm-Message-State: ANhLgQ221r758nXEi5cBNc+0QGJVyiiAshapaufPt18CjMhOs1lSMSKY
        zoOXeHyFvGEieqs7uCB50ieFCmOo
X-Google-Smtp-Source: ADFU+vtjQAne+tFf51iwRqe1JffVtK36zPJY/uTGNenjRfNq6Ko0JADwciHMFupR3ll1XQbvVIus8w==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr4621995wrq.181.1584630655648;
        Thu, 19 Mar 2020 08:10:55 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 11/14] fanotify: send FAN_DIR_MODIFY event flavor with dir inode and name
Date:   Thu, 19 Mar 2020 17:10:19 +0200
Message-Id: <20200319151022.31456-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
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
index 4c5dd5db21bd..75f288d5eeab 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -235,9 +235,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
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
@@ -465,6 +465,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
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
index d286663fcef2..b3d3f2ac34d5 100644
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
index 8ede512fca70..0019cb5f0113 100644
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


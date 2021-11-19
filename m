Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49D456AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhKSHUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhKSHUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E18C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so16423813wrr.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukibpyvVO4XMaS0yh32YqXftFH9VAVvKgHaiUJfMW7U=;
        b=hubfvO6XOE3eoPd0i4swS4dktPZaRPdxdTL+F9VWSA2N6zRcBD0yIonT4uRo0fvPm/
         VkIAUh3MMfchdm3AVurvVQl29BNYKtqIMzR8jCDLBt4XB9FaBLGYXo9E4oVlJL4+KAXr
         X5ydVh3FHOvAUmXx2c0jiqilsqLTk80L6vNZmFLeIVbhHIE7wUAS7H1F+I6rx7Fe/ega
         zvID4PkszwszSJJUpMf7BusWU1EGFWXWFez0c5IWFwRTib172NoqBFXe8h0gV/Ui82/I
         hMB/DxfsROQvWN1csyy6eaXXpeIDTE3rbVkTuXPCdis8ICtA+PcQDhLzeVBrXD4xOFiU
         4ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukibpyvVO4XMaS0yh32YqXftFH9VAVvKgHaiUJfMW7U=;
        b=24L5N7bvqv/nWjkToZiTO+UWyWNvi/q+zvZR5M6PjeDLJEAhdJPmvw/ujiDHccCaqf
         iUX3uarQXmIuxwGvjevZYw95Ylj1uJaErr7CUi2OKsdb2TF3TM903g0tBrH44Lp1AnP/
         D4TAqEruo+OoBtfyq2VJ/PYaWTDkDUjEjXQFZbbS4dZ7FZjdB+KwZCnQMGamyyUSgdFP
         pNPe3REpgq/GW35J3e3F2Fy6YB4Cx+tRZWenjyZylbPSBLiPK7tj/Djz93Nd+YAW+/xu
         tFRtjUxQQmiFpTOnhdxmaRwSIdiBMt8j2YaJnYnwpualjkchspURk0ZtwrwpmJ6YUi5F
         IZwg==
X-Gm-Message-State: AOAM5324jEpIqgFLdVOVXHRfGss6RPtIJSHJJ+UiMLGval7cmWQCfA2h
        QE2Ocqm2zWsBrozOymdI9cRKM+HfQvk=
X-Google-Smtp-Source: ABdhPJyXldEUm9ClAStoOdPb64I3bTWB6KdS1WLq5sVdZptsC7JmWGTZRTpgwMq23z+JZbso41BWpQ==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr4948671wrs.266.1637306264363;
        Thu, 18 Nov 2021 23:17:44 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:43 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/9] fsnotify: generate FS_RENAME event with rich information
Date:   Fri, 19 Nov 2021 09:17:31 +0200
Message-Id: <20211119071738.1348957-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dnotify FS_DN_RENAME event is used to request notification about
a move within the same parent directory and was always coupled with
the FS_MOVED_FROM event.

Rename the FS_DN_RENAME event flag to FS_RENAME, decouple it from
FS_MOVED_FROM and report it with the moved dentry instead of the moved
inode, so it has the information about both old and new parent and name.

Generate the FS_RENAME event regardless of same parent dir and apply
the "same parent" rule in the generic fsnotify_handle_event() helper
that is used to call backends with ->handle_inode_event() method
(i.e. dnotify).  The ->handle_inode_event() method is not rich enough to
report both old and new parent and name anyway.

The enriched event is reported to fanotify over the ->handle_event()
method with the marks array slots for inode and parent mark types hold
the old and new parent inode marks of the group.

The enriched event will be used for reporting old and new parent+name to
fanotify groups with FAN_RENAME events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/dnotify/dnotify.c      |  2 +-
 fs/notify/fsnotify.c             | 14 ++++++++++++++
 include/linux/dnotify.h          |  2 +-
 include/linux/fsnotify.h         |  9 ++++++---
 include/linux/fsnotify_backend.h |  6 +++---
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index e85e13c50d6d..d5ebebb034ff 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -196,7 +196,7 @@ static __u32 convert_arg(unsigned long arg)
 	if (arg & DN_ATTRIB)
 		new_mask |= FS_ATTRIB;
 	if (arg & DN_RENAME)
-		new_mask |= FS_DN_RENAME;
+		new_mask |= FS_RENAME;
 	if (arg & DN_CREATE)
 		new_mask |= (FS_CREATE | FS_MOVED_TO);
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 4034ca566f95..fc21a3b5b86c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -279,6 +279,14 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
 
+	/*
+	 * For FS_RENAME, inode is old_dir and parent is new_dir.
+	 * The only ->handle_inode_event() backend that supports FS_RENAME is
+	 * dnotify, where it means file was renamed within same parent.
+	 */
+	if ((mask & FS_RENAME) && parent_mark != inode_mark)
+		return 0;
+
 	if (parent_mark) {
 		/*
 		 * parent_mark indicates that the parent inode is watching
@@ -470,6 +478,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *parent = NULL;
+	struct dentry *moved;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
 
@@ -479,6 +488,11 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (!inode) {
 		/* Dirent event - report on TYPE_INODE to dir */
 		inode = dir;
+		/* For FS_RENAME, inode is old_dir and parent is new_dir */
+		if (mask & FS_RENAME) {
+			moved = fsnotify_data_dentry(data, data_type);
+			parent = moved->d_parent->d_inode;
+		}
 	} else if (mask & FS_EVENT_ON_CHILD) {
 		/*
 		 * Event on child - report on TYPE_PARENT to dir if it is
diff --git a/include/linux/dnotify.h b/include/linux/dnotify.h
index 0aad774beaec..b87c3b85a166 100644
--- a/include/linux/dnotify.h
+++ b/include/linux/dnotify.h
@@ -26,7 +26,7 @@ struct dnotify_struct {
 			    FS_MODIFY | FS_MODIFY_CHILD |\
 			    FS_ACCESS | FS_ACCESS_CHILD |\
 			    FS_ATTRIB | FS_ATTRIB_CHILD |\
-			    FS_CREATE | FS_DN_RENAME |\
+			    FS_CREATE | FS_RENAME |\
 			    FS_MOVED_FROM | FS_MOVED_TO)
 
 extern int dir_notify_enable;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 787545e87eeb..3a2d7dc3c607 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -144,16 +144,19 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	u32 fs_cookie = fsnotify_get_cookie();
 	__u32 old_dir_mask = FS_MOVED_FROM;
 	__u32 new_dir_mask = FS_MOVED_TO;
+	__u32 rename_mask = FS_RENAME;
 	const struct qstr *new_name = &moved->d_name;
 
-	if (old_dir == new_dir)
-		old_dir_mask |= FS_DN_RENAME;
-
 	if (isdir) {
 		old_dir_mask |= FS_ISDIR;
 		new_dir_mask |= FS_ISDIR;
+		rename_mask |= FS_ISDIR;
 	}
 
+	/* Event with information about both old and new parent+name */
+	fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
+		      old_dir, old_name, 0);
+
 	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
 		      old_dir, old_name, fs_cookie);
 	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 51ef2b079bfa..357467050380 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -63,7 +63,7 @@
  */
 #define FS_EVENT_ON_CHILD	0x08000000
 
-#define FS_DN_RENAME		0x10000000	/* file renamed */
+#define FS_RENAME		0x10000000	/* File was renamed */
 #define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
 #define FS_IN_ONESHOT		0x80000000	/* only send event once */
@@ -76,7 +76,7 @@
  * The watching parent may get an FS_ATTRIB|FS_EVENT_ON_CHILD event
  * when a directory entry inside a child subdir changes.
  */
-#define ALL_FSNOTIFY_DIRENT_EVENTS	(FS_CREATE | FS_DELETE | FS_MOVE)
+#define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
@@ -101,7 +101,7 @@
 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
-			     FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
+			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
 			     FS_ERROR)
 
-- 
2.33.1


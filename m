Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DA46278D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 00:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhK2XHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 18:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhK2XGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:06:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE7C06FD48
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so39415594wrw.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5j6uLXIFKi7tFoTkIEDlfxA5jV/W2nL78YQ1LQvmQ4=;
        b=Hto8bhByYltJPdOx0shiYOwKYHXwM2qzRwkazepZCAv4lmrd6tF1MHCzALX4dfeXnj
         0dJpaocevDVoVibuodM76nUa5KQj++S8icSJ8pcsSfcflEyJwbvxXcr2eruEfsaAG/Cq
         T1mfTtmN8ZC0UeICYI/fD1bgB95sfBQgJF1+t18aAk/wIUS/cZxE9xuMezwfqqyy4huu
         TpOhhXtpAnaMSd2/zttikJCZ8oXUyfHsy31kVZh+CiY1b5Afk1vKuB45vkFgGICmQpJR
         4uXrrauIQqTQ+0r2+4HTZS5jNvekaMJk+pkQ9BFYDhXsJrbrvCi+MWQnRUkdiDE9qoyx
         Bodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5j6uLXIFKi7tFoTkIEDlfxA5jV/W2nL78YQ1LQvmQ4=;
        b=isk08RTHZu2IFX4/cBnAxZw2fOz1DTI8BpkHS+j0JSgqF4Srk/lwRCXGvvIJMuEsvT
         XjQNdEceDw2lczTNZT9varvHQ1SN03rsOu2OC3CI2/DX1JYU5UkTzV0qCEOeydOhcL+e
         K8DoZzqOqHEqGWC9xRkC++9jRee6qJ11Kc882XT30YcmDKnx6SrEBHfFRX9izTMTh92w
         oQPICrr7clIpPfKH+n87dUHI8LOrvelo/TMDOyFgPmFfu72yAemaLXsXunJDCxQazl34
         A3x+2tfr6+OkwVM+PgWIPKNfzNFKCad6QYquHxDz0iwpXZ125gu4V5q3tqnCtHvEqHkb
         8iEQ==
X-Gm-Message-State: AOAM530lUBLX2cMn5ilRXg2gws3MT/clRzajU/fXA9USLBmrubvc5JWt
        ZR1B0o/vtjELl5w7C7QdCwY=
X-Google-Smtp-Source: ABdhPJy8VVTnRvwcSMCB/WA4rWNbXJBWWLeMcJYRLd/GqE97TBeXaOjR5QMbxfXr4xu24UaT1t3A+w==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr36615770wrj.576.1638216944927;
        Mon, 29 Nov 2021 12:15:44 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:44 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/11] fsnotify: generate FS_RENAME event with rich information
Date:   Mon, 29 Nov 2021 22:15:30 +0200
Message-Id: <20211129201537.1932819-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
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
method with the old and new dir inode marks in marks array slots for
ITER_TYPE_INODE and a new iter type slot ITER_TYPE_INODE2.

The enriched event will be used for reporting old and new parent+name to
fanotify groups with FAN_RENAME events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/dnotify/dnotify.c      |  2 +-
 fs/notify/fsnotify.c             | 37 +++++++++++++++++++++++++-------
 include/linux/dnotify.h          |  2 +-
 include/linux/fsnotify.h         |  9 +++++---
 include/linux/fsnotify_backend.h |  7 +++---
 5 files changed, 41 insertions(+), 16 deletions(-)

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
index 0c94457c625e..ab81a0776ece 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -279,6 +279,18 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
 
+	/*
+	 * For FS_RENAME, 'dir' is old dir and 'data' is new dentry.
+	 * The only ->handle_inode_event() backend that supports FS_RENAME is
+	 * dnotify, where it means file was renamed within same parent.
+	 */
+	if (mask & FS_RENAME) {
+		struct dentry *moved = fsnotify_data_dentry(data, data_type);
+
+		if (dir != moved->d_parent->d_inode)
+			return 0;
+	}
+
 	if (parent_mark) {
 		/*
 		 * parent_mark indicates that the parent inode is watching
@@ -469,7 +481,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
-	struct inode *parent = NULL;
+	struct inode *inode2 = NULL;
+	struct dentry *moved;
+	int inode2_type;
 	int ret = 0;
 	__u32 test_mask, marks_mask;
 
@@ -479,12 +493,19 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (!inode) {
 		/* Dirent event - report on TYPE_INODE to dir */
 		inode = dir;
+		/* For FS_RENAME, inode is old_dir and inode2 is new_dir */
+		if (mask & FS_RENAME) {
+			moved = fsnotify_data_dentry(data, data_type);
+			inode2 = moved->d_parent->d_inode;
+			inode2_type = FSNOTIFY_ITER_TYPE_INODE2;
+		}
 	} else if (mask & FS_EVENT_ON_CHILD) {
 		/*
 		 * Event on child - report on TYPE_PARENT to dir if it is
 		 * watching children and on TYPE_INODE to child.
 		 */
-		parent = dir;
+		inode2 = dir;
+		inode2_type = FSNOTIFY_ITER_TYPE_PARENT;
 	}
 
 	/*
@@ -497,7 +518,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (!sb->s_fsnotify_marks &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!parent || !parent->i_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks))
 		return 0;
 
 	marks_mask = sb->s_fsnotify_mask;
@@ -505,8 +526,8 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		marks_mask |= mnt->mnt_fsnotify_mask;
 	if (inode)
 		marks_mask |= inode->i_fsnotify_mask;
-	if (parent)
-		marks_mask |= parent->i_fsnotify_mask;
+	if (inode2)
+		marks_mask |= inode2->i_fsnotify_mask;
 
 
 	/*
@@ -529,9 +550,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[FSNOTIFY_ITER_TYPE_INODE] =
 			fsnotify_first_mark(&inode->i_fsnotify_marks);
 	}
-	if (parent) {
-		iter_info.marks[FSNOTIFY_ITER_TYPE_PARENT] =
-			fsnotify_first_mark(&parent->i_fsnotify_marks);
+	if (inode2) {
+		iter_info.marks[inode2_type] =
+			fsnotify_first_mark(&inode2->i_fsnotify_marks);
 	}
 
 	/*
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
index 73739fee1710..790c31844db5 100644
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
 
@@ -349,6 +349,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_VFSMOUNT,
 	FSNOTIFY_ITER_TYPE_SB,
 	FSNOTIFY_ITER_TYPE_PARENT,
+	FSNOTIFY_ITER_TYPE_INODE2,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
-- 
2.33.1


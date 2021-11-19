Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEF456ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhKSHUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhKSHUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19AC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u18so16430766wrg.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6d1QVvdCUQXe+/rLlA6XdfalKLkh4mUpnaYWDbHrQf8=;
        b=Kyr+REYE90/2bVW3tNMH4/Y5vH6xCjXPeeYOt2q+BEAMmoVjxWQk0zgMUAezah8/KR
         Dh3Np7o+EXI0T1zxmjPMVakrD7cj1T0Xl1416ke/cmMXY7pzFy7Ea+7GCATHcxWdWdAP
         gwUwYLjAsj9UqWevvt6GmV5rLzQW2MUf/cM3UahLS4VwA+JxIL3+Ta8L4Ns0AdJlohah
         QphSfESCrxKyZ4IQ6ZtHcXf/w99rr21aZMwq4w29u2Yg929CCnfWwjYClNIwXK1q8qEu
         ChNN0f/a13J24aaNPMH6wYDs75BUFGrJlCcTgueZh7beSu+RKKel71UP2aFGUVAKP6MG
         2wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6d1QVvdCUQXe+/rLlA6XdfalKLkh4mUpnaYWDbHrQf8=;
        b=jOAjz0h6XnqFVZlF+1Ye/MCv5zJpkuia0izOoJQNdF9Wh93t0+Ri4FE31Ut15KE60Q
         Yy4VgOeQU1MrnX+xsjQ6WTRi26Gz1OcooDoXBllfCC4NbaecmoO7EMzQVwkNqnWNvfBK
         mPD4LKObT+DoMttO7stAh5qxZFm1w4eGK5tgx4nVzioscdfHhVh6g+psXmvix/BHbhkJ
         p5zTmPxZAFPKPlZXrMHWc7oj6kHJXcBbfOThSq2we2Rz+uu2dj/A8pvNSldnFyMGJrWB
         /9a0RZds1lfThsmK7Q0UkrhqfTVnumEFzJDchhs+CY7IfRvxn7AXoRXIeRysRTzqB9Di
         W8jA==
X-Gm-Message-State: AOAM530tBjIQeo0oAjDfzBBS12kdFWintAYWOmsr/Ov3yF1idHtRoUdz
        oOkpHLVideXjxpIlkoBzD9q8ImBE48w=
X-Google-Smtp-Source: ABdhPJzxVAAlu+NDDAbe0Cf+0wUdM+OSpqDTi8rgB1c52KSmFaUz1on+D4lXBXIoaf0b4DNaf28U3w==
X-Received: by 2002:adf:a2de:: with SMTP id t30mr4688876wra.58.1637306263129;
        Thu, 18 Nov 2021 23:17:43 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:42 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/9] fanotify: introduce group flag FAN_REPORT_TARGET_FID
Date:   Fri, 19 Nov 2021 09:17:30 +0200
Message-Id: <20211119071738.1348957-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_REPORT_FID is ambiguous in that it reports the fid of the child for
some events and the fid of the parent for create/delete/move events.

The new FAN_REPORT_TARGET_FID flag is an implicit request to report
the fid of the target object of the operation (a.k.a the child inode)
also in create/delete/move events in addition to the fid of the parent
and the name of the child.

To reduce the test matrix for uninteresting use cases, the new
FAN_REPORT_TARGET_FID flag requires both FAN_REPORT_NAME and
FAN_REPORT_FID.  The convenience macro FAN_REPORT_DFID_NAME_TARGET
combines FAN_REPORT_TARGET_FID with all the required flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 48 ++++++++++++++++++++++--------
 fs/notify/fanotify/fanotify_user.c | 11 ++++++-
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  4 +++
 4 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index b6091775aa6e..9b1641ecfe97 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -458,17 +458,41 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 }
 
 /*
- * The inode to use as identifier when reporting fid depends on the event.
- * Report the modified directory inode on dirent modification events.
- * Report the "victim" inode otherwise.
+ * FAN_REPORT_FID is ambiguous in that it reports the fid of the child for
+ * some events and the fid of the parent for create/delete/move events.
+ *
+ * With the FAN_REPORT_TARGET_FID flag, the fid of the child is reported
+ * also in create/delete/move events in addition to the fid of the parent
+ * and the name of the child.
+ */
+static inline bool fanotify_report_child_fid(unsigned int fid_mode, u32 mask)
+{
+	if (mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+		return (fid_mode & FAN_REPORT_TARGET_FID);
+
+	return (fid_mode & FAN_REPORT_FID) && !(mask & FAN_ONDIR);
+}
+
+/*
+ * The inode to use as identifier when reporting fid depends on the event
+ * and the group flags.
+ *
+ * With the group flag FAN_REPORT_TARGET_FID, always report the child fid.
+ *
+ * Without the group flag FAN_REPORT_TARGET_FID, report the modified directory
+ * fid on dirent events and the child fid otherwise.
+ *
  * For example:
- * FS_ATTRIB reports the child inode even if reported on a watched parent.
- * FS_CREATE reports the modified dir inode and not the created inode.
+ * FS_ATTRIB reports the child fid even if reported on a watched parent.
+ * FS_CREATE reports the modified dir fid without FAN_REPORT_TARGET_FID.
+ *       and reports the created child fid with FAN_REPORT_TARGET_FID.
  */
 static struct inode *fanotify_fid_inode(u32 event_mask, const void *data,
-					int data_type, struct inode *dir)
+					int data_type, struct inode *dir,
+					unsigned int fid_mode)
 {
-	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
+	if ((event_mask & ALL_FSNOTIFY_DIRENT_EVENTS) &&
+	    !(fid_mode & FAN_REPORT_TARGET_FID))
 		return dir;
 
 	return fsnotify_data_inode(data, data_type);
@@ -647,10 +671,11 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 {
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
-	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
+	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir,
+					      fid_mode);
 	struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
-	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct mem_cgroup *old_memcg;
 	struct inode *child = NULL;
 	bool name_event = false;
@@ -660,11 +685,10 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
-		 * With both flags FAN_REPORT_DIR_FID and FAN_REPORT_FID, we
-		 * report the child fid for events reported on a non-dir child
+		 * For certain events and group flags, report the child fid
 		 * in addition to reporting the parent fid and maybe child name.
 		 */
-		if ((fid_mode & FAN_REPORT_FID) && id != dirid && !ondir)
+		if (fanotify_report_child_fid(fid_mode, mask) && id != dirid)
 			child = id;
 
 		id = dirid;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 559bc1e9926d..0ade5031733d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1275,6 +1275,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	if ((fid_mode & FAN_REPORT_NAME) && !(fid_mode & FAN_REPORT_DIR_FID))
 		return -EINVAL;
 
+	/*
+	 * FAN_REPORT_TARGET_FID requires FAN_REPORT_NAME and FAN_REPORT_FID
+	 * and is used as an indication to report both dir and child fid on all
+	 * dirent events.
+	 */
+	if ((fid_mode & FAN_REPORT_TARGET_FID) &&
+	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
+		return -EINVAL;
+
 	f_flags = O_RDWR | FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
@@ -1667,7 +1676,7 @@ static int __init fanotify_user_setup(void)
 				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 616af2ea20f3..376e050e6f38 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -25,7 +25,7 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FANOTIFY_PERM_CLASSES)
 
-#define FANOTIFY_FID_BITS	(FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
+#define FANOTIFY_FID_BITS	(FAN_REPORT_DFID_NAME_TARGET)
 
 #define FANOTIFY_INFO_MODES	(FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index bd1932c2074d..60f73639a896 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -57,9 +57,13 @@
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
 #define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
 #define FAN_REPORT_NAME		0x00000800	/* Report events with name */
+#define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
+/* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flags */
+#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
+				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.33.1


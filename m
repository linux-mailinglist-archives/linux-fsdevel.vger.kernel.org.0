Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E621C5D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgEEQUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgEEQUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DAC061A10;
        Tue,  5 May 2020 09:20:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so3462885wra.7;
        Tue, 05 May 2020 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFtMzdlVERg3W0V/nBQMM7T1KqaZRn4iadefSm9BaJs=;
        b=ZNpVYstLVUqqv4tOCIkPr1wjpgsGXAUVfCd0fg0c8izBlRU1zVw782DYAkBGSlIPDb
         KDYiT8LGCTHEX6XUBIS5xPaz+TUnKKp8UlD/64JgMADSdhTwSfTfAN/VdrB7mQSY5oRn
         Z6IXmlg++rj5nmwxOzPAcmMIaId4/2XLN5qL2G08Ki5Wf1TCFsmBLB2jOFegbZ/dwOeE
         HW02tNSmySUTslRZe4sv+R3K0WgID4o3dR2khmpfpBC3kZnIfuir0vS1pBTewteEmpNM
         sTdBnOgboZa6RorkAYkSXRGxAq30Hg0ueR+RnYwbRXuKBKHZUqKkuoV1lQ/3jrMUM/kV
         m59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yFtMzdlVERg3W0V/nBQMM7T1KqaZRn4iadefSm9BaJs=;
        b=OFGrq9I5bTuJ2UAznpsJhiZ3t1XxxTMvfz5UxjMwseK+8C8ATgL1kZQRJwH/XTUQX3
         99qdhg5DGBGqVB2587Nq/fa9gPJP6PDhXLYZ3SIye4vvtBjDGyy6dXKqtsJ0oTb7SyU3
         Z/V9VyYzXWiutxRABtek5UckcP4yFUagEMhjxL+iwjXbzc7AeDoOehYQf6n0yHr0koSx
         4tpV2uLweJWFN4dE1RGv7h5cjwIAu8m6jtXOgTwRMyHWKDJx97rSTO0EBaHDfI6mpdvs
         GuiqNTf7XgHsW4YpYqwHRJ+M6qWXxutX+VzvFBfqeW/Kqga2+n2PbocfgPby8yaDtGwh
         UirA==
X-Gm-Message-State: AGi0PuZkKh+5s074aXf14c1Un+wsWL31WrsgA8Zcg4FhgmhRUx40qsP+
        sgpWUvkc+L3yBXA4p8QKL7GxBG7y
X-Google-Smtp-Source: APiQypKwRxXSWs0PLLw+2kd4wvZ7y2ucebRLh7WFhiCBTmA4gjrFONKCYFVbXB39CkGO9LURDM5pmg==
X-Received: by 2002:adf:e450:: with SMTP id t16mr4906034wrm.301.1588695628883;
        Tue, 05 May 2020 09:20:28 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:28 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 5/7] fanotify: report parent fid + name for events on children
Date:   Tue,  5 May 2020 19:20:12 +0300
Message-Id: <20200505162014.10352-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An application that needs to index or mirror the content of a large
directory needs an efficient way to be notified on changes in that
directory without re-scanning the entire directory on every change.

The event FAN_DIR_MODIFY provides the means to get a notification on
directory entry changes, but not on child modifications. fanotify
provides the capability to get events on changes to children of a watched
directory, but getting the name of the child is not reliable and this
is something that an application of that sort needs.

As a matter of fact, inotify already provides this capability, but it
does not scale to watching the entire filesystem.
We are adding the basic capability to fanotify only for directory marks
for now and soon we will add the ability to watch an entire filesystem
or mount with a reliable [*] way to get the path on the event.

[*] reliable above means that we can stat the file by dirfid+name and
know for sure of the event reported was for that file.

A new fanotify_init() flag FAN_REPORT_NAME is introduced.  It requires
flag FAN_REPORT_FID and there is a constant for setting both flags named
FAN_REPORT_FID_NAME.

For a group with fanotify_init() flag FAN_REPORT_NAME, the parent fid and
name are reported for events "on child" to a directory watching children.
The parent fid and name are reported with an info record of type
FAN_EVENT_INFO_TYPE_DFID_NAME, similar to the way that name info is
reported for FAN_DIR_MODIFY events.

The child fid itself is reported with another info record of type
FAN_EVENT_INFO_TYPE_FID that follows the first info record, with the
same fid info as reported to a group with only FAN_REPORT_FID flag.

FAN_DIR_MODIFY events do not record nor report the "child" fid, but in
order to stay consistent with events "on child", we store those events
in struct fanotify_name_event with an empty object_fh.

This wastes a few unused bytes (16) of memory per FAN_DIR_MODIFY event,
but keeps the code simpler and avoids creating a custom event struct
just for FAN_DIR_MODIFY events.

Cc: <linux-api@vger.kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 33 ++++++++++++++++++++++++------
 fs/notify/fanotify/fanotify.h      |  3 +++
 fs/notify/fanotify/fanotify_user.c |  6 +++++-
 include/linux/fanotify.h           |  2 +-
 include/uapi/linux/fanotify.h      |  4 ++++
 5 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index bdafc76cc258..e91a8cc1b83c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -64,7 +64,8 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 		return false;
 
 	if (fne1->name_len != fne2->name_len ||
-	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh))
+	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh) ||
+	    !fanotify_fh_equal(&fne1->object_fh, &fne2->object_fh))
 		return false;
 
 	return !memcmp(fne1->name, fne2->name, fne1->name_len);
@@ -211,7 +212,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     int data_type)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
+				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_mark *mark;
 	int type;
@@ -262,11 +264,17 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
 	 * to user in FAN_REPORT_FID mode for all event types.
+	 *
+	 * We never report FAN_EVENT_ON_CHILD to user, but we do pass it in to
+	 * fanotify_alloc_event() for group with FAN_REPORT_NAME as indication
+	 * of how the event should be reported.
 	 */
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		/* Do not report event flags without any event */
 		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
+		if (!FAN_GROUP_FLAG(group, FAN_REPORT_NAME))
+			user_mask &= ~FAN_EVENT_ON_CHILD;
 	} else {
 		user_mask &= ~FANOTIFY_EVENT_FLAGS;
 	}
@@ -394,10 +402,10 @@ struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 	return &ffe->fae;
 }
 
-struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
+struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 						 __kernel_fsid_t *fsid,
 						 const struct qstr *file_name,
-						 gfp_t gfp)
+						 struct inode *id, gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
 
@@ -407,7 +415,8 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 
 	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
 	fne->fsid = *fsid;
-	fanotify_encode_fh(&fne->dir_fh, id, gfp);
+	fanotify_encode_fh(&fne->dir_fh, dir, gfp);
+	fanotify_encode_fh(&fne->object_fh, id, gfp);
 	fne->name_len = file_name->len;
 	strcpy(fne->name, file_name->name);
 
@@ -447,7 +456,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		 * and the name of the modified entry.
 		 * Allocate an fanotify_name_event struct and copy the name.
 		 */
-		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
+		event = fanotify_alloc_name_event(id, fsid, file_name, NULL,
+						  gfp);
+	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_NAME) &&
+		   (mask & FAN_EVENT_ON_CHILD) && likely(inode != id)) {
+		/*
+		 * With flag FAN_REPORT_NAME, we report the parent fid and name
+		 * for events reported "on child" in addition to reporting the
+		 * child fid.
+		 */
+		event = fanotify_alloc_name_event(inode, fsid, file_name, id,
+						  gfp);
 	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		event = fanotify_alloc_fid_event(id, fsid, gfp);
 	} else {
@@ -631,6 +650,8 @@ static void fanotify_free_name_event(struct fanotify_event *event)
 {
 	struct fanotify_name_event *fne = FANOTIFY_NE(event);
 
+	if (fanotify_fh_has_ext_buf(&fne->object_fh))
+		kfree(fanotify_fh_ext_buf(&fne->object_fh));
 	if (fanotify_fh_has_ext_buf(&fne->dir_fh))
 		kfree(fanotify_fh_ext_buf(&fne->dir_fh));
 	kfree(fne);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 3adbb9f7d1a8..9aafccc23c75 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -96,6 +96,7 @@ FANOTIFY_FE(struct fanotify_event *event)
 struct fanotify_name_event {
 	struct fanotify_event fae;
 	__kernel_fsid_t fsid;
+	struct fanotify_fh object_fh;
 	struct fanotify_fh dir_fh;
 	u8 name_len;
 	char name[0];
@@ -122,6 +123,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID)
 		return &FANOTIFY_FE(event)->object_fh;
+	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
+		return &FANOTIFY_NE(event)->object_fh;
 	else
 		return NULL;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8c6d22ec7b41..030534da49e2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -879,6 +879,10 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (flags & FANOTIFY_CLASS_BITS) != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
+	/* Child name is reported with parent fid */
+	if ((flags & FAN_REPORT_NAME) && !(flags & FAN_REPORT_FID))
+		return -EINVAL;
+
 	user = get_current_user();
 	if (atomic_read(&user->fanotify_listeners) > FANOTIFY_DEFAULT_MAX_LISTENERS) {
 		free_uid(user);
@@ -1212,7 +1216,7 @@ COMPAT_SYSCALL_DEFINE6(fanotify_mark,
  */
 static int __init fanotify_user_setup(void)
 {
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 8);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 9);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 3049a6c06d9e..5412a25c54c0 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -19,7 +19,7 @@
 				 FAN_CLASS_PRE_CONTENT)
 
 #define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | \
-				 FAN_REPORT_TID | FAN_REPORT_FID | \
+				 FAN_REPORT_TID | FAN_REPORT_FID_NAME | \
 				 FAN_CLOEXEC | FAN_NONBLOCK | \
 				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index a88c7c6d0692..41f54a0f360f 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -54,6 +54,10 @@
 /* Flags to determine fanotify event format */
 #define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
 #define FAN_REPORT_FID		0x00000200	/* Report unique file id */
+#define FAN_REPORT_NAME		0x00000400	/* Report events with name */
+
+/* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_FID */
+#define FAN_REPORT_FID_NAME	(FAN_REPORT_FID | FAN_REPORT_NAME)
 
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
-- 
2.17.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBBF1C5D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbgEEQU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgEEQUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F700C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:20:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so2945106wmk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8jteWdy5qLU814tl/j2JNd4yjbPoMjg+eGhjvanzjio=;
        b=d+1BUMa6j4dLF7fNl89xYa6+Arlko2NvBu+cqdBVyp/lhcHRGcExeVohXz4GRe+i/G
         D62QVNe81iqcUqMHJmsHoR5c4jug6eqnP1W88sBf6aBWjS4L0OSc5gWupFUaJFZclRwx
         14lISYh1TyYw/7S+fzAu2sWJ0AB7GzWTdUjZbtOyBq1UispFXkzZ6PS0KwdB6E5FyDX8
         bYP231Uc5cWnlBZdbz7SSmWD3qkJHUkJDCZR4i5SBOvc1b6bp1lqcmOY/N+xRp7Ew2s+
         zqHtZD8Lnk5NCl0k6RjOpeNuk4TlPKoLPvfHEmNdbfh0O0c07gVKzTCF1HhgVx12FNks
         voEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8jteWdy5qLU814tl/j2JNd4yjbPoMjg+eGhjvanzjio=;
        b=nU6G0QcMQ5eJcUBXFfLqcSePkmLMy37DlM6S6D/hJ2DI8zLWRLnMXDsv42m3dvu6Dy
         3HtLQbdzJrgpb4RUg+VusbD7iej0MQeqeTDmOV5ogIeThqVzhJLFbkgIP4VBSK+ydWkM
         mIX5X75RsgrJwYQ1tx8pT6RwOXW7oIiPgo471xzHqmdp5r2Zf7v2pjsrB3ks26Gi7+zv
         2ZtEyqdgfIBtffmt4N2Qo9Bj0zYUtwnAIMfI4rKMKbODJWY0YWKyLo+Djq51cDS2PWdR
         //aWkQeJhK4jnjW594/yd0Uh8ZxZe8TT1zNCNz6SkVVOLe0UTIR7523H0lsCDdegaODH
         ySOQ==
X-Gm-Message-State: AGi0PuYQTdB69mnv6xyM+vM1zzgyeS1/TlurhmhrFUIVJasw7DljWX39
        YZbn82aq9D6CUUpa/BGD6Ek=
X-Google-Smtp-Source: APiQypLHyEBB71jlibkgDazkGs6ksqrJIW6T7fPC0FwJV5B4k7Z7a3ZH+RRV6RclBVYG2n7xTakcLw==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr1651784wmd.178.1588695622993;
        Tue, 05 May 2020 09:20:22 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/7] fanotify: create overflow event type
Date:   Tue,  5 May 2020 19:20:08 +0300
Message-Id: <20200505162014.10352-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The special overflow event is allocated as struct fanotify_path_event,
but with a null path.

Use a special event type to identify the overflow event, so the helper
fanotify_has_event_path() will always indicate a non null path.

Allocating the overflow event doesn't need any of the fancy stuff in
fanotify_alloc_event(), so create a simplified helper for allocating the
overflow event.

There is also no need to store and report the pid with an overflow event.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 27 +++++++++++----------------
 fs/notify/fanotify/fanotify.h      | 15 +++++++++------
 fs/notify/fanotify/fanotify_user.c | 21 ++++++++++++++++-----
 3 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5435a40f82be..ce4677077118 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -341,11 +341,11 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 	return (struct inode *)fsnotify_data_inode(data, data_type);
 }
 
-struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
-					    struct inode *inode, u32 mask,
-					    const void *data, int data_type,
-					    const struct qstr *file_name,
-					    __kernel_fsid_t *fsid)
+static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
+						struct inode *inode, u32 mask,
+						const void *data, int data_type,
+						const struct qstr *file_name,
+						__kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
 	struct fanotify_fid_event *ffe = NULL;
@@ -423,8 +423,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
 	 */
-	fsnotify_init_event(&event->fse, (unsigned long)id);
-	event->mask = mask;
+	fanotify_init_event(event, (unsigned long)id, mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
@@ -440,15 +439,8 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		fanotify_encode_fh(fanotify_event_dir_fh(event), id, gfp);
 
 	if (fanotify_event_has_path(event)) {
-		struct path *p = fanotify_event_path(event);
-
-		if (path) {
-			*p = *path;
-			path_get(path);
-		} else {
-			p->mnt = NULL;
-			p->dentry = NULL;
-		}
+		*fanotify_event_path(event) = *path;
+		path_get(path);
 	}
 out:
 	memalloc_unuse_memcg();
@@ -637,6 +629,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
 	case FANOTIFY_EVENT_TYPE_FID_NAME:
 		fanotify_free_name_event(event);
 		break;
+	case FANOTIFY_EVENT_TYPE_OVERFLOW:
+		kfree(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 35bfbf4a7aac..3adbb9f7d1a8 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -63,6 +63,7 @@ enum fanotify_event_type {
 	FANOTIFY_EVENT_TYPE_FID_NAME, /* variable length */
 	FANOTIFY_EVENT_TYPE_PATH,
 	FANOTIFY_EVENT_TYPE_PATH_PERM,
+	FANOTIFY_EVENT_TYPE_OVERFLOW, /* struct fanotify_event */
 };
 
 struct fanotify_event {
@@ -72,6 +73,14 @@ struct fanotify_event {
 	struct pid *pid;
 };
 
+static inline void fanotify_init_event(struct fanotify_event *event,
+				       unsigned long id, u32 mask)
+{
+	fsnotify_init_event(&event->fse, id);
+	event->mask = mask;
+	event->pid = NULL;
+}
+
 struct fanotify_fid_event {
 	struct fanotify_event fae;
 	__kernel_fsid_t fsid;
@@ -202,9 +211,3 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
 	else
 		return NULL;
 }
-
-struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
-					    struct inode *inode, u32 mask,
-					    const void *data, int data_type,
-					    const struct qstr *file_name,
-					    __kernel_fsid_t *fsid);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 42cb794c62ac..8c6d22ec7b41 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -829,13 +829,26 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 				 FSNOTIFY_OBJ_TYPE_INODE, mask, flags, fsid);
 }
 
+static struct fsnotify_event *fanotify_alloc_overflow_event(void)
+{
+	struct fanotify_event *oevent;
+
+	oevent = kmalloc(sizeof(*oevent), GFP_KERNEL_ACCOUNT);
+	if (!oevent)
+		return NULL;
+
+	fanotify_init_event(oevent, 0, FS_Q_OVERFLOW);
+	oevent->type = FANOTIFY_EVENT_TYPE_OVERFLOW;
+
+	return &oevent->fse;
+}
+
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 {
 	struct fsnotify_group *group;
 	int f_flags, fd;
 	struct user_struct *user;
-	struct fanotify_event *oevent;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -890,13 +903,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	atomic_inc(&user->fanotify_listeners);
 	group->memcg = get_mem_cgroup_from_mm(current->mm);
 
-	oevent = fanotify_alloc_event(group, NULL, FS_Q_OVERFLOW, NULL,
-				      FSNOTIFY_EVENT_NONE, NULL, NULL);
-	if (unlikely(!oevent)) {
+	group->overflow_event = fanotify_alloc_overflow_event();
+	if (unlikely(!group->overflow_event)) {
 		fd = -ENOMEM;
 		goto out_destroy_group;
 	}
-	group->overflow_event = &oevent->fse;
 
 	if (force_o_largefile())
 		event_f_flags |= O_LARGEFILE;
-- 
2.17.1


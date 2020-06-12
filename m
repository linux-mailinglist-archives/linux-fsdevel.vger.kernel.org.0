Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0431F760C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFLJeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgFLJeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5AC03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so9398514ejn.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hP42MA+PQNeh5/lNY5nfswLPCWPrDLJB57T2z7yHDZ4=;
        b=grqOW68OijtOKZoZH7gq7QP4CPMsB8irYSQuzaDZOiR+6rLyAY01hO6NlzB7daKh+A
         wfpsdIb97j93dl7OX0jJLeuh7r6bBjNpIJqtqvebovR7FtbiMiORH3RBhfH4BxmpcoX4
         g3VlZ2LErwiz/56THyM1IL1tmNW+9dy1dViJlV58Bb/w8yPSy47+DfvA6cC13XJqCD8L
         AwyycYMXu3tfpAScNT3ii09xv2eu9tbc2WYWPpTdcp2R2fi+bsiXMG/3T9E8rAdg/Av2
         k0BCel4SvfalcIox54hI6HrGu/hR/ZQDDEoOQoQP7YB17L3Q8fD0lZuVQxBHu7HwUbq5
         Xbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hP42MA+PQNeh5/lNY5nfswLPCWPrDLJB57T2z7yHDZ4=;
        b=IDlkamnpKRUUaM1CRhYC859/XCoQbjqlc/Y2s/ssYv6ElIlVHndp4JfRXob16Lx17D
         2wD3MIwyEJ9PsmnT9u8m6Ci4xslAJPnVbQOcT8GxGmZORRg2KX/+BAjXD8DogA6+G0CH
         kPRFSGeoqAK1G+M25amwvwUBTF5+qR8W7sFYVbv0jas/aZtb5YdiBvzahBq8AufAj2Up
         qcsFy4/ZxK6A/aSQemhBS9XfkpNcp5YBUydL/mAm7a9xFWBMGqLEa3dhOSBRpI/x8r/o
         KO5D4AJK2rgCK9wDe6SS+qVC3P9RQGmHRmA3R0F6lb23lPZrdW4qKHoYzCeKghs82HSB
         mQCw==
X-Gm-Message-State: AOAM530sis/E3nKWf48PEA+qVrxg+x7UFPKaR/UidPhLzdmJ/zIF7f6V
        xzjFNXTaFgKmtk3XhYtVIeg=
X-Google-Smtp-Source: ABdhPJw1Tr3r3qkVkPrfCPvN2+f2MY21MhuLJIYALj+rA7MAfiyKWeI+nyvUGx5SHuFkD4PlNYKeYQ==
X-Received: by 2002:a17:906:481b:: with SMTP id w27mr12031798ejq.27.1591954450596;
        Fri, 12 Jun 2020 02:34:10 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:09 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/20] fanotify: create overflow event type
Date:   Fri, 12 Jun 2020 12:33:30 +0300
Message-Id: <20200612093343.5669-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
index d9fc83dd994a..921ff05e1877 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -344,11 +344,11 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 	return fsnotify_data_inode(data, data_type);
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
@@ -426,8 +426,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	 * event queue, so event reported on parent is merged with event
 	 * reported on child when both directory and child watches exist.
 	 */
-	fsnotify_init_event(&event->fse, (unsigned long)id);
-	event->mask = mask;
+	fanotify_init_event(event, (unsigned long)id, mask);
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
 	else
@@ -443,15 +442,8 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
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
@@ -640,6 +632,9 @@ static void fanotify_free_event(struct fsnotify_event *fsn_event)
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
index 8ce7ccfc4b0d..1b2a3bbe6008 100644
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
index 63b5dffdca9e..8f3c70873598 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -831,13 +831,26 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
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
@@ -892,13 +905,11 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
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


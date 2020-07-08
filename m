Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AA42185B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgGHLMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgGHLMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04A2C08E763
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so2473004wme.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hP42MA+PQNeh5/lNY5nfswLPCWPrDLJB57T2z7yHDZ4=;
        b=KFe1hz6c3FFOdh6X61XaSE2EWW7OTbDUAUOZEddltsmgSX3tUrzzZRxzb7YAW8q+f3
         mtjEPBVC7tH+vUPrGZvx7wOpR8RPrApLPn8cpdUhIihxAfVqmZLctbOzx7b2xmghHCPU
         RVU5JkD4aj/AdgbnHjZjnGvPxhaBS/9RZNCUXEGnT6ohJcXDTr/vZYT/eOVTh081HkhY
         8l/FPHPQcdzytqbAGywq08xOg8fy+5aQ7m1gD9oRPDAg33/Z4rePHaMfHWJbo8ABTfbV
         5TuO+ltRlK9QWcBOWjj6BGskdFWBNVYHr6DW5U2vxdqxkjce48C7u4SL2sPLvIHv4fjG
         GE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hP42MA+PQNeh5/lNY5nfswLPCWPrDLJB57T2z7yHDZ4=;
        b=UvCWBKAzInlfLWJU7PCN1ce5NMoEr5gAuKyyJkiN3fgZItI56wpcKcjTHmbOh5oYEm
         slauIAYVA3p1TuNvy1R0edXByjCttRleFfST5zOUZSNBQ35uylNcvzO+VkYbASx5XvzH
         cSkkcKE7tyGPFm/xnTUzhv3UUFEyzBvxBxrWLlI0VYcWnzpWJ8PlgGIxrb780JOYjkqi
         A/as0mvlpMSGh1r3g+erjgggMomTsnMgfNCCIqzBvXUmfJrxKGtdQN1E7ku/9eQxiR3+
         jJNoBEqZtqJCfhjJ0InCK5rxX9qp8e2DEwBUyKNgD5mucOCdaKLtNQZqS7Z3GkQuF4ho
         inAA==
X-Gm-Message-State: AOAM531h81YO9e08/R6Vc2A2+Nrwjd1EOV/yNtTKEIN8UNgJliDJAM2j
        0il6q1dl7yySBTEbvfnrHFTmeasi
X-Google-Smtp-Source: ABdhPJybe7Yox6/2mvtinBS6ruHH3afhMwzBGRS1Coo9FjtjbGdtLpcgQesyvZjbCWY5hOJ/I6+Wkg==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr9196993wmi.66.1594206735620;
        Wed, 08 Jul 2020 04:12:15 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 07/20] fanotify: create overflow event type
Date:   Wed,  8 Jul 2020 14:11:42 +0300
Message-Id: <20200708111156.24659-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
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


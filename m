Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9A1F7612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgFLJeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgFLJeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:20 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5FCC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w7so5962263edt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tapwZE1nkO+GZnn7L+8ianGbMYvnrjU3Yn+WWBMAgW4=;
        b=VyJVtLPtb7g3dEW8AS8Nzw2Tw27JQHaV+ZUwPZ7c2Yof3ofbU9XWvuSk9kuHeL6lA0
         Uefx4npC55mAlm5iSh9VVypUxeGTT0wPU77TKc4JHMPLjJ9YzDiYMukmJ/3yuA09tYYk
         Oa99jNcCvChBF6Vl427GwBfRiNK7iXyCioh9XEireM4vdZzJ8sQSdvtvom+dS3/O/9+a
         YydHYW/EjWHs+VeC+u8GGnTHOvi+9qGN3oWJgcxS6HCiRYKlP3ZC3a81K0kOgUQYPtBw
         gPP2JIDvxb0sqj2FHaa+swIhoSXShqRBlu7ame25dXOhBK/cjnKw4hVeIGTf47RffHBw
         5bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tapwZE1nkO+GZnn7L+8ianGbMYvnrjU3Yn+WWBMAgW4=;
        b=bFNZtxIevTw4zsW/cwtlCTSSBI59wN+e+Nn1MLACo2pGyeJx6hWxQnFuIQ+CMUTIbA
         iqoFz2Uzfxj9rsFMWIWbPvxNHIolVNBZFiRPNpL185zzouOhsbIxoqrbSZYf4AymrUFR
         pthtb5ffw1OkvQ3b5tNpncSUGQf7xcqVPOYxT4gpmZDk5bvXBRpSZ8gzh1wcK/NCxOeK
         KFkh+e6N8pH6o7btQvy4QV3UJVrGjOsRsSxji+llVIeYIqTjF9ZLOZpcFlmEP6eFL4VS
         IKY5pwViHIClygdE69EugpjssZVGxtxCRuNmNnkiXqk6lGPNSYfbSbI8khm0sxMhdE67
         CHNA==
X-Gm-Message-State: AOAM530uQGJycpjAe6YAiNAFY78rdAzuzg9W1HMkEy7s63ojg0Z/5cdd
        /wBcVOrTPGzCky3OrFbkljGQ1D0p
X-Google-Smtp-Source: ABdhPJwkD4JgBuHzWmPLXjeE4MCDiMrWDnRCRryLU96YQZcO1bE8j3aodSHEwrircX395zUMuS/Hvg==
X-Received: by 2002:aa7:cc84:: with SMTP id p4mr10443138edt.157.1591954458526;
        Fri, 12 Jun 2020 02:34:18 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/20] fanotify: generalize test for FAN_REPORT_FID
Date:   Fri, 12 Jun 2020 12:33:36 +0300
Message-Id: <20200612093343.5669-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As preparation to new flags that report fids, define a bit set
of flags for a group reporting fids, currently containing the
only bit FAN_REPORT_FID.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 12 +++++++-----
 fs/notify/fanotify/fanotify_user.c | 12 ++++++------
 include/linux/fanotify.h           |  6 ++++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a982594ebca7..3a82ddb63196 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -207,13 +207,14 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
 				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
 	int type;
 
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
-	if (!FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (!fid_mode) {
 		/* Do we have path to open a file descriptor? */
 		if (!path)
 			return 0;
@@ -258,13 +259,13 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
-	 * to user in FAN_REPORT_FID mode for all event types.
+	 * to user in fid mode for all event types.
 	 *
 	 * We never report FAN_EVENT_ON_CHILD to user, but we do pass it in to
 	 * fanotify_alloc_event() when group is reporting fid as indication
 	 * that event happened on child.
 	 */
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (fid_mode) {
 		/* Do not report event flags without any event */
 		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
@@ -424,6 +425,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(mask, data, data_type, dir);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -448,7 +450,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		 * Allocate an fanotify_name_event struct and copy the name.
 		 */
 		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
-	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, gfp);
 	} else {
 		event = fanotify_alloc_path_event(path, gfp);
@@ -556,7 +558,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
 		fsid = fanotify_get_fsid(iter_info);
 		/* Racing with mark destruction or creation? */
 		if (!fsid.val[0] && !fsid.val[1])
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8f3c70873598..92bb885b98b6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -100,7 +100,7 @@ static struct fanotify_event *get_one_event(struct fsnotify_group *group,
 	if (fsnotify_notify_queue_is_empty(group))
 		goto out;
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
 		event_size += fanotify_event_info_len(
 			FANOTIFY_E(fsnotify_peek_first_event(group)));
 	}
@@ -877,7 +877,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EINVAL;
 	}
 
-	if ((flags & FAN_REPORT_FID) &&
+	if ((flags & FANOTIFY_FID_BITS) &&
 	    (flags & FANOTIFY_CLASS_BITS) != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
@@ -1035,7 +1035,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-	unsigned int obj_type;
+	unsigned int obj_type, fid_mode;
 	int ret;
 
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
@@ -1108,9 +1108,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * inode events are not supported on a mount mark, because they do not
 	 * carry enough information (i.e. path) to be filtered by mount point.
 	 */
+	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	if (mask & FANOTIFY_INODE_EVENTS &&
-	    (!FAN_GROUP_FLAG(group, FAN_REPORT_FID) ||
-	     mark_type == FAN_MARK_MOUNT))
+	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		goto fput_and_out;
 
 	if (flags & FAN_MARK_FLUSH) {
@@ -1135,7 +1135,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 	}
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (fid_mode) {
 		ret = fanotify_test_fid(&path, &__fsid);
 		if (ret)
 			goto path_put_and_out;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index b79fa9bb7359..bbbee11d2521 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -18,8 +18,10 @@
 #define FANOTIFY_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
 				 FAN_CLASS_PRE_CONTENT)
 
-#define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | \
-				 FAN_REPORT_TID | FAN_REPORT_FID | \
+#define FANOTIFY_FID_BITS	(FAN_REPORT_FID)
+
+#define FANOTIFY_INIT_FLAGS	(FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
+				 FAN_REPORT_TID | \
 				 FAN_CLOEXEC | FAN_NONBLOCK | \
 				 FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
 
-- 
2.17.1


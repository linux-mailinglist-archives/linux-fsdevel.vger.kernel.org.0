Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321562185B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGHLM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5BC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so48445731wru.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oInbQVhRH555hPda+U4NJnZYtCjJvpWTosUFV8aGrRE=;
        b=fVh1CippflwH5/ASU4Zt9M8/F4WD0DP1DAcv1ePEYxU6/XKWEDYEArEOEmIHF+9V0U
         n7fprCJ02aZXFeAS+nbd4HsRyQz/CdL435Yk6laYFTaT9qMIF8QjwbdKrhxQPg38pR90
         ZgYKaW8JCgtZZlRCN6oWcJDp/2OId/sBfqpDN+ZbF7/vNQXkSKIZmaDOn4czGCsfK6Py
         3CvN2OOEkhNFRSV5+77mPz2+OXzro+vvUKrjeiPDjoAO38AIclMUhrzHyQdyHqL8ll4N
         P13+dekJi9c7vuUjGrexNECH9NPpfcyPeKG/FoP7o9xEFX60iKRD8LZdO0SFOZ/JRuUJ
         bPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oInbQVhRH555hPda+U4NJnZYtCjJvpWTosUFV8aGrRE=;
        b=f6BzUDOTf9jIY2E8/NMchdLTqEYxHvEfHYAafcvYTOGKGptWqUB/1LZvmobnWCBww2
         J+KzArBOSjRQ/i3clEEFFijWXTGQDaYkL1bs8KBX1GzwQxqpJBiQglQ+xkLCJ+7FtWXp
         pOhp8y7RA46iYQaWjZYzEUMa3Pyr9ODfysec0zDCLqSDPduF2/yZlpOdiQvQGl4jlG6T
         k4ejQ4raWvLulxgTPuLgpwm8qYc1gCLqC4yzmYf9ypVfKa3hc+TqucpBhxw1AXSXBYaH
         HZwKCshK6J6g6FwUH4c8HJ334nhgDUSgAilMWB/0kdjEo+Q7DlHErxeFur2gQgFBjH0S
         iAIw==
X-Gm-Message-State: AOAM532Nse6hN+qrntyZmCNxlk0Ec97WDyxwYLP/AWTxA1qq/QVc+HvC
        FEZ+HQnEOkFC0Ns2FC3n3zk=
X-Google-Smtp-Source: ABdhPJyDRqjjlmhUG8pFGZwIkXymGQQ4j8hfDglxDuVjniIzemVff0N07EuUKv4VGoETEsDeM9Eugg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr57266801wrp.100.1594206744647;
        Wed, 08 Jul 2020 04:12:24 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 13/20] fanotify: generalize test for FAN_REPORT_FID
Date:   Wed,  8 Jul 2020 14:11:48 +0300
Message-Id: <20200708111156.24659-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As preparation to new flags that report fids, define a bit set
of flags for a group reporting fids, currently containing the
only bit FAN_REPORT_FID.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 10 ++++++----
 fs/notify/fanotify/fanotify_user.c | 12 ++++++------
 include/linux/fanotify.h           |  6 ++++--
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index ef8a1b698691..3a82ddb63196 100644
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
@@ -264,7 +265,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
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


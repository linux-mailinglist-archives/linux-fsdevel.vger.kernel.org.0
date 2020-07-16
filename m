Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F6221EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgGPImp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGPImn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C38C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so10658269wmf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z74CEK0HPXcDnU1MUydtflR5ehndxH4DI7x/m7Gu52s=;
        b=AVHEvT3IC8SPOp0SpVWDeU/2EvVac0Eqq+09bBm2fl6iRFlbA1KuCyGHRg4h+WtyOd
         G57C8pAqmE1bZ0dIE267+N54176qMoPYkPSe8NRY8onhZ4Xt8Cw4W/8G9tuewmkNtdAH
         kooGMgqPmeB69r1EHlbfTE7qjzEnsAGbo6mPdnDsATk5nFL71DeXi68CSmFz1RhaDYud
         2zxeXJy0Cpl7Pmbl+ZLcoP95W/Q740eeR0cB21j+LQZQ6gO8iqXL7IWXgRrH7CC6Oi/Y
         0s3tlGDPKpXVmih/JDfq2W6bZbYyweTb0RA1UYZFn7NvLwlG9hAkNq/4NEq6ZIbO/dZX
         exqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z74CEK0HPXcDnU1MUydtflR5ehndxH4DI7x/m7Gu52s=;
        b=G2xc9TAtp8AiFp4CUIvbI5vTm4eMuaaGh946uLilD5l/7l0bmOie11qoA9k35bu83k
         KUyhZx5PFoPirVICih5GJAzih+4a3I47iQl2IsIzTW0J5Yxe/6B7Y7TgpZ1z8QrMPa3v
         qKIfwiCIA8yT5n8qQqEKjR2SlTdd9troo9kgGLtVKpNSSgqYlrR7R1TJigXFNfhxYzXb
         cnaR6PX/bMIVlifAk8LqRN/MjqPn37ZITNF9oklyqKHHQ4zI/9T4l1L09CLiBec40jXu
         q5wmAfi0r7mm52DK4T5bQfyItAHflVYKpY16TkHGLi8niXDtcsXMWvPuPWwuh0/nCcaK
         LVfQ==
X-Gm-Message-State: AOAM530gw6ULaqXXA75TXabWnpz1XVDmuVc1nxuGQnawWS4XsDAkVQ7H
        CzWU4W8eaVDVW5n/66agBkEEK0eG
X-Google-Smtp-Source: ABdhPJyMdblUm+23gX7yTJc5SPG0VoKwQ+IOVb3MmZ3v/tW2epKWVtMEM54DXcUeozUe3skt0Ce5hg==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr3298610wmg.27.1594888962214;
        Thu, 16 Jul 2020 01:42:42 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 04/22] fanotify: generalize test for FAN_REPORT_FID
Date:   Thu, 16 Jul 2020 11:42:12 +0300
Message-Id: <20200716084230.30611-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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
index 3dc71a8e795a..b8c04a6f04c5 100644
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
 	bool name_event = false;
 
 	/*
@@ -444,7 +446,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		event = fanotify_alloc_perm_event(path, gfp);
 	} else if (name_event && file_name) {
 		event = fanotify_alloc_name_event(id, fsid, file_name, gfp);
-	} else if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	} else if (fid_mode) {
 		event = fanotify_alloc_fid_event(id, fsid, gfp);
 	} else {
 		event = fanotify_alloc_path_event(path, gfp);
@@ -551,7 +553,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
 		fsid = fanotify_get_fsid(iter_info);
 		/* Racing with mark destruction or creation? */
 		if (!fsid.val[0] && !fsid.val[1])
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c9a824e5c045..1e04caf8d6ba 100644
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
@@ -882,7 +882,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		return -EINVAL;
 	}
 
-	if ((flags & FAN_REPORT_FID) &&
+	if ((flags & FANOTIFY_FID_BITS) &&
 	    (flags & FANOTIFY_CLASS_BITS) != FAN_CLASS_NOTIF)
 		return -EINVAL;
 
@@ -1040,7 +1040,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-	unsigned int obj_type;
+	unsigned int obj_type, fid_mode;
 	int ret;
 
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
@@ -1113,9 +1113,9 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1140,7 +1140,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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


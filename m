Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E22CBC83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgLBMJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388675AbgLBMJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:09:22 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B2C08E860
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:27 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id d18so3536584edt.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JHozK/tuZHUF19wWhEC6pq30khKp2BlBsfQDSbsN/ZI=;
        b=hNZ2B5D4lMr2ovkUSa/t1ZVNoVohO8AWxFH6s7WSb+P8uiYi9qjnJj+btx4X0cNziL
         Gkb7la9OtlrxtIA/w1zaQv03TeJwNtSWQ0ssm4rmcpukIKRG5x1+MV8bZC0mc6V54RJo
         RCNG2WxR5R0w3rwurUnyfZqT5Kimv7Nh1jgR4wMeFl/oX/zxigZtiNZvZRSOa+825RNx
         M86rHw9J/XC91z9qn/rcl+rxAn5VLz5QEJJypeyCi23yqFOqrLAzpHFCdEJ9Ob2eDtE5
         NKLnTZgG2DL3UmeYhW+cAYvNW6DZoUE5SvAoJmNzH3/eBnfjfE76He0jCIP1+P/Aef0R
         wyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHozK/tuZHUF19wWhEC6pq30khKp2BlBsfQDSbsN/ZI=;
        b=f2urzULMxZoTQ+3y24ycD/i8rO8TzU3HbMTYWHoVDDj5yQ6mzTrU3T2eCMG3DGwTDu
         BTUnA1CvWlk4zVE60P2dNGaaqKziU+1zXH0PIb1KR1u2TjFA9vB7XFUBAxFTJDk6ESgu
         mC8BTVOOa26aXmhuzmvEB7NlX44QKh6TeVbclX6uFp/Y8lQ7GB0ODzEpl8bcBsnyPGHd
         53vLrXfqGpvKA99nWXeOUT0Vkk/Q/t9T1/tx/tOjzuMaBr5chO5fZrQoyYyTBV96PBsw
         iuc0SZaub5Wo2aDE6BCenvBfBYq91n7mcfklshszsu/pXF+L+TFVdpRKTUOELPERSeeo
         BVuA==
X-Gm-Message-State: AOAM531wnm7imV1CD+ydECNRVytjx5FesvRlgXgI7UnZXoVVpXs5zQUM
        87pvEgECVyKJcXEa/YOtsfmg8HvfBhU=
X-Google-Smtp-Source: ABdhPJzEQFwkllbz1vp3WYCpChN6bwfhyhnNBhy6nWneCUC3lbsI/EhaWfZ8Ht/R4203iaII/QNo/Q==
X-Received: by 2002:a50:9518:: with SMTP id u24mr2166773eda.333.1606910846697;
        Wed, 02 Dec 2020 04:07:26 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:26 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] fsnotify: optimize merging of marks with no ignored masks
Date:   Wed,  2 Dec 2020 14:07:13 +0200
Message-Id: <20201202120713.702387-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify() tries to merge marks on all object types (sb, mount, inode)
even if the object's mask shows no interest in the specific event type.

This is done for the case that the object has marks with the event type
in their ignored mask, but the common case is that an object does not
have any marks with ignored mask.

Set a bit in object's fsnotify mask during fsnotify_recalc_mask() to
indicate the existence of any marks with ignored masks.

Instead of merging marks of all object types, only merge marks from
objects that either showed interest in the specific event type or have
any marks with ignored mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    |  5 +++++
 fs/notify/fsnotify.c             | 18 ++++++++++++------
 include/linux/fsnotify_backend.h | 12 ++++++++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 8655a1e7c6a6..4441de2fba11 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -677,6 +677,11 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	/*
+	 * FS_HAS_IGNORED_MASK bit is reserved for internal use so should
+	 * not be exposed to fanotify uapi.
+	 */
+	BUILD_BUG_ON(ALL_FANOTIFY_EVENT_BITS & FS_HAS_IGNORED_MASK);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type, dir);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9a26207d1b5d..6b3a828db6aa 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -500,7 +500,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if (parent)
 		marks_mask |= parent->i_fsnotify_mask;
 
-
 	/*
 	 * If this is a modify event we may need to clear some ignored masks.
 	 * In that case, the object with ignored masks will have the FS_MODIFY
@@ -521,17 +520,24 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	BUILD_BUG_ON(FSNOTIFY_OBJ_TYPE_VFSMOUNT != (int)FSNOTIFY_ITER_TYPE_VFSMOUNT);
 	BUILD_BUG_ON(FSNOTIFY_OBJ_TYPE_SB != (int)FSNOTIFY_ITER_TYPE_SB);
 
-	iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
-		fsnotify_first_mark(&sb->s_fsnotify_marks);
-	if (mnt) {
+	/*
+	 * Consider only marks that care about this type of event and marks with
+	 * an ignored mask.
+	 */
+	test_mask |= FS_HAS_IGNORED_MASK;
+	if (test_mask && sb->s_fsnotify_mask) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
+			fsnotify_first_mark(&sb->s_fsnotify_marks);
+	}
+	if (mnt && (test_mask & mnt->mnt_fsnotify_mask)) {
 		iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
 			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
 	}
-	if (inode) {
+	if (inode && (test_mask & inode->i_fsnotify_mask)) {
 		iter_info.marks[FSNOTIFY_ITER_TYPE_INODE] =
 			fsnotify_first_mark(&inode->i_fsnotify_marks);
 	}
-	if (parent) {
+	if (parent && (test_mask & parent->i_fsnotify_mask)) {
 		iter_info.marks[FSNOTIFY_ITER_TYPE_PARENT] =
 			fsnotify_first_mark(&parent->i_fsnotify_marks);
 	}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 046fcfb88492..0615ca2fddf9 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -61,6 +61,14 @@
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
 #define FS_IN_ONESHOT		0x80000000	/* only send event once */
 
+/*
+ * Overload FS_IN_ONESHOT is set only on inotify marks, which never set the
+ * ignored mask and is not relevant in the object's cumulative mask.
+ * Overload the flag to indicate the existence of marks on the object that
+ * have an ignored mask.
+ */
+#define FS_HAS_IGNORED_MASK	FS_IN_ONESHOT
+
 #define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
 
 /*
@@ -522,13 +530,13 @@ static inline __u32 fsnotify_calc_mask(struct fsnotify_mark *mark)
 	__u32 mask = mark->mask;
 
 	if (!mark->ignored_mask)
-		return mask;
+		return mask & ~FS_HAS_IGNORED_MASK;
 
 	/* Interest in FS_MODIFY may be needed for clearing ignored mask */
 	if (!(mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
 		mask |= FS_MODIFY;
 
-	return mask;
+	return mask | FS_HAS_IGNORED_MASK;
 }
 
 /* Get mask of events for a list of marks */
-- 
2.25.1


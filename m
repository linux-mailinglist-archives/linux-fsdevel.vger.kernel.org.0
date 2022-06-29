Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE25D560371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiF2Om1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiF2OmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:42:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689DF38190;
        Wed, 29 Jun 2022 07:42:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso6200855wmq.4;
        Wed, 29 Jun 2022 07:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IG8l5XqsblqCtDe1AQxpeaU2s01EyDafscahOiuPeoE=;
        b=SkpW5am6z6TVyyIph7DFhEzVSD3L+QYaqR0AlPGJt2yhhWW6jfCqYEgpTI3WcgA/he
         U5HE+jZsZTuYKWyTiyd5PZMKxY8vOGtC3MDW6QVfVJ1UhLQSYucNfR5rL1xt7JtlYHvY
         pt+DXUxoX8NjbiHzsJxgLCwFRM5l3IP2fNvZiDvK9uV7+jxqrTMvzwb7fJBIuIXIA2E7
         /9dLg9QtF5ysyqQQthvLmwX8QMgH35UbcJXSMikzVPtUb8zUJwOSX9q92WsG8LJHu3Rk
         0BgmrIbWGa3k5M4+vdlQqA1LsoWFsTwNAkOqZgnexMfzaW7iTlHK10FNH9BFtISrficu
         TTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IG8l5XqsblqCtDe1AQxpeaU2s01EyDafscahOiuPeoE=;
        b=Yi0sFb2Z2mrzZdTf+of9Do2fIATqXefdCS0cEIuwPIfC6Z/+UvHyasW2oXLDotwIDV
         1QdZ8+86BVO7s3RGDJXIN/cmQAgJn7iedAI+pHARWRI8UAGnG27PDee+aeGsfTe0rvCY
         +fXF3nLkxdso3GZ2hRxndVywIIlws8vqOdzprg3eBGxNVk1aRJXKjXI3BlNNW2HmCrRK
         18CuPKYStN1LGF9QqYbXv0sceDjb54j/ReWNDiltl/rgYd+fi565661xKlQDSMNpp6Fg
         Kcne8hhkNirXn081HeNRnNWN3NrXJxnZrBUrOU/9AKCtf5QaQOhPCu3Qp2DWiGe1GE32
         dl7Q==
X-Gm-Message-State: AJIora+1WQhLBk5f9LzV6qxwjdqTDi7/9pXWqhpfnbxoJ3zQs4WV2xij
        UoD+UGooKytSycY8LVpP+QU=
X-Google-Smtp-Source: AGRyM1tIXAVTzJDt9psAdKiybZ3eaU90zfvYkAd35J4OudWLtxLNi6GLeMMlCmZC01jHR9aofp/2LQ==
X-Received: by 2002:a05:600c:274b:b0:3a0:47e8:ca85 with SMTP id 11-20020a05600c274b00b003a047e8ca85mr6235914wmw.156.1656513739936;
        Wed, 29 Jun 2022 07:42:19 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0039c747a1e8fsm3562085wmq.7.2022.06.29.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:42:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 3/3] fanotify: introduce FAN_MARK_IGNORE
Date:   Wed, 29 Jun 2022 17:42:10 +0300
Message-Id: <20220629144210.2983229-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629144210.2983229-1-amir73il@gmail.com>
References: <20220629144210.2983229-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This flag is a new way to configure ignore mask which allows adding and
removing the event flags FAN_ONDIR and FAN_EVENT_ON_CHILD in ignore mask.

The legacy FAN_MARK_IGNORED_MASK flag would always ignore events on
directories and would ignore events on children depending on whether
the FAN_EVENT_ON_CHILD flag was set in the (non ignored) mask.

FAN_MARK_IGNORE can be used to ignore events on children without setting
FAN_EVENT_ON_CHILD in the mark's mask and will not ignore events on
directories unconditionally, only when FAN_ONDIR is set in ignore mask.

The new behavior is non-downgradable.  After calling fanotify_mark() with
FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
on the same object will return EEXIST error.

Setting the event flags with FAN_MARK_IGNORE on a non-dir inode mark
has no meaning and will return ENOTDIR error.

The meaning of FAN_MARK_IGNORED_SURV_MODIFY is preserved with the new
FAN_MARK_IGNORE flag, but with a few semantic differences:

1. FAN_MARK_IGNORED_SURV_MODIFY is required for filesystem and mount
   marks and on an inode mark on a directory. Omitting this flag
   will return EINVAL or EISDIR error.

2. An ignore mask on a non-directory inode that survives modify could
   never be downgraded to an ignore mask that does not survive modify.
   With new FAN_MARK_IGNORE semantics we make that rule explicit -
   trying to update a surviving ignore mask without the flag
   FAN_MARK_IGNORED_SURV_MODIFY will return EEXIST error.

The conveniene macro FAN_MARK_IGNORE_SURV is added for
(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY), because the
common case should use short constant names.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  2 +
 fs/notify/fanotify/fanotify_user.c | 63 +++++++++++++++++++++++++-----
 include/linux/fanotify.h           |  5 ++-
 include/uapi/linux/fanotify.h      |  8 ++++
 4 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 80e0ec95b113..c54d0b404373 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -499,6 +499,8 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
 	if (mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)
 		mflags |= FAN_MARK_EVICTABLE;
+	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORE_FLAGS)
+		mflags |= FAN_MARK_IGNORE;
 
 	return mflags;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 6781d46cd37c..006be1ca048a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1009,7 +1009,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 	mask &= ~umask;
 	spin_lock(&fsn_mark->lock);
 	oldmask = fsnotify_calc_mask(fsn_mark);
-	if (!(flags & FAN_MARK_IGNORED_MASK)) {
+	if (!(flags & FANOTIFY_MARK_IGNORE_BITS)) {
 		fsn_mark->mask &= ~mask;
 	} else {
 		fsn_mark->ignore_mask &= ~mask;
@@ -1085,15 +1085,24 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				       unsigned int fan_flags)
 {
 	bool want_iref = !(fan_flags & FAN_MARK_EVICTABLE);
+	unsigned int ignore = fan_flags & FANOTIFY_MARK_IGNORE_BITS;
 	bool recalc = false;
 
+	/*
+	 * When using FAN_MARK_IGNORE for the first time, mark starts using
+	 * independent event flags in ignore mask.  After that, trying to
+	 * update the ignore mask with the old FAN_MARK_IGNORED_MASK API
+	 * will result in EEXIST error.
+	 */
+	if (ignore == FAN_MARK_IGNORE)
+		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORE_FLAGS;
+
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
 	 * because of an ignore mask that is now going to survive FS_MODIFY.
 	 */
-	if ((fan_flags & FAN_MARK_IGNORED_MASK) &&
-	    (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	if (ignore && (fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)) {
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY;
 		if (!(fsn_mark->mask & FS_MODIFY))
@@ -1120,7 +1129,7 @@ static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	bool recalc;
 
 	spin_lock(&fsn_mark->lock);
-	if (!(fan_flags & FAN_MARK_IGNORED_MASK))
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
 		fsn_mark->mask |= mask;
 	else
 		fsn_mark->ignore_mask |= mask;
@@ -1197,6 +1206,24 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
 		return -EEXIST;
 
+	/*
+	 * New ignore mask semantics cannot be downgraded to old semantics.
+	 */
+	if (fan_flags & FAN_MARK_IGNORED_MASK &&
+	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORE_FLAGS)
+		return -EEXIST;
+
+	/*
+	 * An ignore mask that survives modify could never be downgraded to not
+	 * survive modify.  With new FAN_MARK_IGNORE semantics we make that rule
+	 * explicit and return an error when trying to update the ignore mask
+	 * without the original FAN_MARK_IGNORED_SURV_MODIFY value.
+	 */
+	if (fan_flags & FAN_MARK_IGNORE &&
+	    !(fan_flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
+	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
+		return -EEXIST;
+
 	return 0;
 }
 
@@ -1231,7 +1258,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
-	if (!(fan_flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
+	    (mask & FAN_FS_ERROR)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
@@ -1275,7 +1303,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 	 * an ignore mask, unless that ignore mask is supposed to survive
 	 * modification changes anyway.
 	 */
-	if ((flags & FAN_MARK_IGNORED_MASK) &&
+	if ((flags & FANOTIFY_MARK_IGNORE_BITS) &&
 	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    inode_is_open_for_write(inode))
 		return 0;
@@ -1531,7 +1559,8 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
-				 (mask & FAN_RENAME);
+				 (mask & FAN_RENAME) ||
+				 (flags & FAN_MARK_IGNORE);
 
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
@@ -1569,7 +1598,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
-	bool ignore = flags & FAN_MARK_IGNORED_MASK;
+	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
 	int ret;
@@ -1618,12 +1647,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & ~valid_mask)
 		return -EINVAL;
 
+
+	/* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
+	if (ignore == (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
+		return -EINVAL;
+
 	/*
 	 * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
 	 * FAN_MARK_IGNORED_MASK.
 	 */
-	if (ignore)
+	if (ignore == FAN_MARK_IGNORED_MASK) {
 		mask &= ~FANOTIFY_EVENT_FLAGS;
+		umask = FANOTIFY_EVENT_FLAGS;
+	}
 
 	f = fdget(fanotify_fd);
 	if (unlikely(!f.file))
@@ -1727,6 +1763,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	else
 		mnt = path.mnt;
 
+	ret = mnt ? -EINVAL : -EISDIR;
+	/* FAN_MARK_IGNORE requires SURV_MODIFY for sb/mount/dir marks */
+	if (mark_cmd == FAN_MARK_ADD && ignore == FAN_MARK_IGNORE &&
+	    (mnt || S_ISDIR(inode->i_mode)) &&
+	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY))
+		goto path_put_and_out;
+
 	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
 	if (mnt || !S_ISDIR(inode->i_mode)) {
 		mask &= ~FAN_EVENT_ON_CHILD;
@@ -1819,7 +1862,7 @@ static int __init fanotify_user_setup(void)
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index a7207f092fd1..8ad743def6f3 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -62,11 +62,14 @@
 #define FANOTIFY_MARK_CMD_BITS	(FAN_MARK_ADD | FAN_MARK_REMOVE | \
 				 FAN_MARK_FLUSH)
 
+#define FANOTIFY_MARK_IGNORE_BITS (FAN_MARK_IGNORED_MASK | \
+				   FAN_MARK_IGNORE)
+
 #define FANOTIFY_MARK_FLAGS	(FANOTIFY_MARK_TYPE_BITS | \
 				 FANOTIFY_MARK_CMD_BITS | \
+				 FANOTIFY_MARK_IGNORE_BITS | \
 				 FAN_MARK_DONT_FOLLOW | \
 				 FAN_MARK_ONLYDIR | \
-				 FAN_MARK_IGNORED_MASK | \
 				 FAN_MARK_IGNORED_SURV_MODIFY | \
 				 FAN_MARK_EVICTABLE)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index f1f89132d60e..d8536d77fea1 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -83,12 +83,20 @@
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
 #define FAN_MARK_EVICTABLE	0x00000200
+/* This bit is mutually exclusive with FAN_MARK_IGNORED_MASK bit */
+#define FAN_MARK_IGNORE		0x00000400
 
 /* These are NOT bitwise flags.  Both bits can be used togther.  */
 #define FAN_MARK_INODE		0x00000000
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
 
+/*
+ * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
+ * for non-inode mark types.
+ */
+#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
+
 /* Deprecated - do not use this in programs and do not add new flags here! */
 #define FAN_ALL_MARK_FLAGS	(FAN_MARK_ADD |\
 				 FAN_MARK_REMOVE |\
-- 
2.25.1


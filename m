Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8907F559BD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiFXOhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiFXOgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:36:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3B960E36;
        Fri, 24 Jun 2022 07:35:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e7so3356283wrc.13;
        Fri, 24 Jun 2022 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6oFXPONWcD9zTLXE6cye4cgQbH9nS+s1vOtNjudXMY=;
        b=lvfo9ZecnzNLnov7BNt/6atj2n7Hk+bmrDouT0jG4DJ+daqRxL+raXkbW/0zsdGvhF
         Xw1tJjEDCAyPYNdqXbLTbXlKQPEcnXrzrwPYWlLAjCME2w6pjBVse6aNz2tHRDNWNKYU
         kkvmq4npYlL7Dn4h/6AsbUsmHZ7ndSZ16G6ApYTz7PDxIqw1uonCSs2tqAYZw4EQhsDY
         aH92rOy/n05hC5NkWnyEXIFCiVlrHGKvIKvyVBg5ogJy/ZV6yY0AWwCfJbgRmTHtjm0k
         p4BtbrvVj4gEieY8ObEm5kgMuFNedjrExCkeTeFoOCEMHpYdI6/s0L6deq81gqkxptEl
         jHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6oFXPONWcD9zTLXE6cye4cgQbH9nS+s1vOtNjudXMY=;
        b=rT646Qq7ST8bqC7Fjpq98oFhuzvhWrrPzbfLZmxHTliBITZhDA0ckNzaJynXHL7nU8
         0fdihzakZLF/3tRF6YY9nXKw02wj60Edv7o6q2c5tPvW+9DoQrs/wSaRYAmwWQinAPfM
         U+llS/StkFjxad1M1kmH+tsCiiOzC2Mqgm50yziiLgeHqNpxVz8GR9kwVvWRLEMMMu20
         TR66JHWSpdBL6R4UmA9ncxBeGm9tjGnI39++MdCtYhM9x7+6IheMNRtHXHBmoxChSCi9
         LxNGjGIHYyKpUXCBLdgqqV7K/nLOqNP3f0ul+Ey0KSnvvpUEnXbJKWpYrMW5+5X5EBok
         ArJA==
X-Gm-Message-State: AJIora/nB4RsfmxPY99etFFXFxwSi8YOY/t7yRr5KabbeRkqOtsFhJNg
        2FxjOOxJqfAs+RmbhEuWL2g=
X-Google-Smtp-Source: AGRyM1vdmq4ogh8x1ho5oNj7Sur1VBXUuNj4VsygMkNa5emDAEiyIsA8yI2Um+/YDs5kv6jaHLA2uw==
X-Received: by 2002:a5d:4589:0:b0:21b:8568:f38e with SMTP id p9-20020a5d4589000000b0021b8568f38emr13522540wrq.165.1656081345830;
        Fri, 24 Jun 2022 07:35:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003a02cbf862esm3116732wmr.13.2022.06.24.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:35:45 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 2/2] fanotify: introduce FAN_MARK_IGNORE
Date:   Fri, 24 Jun 2022 17:35:38 +0300
Message-Id: <20220624143538.2500990-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624143538.2500990-1-amir73il@gmail.com>
References: <20220624143538.2500990-1-amir73il@gmail.com>
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

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  2 ++
 fs/notify/fanotify/fanotify_user.c | 44 ++++++++++++++++++++++++------
 include/linux/fanotify.h           |  5 +++-
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 43 insertions(+), 10 deletions(-)

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
index b718df84bd56..0a657ded48e4 100644
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
@@ -1216,11 +1225,21 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 		goto out;
 	}
 
+	/*
+	 * New ignore mask semantics cannot be downgraded to old semantics.
+	 */
+	if (fan_flags & FAN_MARK_IGNORED_MASK &&
+	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORE_FLAGS) {
+		ret = -EEXIST;
+		goto out;
+	}
+
 	/*
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
-	if (!(fan_flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
+	    (mask & FAN_FS_ERROR)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
@@ -1264,7 +1283,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 	 * an ignore mask, unless that ignore mask is supposed to survive
 	 * modification changes anyway.
 	 */
-	if ((flags & FAN_MARK_IGNORED_MASK) &&
+	if ((flags & FANOTIFY_MARK_IGNORE_BITS) &&
 	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    inode_is_open_for_write(inode))
 		return 0;
@@ -1540,7 +1559,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-	bool ignore = flags & FAN_MARK_IGNORED_MASK;
+	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
 	int ret;
@@ -1589,12 +1608,19 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
@@ -1803,7 +1829,7 @@ static int __init fanotify_user_setup(void)
 
 	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
-	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 10);
+	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index edc28555814c..f32893942fd7 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -59,12 +59,15 @@
 #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
 				 FAN_MARK_FILESYSTEM)
 
+#define FANOTIFY_MARK_IGNORE_BITS (FAN_MARK_IGNORED_MASK | \
+				   FAN_MARK_IGNORE)
+
 #define FANOTIFY_MARK_FLAGS	(FANOTIFY_MARK_TYPE_BITS | \
+				 FANOTIFY_MARK_IGNORE_BITS | \
 				 FAN_MARK_ADD | \
 				 FAN_MARK_REMOVE | \
 				 FAN_MARK_DONT_FOLLOW | \
 				 FAN_MARK_ONLYDIR | \
-				 FAN_MARK_IGNORED_MASK | \
 				 FAN_MARK_IGNORED_SURV_MODIFY | \
 				 FAN_MARK_EVICTABLE | \
 				 FAN_MARK_FLUSH)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index f1f89132d60e..3efe417f2282 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -83,6 +83,8 @@
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
 #define FAN_MARK_EVICTABLE	0x00000200
+/* This bit is mutually exclusive with FAN_MARK_IGNORED_MASK bit */
+#define FAN_MARK_IGNORE		0x00000400
 
 /* These are NOT bitwise flags.  Both bits can be used togther.  */
 #define FAN_MARK_INODE		0x00000000
-- 
2.25.1


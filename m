Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35FC551EF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiFTObl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbiFTObZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:31:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB72E4D612;
        Mon, 20 Jun 2022 06:45:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i10so11012019wrc.0;
        Mon, 20 Jun 2022 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5BPK6UaCC6TYcKkszZrCdnf34LN0tq5ad2n2bD3Rr0=;
        b=FTzMDKJBJtVnBdeggAtMy1enQY0zDTv6oALwuufzFPeuecWdwCst0uBVfkWawV5v2h
         snc79UjoFb0QD5lyiyzJ/8lzb+yEYZT9UNPWqu7q8GLT09lE6+FlXReoNBbdXt7jcMz6
         G9JlTn/LsZQopw00lq93gt1mdnZyVyL065gydO4Mk8v8zrDXS1OBrEoH7IcNqM74ySah
         zJB7kgB+cmDdDLmFfU/r2aAwqjScd7Av4gRGULdZ9mJm1L5S6S7RM4iXGASSWcww0OtH
         CWzIi3dbOsmnILmQAJK0sJpM4e5G1cZ4hdJzRGSIxcI/fn7K4TFCeiXo2hHTLoHHtIi2
         0zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5BPK6UaCC6TYcKkszZrCdnf34LN0tq5ad2n2bD3Rr0=;
        b=qVTMU0oh8/BnUAy/lkb94DXa9bvGEGjELGX/TsMYOnAeng5Dl35q7fqx9Sp2bViPQt
         OldgHNeWxuSEPN+jmz8X6hBgf9AHKlZ6ioHHVLeWNRdCak4OyimczprhNF9KhzhGQgbN
         SceExiUAMJ2VG0hCB3CK81bHaH5cNZpnuLsz8ASoyyGwulbyfMfG6JoVz9gk3iQioA9B
         +mAOFIadospzLyZoYniTLpAoXDjvK/Khh09JQxoQitrY/HpwqR6ezggyM1I7k9xPtUgM
         CcVvbdIvK3o2mipZfNZ00+6kF3wCxZLo1hLYgnvb/BTLns1p8lhUANjnO/0P6GMVqc4d
         JTow==
X-Gm-Message-State: AJIora+IqlRSauxQp5TUQ6QH+rJWYHnwbt6RpACAC0LD/nJrWYJVARyi
        RHPWZic8e3Mduw/zuHwRXsBgR30mkFIPPw==
X-Google-Smtp-Source: AGRyM1t17Z6Nlnt+/SqjtjbzbpAht0o0H2zyy17xi7ZXyuJjk3ppyATnKUCvFtl/K22hfCyo8TneOA==
X-Received: by 2002:a5d:5588:0:b0:21b:9572:6f56 with SMTP id i8-20020a5d5588000000b0021b95726f56mr175797wrv.566.1655732758336;
        Mon, 20 Jun 2022 06:45:58 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d6150000000b0021b932de5d6sm1634355wrt.39.2022.06.20.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:45:57 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/2] fanotify: introduce FAN_MARK_IGNORE
Date:   Mon, 20 Jun 2022 16:45:51 +0300
Message-Id: <20220620134551.2066847-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620134551.2066847-1-amir73il@gmail.com>
References: <20220620134551.2066847-1-amir73il@gmail.com>
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

The new behavior is sticky.  After calling fanotify_mark() with
FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
will update the ignore mask, but will not change the event flags in
ignore mask nor how these flags are treated.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  2 ++
 fs/notify/fanotify/fanotify_user.c | 40 ++++++++++++++++++++++--------
 include/linux/fanotify.h           |  5 +++-
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 38 insertions(+), 11 deletions(-)

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
index b718df84bd56..07876d6c1dbc 100644
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
+	 * independent event flags in ignore mask.  After that, updating the
+	 * ignore mask with FAN_MARK_IGNORED_MASK works, but does not change
+	 * the flags nor the behavior.
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
@@ -1220,7 +1229,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
 	 */
-	if (!(fan_flags & FAN_MARK_IGNORED_MASK) && (mask & FAN_FS_ERROR)) {
+	if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
+	    (mask & FAN_FS_ERROR)) {
 		ret = fanotify_group_init_error_pool(group);
 		if (ret)
 			goto out;
@@ -1264,7 +1274,7 @@ static int fanotify_add_inode_mark(struct fsnotify_group *group,
 	 * an ignore mask, unless that ignore mask is supposed to survive
 	 * modification changes anyway.
 	 */
-	if ((flags & FAN_MARK_IGNORED_MASK) &&
+	if ((flags & FANOTIFY_MARK_IGNORE_BITS) &&
 	    !(flags & FAN_MARK_IGNORED_SURV_MODIFY) &&
 	    inode_is_open_for_write(inode))
 		return 0;
@@ -1540,7 +1550,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	__kernel_fsid_t __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
-	bool ignore = flags & FAN_MARK_IGNORED_MASK;
+	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
 	unsigned int obj_type, fid_mode;
 	u32 umask = 0;
 	int ret;
@@ -1591,10 +1601,20 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 
 	/*
 	 * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
-	 * FAN_MARK_IGNORED_MASK.
+	 * FAN_MARK_IGNORED_MASK.  They can be updated in ignore mask with
+	 * FAN_MARK_IGNORE and then they do take effect.
 	 */
-	if (ignore)
+	switch (ignore) {
+	case 0:
+	case FAN_MARK_IGNORE:
+		break;
+	case FAN_MARK_IGNORED_MASK:
 		mask &= ~FANOTIFY_EVENT_FLAGS;
+		umask = FANOTIFY_EVENT_FLAGS;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	f = fdget(fanotify_fd);
 	if (unlikely(!f.file))
@@ -1803,7 +1823,7 @@ static int __init fanotify_user_setup(void)
 
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


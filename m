Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219904FF30F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiDMJNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiDMJMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C536286D7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g18so1626884wrb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQP4t31IBbyZUrqerF0qyM4AohJqwX6xLtWXo7ap3iI=;
        b=IHGvyNqfqGFDmeZ5c0QPZwvQdqjby+omiTMP4e66jIEThFgXPyXO1wc0dSd+EUEHpB
         lForOGPv9E4Bg13cUGe7qw6r6kPIN+EisT91ZsFJmqxU2Fyu+NxRWITBB2LKh0FHjfbG
         uUwO7Y8q49pZnpAPakfgaBrohRdWTl6qPl3la3xKk9yxv2tpdAFRPCq51vWjyD2V4cqb
         OIU1N8irzWZq15yhpeDO2I0UsDBke9aEQ3/tXpzZacc497zRLrybzU+Gz5clEsW3sJ/T
         m6UEPpW2Wbl87VapgI4VyhM4IArnLCmzOgRRgz4Qfpe1cQ7cz1LOytgWowPFQZ5zv82P
         0STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQP4t31IBbyZUrqerF0qyM4AohJqwX6xLtWXo7ap3iI=;
        b=xh8b6V4ZwND6Jq+hFry4/lOcSEaAmgnbXrqRFE4YLh06tDUU+RE9HHuW/ZFXoILqwg
         GLz8PAlwKQ0Ba5xhPyUkj5DP6rLet1fEhTZsdYfNcyknkSU5TFSJNmRsFlviGohGi1Yf
         i+x88Nw07EeffwvZn9uUl4tXImbgX/KRFfw8PAuVBuAL9udMCKH546zmg+OvDE4bp6CM
         kid4TmUFJRMnOriTz9Ebd9nWCKA5z3k3dAnL9OXV0zG96WRZ1r2088yOb1cyJZeFy1rx
         J8qSJzo8nnpu/rkEfTcmxMVhkPiHfHNhsFeWSI4ru4yxrmeV8Yq63Wc8guvlYRb1btrM
         9gNw==
X-Gm-Message-State: AOAM531lh7by8a1Sz4Y9/47SW7h+eVrSTXwflD/M7LGfaejUdugJ5SPB
        w9xh1WBuSudZ5gtFguRIQPPT+Wfm/Gk=
X-Google-Smtp-Source: ABdhPJy0se1JFu7KSwzKCW6O0bALuXdqF/42qn02hUHy6mQVUykTxwzWst/jpFkrs4thLtNhCodX5A==
X-Received: by 2002:adf:9e49:0:b0:205:b77d:adf8 with SMTP id v9-20020adf9e49000000b00205b77dadf8mr31631397wre.85.1649840996522;
        Wed, 13 Apr 2022 02:09:56 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/16] fanotify: implement "evictable" inode marks
Date:   Wed, 13 Apr 2022 12:09:33 +0300
Message-Id: <20220413090935.3127107-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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

When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
pin the marked inode to inode cache, so when inode is evicted from cache
due to memory pressure, the mark will be lost.

When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
this flag, the marked inode is pinned to inode cache.

When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
existing mark already has the inode pinned, the mark update fails with
error EEXIST.

Evictable inode marks can be used to setup inode marks with ignored mask
to suppress events from uninteresting files or directories in a lazy
manner, upon receiving the first event, without having to iterate all
the uninteresting files or directories before hand.

The evictbale inode mark feature allows performing this lazy marks setup
without exhausting the system memory with pinned inodes.

This change does not enable the feature yet.

Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  2 ++
 fs/notify/fanotify/fanotify_user.c | 37 +++++++++++++++++++++++++++++-
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 87142bc0131a..80e0ec95b113 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -497,6 +497,8 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 
 	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
+	if (mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)
+		mflags |= FAN_MARK_EVICTABLE;
 
 	return mflags;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d8d44a5b37e3..0b4beba95fa8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1084,6 +1084,8 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				      unsigned int flags, bool *recalc)
 {
+	bool want_iref = !(flags & FAN_MARK_EVICTABLE);
+
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
 	 * the removal of the FS_MODIFY bit in calculated mask if it was set
@@ -1097,6 +1099,18 @@ static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 			*recalc = true;
 	}
 
+	if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
+	    want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+		return 0;
+
+	/*
+	 * NO_IREF may be removed from a mark, but not added.
+	 * When removed, fsnotify_recalc_mask() will take the inode ref.
+	 */
+	WARN_ON_ONCE(!want_iref);
+	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
+	*recalc = true;
+
 	return 0;
 }
 
@@ -1128,6 +1142,7 @@ static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int obj_type,
+						   unsigned int fan_flags,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
@@ -1150,6 +1165,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
+	if (fan_flags & FAN_MARK_EVICTABLE)
+		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
+
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
@@ -1185,13 +1203,22 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
+						 fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
 		}
 	}
 
+	/*
+	 * Non evictable mark cannot be downgraded to evictable mark.
+	 */
+	ret = -EEXIST;
+	if (flags & FAN_MARK_EVICTABLE &&
+	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+		goto out;
+
 	/*
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
@@ -1601,6 +1628,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    mark_type != FAN_MARK_FILESYSTEM)
 		goto fput_and_out;
 
+	/*
+	 * Evictable is only relevant for inode marks, because only inode object
+	 * can be evicted on memory pressure.
+	 */
+	if (flags & FAN_MARK_EVICTABLE &&
+	     mark_type != FAN_MARK_INODE)
+		goto fput_and_out;
+
 	/*
 	 * Events that do not carry enough information to report
 	 * event->fd require a group that supports reporting fid.  Those
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index e8ac38cc2fd6..f1f89132d60e 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -82,6 +82,7 @@
 #define FAN_MARK_IGNORED_SURV_MODIFY	0x00000040
 #define FAN_MARK_FLUSH		0x00000080
 /* FAN_MARK_FILESYSTEM is	0x00000100 */
+#define FAN_MARK_EVICTABLE	0x00000200
 
 /* These are NOT bitwise flags.  Both bits can be used togther.  */
 #define FAN_MARK_INODE		0x00000000
-- 
2.35.1


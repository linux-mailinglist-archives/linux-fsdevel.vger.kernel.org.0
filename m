Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386954EA8C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiC2HvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiC2HvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F511E5221
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so598986wms.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghLob7pz1z6BVvec+MhphEZOFMWIi6TQWa4rgtOFJik=;
        b=DUVxAPYarFHXJphSyMv3+yUz3X3BwudNNfBpRQn0PJfnzmcomE+hLNjMqrAsiduWWV
         OpupioN/1lKhjlzOGsOtmSeeziH/c3R0NclOjsBKtw1SYXcMGm+4KoUBcVibmNdD+yLn
         DehU78HORsqWAteBYeOH14W2bVK/z9nInuelGcU88K3Wp9PWePAaA3VUw0La1a3PBMNi
         2o6wEhM4deeQopYCjLTYl1iMfDu2gp8UdWE+UT5Ki32/1YX8DDYpge9oq6T6TCLbqK2Q
         hquvoPi2G+Zb4AYn8XztYyKJMyiRuORHhVofHvsFgm4JSFZADtlTM5bV9Z1t0EGrzXjN
         wliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghLob7pz1z6BVvec+MhphEZOFMWIi6TQWa4rgtOFJik=;
        b=7z29K8rjz7tqof5ojOjrRxAFd66CRS9FCcUsuzfGFX2Ha51jOehP4SjAEobbhmO8AU
         8rCkKSGYJ7jqjtnGKRUarTlBk3t/qRKZKtFxVp5+jNIfsNrGEkMI0wxcIfKgCM84VCJA
         Dpr0GWT4lNV8OFgGOi48bvopniWPRTE2QyH6UxObRGbkIEwEdBNOUfArxvIoNx12lv6v
         xBoPJnTke5E8IxnwF6TXsFYMuFAlWVwf31f24J3geUSdBAlBp3pv+zfzmsIk95W98XbY
         d6pCc+7/w3qt4OT/q0ml8HPmTy+nhQu4iqMiwv6zNhS4At1DdNezR9bfHdAL7X/QHhuI
         +xjA==
X-Gm-Message-State: AOAM533JShB7N3HadAAL85bTCd2CVzO5/1IeoucpLOOpKmiceVYcoMqn
        sHqNRIln6jZie14C/J8ximdOG3N+Sb0=
X-Google-Smtp-Source: ABdhPJwv1dG4W6DEk+WADCnMrrUDf8/mN2TjKCt3w6JBZG9msnWbbOYXtdbpq2l8sYkl5MvDm7Y+Zg==
X-Received: by 2002:a1c:6a15:0:b0:38b:57e8:dd5c with SMTP id f21-20020a1c6a15000000b0038b57e8dd5cmr5191610wmc.160.1648540167523;
        Tue, 29 Mar 2022 00:49:27 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:27 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/16] fanotify: implement "evictable" inode marks
Date:   Tue, 29 Mar 2022 10:49:01 +0300
Message-Id: <20220329074904.2980320-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify_user.c | 31 +++++++++++++++++++++++++++++-
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

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
index 6e78ea12239c..2c65038da4ce 100644
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
@@ -1097,6 +1099,20 @@ static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
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
+	if (!want_iref)
+		return -EEXIST;
+
+	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
+	*recalc = true;
+
 	return 0;
 }
 
@@ -1130,6 +1146,7 @@ static int fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int obj_type,
+						   unsigned int fan_flags,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
@@ -1152,6 +1169,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
+	if (fan_flags & FAN_MARK_EVICTABLE)
+		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
+
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
@@ -1187,7 +1207,8 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, flags,
+						 fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
@@ -1602,6 +1623,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
2.25.1


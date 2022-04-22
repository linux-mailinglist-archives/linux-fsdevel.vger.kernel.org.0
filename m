Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87750B6C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447271AbiDVMH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447346AbiDVMHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646256C10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so16008786ejn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMJ8rWSUhi1D/a/sEnw0qmlcFhILH0BUaifQb7FV55w=;
        b=BBNJNaFsAf/Xiva7MU1i+kUGy+fGaIsR3HIHKtw65lHAC2um/REg/ngUJUgIJt4EQM
         bvmiBr9FI65UqOhds0S7Ti1Qmg1rqfwqKofNY5GgYhqFSl0ODaaq87fUbsvf4DYrcBe5
         wMEyr9I6KHtIY/AB6pwHYffT1k7iPrILzZyczqvoozRuCLPA9CQ/4F3Rpg/a+cyBNo+Y
         DOvB/5/MJBMB666TYM16S6Kv1igoauwluMUl//8/L358DqBtxZIipUezEpg9r4U3VErD
         m1PhpadoSlWxYl86cRV0V1+EuCiZQ0VVR4cQLeLc1ki6zHvqLA74qaQwITCOr0z0AS+D
         5lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMJ8rWSUhi1D/a/sEnw0qmlcFhILH0BUaifQb7FV55w=;
        b=er0TJfAdnpH5sgN79urmQivPMxEJHGdDqMeao4neFdOlPA48KtrkshdrVOI62n9ZOZ
         gPID67+ITNxovyXx+owyrf6784y6h7is8ufC3+/ppmZaJhQbXxJF0mA/ccbPorpW3BOC
         QxmOMd2ZhyJhrRDRHKjsP2Uyr0z87DV9RegOMUSbRRQECZg4gTTOPulQN4OYjtbU4i1q
         QejSpYGbZ//viplh3Mt7/1IMkqzgKsYWQ75XAl9KsbYEw6XLnopaK3DEJFAOfIWawCRb
         SNJJXEwTzAPiRUJZfdQkpYZtEkoiVwyQapDtIdUTHcpSGyfa7Gj/594OnTH13hHfu+XQ
         d31A==
X-Gm-Message-State: AOAM530Nk98sa+YWYpN4ix8fQVy7l59unZqFzx2ZmaJJuMhDlcEPOQe9
        NgiGVi5tMsas/4mhHw1e9rw=
X-Google-Smtp-Source: ABdhPJx2avousG64Iy72WU6ooWhn2hULE7yh9AkcKlEmAHHxhsm19zbk6YNh9kLI5ucwaVGVVxbi4w==
X-Received: by 2002:a17:906:2f02:b0:6e8:289d:c13e with SMTP id v2-20020a1709062f0200b006e8289dc13emr3920736eji.489.1650629035014;
        Fri, 22 Apr 2022 05:03:55 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:54 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 14/16] fanotify: implement "evictable" inode marks
Date:   Fri, 22 Apr 2022 15:03:25 +0300
Message-Id: <20220422120327.3459282-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++--
 include/uapi/linux/fanotify.h      |  1 +
 3 files changed, 39 insertions(+), 2 deletions(-)

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
index 4005ee8e6e2c..ae36138afead 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1084,6 +1084,7 @@ static int fanotify_remove_inode_mark(struct fsnotify_group *group,
 static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				       unsigned int fan_flags)
 {
+	bool want_iref = !(fan_flags & FAN_MARK_EVICTABLE);
 	bool recalc = false;
 
 	/*
@@ -1099,7 +1100,18 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 			recalc = true;
 	}
 
-	return recalc;
+	if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
+	    want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+		return recalc;
+
+	/*
+	 * NO_IREF may be removed from a mark, but not added.
+	 * When removed, fsnotify_recalc_mask() will take the inode ref.
+	 */
+	WARN_ON_ONCE(!want_iref);
+	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
+
+	return true;
 }
 
 static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
@@ -1125,6 +1137,7 @@ static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int obj_type,
+						   unsigned int fan_flags,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
@@ -1147,6 +1160,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
+	if (fan_flags & FAN_MARK_EVICTABLE)
+		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
+
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
@@ -1183,13 +1199,23 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type,
+						 fan_flags, fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
 		}
 	}
 
+	/*
+	 * Non evictable mark cannot be downgraded to evictable mark.
+	 */
+	if (fan_flags & FAN_MARK_EVICTABLE &&
+	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)) {
+		ret = -EEXIST;
+		goto out;
+	}
+
 	/*
 	 * Error events are pre-allocated per group, only if strictly
 	 * needed (i.e. FAN_FS_ERROR was requested).
@@ -1601,6 +1627,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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


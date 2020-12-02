Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60D62CBC72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 13:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLBMIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 07:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgLBMIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:08:39 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45879C061A49
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 04:07:21 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so3806057ejj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HoJCq1RLwaX8TpqBRU2lfWbZSeg4QGA6FWYGWUyqYwU=;
        b=KEVmrYw/zHKdaIQT/avBPA/xo597cpoJE+ihyyOCuEBmb944CAAyO9wdJPbUVv7XIz
         emsZD7o56wv5Uotw2XGcn4FGzt3XLloJKNmi09ehfm7O+RoHW3jh7nKFgJUvH+un0zgM
         1FXBxlNRyfoTDETjj9hQVRx3CIVapeDR+jOkBHScVYfE/74dqVbw66tSXQhj0w6cYOJH
         p9za8B1YJgO144q7NoisKgBZ2D+f1ar3vkRYk1mgp6VMtNDubg+gR8U+QpoWBT1rgAeq
         H74XWsCQKFa257CtxzCPgcwBCFqyidrAm1mSCGWkv/y2XQHy/gascb5StoVutVaydEGS
         RYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoJCq1RLwaX8TpqBRU2lfWbZSeg4QGA6FWYGWUyqYwU=;
        b=d9JxORXKenP79HS6hX1/SZ3Su2X7rdd4TwVgX8Wj+vLTKoCAfp8qDr2AD/2mS03l5V
         z8GUK1zae2Y79++/yVtLfSPEJWJR+BCg1Q4Bfxa8Kg0SxgO2DM4iwNjgFr+DKCL/dbDS
         StaSN3imgoISzsRmPSpz7Z30qlknNlXA9egnGiwODtKIum6Py+X5kHtWBFlulXkapCSU
         +ZRvPb4pqAtMBdWhTZR6yDAGLuTNsSR3TwOCi9cPeQCVEGF1swZzrUxSE75WIpJVV/ql
         AHOWCx76yKw+F2HyHgGTysmukkmcwRcef9cC7ZFSYiAWQ3acNf5Cn5YCRISD1wXhseeI
         3cIw==
X-Gm-Message-State: AOAM5300jAVPArSEXxodNHZyi+64jNz+6p1RjT0no1fDAmlyYyVbBNDM
        zwXCTwHt2R1at0L4qBvYQdyjMnRGlrU=
X-Google-Smtp-Source: ABdhPJx2lkt/R40XOt0wkDu2u430HUlMx8R5rdM4OUU/cGjs6qMMe4VDftu7xQ3jzqhUTXfvgkik+g==
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr1961258ejz.2.1606910839990;
        Wed, 02 Dec 2020 04:07:19 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id b7sm1058227ejj.85.2020.12.02.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:19 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] inotify: convert to handle_inode_event() interface
Date:   Wed,  2 Dec 2020 14:07:08 +0200
Message-Id: <20201202120713.702387-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202120713.702387-1-amir73il@gmail.com>
References: <20201202120713.702387-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert inotify to use the simple handle_inode_event() interface to
get rid of the code duplication between the generic helper
fsnotify_handle_event() and the inotify_handle_event() callback, which
also happen to be buggy code.

The bug will be fixed in the generic helper.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify.h          |  9 +++---
 fs/notify/inotify/inotify_fsnotify.c | 47 ++++++----------------------
 fs/notify/inotify/inotify_user.c     |  7 +----
 3 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 4327d0e9c364..7fc3782b2fb8 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -24,11 +24,10 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
 
 extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 					   struct fsnotify_group *group);
-extern int inotify_handle_event(struct fsnotify_group *group, u32 mask,
-				const void *data, int data_type,
-				struct inode *dir,
-				const struct qstr *file_name, u32 cookie,
-				struct fsnotify_iter_info *iter_info);
+extern int inotify_handle_event(struct fsnotify_group *group,
+				struct fsnotify_mark *inode_mark, u32 mask,
+				struct inode *inode, struct inode *dir,
+				const struct qstr *name, u32 cookie);
 
 extern const struct fsnotify_ops inotify_fsnotify_ops;
 extern struct kmem_cache *inotify_inode_mark_cachep;
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 9ddcbadc98e2..f348c1d3b358 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -55,10 +55,10 @@ static int inotify_merge(struct list_head *list,
 	return event_compare(last_event, event);
 }
 
-static int inotify_one_event(struct fsnotify_group *group, u32 mask,
-			     struct fsnotify_mark *inode_mark,
-			     const struct path *path,
-			     const struct qstr *file_name, u32 cookie)
+int inotify_handle_event(struct fsnotify_group *group,
+			 struct fsnotify_mark *inode_mark, u32 mask,
+			 struct inode *inode, struct inode *dir,
+			 const struct qstr *file_name, u32 cookie)
 {
 	struct inotify_inode_mark *i_mark;
 	struct inotify_event_info *event;
@@ -68,10 +68,6 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
-	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
-	    path && d_unlinked(path->dentry))
-		return 0;
-
 	if (file_name) {
 		len = file_name->len;
 		alloc_len += len + 1;
@@ -131,35 +127,12 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
 	return 0;
 }
 
-int inotify_handle_event(struct fsnotify_group *group, u32 mask,
-			 const void *data, int data_type, struct inode *dir,
-			 const struct qstr *file_name, u32 cookie,
-			 struct fsnotify_iter_info *iter_info)
+static int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
+				      struct inode *inode, struct inode *dir,
+				      const struct qstr *name, u32 cookie)
 {
-	const struct path *path = fsnotify_data_path(data, data_type);
-	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
-	struct fsnotify_mark *child_mark = fsnotify_iter_child_mark(iter_info);
-	int ret = 0;
-
-	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
-		return 0;
-
-	/*
-	 * Some events cannot be sent on both parent and child marks
-	 * (e.g. IN_CREATE).  Those events are always sent on inode_mark.
-	 * For events that are possible on both parent and child (e.g. IN_OPEN),
-	 * event is sent on inode_mark with name if the parent is watching and
-	 * is sent on child_mark without name if child is watching.
-	 * If both parent and child are watching, report the event with child's
-	 * name here and report another event without child's name below.
-	 */
-	if (inode_mark)
-		ret = inotify_one_event(group, mask, inode_mark, path,
-					file_name, cookie);
-	if (ret || !child_mark)
-		return ret;
-
-	return inotify_one_event(group, mask, child_mark, path, NULL, 0);
+	return inotify_handle_event(inode_mark->group, inode_mark, mask, inode,
+				    dir, name, cookie);
 }
 
 static void inotify_freeing_mark(struct fsnotify_mark *fsn_mark, struct fsnotify_group *group)
@@ -227,7 +200,7 @@ static void inotify_free_mark(struct fsnotify_mark *fsn_mark)
 }
 
 const struct fsnotify_ops inotify_fsnotify_ops = {
-	.handle_event = inotify_handle_event,
+	.handle_inode_event = inotify_handle_inode_event,
 	.free_group_priv = inotify_free_group_priv,
 	.free_event = inotify_free_event,
 	.freeing_mark = inotify_freeing_mark,
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 24d17028375e..b559f296d4cf 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -495,14 +495,9 @@ void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
 				    struct fsnotify_group *group)
 {
 	struct inotify_inode_mark *i_mark;
-	struct fsnotify_iter_info iter_info = { };
-
-	fsnotify_iter_set_report_type_mark(&iter_info, FSNOTIFY_OBJ_TYPE_INODE,
-					   fsn_mark);
 
 	/* Queue ignore event for the watch */
-	inotify_handle_event(group, FS_IN_IGNORED, NULL, FSNOTIFY_EVENT_NONE,
-			     NULL, NULL, 0, &iter_info);
+	inotify_handle_event(group, fsn_mark, FS_IN_IGNORED, NULL, NULL, NULL, 0);
 
 	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
 	/* remove this mark from the idr */
-- 
2.25.1


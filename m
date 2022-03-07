Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AF4D038B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiCGP7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCGP66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:58:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17E31504
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:58:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n15so9921954wra.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzlFDcKeup3tPIXzWHHjCUBp6o8hEnxEJJeuyu6PzKo=;
        b=cP22eTz+mci0yvwhJcdEqNvsht8SgC+hkgSNAC5SmWA39xhM1Bei4S28UpsHR7vReK
         GUY+ricvH5mNRjNdlxDlGQdmowAOcJ13OBONDALWch0w3lLUl1I5QsSVAtggGC5HQMg+
         l3smR2Zn3JHfViQNRJi1yn4VLnPKsRz3mEf8mPvvk4k5osigx+lON3OAI2zw45aFpkSg
         Ucs0XivvN3+H4pfHVYb0A9pT5KkHyOnPmp5B9HCGBDhCxHdVYEjxZxC8fbLj6GRrRR8g
         rJ1+dA9B2rfU64NMN8N1hUG5GJvTCQDxxa9H5zOSyFKMa4n6RXE7rdLrO89M0aOsvnUd
         7Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzlFDcKeup3tPIXzWHHjCUBp6o8hEnxEJJeuyu6PzKo=;
        b=GKwmUc+WqobpZC5dmTK/AP6zth6fFGS9C3pE8FqENYPjt/HnDFty/bH9MRzg80RKhe
         UrNCk5CACuxCX+6TD2lZuqiZLBzcKejaAkROOEVkGtnoLTxMcuwnhucAJQfKa3qCxlHZ
         YsRJJH63PLK9/RssdYjsShBW3bQw2be80DB5jWq+u01XhldY9a74++Cu/9EFGjdVpWwK
         HbgCczHOdyal/x5A24SIGFsHD/36ZcWITq5tJ60XNvdEP59DvkiFpVJnAnaSEcI48xoK
         alOUdD3B9s0D9JjaN3JqLh+qczvZVFZFwxpXT9EdGukHwnJebcrM2ufBhBq4zoKmKE/Q
         c3jw==
X-Gm-Message-State: AOAM5333INrAIr33qYjJQdGwJk7SRaYZPtYyY4UuGpCiD/E9ezEnAdk0
        uUC1eHODjzktLm6SQZMVsIA=
X-Google-Smtp-Source: ABdhPJzoSLeTAVFAymiQXSEnz/Dl4a2ASIZcIXuRWiVBhfIuXN9A6/+GSiAAgAjZv/U2w1JuyOdSeQ==
X-Received: by 2002:adf:d84c:0:b0:1f0:651d:c6da with SMTP id k12-20020adfd84c000000b001f0651dc6damr8728883wrl.665.1646668680785;
        Mon, 07 Mar 2022 07:58:00 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm11686591wrv.79.2022.03.07.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:58:00 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] fsnotify: move inotify control flags to mark flags
Date:   Mon,  7 Mar 2022 17:57:37 +0200
Message-Id: <20220307155741.1352405-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307155741.1352405-1-amir73il@gmail.com>
References: <20220307155741.1352405-1-amir73il@gmail.com>
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

The inotify control flags in the mark mask (e.g. FS_IN_ONE_SHOT) are not
relevant to object interest mask, so move them to the mark flags.

This frees up some bits in the object interest mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c                 |  4 +--
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     | 40 +++++++++++++++++-----------
 include/linux/fsnotify_backend.h     | 11 ++++----
 4 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 494f653efbc6..f5d2547e2411 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -255,7 +255,7 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 	if (WARN_ON_ONCE(!inode && !dir))
 		return 0;
 
-	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
+	if ((inode_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
 		return 0;
 
@@ -583,7 +583,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index d92d7b0adc9a..49cfe2ae6d23 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -122,7 +122,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		fsnotify_destroy_event(group, fsn_event);
 	}
 
-	if (inode_mark->mask & IN_ONESHOT)
+	if (inode_mark->flags & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
 		fsnotify_destroy_mark(inode_mark, group);
 
 	return 0;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 54583f62dc44..324c49d26b53 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -110,11 +110,26 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 		mask |= FS_EVENT_ON_CHILD;
 
 	/* mask off the flags used to open the fd */
-	mask |= (arg & (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK));
+	mask |= (arg & IN_ALL_EVENTS);
 
 	return mask;
 }
 
+#define INOTIFY_MARK_FLAGS \
+	(FSNOTIFY_MARK_FLAG_EXCL_UNLINK | FSNOTIFY_MARK_FLAG_IN_ONESHOT)
+
+static inline unsigned int inotify_arg_to_flags(u32 arg)
+{
+	unsigned int flags = 0;
+
+	if (arg & IN_EXCL_UNLINK)
+		flags |= FSNOTIFY_MARK_FLAG_EXCL_UNLINK;
+	if (arg & IN_ONESHOT)
+		flags |= FSNOTIFY_MARK_FLAG_IN_ONESHOT;
+
+	return flags;
+}
+
 static inline u32 inotify_mask_to_arg(__u32 mask)
 {
 	return mask & (IN_ALL_EVENTS | IN_ISDIR | IN_UNMOUNT | IN_IGNORED |
@@ -526,13 +541,10 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	struct fsnotify_mark *fsn_mark;
 	struct inotify_inode_mark *i_mark;
 	__u32 old_mask, new_mask;
-	__u32 mask;
-	int add = (arg & IN_MASK_ADD);
+	int replace = !(arg & IN_MASK_ADD);
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
 
-	mask = inotify_arg_to_mask(inode, arg);
-
 	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, group);
 	if (!fsn_mark)
 		return -ENOENT;
@@ -545,10 +557,12 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 
 	spin_lock(&fsn_mark->lock);
 	old_mask = fsn_mark->mask;
-	if (add)
-		fsn_mark->mask |= mask;
-	else
-		fsn_mark->mask = mask;
+	if (replace) {
+		fsn_mark->mask = 0;
+		fsn_mark->flags &= ~INOTIFY_MARK_FLAGS;
+	}
+	fsn_mark->mask |= inotify_arg_to_mask(inode, arg);
+	fsn_mark->flags |= inotify_arg_to_flags(arg);
 	new_mask = fsn_mark->mask;
 	spin_unlock(&fsn_mark->lock);
 
@@ -579,19 +593,17 @@ static int inotify_new_watch(struct fsnotify_group *group,
 			     u32 arg)
 {
 	struct inotify_inode_mark *tmp_i_mark;
-	__u32 mask;
 	int ret;
 	struct idr *idr = &group->inotify_data.idr;
 	spinlock_t *idr_lock = &group->inotify_data.idr_lock;
 
-	mask = inotify_arg_to_mask(inode, arg);
-
 	tmp_i_mark = kmem_cache_alloc(inotify_inode_mark_cachep, GFP_KERNEL);
 	if (unlikely(!tmp_i_mark))
 		return -ENOMEM;
 
 	fsnotify_init_mark(&tmp_i_mark->fsn_mark, group);
-	tmp_i_mark->fsn_mark.mask = mask;
+	tmp_i_mark->fsn_mark.mask = inotify_arg_to_mask(inode, arg);
+	tmp_i_mark->fsn_mark.flags = inotify_arg_to_flags(arg);
 	tmp_i_mark->wd = -1;
 
 	ret = inotify_add_to_idr(idr, idr_lock, tmp_i_mark);
@@ -845,9 +857,7 @@ static int __init inotify_user_setup(void)
 	BUILD_BUG_ON(IN_UNMOUNT != FS_UNMOUNT);
 	BUILD_BUG_ON(IN_Q_OVERFLOW != FS_Q_OVERFLOW);
 	BUILD_BUG_ON(IN_IGNORED != FS_IN_IGNORED);
-	BUILD_BUG_ON(IN_EXCL_UNLINK != FS_EXCL_UNLINK);
 	BUILD_BUG_ON(IN_ISDIR != FS_ISDIR);
-	BUILD_BUG_ON(IN_ONESHOT != FS_IN_ONESHOT);
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 22);
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0805b74cae44..0bd63608e935 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -55,7 +55,6 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
-#define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -66,7 +65,6 @@
 #define FS_RENAME		0x10000000	/* File was renamed */
 #define FS_DN_MULTISHOT		0x20000000	/* dnotify multishot */
 #define FS_ISDIR		0x40000000	/* event occurred against dir */
-#define FS_IN_ONESHOT		0x80000000	/* only send event once */
 
 #define FS_MOVE			(FS_MOVED_FROM | FS_MOVED_TO)
 
@@ -106,8 +104,7 @@
 			     FS_ERROR)
 
 /* Extra flags that may be reported with event or control handling of events */
-#define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
-			     FS_DN_MULTISHOT | FS_EVENT_ON_CHILD)
+#define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
 
 #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_EVENTS | ALL_FSNOTIFY_FLAGS)
 
@@ -473,9 +470,13 @@ struct fsnotify_mark {
 	struct fsnotify_mark_connector *connector;
 	/* Events types to ignore [mark->lock, group->mark_mutex] */
 	__u32 ignored_mask;
-#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x01
+	/* Internal fsnotify flags */
 #define FSNOTIFY_MARK_FLAG_ALIVE		0x02
 #define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
+	/* Backend controlled flags */
+#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x10
+#define FSNOTIFY_MARK_FLAG_EXCL_UNLINK		0x20
+#define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x40
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.25.1


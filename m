Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392364FF318
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiDMJMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiDMJMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD571CFEE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m14so1647321wrb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MPpwsLuqEQgOfuuaDtCHGwQaMztJ8PuWPMUjX+42Cm8=;
        b=eXSBXyAhRlEIwuYV4olWkLA26E7dQEQhuJDjtmbznunAOemkFHkU19mvPI6Qyz5qUz
         wt0bWcU7NV70bhVlsVQUtfL47VfY+a8DK0zV4IkPikSqxN55JlrwXj8DU9LgcVKESmjc
         JQzEYkwUWo/j9z7hI3ZuhIni1oATIJd9Jc2xhjfbg5nxpIJUG7J55i2LaKHC+IQS7kin
         8dSeeC38yKO8dbuF7xgnn2uUNv8uOc2RcyU6edrzMRJxoExl7GaZ9GaPjIadqDA8QqoO
         aeynrgy1KwpcFy7eiQTatLaYi8ikP403dQzPhOi/VzBKYMQIIYRn3CflGZp9lNGtGICz
         gc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPpwsLuqEQgOfuuaDtCHGwQaMztJ8PuWPMUjX+42Cm8=;
        b=FnM/AYLwRzn37EfJs9N1ITFZ/zyOXDq2gWXx+TTIP4WsvXT6GFufpwCDQKgNrFFfe/
         dlG73Al6N+UkD8rZRsfKKpnXQFBhq+WPN7zp0jaFikbPGo2JtYEyP8SvNhS1y4K0rZq9
         xOIRQTIyOv9soR245adYp67Bn+kH2GESO5Vcs4Cj8WIblcBWB75RFgLCz5OGyVfIn/wZ
         cbxZQY9TLGxOf0k6p0F8lCUQxeYvtYZcY42KwcbXeV0R0Wj1C2llcp4Z0HmhRymorrXI
         xR/hj8lvqeI/IzrA+7wJ3O/k5FQkrEF8l2zF4x5afNG1rDKnkuQ4jsSpFQGmc5ZQN6iE
         rG7Q==
X-Gm-Message-State: AOAM531+aY7EPfc45t/vd7OD8wKF+vEKtUO/VN5jsyqTHV/zTJlShvcE
        wQLHhdi6Br9fOLJI14s1wCpQaY45sZU=
X-Google-Smtp-Source: ABdhPJwmqzBMkwKdm9nnVewgp1364DRdW9oODjZuuOlTrDWzhkkglJ8CUO3g6aUTMGtDQ6wDbdE5Yg==
X-Received: by 2002:a5d:6788:0:b0:207:ad57:cc71 with SMTP id v8-20020a5d6788000000b00207ad57cc71mr6053349wru.180.1649840980779;
        Wed, 13 Apr 2022 02:09:40 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:40 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/16] inotify: move control flags from mask to mark flags
Date:   Wed, 13 Apr 2022 12:09:21 +0300
Message-Id: <20220413090935.3127107-3-amir73il@gmail.com>
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

The inotify control flags in the mark mask (e.g. FS_IN_ONE_SHOT) are not
relevant to object interest mask, so move them to the mark flags.

This frees up some bits in the object interest mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fsnotify.c                 |  4 +--
 fs/notify/inotify/inotify.h          | 11 ++++++--
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     | 38 ++++++++++++++++++----------
 include/linux/fsnotify_backend.h     | 16 +++++++-----
 5 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 70a8516b78bc..6eee19d15e8c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -253,7 +253,7 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 	if (WARN_ON_ONCE(!inode && !dir))
 		return 0;
 
-	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
+	if ((inode_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
 		return 0;
 
@@ -581,7 +581,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 8f00151eb731..7d5df7a21539 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -27,11 +27,18 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
  * userspace.  There is at least one bit (FS_EVENT_ON_CHILD) which is
  * used only internally to the kernel.
  */
-#define INOTIFY_USER_MASK (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK)
+#define INOTIFY_USER_MASK (IN_ALL_EVENTS)
 
 static inline __u32 inotify_mark_user_mask(struct fsnotify_mark *fsn_mark)
 {
-	return fsn_mark->mask & INOTIFY_USER_MASK;
+	__u32 mask = fsn_mark->mask & INOTIFY_USER_MASK;
+
+	if (fsn_mark->flags & FSNOTIFY_MARK_FLAG_EXCL_UNLINK)
+		mask |= IN_EXCL_UNLINK;
+	if (fsn_mark->flags & FSNOTIFY_MARK_FLAG_IN_ONESHOT)
+		mask |= IN_ONESHOT;
+
+	return mask;
 }
 
 extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
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
index 3ef57db0ec9d..d8907d32a05b 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -115,6 +115,21 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
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
index 0805b74cae44..b1c72edd9784 100644
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
 
@@ -473,9 +470,14 @@ struct fsnotify_mark {
 	struct fsnotify_mark_connector *connector;
 	/* Events types to ignore [mark->lock, group->mark_mutex] */
 	__u32 ignored_mask;
-#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x01
-#define FSNOTIFY_MARK_FLAG_ALIVE		0x02
-#define FSNOTIFY_MARK_FLAG_ATTACHED		0x04
+	/* General fsnotify mark flags */
+#define FSNOTIFY_MARK_FLAG_ALIVE		0x0001
+#define FSNOTIFY_MARK_FLAG_ATTACHED		0x0002
+	/* inotify mark flags */
+#define FSNOTIFY_MARK_FLAG_EXCL_UNLINK		0x0010
+#define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
+	/* fanotify mark flags */
+#define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.35.1

